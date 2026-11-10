# <PROJECT_NAME>: Agent Docs Index

Agent-ready documentation derived from the human-owned product doc (`<PRD.md>`). If these files conflict with it, the product doc wins; report the conflict to `context-keeper`.

## Read order

| File | Owner | Read when |
|------|-------|-----------|
| `00-product-brief.md` | project | Always first: what and why, locked decisions, scope, milestones |
| `01-agent-operating-rules.md` | upstream | Every agent, every task: iteration limits, handoffs, task IDs |
| `02-commit-rules.md` | project | Before any commit |
| `03-risks-and-open-questions.md` | project | Before any decision touching cost, legal, security or scope |
| `stack-rules.md` | project | Developer: before coding |
| `drift-checks.md` | project | context-keeper: every pass |
| `<add: glossary, architecture, data model, requirements, testing strategy ...>` | project | <when> |

"upstream" files can be overwritten when you update context-ops; "project" files are yours.

## Living context (written by agents, curated by `context-keeper`)

`.claude/context/`: `CONTEXT.md` (current state), `DECISIONS.md` (ADR log), `TASKS.md` (board), `briefs/` (per-task briefs), `handoffs/` (per-task reports), `repos.conf` (repos the Stop hook watches). The hook `.claude/hooks/context-sync.sh` (registered in `.claude/settings.json`) triggers `context-keeper` when unprocessed handoffs exist.

## Agents

`.claude/agents/`: `pm`, `developer`, `qa`, `context-keeper`, optional `ui-ux`. PM skill: `.claude/skills/spawn-developers/SKILL.md`. Human skill: `.claude/skills/confirm/SKILL.md`.
