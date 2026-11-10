---
name: spawn-developers
description: PM-only skill. Decide whether a set of tasks can run in parallel and spawn 1-4 developer agents with disjoint scopes, iteration budgets, and handoff paths. Use when the PM has 2+ ready tasks.
---

# spawn-developers

Used by the `pm` agent (main thread). Subagents cannot spawn subagents, so this only works when PM runs via `claude --agent pm`.

## Step 1: Check readiness
Each task must meet the Definition of Ready (`.claude/docs/01-agent-operating-rules.md`): goal, doc refs, acceptance criteria, scope paths, budget. Fix or drop tasks that don't.

## Step 2: Check independence (all must be true to parallelize two tasks)
- Disjoint write scope (no shared files; shared directories only if different files).
- No data dependency (task B doesn't need task A's output, migration, or generated artifact).
- No concurrent change to a **serialized resource**: schema/migrations, dependency manifests and lockfiles, generated API clients, shared config. Only ONE task per batch may touch each; serialize the rest. List your project's serialized resources in `briefs/_COMMON.md`.
- Different repos are naturally parallel, provided the contract between them is already fixed.

If unsure, serialize.

## Step 3: Size the batch
`N = min(max_parallel, number of independent ready tasks)`, where `max_parallel` is the PM limit (default 4). One developer per task. Never split one task across developers. Never spawn a developer for a task under ~10 minutes of work; bundle trivial tasks into one brief.

## Step 4: Spawn
Launch all N in a single message (parallel Agent calls), `subagent_type: developer`. Each prompt is the delegation brief from `pm.md`, including:
- task ID, goal, docs list,
- scope allowed AND scope forbidden (other developers' scopes),
- acceptance criteria,
- iteration budget: 8 iterations, 3-same-error stop, timebox per the operating rules,
- handoff path `.claude/context/handoffs/<date>-<task-id>-developer.md`,
- instruction: do not commit; do not touch shared files outside scope; report instead of expanding scope.

When scopes touch the same repo, pass `isolation: "worktree"` and merge in Step 6.

## Step 5: Wait
Do not poll. Completion notifications arrive automatically. Meanwhile you may spawn `ui-ux` for the next step's specs (counts toward the parallel limit).

## Step 6: Collect
For each result read the handoff, not the full transcript.
- `DONE`: queue a `qa` task (one qa per feature/batch).
- `PARTIAL`/`BLOCKED`: respawn at most twice with a narrowed brief that includes the previous error; after that mark `BLOCKED` and escalate to the human.
- If worktrees were used, merge sequentially, resolve conflicts, rerun checks once.

## Step 7: Close the batch
Invoke `context-keeper` once for the batch (the Stop hook also prompts for it when handoffs are pending). Then plan the next batch. It counts against the re-plan limit only if the plan itself changed.

## Anti-patterns
Spawning for dependent tasks · overlapping scopes · more than the parallel limit · vague briefs · no budget · respawning a failed task unchanged.
