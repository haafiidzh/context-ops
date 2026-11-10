# 01 — Agent Operating Rules

Applies to every agent. Goal: never burn time or tokens looping on a failing approach.

## 1. Iteration limits (hard caps)

An **iteration** = one change -> run a check -> read the result. Count every one.

| Role | Per-task cap | Same-error cap | Other caps |
|---|---|---|---|
| developer | 8 iterations | 3 identical failures -> stop | Max 25 tool calls exploring before the first edit; no refactors beyond scope |
| ui-ux | 2 revision rounds per spec | — | Max 1 reference-gathering pass (<= 5 fetches); spec complete in round 1 |
| qa | 2 retest cycles per ticket | 2 flaky reruns, then mark flaky | Max 1 exploratory pass per feature (<= 20 tool calls) |
| pm | 2 re-plan rounds per milestone | — | Max 4 agents in parallel; max 2 respawns per failed task |
| context-keeper | 1 pass per invocation (<= 60 tool calls) | — | Never edits source code |

Write `iter N/cap` in the handoff. At the cap you MUST stop, even if the next try looks promising.

## 2. Stop-and-report protocol (when a cap hits or you are blocked)
1. Stop making changes. Leave the tree in a safe state (revert or isolate half-done edits; never leave a broken build).
2. Write a handoff with status `BLOCKED` or `PARTIAL`: what was tried, exact error text, hypothesis, what is needed.
3. Return a 5-line summary to the caller. Do not retry on your own.

## 3. Timeboxes (wall-clock guidance)
Setup/scaffold <= 20 min. Single feature slice <= 40 min. Bugfix <= 20 min. A command silent for more than 5 minutes: abort it and count one iteration. Dev servers, watchers and containers run in the background only; stop them before finishing.

## 4. Doc usage
- Read only the docs listed in your brief, plus `00-product-brief.md` on your first task. Do not read all docs.
- If docs conflict or are silent: take the documented default, note it under `Assumptions` in the handoff, move on. If the default touches security or cost, take the stricter option.

## 5. Scope discipline
Do exactly the task. No drive-by refactors. No new dependencies without listing them in the handoff.

## 6. Handoffs and context
- Every finished task ends with a handoff (`DONE`, `PARTIAL`, `BLOCKED`) at `.claude/context/handoffs/<date>-<task-id>-<role>.md`. Template: `.claude/context/handoffs/README.md`.
- Agents do NOT edit `CONTEXT.md`, `DECISIONS.md`, `TASKS.md` (owned by `context-keeper`). PM may edit the `TASKS.md` status column for tasks it assigned.
- The Stop hook asks the main thread to run `context-keeper` when handoffs are pending. Do not invoke it per task.
- Proposed decisions go in the handoff `Decisions proposed` section.
- Questions for the human go through PM / the main thread into `.claude/question-confirmation.md`.

## 7. Definition of Ready (PM checks before delegating)
Goal in one sentence · doc refs · testable acceptance criteria · scope allowed and forbidden · owner role · iteration budget.

## 8. Task IDs
`<milestone>-<nn>`, e.g. `M2-03`. Cross-cutting `X-nn`, QA runs `QA-nn`, human actions `H-nn`, backlog `B-nn`. Referenced in `TASKS.md`, handoff filenames and branch names. IDs are never reused.
