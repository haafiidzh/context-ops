# 07 — Adopting context-ops

## 1. Copy the template
```bash
npx degit haafiidzh/context-ops/template my-project   # or: cp -r template/. my-project/
cd my-project
chmod +x .claude/hooks/context-sync.sh
```
`.claude/` is meant to be its own private git repo when the product repo is public or shared; it holds working notes, not product code.

## 2. Fill in the placeholders
```bash
grep -rn "<PROJECT_NAME>\|<PRD.md>" .
```

| File | Action |
|---|---|
| `CLAUDE.md` | Project summary, source-of-truth doc, hard rules, language |
| `.claude/docs/00-product-brief.md` | Locked decisions, scope, milestones with exit conditions |
| `.claude/docs/stack-rules.md` | Language, conventions, test commands, forbidden patterns |
| `.claude/docs/drift-checks.md` | The mismatches that would hurt you silently |
| `.claude/docs/03-risks-and-open-questions.md` | Gates (cost, security, scope) |
| `.claude/context/briefs/_COMMON.md` | Paths, commands, **serialized resources** |
| `.claude/context/repos.conf` | Repos the hook should watch |
| `.claude/docs/02-commit-rules.md` | Your commit and push policy |

Delete what you do not need: `ui-ux.md` for projects without a UI, `confirm` if you do not want a question list.

## 3. Verify the hook
Create a file `.claude/context/handoffs/test.md`, end a turn, and expect a "Context sync needed" block. Then delete the file.

## 4. Start
```bash
claude --agent pm
```
Ask PM to plan milestone M0. It reads the docs, writes tasks and briefs, and spawns developers.

## Upstream vs project-owned
| Upstream (safe to overwrite when updating) | Project-owned (do not overwrite) |
|---|---|
| `agents/*`, `skills/*`, `hooks/*`, `docs/01-agent-operating-rules.md` | `CLAUDE.md`, `docs/00,02,03`, `stack-rules.md`, `drift-checks.md`, `context/*` |

Project-specific rules belong in the right-hand column, not inside agent files.

## Common adjustments
- Change `max_parallel` (default 4) in `pm.md` and `01-agent-operating-rules.md` together.
- Several repos: list each in `repos.conf`.
- Non-English project: change the language rule in `CLAUDE.md`; keep the question list in your own language.
