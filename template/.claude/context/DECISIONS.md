# Decision Log (append-only, owner: context-keeper)

Rows are never deleted or rewritten; only the Status column may change (e.g. `SUPERSEDED by ADR-0xx`). New facts go in a new row.

Status: `ACCEPTED`, `REJECTED`, `SUPERSEDED`, `PROPOSED` (awaiting the human; not in force until ACCEPTED).

| ID | Date | Status | Decision | Why | Source |
|---|---|---|---|---|---|
| ADR-001 | YYYY-MM-DD | ACCEPTED | Work follows `.claude/docs/01-agent-operating-rules.md` (iteration caps, handoffs, single writer for context files) | Prevent long failing loops and conflicting context edits | context-ops |
