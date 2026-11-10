# 02 — Iteration caps

An **iteration** is one change, one check, one read of the result. Every agent counts them and writes `iter N/cap` in its handoff.

| Role | Cap | Same-error cap |
|---|---|---|
| developer | 8 per task | 3 identical failures |
| qa | 2 retest cycles per ticket | 2 flaky reruns |
| ui-ux | 2 revision rounds per spec | — |
| pm | 2 re-plan rounds per milestone, 2 respawns per failed task | — |
| context-keeper | 1 pass, <= 60 tool calls | — |

## Why hard caps
An agent that is failing tends to keep trying variations of the same idea. The cost grows linearly; the chance of success does not. A cap converts an open-ended loop into a bounded one with a defined exit: **stop and report**.

## Stop-and-report
1. Stop changing things. Leave the tree buildable.
2. Write a `BLOCKED` or `PARTIAL` handoff with the exact error text, what was tried, a hypothesis, and what is needed.
3. Return a 5-line summary. Do not retry.

The PM then has exactly four moves: re-scope, split, reassign, or supply a missing decision. A third re-plan escalates to the human.

## Related limits
- Exploration: at most 25 tool calls before the first edit.
- Commands silent for > 5 minutes: abort, count one iteration.
- Servers and watchers run in the background only.
- Planning pass: <= 15 tool calls before producing the plan.

## Tuning
The numbers are defaults, not laws. Change them in `01-agent-operating-rules.md` and in the matching agent file together; keeping both in sync is a drift check worth adding.
