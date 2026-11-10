# 06 — Human in the loop

## Single question list
Agents never interrupt with scattered questions. Open decisions go into `.claude/question-confirmation.md`, grouped by priority (Critical, High, Medium, Low) and topic. Every item ends with `[Default: ...]` or `[Your action]`. The file is gitignored and may be written in your own language; `question-confirmation.example.md` is the English template.

## `/confirm`
You answer in chat: `/confirm Critical 1-3 default, High Dependencies 1 approve`. The skill:

1. Parses each answer.
2. **Echoes its interpretation** in one line per answer and asks when an answer is terse, negated or ambiguous.
3. Removes answered questions, queues the decision for `context-keeper` to record as an ADR.
4. Reports what is unblocked and the remaining Critical/High count.

Only the human's own chat text counts as an answer, never an agent message or a hook.

## Gates worth writing down
Put these in `CLAUDE.md` hard rules and `docs/03-risks-and-open-questions.md`:

| Gate | Typical rule |
|---|---|
| Cost | No paid service or API key without approval |
| Dependencies | Only the approved list; others need approval |
| Commits | Only when asked in the current request |
| Push | Only when asked **and** confirmed a second time |
| Product doc | Never edited by agents |
| Official docs first | Read current docs for external APIs; never rely on memory |

A hard rule is one an agent can check mechanically. "Write good code" is not a rule; "no `console.log` in `src/`" is.
