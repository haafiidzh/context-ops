# Example Service: Current Context

Owner: `context-keeper`. Snapshot, not a log. Last updated: 2026-11-04 (pass verified at repo HEAD `a1b2c3d`).

## Phase
Milestone M2 in progress. M0 and M1 closed (QA-01 PASS).

## Milestone status
| M | Status |
|---|---|
| M0 Foundation | DONE |
| M1 Auth and accounts | DONE |
| M2 Core tools | DOING: M2-01..05 done; M2-07 done; M2-06 PARTIAL (tests not run, see handoff) |
| M3 Billing | TODO |

## What exists
- `src/tools/`: 4 tools registered (`check_vendor`, `usage_status`, ...); verified by listing `src/tools/index.ts`.
- Tests: 87 passing (`pnpm test`, re-run by context-keeper on 2026-11-04).

## How to run
`pnpm install && cp .env.example .env.local && pnpm dev`

## Awaiting human
- Approve `example-package` (M3-02 needs it). Mirrored in `question-confirmation.md`, High Dependencies 1.

## Known issues
- M2-06: handoff said DONE but no test output was recorded; downgraded to PARTIAL until QA runs it.

## Drift
- `.env.example` lacks `UPSTREAM_TIMEOUT_MS` read in `src/lib/client.ts:12`; task X-04 added.

## Next up
M2-08, QA-02, X-04.
