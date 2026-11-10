# M2-07 — usage_status tool (developer)
Status: DONE
Iterations used: 5/8

## Summary
Added the `usage_status` tool. Returns plan, used, remaining, reset date and upgrade link. Never counts against quota and never calls the upstream lookup.

## Changes
- src/tools/usage-status.ts: new tool handler
- src/tools/index.ts: registration only
- tests/unit/tools/usage-status.test.ts: 6 cases incl. no quota reservation, no upstream fetch

## Checks run
- `pnpm test tests/unit/tools/usage-status.test.ts` -> 6 passed
- `pnpm lint` -> clean
- `pnpm typecheck` -> clean

## Assumptions
- Reset date shown in the business's local time zone, as `1 Nov (Sydney time)`; the requirements doc gave no format.

## Decisions proposed
- Upgrade link is built from `NEXT_PUBLIC_APP_URL` + `/pricing` rather than hard-coded.

## Dependencies added
- none

## Blockers / needed
- none

## Open questions
- none

## Follow-ups
- QA task for the full tool suite after M2-05 and M2-07 are both merged.
