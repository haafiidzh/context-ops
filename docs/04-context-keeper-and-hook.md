# 04 — context-keeper and the Stop hook

## The hook
`.claude/hooks/context-sync.sh` is registered as a `Stop` hook in `.claude/settings.json`. When the main thread tries to finish, the hook checks two things:

1. **Pending handoffs**: any `.md` directly under `context/handoffs/` other than `README.md`.
2. **Moved repos**: for each repo in `context/repos.conf`, whether `git rev-parse HEAD` differs from the SHA recorded in `context/.sync-state` at the last pass.

If either is true it prints `{"decision": "block", "reason": ...}`, telling the main thread to run `context-keeper` once before finishing.

### Loop protection
| Guard | Prevents |
|---|---|
| `stop_hook_active` in the hook input | Re-blocking a stop the hook already extended |
| `.sync-lock` (ignored after 30 minutes) | Re-triggering while the keeper is mid-pass |
| First pass writes `.sync-state` | Repo check is skipped until a baseline exists |

### Behaviour you can rely on
Tested scenarios: clean tree (no output), pending handoff (block), `stop_hook_active` (no output), fresh lock (no output), state matching HEAD (no output), new commit (block), valid JSON output.

## The keeper's pass
1. `touch .sync-lock`.
2. Read every pending handoff.
3. **Verify** each claim against the repo (open files, `git status`, `git log`, grep). Unsupported `DONE` becomes `PARTIAL`.
4. Update `TASKS.md`; append ADRs to `DECISIONS.md`; reject proposals that break hard rules.
5. Rewrite `CONTEXT.md` as a snapshot (delete lines that stopped being true; no "fixed" notes).
6. Run every check in `docs/drift-checks.md`.
7. Cross-check that every path, ADR id and task id written resolves.
8. Archive processed handoffs.
9. Write `.sync-state` (`<name> <sha>` per repo), remove the lock.

Limits: one pass per invocation, <= 60 tool calls, oldest handoffs first if there are too many. The lock is always removed, even on failure.

## Why a snapshot, not a log
`CONTEXT.md` is read at the start of every task. A log grows until nobody reads it; a snapshot stays short enough that every agent does. History lives in `DECISIONS.md` (append-only) and the archive.

## ADR rules
Rows are never rewritten. Only the Status column changes (`SUPERSEDED by ADR-0xx`, `ACCEPTED (amended by ADR-0xx)`). A new fact is a new row.

## Requirements
`bash`, `git`, `python3`. The hook handles both GNU and BSD `stat`.
