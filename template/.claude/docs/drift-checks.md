# Drift Checks

Project-owned. `context-keeper` runs every check below on each pass, even with zero handoffs. A check is a command or comparison with a clear pass condition. Fix docs when code is authoritative and intentional; otherwise list the mismatch under CONTEXT "Drift" and add a task.

| # | Check | How | Compare with |
|---|---|---|---|
| 1 | Exposed routes / tools / commands | <command that lists them> | requirements doc |
| 2 | Data model | <schema file> | data-model doc |
| 3 | Env names | `.env.example`, config schema, code reads | deploy doc |
| 4 | Dependencies | manifest file | approved list |
| 5 | Secrets | grep for credential patterns | must be empty |
| 6 | Tests | count only if a handoff changed tests | CONTEXT |

Delete rows that do not apply; add rows for anything whose silent divergence would cost you later.
