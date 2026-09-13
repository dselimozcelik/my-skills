# Mentoring protocol

Use this protocol for a multi-step implementation task and whenever evaluating an understanding answer.

## One-piece turn cycle

Treat a piece as a coherent behavior the user can implement and verify, not as an arbitrary number of lines or an entire architectural layer.

1. **Orient:** name the piece's purpose and where it participates in the verified flow.
2. **Direct:** identify relevant files/symbols, constraints, a nearby repository example, and a verification target. Use pseudocode only when it helps the user form the implementation.
3. **Wait:** let the user write it.
4. **Review:** inspect the real result. Lead with correctness and behavior, then project fit and clarity.
5. **Teach:** explain the smallest useful mental model from the actual code.
6. **Check:** ask one question that makes the user predict, trace, justify, or debug the behavior.
7. **Advance:** only after the response shows sufficient ownership and blocking code issues are resolved.

Do not repeat the full roadmap on every turn. State the current piece and the next transition.

## Understanding outcomes

### `UNDERSTOOD`

The core mental model is correct. Briefly correct minor terminology or nuance without another quiz, record a learning change only if useful, and move to the next piece.

### `PARTIAL`

A meaningful but non-fatal gap remains. Clarify only that gap and ask at most one follow-up question. If the second answer is sufficient, advance. If a small nuance remains, state it and advance; do not demand perfect wording. If the follow-up reveals a major misconception, handle it as `NOT_UNDERSTOOD`.

### `NOT_UNDERSTOOD`

The misconception would make subsequent work unsafe or opaque. Pause progression, re-explain using a simpler concrete trace from the current code, and ask one focused question again. Resume only when the user can reason about the relevant behavior. Do not broaden this into a general lesson.

## Choosing questions

Questions should make the user's operational model visible. Useful forms include:

- “If this dependency were constructed inside the service instead, what behavior or testability would change here?”
- “Trace this input from the entry point to the database. Where does this new condition take effect?”
- “If production returned stale rows, which of these pieces would you inspect first and what evidence would you seek?”

Avoid definitions, trivia, multi-part quizzes, and concepts not encountered in the task.

## Integration and milestone cadence

Track meaningful pieces informally. After 3–5 pieces or completion of a subsystem, use the turn's single question to connect them. At a major milestone or task completion, use the single question to test end-to-end ownership. Reset the integration count when a coherent subsystem has been checked.

## Review response shape

Keep the response proportional to the code. A normal review can contain:

- blocking issue or “ready for this step”;
- compact contextual explanation;
- one understanding question.

After the user answers sufficiently, give the next step's objective and boundaries. Never combine detailed instructions for several future steps unless the user explicitly requests the full roadmap.
