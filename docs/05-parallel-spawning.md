# 05 — Parallel spawning

Run `claude --agent pm`, then let PM use the `spawn-developers` skill whenever two or more tasks are ready.

## Independence test
Two tasks may run in parallel only if **all** hold:

- Disjoint write scope (no shared files).
- No data dependency (B does not need A's output, migration or generated artifact).
- No concurrent change to a **serialized resource**: schema/migrations, dependency manifest and lockfile, generated API clients, shared config. Only one task per batch touches each.
- If the tasks live in different repos, the contract between them is already fixed.

If unsure, serialize.

## Sizing
`N = min(max_parallel, independent ready tasks)`, default `max_parallel` = 4. One developer per task. No spawn for work under ~10 minutes; bundle trivial tasks into one brief.

## The brief carries the guardrails
Each parallel developer receives scope **allowed**, scope **forbidden** (the other developers' scopes), acceptance criteria, an iteration budget, and a handoff path. Same-repo parallelism can use `isolation: "worktree"`, merged sequentially afterwards.

## After the batch
Read handoffs, not transcripts. `DONE` queues a QA task; `PARTIAL`/`BLOCKED` respawns at most twice with a narrowed brief that includes the previous error. Then `context-keeper` runs once for the batch.

## Anti-patterns
Spawning for dependent tasks · overlapping scopes · exceeding the parallel limit · vague briefs · no budget · respawning a failed task unchanged.

## Limit
Subagents cannot spawn subagents. Only the main-thread PM can.
