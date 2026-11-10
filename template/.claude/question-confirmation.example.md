# Questions awaiting confirmation

Template for `question-confirmation.md` (gitignored). Copy this file to `question-confirmation.md` and write the real list in your preferred language.

Rules:
- The human answers in chat (`/confirm`), not in this file.
- One question per numbered line, grouped by priority, then by topic.
- Every question ends with `[Default: ...]` (the recommended answer) or `[Your action]` when the human must do something.
- Remove a question as soon as it is confirmed in chat, and record the decision where it belongs (`context/DECISIONS.md`, via context-keeper).
- Add new questions as soon as an agent raises a human decision.
- In chat, refer to questions as Priority + Topic + number, e.g. "High, Dependencies 2".

Last updated: YYYY-MM-DD

---

## Critical
Blocks work that is ready to start now.

### Setup
1. Example: where does the app code live? [Default: `app/` at the project root]

---

## High
Needed before the next milestone starts.

### Dependencies
1. Approve `example-package` for <reason>? [Default: approve]

---

## Medium
Design decisions already applied provisionally.

### Config
1. Example config-shape decision. [Default: ...]

---

## Low
Can wait.

### Publishing
1. Example later decision. [Your action]
