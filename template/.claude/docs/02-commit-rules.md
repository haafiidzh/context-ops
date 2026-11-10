# 02 — Commit Rules

Project-owned template: fill in the placeholders, edit freely.

- **Commit policy:** <when agents may commit, e.g. only when the human asks in the current request>
- **Push policy:** <when agents may push, e.g. only after explicit human confirmation>
- **Message format:** <e.g. Conventional Commits prefix `feat:`, `fix:`, `chore:`, `docs:`, ...; single-line or with body>
- **Commit granularity:** <e.g. one commit per single context of change>
- **Attribution trailers:** <decide per project: allow or forbid `Co-Authored-By` / AI attribution lines>
- **Never commit:** secrets, real config, `.env*` (except `.env.example`), `node_modules`, build output, local DB files, `.claude/context/.sync-*`.
- **Pre-commit check:** <e.g. grep the staged diff for credential patterns before committing>

Examples: <add 3-4 sample commit messages in your chosen format>
