# Decision Log (excerpt)

| ID | Date | Status | Decision | Why | Source |
|---|---|---|---|---|---|
| ADR-001 | 2026-11-02 | ACCEPTED | Security defaults (read-only, least privilege, no secrets) are fixed; agents never weaken them | Product doc hard rules | Product doc |
| ADR-002 | 2026-11-02 | ACCEPTED | `.claude/` mirrors an earlier project's structure: agents, docs, context, handoffs, Stop hook | Human asked to reuse the proven setup | Human, 2026-11-02 |
| ADR-003 | 2026-11-02 | ACCEPTED | Iteration caps per role | Prevent long failing loops | Earlier project |
| ADR-004 | 2026-11-02 | ACCEPTED | PM runs as the main-thread agent (`claude --agent pm`) | Subagents cannot spawn subagents | Platform constraint |
| ADR-010 | 2026-11-03 | ACCEPTED (amended by ADR-014) | Max 3 agents at once | Machine limit | Human, 2026-11-03 |
| ADR-014 | 2026-11-04 | ACCEPTED | Max 2 agents at once while a database migration is in flight | Avoid concurrent schema changes | PM proposal, accepted by context-keeper |
| ADR-018 | 2026-11-05 | REJECTED | Add a paid hosted queue | Conflicts with the free-only hard rule | Developer handoff M3-02; rejected by context-keeper |
| ADR-021 | 2026-11-06 | PROPOSED | Add a read-only dashboard | Needs human approval; not in force | PM, awaiting human |

Notes:
- Rows are never rewritten. ADR-010 changed only in its Status column; the amendment is its own row (ADR-014).
- A proposal that breaks a hard rule is `REJECTED` with the reason, not silently dropped.
- `PROPOSED` rows are not in force until the human accepts them.
