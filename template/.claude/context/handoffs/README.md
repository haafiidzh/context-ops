# Handoffs

One file per agent per task: `<YYYY-MM-DD>-<task-id>-<role>.md`. Processed files move to `archive/<milestone>/` (context-keeper). A pending handoff here triggers the Stop hook, which asks the main thread to run `context-keeper`.

## Template

```markdown
# <task-id> — <title> (<role>)
Status: DONE | PARTIAL | BLOCKED
Iterations used: N/cap

## Summary
<3 lines max>

## Changes
- <path>: <what>

## Checks run
- <command> -> <result>

## Assumptions
- <where docs were silent and what default was used>

## Decisions proposed
- <decision + why>  (or "none")

## Dependencies added
- <pkg@version + why>  (or "none")

## Blockers / needed
- <exact error text, what was tried, what is needed>  (or "none")

## Open questions
- <for human / PM>

## Follow-ups
- <next tasks suggested>
```
