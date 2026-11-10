# context-ops

> Agents forget. The repo shouldn't.

A workflow template for [Claude Code](https://claude.com/claude-code): role-based agents, hard iteration caps, handoff files, and a Stop-hook-driven `context-keeper` that keeps project memory **verified against the code**.

*Unofficial. Not affiliated with or endorsed by Anthropic.*

## The problem

Long agentic projects rot in predictable ways:

- `CLAUDE.md` and docs go stale, and the next session trusts them anyway.
- An agent loops on a failing approach and burns the budget.
- Parallel agents overwrite each other's files, or edit the shared state file at the same time.
- "DONE" in a report does not mean the tests ran.

context-ops is a small set of files that makes these failures structurally harder.

## The idea in one picture

```
 you ──► pm (main thread) ──► briefs ──► developer ×N (parallel, disjoint scope)
                                              │                    │
                                              ▼                    ▼
                                           handoff.md           handoff.md      ◄── the only thing agents write
                                              │                    │                  about project state
                                              └──────────┬─────────┘
                                                         ▼
                                  Stop hook sees pending handoffs / moved repos
                                                         ▼
                                       context-keeper (single writer)
                                  verifies claims vs code ─► CONTEXT / DECISIONS / TASKS
                                                         ▼
                                  next agent starts from verified state
```

## Five mechanisms

| # | Mechanism | What it enforces | Where |
|---|---|---|---|
| 1 | **Roles with different tool access** | PM plans but writes no product code; developer cannot edit shared state; QA writes tests only; one agent owns memory | `agents/*.md` |
| 2 | **Hard iteration caps** | 8 iterations per task, stop after 3 identical failures, 2 retests, 2 re-plans. At the cap: stop and write a `BLOCKED` handoff | `docs/01-agent-operating-rules.md` |
| 3 | **Handoff contract** | Fixed template: status, iterations, changes, checks run, assumptions, proposed decisions, blockers | `context/handoffs/README.md` |
| 4 | **Verified context** | `context-keeper` checks every claim against files and git, downgrades unsupported `DONE` to `PARTIAL`, runs drift checks every pass | `agents/context-keeper.md`, `hooks/context-sync.sh` |
| 5 | **Safe parallelism** | `spawn-developers` skill: disjoint write scopes, serialized resources (schema, lockfile), serialize when unsure | `skills/spawn-developers/` |

Plus a human gate: agents queue questions in `question-confirmation.md`, and you answer with `/confirm`.

## Quick start

```bash
# copy the template into your project (degit shown; plain cp works too)
npx degit haafiidzh/context-ops/template my-project
cd my-project
chmod +x .claude/hooks/context-sync.sh

# fill in the placeholders
grep -rn "<PROJECT_NAME>" .

# run the PM as the main-thread agent so it can spawn developers
claude --agent pm
```

Requirements: `bash`, `git`, `python3` (JSON handling in the hook only).

Then read [`docs/07-adopting.md`](docs/07-adopting.md) for the fill-in checklist.

## What is in this repo

```
template/     the files you copy into a project (CLAUDE.md + .claude/)
docs/         why each mechanism exists and how it behaves
examples/     a filled-in handoff, brief and ADR log
case-studies/ how the pattern evolved across three real projects
```

## Upstream vs project-owned files

Files that change when this template improves (agents, skills, the hook, `01-agent-operating-rules.md`) are kept separate from files that hold your project's facts (`CLAUDE.md`, `context/`, `stack-rules.md`, `drift-checks.md`, `00-product-brief.md`). Project-specific rules never live inside an agent file, so you can pull upstream changes without losing them.

## Design principles

1. **Single writer for shared state.** Agents propose; one agent records.
2. **Verify, then write.** A wrong line in `CONTEXT.md` costs more than a missing one.
3. **Stop is a feature.** A capped agent that reports beats an agent that keeps guessing.
4. **Humans own intent.** The product doc is never edited by agents; locked decisions are not re-litigated.
5. **Plain files.** Markdown, one bash script. Nothing to install, nothing to host.

## License

MIT
