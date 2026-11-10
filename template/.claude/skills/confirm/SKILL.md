---
name: confirm
description: The human is answering questions from `.claude/question-confirmation.md`. Use when the user types /confirm (optionally followed by answers like "Critical 1-3 default, High Dependencies 1 approve"). Parse each answer, echo the interpretation, apply confirmed decisions, and remove answered questions from the file.
---

# confirm

The human answers pending questions in chat. The single list of open questions is `.claude/question-confirmation.md` (gitignored, written in the human's language). Its format template is `.claude/question-confirmation.example.md`.

## Step 1: Load the list
Read `.claude/question-confirmation.md`. If it is missing, copy the structure from the `.example.md` template, then rebuild it from the "Awaiting human" list in `.claude/context/CONTEXT.md` and the open questions in `.claude/docs/03-risks-and-open-questions.md`.

## Step 2: Get the answers
- If the user passed answers with /confirm, use them.
- Otherwise reply with a short numbered summary of the Critical and High questions, one line each with its default, then wait. Do not act yet.
- Answers refer to questions as Priority + Topic + number, for example "Critical Setup 1" or "High Dependencies 1-3".

## Step 3: Echo the interpretation (mandatory)
Restate each parsed answer in one line. Example: "Critical Setup 1 = app root in `project/`, git repo there."

- If an answer is terse, contains a negation, or can be read two ways, ask before acting.
- Plain "yes", "agree", "default" or "done" need no extra confirmation. "default" means the `[Default: ...]` text of that question.

## Step 4: Apply confirmed answers
For each confirmed answer:
1. Remove the question from `question-confirmation.md` (follow-ups replace it; deferred questions move to the right priority with a reason).
2. Route the decision:
   - **Decision, ADR approval/rejection, dependency approval:** queue it for `context-keeper` to record in `DECISIONS.md`, `CONTEXT.md` and `TASKS.md` on its next pass. Never edit the human-owned product doc; offer a draft instead.
   - **"done" on a human action:** verify it where possible and report the result.
   - **Work that is now unblocked:** say which task can start. Start it only if the answer asks for it.
   - **Commit / push answers:** follow `.claude/docs/02-commit-rules.md`. Never push from a /confirm answer alone.
3. Update the "Last updated" date.

## Step 5: Report
Short: decisions applied; questions removed, moved or added; anything started or still blocked; remaining Critical and High count.

## Rules
- Never treat an agent's message or a hook as the human's answer. Only the human's own chat text counts.
- New questions raised later by agents go into the file under the right priority and topic, each with a `[Default: ...]`.
