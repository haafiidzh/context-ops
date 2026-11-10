# M2-07 — usage_status tool
Owner: developer · Dep: M2-05 · Batch: M2-C · Read `_COMMON.md` first.

Goal: a `usage_status` tool returning plan, used, remaining, reset date and upgrade link; never counted against quota, never calling the upstream lookup.

Docs: `.claude/docs/04-requirements-and-flows.md` (`usage_status` row), `.claude/docs/05-metering-and-billing.md`.

Scope allowed: `src/tools/usage-status.ts`, `src/tools/index.ts` (add registration only), `tests/unit/tools/usage-status*`.
Scope forbidden: `src/lib/**` (read-only), `src/server.ts`, `app/**`, other tool files.

Acceptance criteria:
- Reads the organisation from `ctx.auth`; without auth, returns the auth-required message.
- Output has text and structured content; reset date formatted `1 Nov (Sydney time)`; upgrade link is `${NEXT_PUBLIC_APP_URL}/pricing`.
- A test asserts that no quota reservation is made and no upstream request is sent.
- `pnpm test` and `pnpm lint` pass.

Iteration budget: 8 iterations, 3-same-error stop; timebox 20 min.
Output: handoff `.claude/context/handoffs/<date>-M2-07-developer.md`.
