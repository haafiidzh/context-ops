# 01 — Roles and permissions

Roles are not personas. Each one is a subagent definition whose `tools:` list and instructions make a specific mistake impossible or unlikely.

| Role | Model | Can write | Cannot | Why |
|---|---|---|---|---|
| `pm` | opus | `TASKS.md` status column, briefs | product code | Planners who also code skip planning. Runs as the main thread (`claude --agent pm`) because subagents cannot spawn subagents. |
| `developer` | sonnet | product code, own handoff | `CONTEXT.md`, `DECISIONS.md`, `TASKS.md` | Several developers run in parallel; shared state needs a single writer. |
| `qa` | sonnet | test files, fixtures, own handoff | product code | A verifier that fixes what it finds stops being independent. |
| `ui-ux` (optional) | sonnet | specs under `docs/design/specs/` | code in app repos | Specs lead implementation by one step. |
| `context-keeper` | opus | `CONTEXT.md`, `DECISIONS.md`, `TASKS.md`, docs drift fixes, archive | source code, the human-owned product doc | The only agent that records project state, so it is the one that must verify. |

## Model choice
Judgment-heavy, low-volume roles (`pm`, `context-keeper`) use the stronger model; high-volume implementation and verification roles use the cheaper one. Adjust in each agent's frontmatter.

## Human-owned files
The product doc (PRD) and the locked-decisions table in `00-product-brief.md` are never edited by agents. If agent docs conflict with the PRD, the PRD wins and the conflict is reported to `context-keeper`.

## Adding a role
Write the agent file with: description (when to use it), `tools:` (minimum needed), the files it reads before work, hard limits, and the handoff it writes. Add its caps to `01-agent-operating-rules.md`.
