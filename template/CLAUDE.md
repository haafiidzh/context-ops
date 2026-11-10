# <PROJECT_NAME>

<One paragraph: what this is, who it is for. Name the human-owned source of truth for product intent, e.g. `PRD.md`. Agent docs in `.claude/docs/` are the derivation; if they conflict with it, the product doc wins.>

## Start here
1. `.claude/docs/README.md`: index and read order.
2. `.claude/context/CONTEXT.md`: current state.
3. `.claude/docs/01-agent-operating-rules.md`: iteration limits and handoff protocol (mandatory).

## Agents (`.claude/agents/`)
`pm` (plans, spawns developers via the `spawn-developers` skill; run with `claude --agent pm`), `developer`, `qa`, `context-keeper`, optional `ui-ux`.

## Hard rules (never relax)
<!-- Keep to rules an agent can check mechanically. Examples:
- FREE ONLY. No paid service or API key without the human's approval.
- NO SECRETS in files, logs or results. Env var names only.
- OFFICIAL DOCS FIRST. Read current docs for any external API; never rely on memory.
- Work milestones in order. Verify each before the next.
- Tests are mandatory for <core business logic>. -->

## Other rules
- Docs, code, comments, commits in <language>.
- Commits: `.claude/docs/02-commit-rules.md`; commit only when asked.
- Respect iteration caps; on cap, stop and write a BLOCKED handoff.
