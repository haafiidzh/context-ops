# Case studies

context-ops was extracted from three projects built with the same pattern. Names are omitted; the table shows how the setup differed, and the notes explain the design choices that follow from it.

| | Project A: consumer web app | Project B: SaaS with a billing layer | Project C: local-first server with a security model |
|---|---|---|---|
| Repos watched by the hook | 2 (backend, frontend) | 1 | 1 |
| Hard rules in `CLAUDE.md` | few: language, locked decisions, commit rules, iteration caps | free-only, test-mode billing, no card data, no secrets, tests for core logic | nine security and cost rules: least privilege, read-only default, clean stdout, no secrets |
| Per-task briefs | none | one file per task (~70) plus a shared `_COMMON.md` | shared `_COMMON.md` plus short briefs |
| PM to UI/UX channel | handoffs only | append-only thread file | none |
| Human gate | chat | `/confirm` skill and a question list | same, plus a two-step confirmation before any push |
| Extra docs | design mockups, research notes | approved-dependency list, metering doc | security model, approved-dependency list |

## Direction of change
Each project added **explicit human gates** and **more structured briefs** than the one before: an approved-dependency list, the `/confirm` flow, a push rule, and a shared `_COMMON.md` for constraints common to every task.

## Design rationale
These are reasons for the template's choices, not reports of specific incidents.

1. **Hard rules belong at the top of the entry file.** In B and C they are short, checkable lines in `CLAUDE.md`. A rule an agent can check mechanically (no `console.log` in `src/`) is enforceable; prose guidance is not.
2. **Shared constraints go in one file.** With ~70 briefs, repeating the same constraints invites drift. `_COMMON.md` is read with every brief.
3. **Dependency approval is a gate.** B and C keep an approved list; anything else stops the agent and goes to the human.
4. **Verification is the keeper's job.** Handoffs are self-reports. `context-keeper` checks them against files and git, so a `DONE` without recorded checks becomes `PARTIAL`.
5. **The human gate echoes interpretations.** Answers like "yes" or "1-3" are terse; `/confirm` restates each parsed answer before acting.
6. **Parallelism limits are data.** C capped concurrency at 3 for machine reasons while A and B used 4, so the cap is a documented setting rather than a constant.
7. **Upstream and project-owned files are separated.** The three projects each carried their own copy of the same agents, hook and skills with small edits (paths, repo names). Keeping project facts in `stack-rules.md`, `drift-checks.md` and `_COMMON.md` lets one upstream copy serve all of them.

## What did not carry over
Project-specific content: milestone histories, ADRs, archived handoffs, design mockups and stack rules. They are data about those projects, not the approach.
