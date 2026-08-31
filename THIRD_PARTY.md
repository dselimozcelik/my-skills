# Third-party notices

## Matt Pocock — skills

- Source: https://github.com/mattpocock/skills
- Reviewed revision: `6654f6b60cd9d5be8b54c6fafe44346dabeb3b76` (2026-08-24)
- License: MIT

Included material:

- `skills/teach`: adapted for a global, cross-repository, evidence-based backend learning profile. The original mission grounding, zone-of-proximal-development, retrieval-practice and durable-learning ideas are retained.

Each imported skill directory retains its upstream `LICENSE` file where supplied.

Ideas deliberately used without importing an additional skill:

- Separate **Spec** and **Standards** review axes from the code-review workflow.
- Focused validation during implementation and a proportionate full suite at completion.

Not bundled:

- `code-review`: its useful two-axis review idea is already small enough to live in the main orchestration skill.
- `implement`: overlaps substantially with the host coding agent; automatic commit behavior was not wanted.
- `diagnosing-bugs`: intentionally removed from this version; bug work follows the normal semantic-block workflow.
- `tdd`: intentionally removed from the portable bundle at the learner's request; ordinary task verification remains part of `engineering-mentor`, and a dedicated test-first skill can be added later if the team needs it.
- `retro`, `grilling`, `wait-what`: useful in other settings but not necessary for the initial task-to-learning loop.
- `agentic-learning`: overlaps with the customized `teach` state engine and would risk two competing progress records.
