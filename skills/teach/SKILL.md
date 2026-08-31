---
name: teach
description: Teach and verify a backend concept when engineering-mentor detects a knowledge gap during repository exploration, task delivery, debugging, or review, or when the user requests direct learning. Use repository evidence and persistent learner state; never implement the parent task.
license: MIT
metadata:
  author: mattpocock
  source: https://github.com/mattpocock/skills/tree/main/skills/productivity/teach
  adaptation: Global evidence-based backend learning profile for Selim
---

# Teach

Teach statefully across repositories and AI tools. Resolve the learner's durable state once per session: use `AI_LEARNING_HOME` when set; otherwise use `$HOME/.ai-learning/backend-engineering` on POSIX systems or `%USERPROFILE%\.ai-learning\backend-engineering` on Windows. Learner state lives under `learner/`; never store it in the current product repository. Read the profile before choosing what to explain; update it only after the learner demonstrates evidence.

This skill is a learning engine, not a task orchestrator. Do not plan or implement the parent task, edit product source, approve a semantic block, or continue the parent workflow. Finish the learning gate and return control to `engineering-mentor`.

This skill is adapted from Matt Pocock's `teach` skill. Preserve its mission grounding, zone of proximal development, retrieval practice, storage-strength focus, and compact learning records. Replace its assumption that the current directory is a course workspace with the global profile below.

## Global learning workspace

Use these files and directories under `<learning-home>/learner/`:

- `MISSION.md`: why the learner is building backend engineering ability and the observable outcomes that matter.
- `PREFERENCES.md`: stable teaching preferences and constraints.
- `MASTERY.md`: canonical concept levels, evidence pointers, and the next proof required.
- `LEARNING-QUEUE.md`: concepts discovered in repositories but intentionally deferred until they become useful.
- `GLOSSARY.md`: compressed definitions only for concepts the learner has demonstrated.
- `RESOURCES.md`: curated, high-trust primary sources and when to use them.
- `learning-records/*.md`: immutable evidence-backed insights, numbered sequentially.
- `sessions/*.md`: sanitized task-learning summaries; never proprietary code or data.
- `reference/*`: optional reusable cheat sheets. Create only when repeated lookup proves useful.

If the workspace is missing, create it from [MISSION-FORMAT.md](MISSION-FORMAT.md), [PREFERENCES-FORMAT.md](PREFERENCES-FORMAT.md), [MASTERY-FORMAT.md](MASTERY-FORMAT.md), [LEARNING-QUEUE-FORMAT.md](LEARNING-QUEUE-FORMAT.md), [GLOSSARY-FORMAT.md](GLOSSARY-FORMAT.md), [RESOURCES-FORMAT.md](RESOURCES-FORMAT.md), and [SESSION-FORMAT.md](SESSION-FORMAT.md). Do not create lesson HTML by default. A real codebase task is the primary lesson surface; create a reference artifact only when the user will plausibly reuse it.

## Start every lesson from state

1. Read `MISSION.md`, `PREFERENCES.md`, and `MASTERY.md`.
2. Read only the learning records and glossary entries relevant to the current task.
3. Inspect the smallest relevant slice of the current codebase, diff, test, log, query, or message flow.
4. Teach the single concept handed off by `engineering-mentor`, or the smallest prerequisite that blocks it. Do not front-load the repository's concept list.
5. Use current mastery to choose the entry point; do not restart from generic fundamentals automatically.

Do not store company names, repository paths, source code, customer information, internal architecture, credentials, or production values in the global workspace. Abstract evidence into a portable statement such as "explained why a proxied transaction boundary can be bypassed by self-invocation."

## Mastery model

Use four levels:

- `0 — unverified`: assume a beginner baseline; exposure is not evidence.
- `1 — explain`: can explain the central mechanism in their own words with light prompting.
- `2 — apply`: can apply and verify the concept in a real task with AI or documentation.
- `3 — debug/review/teach`: can diagnose failures, review another implementation, or teach the concept causally.

The initial level is provisional, not a judgment of intelligence or potential.

Before reteaching a level `2` or `3` concept, ask one short transfer or retrieval question. If the learner answers causally, skip the explanation and continue at the next useful layer. If they reveal a gap, teach the missing link and record the corrected evidence; do not erase prior progress.

For level `1`, give a compressed reminder only when needed, then require application. For level `0`, explain the minimum prerequisite chain from a beginner baseline.

Advance mastery only when the learner produces evidence. A green build, reading an explanation, or saying "I understand" does not count. Good evidence includes:

- tracing a request, transaction, query, or message flow without reading the answer;
- predicting behavior before running code;
- explaining why a framework mechanism behaves that way;
- selecting and defending a test seam;
- diagnosing a failure using observations;
- transferring the concept to a different example.

## Task-grounded teaching loop

For the current blocking concept:

1. **Retrieve first:** ask what the learner thinks the current code does or predict an observable result. Do not reveal the answer in the question.
2. **Diagnose:** separate what is correct, missing, and mistaken. Name the missing causal link precisely.
3. **Teach minimally:** explain only the knowledge required for the current task, grounded in actual repository evidence and a trusted primary source when framework behavior matters.
4. **Apply:** have the learner use the concept on the current code path, test, query, or failure scenario.
5. **Transfer when needed:** use a changed example when explanation alone cannot prove the current gate.
6. **Record:** update mastery and create a learning record only if the evidence satisfies the target level.

Ask one gate question at a time. Do not answer a question just asked. Do not praise intelligence; give specific formative feedback about the reasoning used.

For an ordinary semantic block, use no more than one to three high-signal causal questions. Add another question only when the learner's answer exposes a specific missing link; do not turn the gate into a broad quiz.

## Return contract

End the gate with this compact result and return control to `engineering-mentor`:

```text
Learning result: demonstrated | in-progress
Evidence: ...
Remaining gap: ...
Mastery update: yes | no
```

When the result is `in-progress`, state the smallest missing causal link. Do not authorize implementation or proceed with the parent workflow.

## Zone of proximal development

Select the smallest lesson that is both necessary for the current task and just beyond demonstrated mastery. Prefer one tangible win over a broad survey. A task involving `@Bean` may require container ownership and dependency injection; it does not automatically require every bean lifecycle callback or Spring scope.

Distinguish short-term fluency from storage strength. If a concept was explained recently but not independently retrieved, treat it as exposed rather than mastered. Use spaced and interleaved checks when they fit a later real task; do not interrupt urgent delivery with artificial quizzes.

## Knowledge quality

Use official documentation, framework source, specifications, and repository behavior for factual teaching. Add a source to `RESOURCES.md` only when it is high-trust and likely to be reused. Do not accumulate generic blog links.

## Updating state

After verified learning:

1. update the concept row in `MASTERY.md` with level, date, sanitized evidence, and next proof;
2. add a sequential learning record using [LEARNING-RECORD-FORMAT.md](LEARNING-RECORD-FORMAT.md) when the insight is non-trivial, a misconception was corrected, or prior knowledge was established;
3. add or revise a glossary definition only after the learner can use the term correctly;
4. append a short sanitized session record when the lesson came from a real task.

If new evidence contradicts an older record, supersede rather than delete it. Never mark a concept as mastered merely because it was covered.

## Relationship to the parent workflow

When used with `engineering-mentor`:

- that skill owns repository exploration, semantic blocks, task scope, implementation, review, validation, repository memory, and delivery status;
- this skill owns learner calibration, micro-lessons, mastery evidence, and global progress updates;
- a demonstrated learning result and explicit user approval precede implementation of the current semantic block;
- after returning the compact result, stop teaching and let `engineering-mentor` resume the parent workflow.
