# Learning system

Read this file before writing concept notes, appending a portable delta, or merging transferred events.

## Modes and source of truth

The skill repository's `knowledge/` directory is canonical.

- **Canonical mode:** the canonical graph is directly available and writable. Update concept notes there.
- **Transfer mode:** the canonical graph cannot be updated directly. Leave concept notes untouched and record portable events in `learning-delta.md`.

Choose the mode from the user's statement and actual file access. If still ambiguous, keep the proposed event in chat until the user identifies the intended mode. Committing or pushing learning files still requires the user's request.

## Foundational learning states

Use exactly one `learning_state` per concept:

- `DISCOVERED`: encountered and worth remembering; no separate study decision yet.
- `FOUNDATION_RECOMMENDED`: encountered and important enough for later deliberate study.
- `LEARNING`: deliberate foundational study is in progress. A normal task-mentor session does not assign this merely because the concept was discussed.
- `LEARNED`: durable foundational ownership has been established through explicit foundational-learning evidence or a user-approved update. Never assign this from one task-specific answer.

These states describe foundational learning, not whether the current task may continue. Store task-specific evidence separately with `UNDERSTOOD`, `PARTIAL`, or `NOT_UNDERSTOOD`.

Do not downgrade `LEARNING` or `LEARNED` because a transferred event recommends the foundation again. Add encounter evidence instead. Do not create notes for ordinary syntax or concepts the user already owns unless their state meaningfully changes.

## Canonical concept notes

Store one concept per Markdown file under `knowledge/<Area>/<Concept>.md`. Start from [the concept-note template](../templates/concept-note.md), removing empty optional sections. Keep filenames readable; use path-qualified wiki links if names would collide across areas.

YAML properties hold learning metadata. Wiki links in the body form graph edges. Add only relationships that help explain the current system; a small connected graph is better than a taxonomy.

When updating a note:

1. Preserve prior evidence and user-authored wording.
2. Update `last_seen` and foundational state only when justified.
3. Add a short dated encounter showing task context and the task-understanding outcome when useful.
4. Summarize the user's current working model without pretending it is foundational mastery.
5. Add minimal `[[Wiki Links]]` with a brief relationship label.

Obsidian can open the repository root or `knowledge/` as a vault and visualize those links in Graph View without a separate graph database.

## Transfer-mode delta

Append only real changes under `## Events` in the root `learning-delta.md`. Remove the `_No events._` marker when adding the first event. Use one compact block per concept change:

```text
[CONCEPT]
topic: Dependency Injection
area: Spring
state: FOUNDATION_RECOMMENDED
task_understanding: UNDERSTOOD
context: Constructor injection in OrderService
relation: Dependency Injection -> Spring Bean | supplies dependency
date: 2026-09-13
```

Rules:

- `topic`, `area`, `context`, and `date` are required.
- Include `state` only when the foundational state changed or a new concept was discovered.
- Include `task_understanding` only when it provides useful evidence.
- Repeat `relation` for multiple necessary edges; omit it when none changed.
- Use `?` for uncertain values rather than inventing detail.
- Keep each context to one short line so events remain screenshot-friendly.
- Never copy the whole graph into the delta.

## Canonical merge

When the user supplies a delta file, pasted events, or screenshots in canonical mode:

1. Transcribe only readable event data; flag ambiguous text instead of guessing.
2. Process events in date/order sequence and find the concept note by topic and area.
3. Create or update the note using the canonical rules above.
4. Preserve stronger states: transferred `DISCOVERED` or `FOUNDATION_RECOMMENDED` cannot replace `LEARNING` or `LEARNED`.
5. Create relationship targets only when they are themselves useful tracked concepts; otherwise keep the wiki link without manufacturing learning evidence.
6. Show a concise merge summary for review.
7. After the user confirms the events were transferred, restore `learning-delta.md` to its empty `_No events._` state. Do not commit or push unless requested.

Merging deltas updates the canonical graph; it does not perform the separate foundational-learning session.
