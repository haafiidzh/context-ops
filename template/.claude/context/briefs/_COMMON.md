# Common rules for every brief

Project-owned. Every task brief is read together with this file.

- App root and layout: <paths>. Paths in briefs are relative to <root> unless stated.
- Commands: <install, lint, typecheck, test, build>.
- Always read: `.claude/docs/00-product-brief.md` (first task only), `.claude/docs/01-agent-operating-rules.md`, `.claude/docs/stack-rules.md`, plus docs named in the brief.
- Iteration budget: 8 iterations per task, stop after 3 identical failures, max 25 exploring tool calls before the first edit. Write `iter N/8` in the handoff.
- No commit. No dependency outside the approved list.
- No secrets in files. Env var names only.
- Do not edit `.claude/context/CONTEXT.md`, `DECISIONS.md`, `TASKS.md`, or the human-owned product doc.
- **Serialized resources** (only ONE task per batch may touch each; used by `spawn-developers`): <schema/migrations, dependency manifest and lockfile, generated clients, shared config>.
- Handoff: `.claude/context/handoffs/<YYYY-MM-DD>-<task-id>-<role>.md`, template in `handoffs/README.md`. Status DONE / PARTIAL / BLOCKED.
