# 03 — Handoffs

A handoff is the only way an agent reports on project state. One file per agent per task: `<YYYY-MM-DD>-<task-id>-<role>.md` in `.claude/context/handoffs/`.

## Why files, not chat summaries
- A summary returned to the caller disappears when the session ends; a file survives and can be verified later.
- A fixed template makes missing information visible: no "Checks run" section content means no checks ran.
- `context-keeper` can process handoffs asynchronously, in batches.

## Fields that matter
| Field | Use |
|---|---|
| `Status` | `DONE`, `PARTIAL`, `BLOCKED`. `context-keeper` may downgrade `DONE` after verification. |
| `Iterations used` | `N/cap`. Shows how close to the limit the task ran. |
| `Checks run` | Commands and results. Without them, `DONE` is a claim, not a fact. |
| `Assumptions` | Where docs were silent and what default was used. Lets the keeper record or reject them. |
| `Decisions proposed` | Agents propose; the keeper decides whether it becomes an ADR. |
| `Dependencies added` | Surfaced so the human or PM can approve. |
| `Blockers / needed` | Exact error text. A paraphrase cannot be debugged. |

## Lifecycle
```
agent writes handoff ──► Stop hook sees it ──► context-keeper verifies and merges
                                                     │
                                                     ▼
                                      moved to handoffs/archive/<milestone>/  (never deleted)
```

## Briefs (the other direction)
PM writes a brief per task in `context/briefs/<task-id>.md` with goal, docs, scope allowed and forbidden, acceptance criteria, iteration budget, and output path. Every brief is read together with `briefs/_COMMON.md`, which holds rules shared by all tasks. A brief without a budget is not delegated.
