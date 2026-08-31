# Shared Memory Layout

Resolve `AI_LEARNING_HOME`, falling back to the platform-specific `~/.ai-learning/backend-engineering` location. This directory must stay outside product repositories.

```text
<learning-home>/
├── learner/
│   ├── MISSION.md
│   ├── PREFERENCES.md
│   ├── MASTERY.md
│   ├── LEARNING-QUEUE.md
│   ├── GLOSSARY.md
│   ├── RESOURCES.md
│   ├── learning-records/
│   └── sessions/
├── repositories/<repo-id>/
│   ├── REPOSITORY.md
│   ├── ARCHITECTURE.md
│   ├── CONCEPT-MAP.md
│   ├── FLOWS.md
│   ├── OPEN-QUESTIONS.md
│   ├── TASKS.md
│   └── sessions/
└── active/<repo-id>.md
```

## Ownership and privacy

- `teach` is the only workflow that changes learner mastery, learning records, glossary, or learning queue.
- `engineering-mentor` changes repository memory and active session state.
- Learner evidence must be sanitized and portable: no company, repository, service, class, table, endpoint, path, payload, credential, customer, or production identifiers.
- Repository memory may contain company-repository knowledge because it stays on the company computer. Never sync it into the personal skill repository or an external service.

## Repository identity

Prefer a deterministic opaque digest of the normalized Git remote. If no remote exists, use a digest of the canonical repository root. Store human-readable repository metadata only inside that repository's local memory directory.

## Initialization and migration

Create missing directories and files conservatively. Never overwrite existing state. When legacy profile files exist at the learning root, copy their content into the corresponding `learner/` file only when the destination is missing; preserve the originals until the learner explicitly approves cleanup.

## Checkpoint rule

Checkpoint after each completed semantic block and after a repository-understanding flow. An active record must contain enough state for a new chat to resume without relying on the previous conversation transcript.
