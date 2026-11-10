# Stack Rules

Project-owned. The `developer` agent reads this file before coding. Keep every line checkable by an agent.

## Language and framework
- <e.g. TypeScript strict, ESM; framework and version>

## Boundaries and conventions
- <e.g. validate input at trust boundaries; module layout; naming>

## Testing
- <test runner, commands for lint / typecheck / test / build>

## Forbidden
- <patterns the agent must never use>

## Dependencies
- Approved list: <path or inline>. Anything else: stop and report in the handoff.

## External APIs
- Read the current official docs before touching them; cite the URL in the handoff.
