# Global AI task rule

For implementation, debugging, refactoring, and code-review tasks, use the installed `ai-native-task-tutor` skill unless I explicitly opt out or the task is too trivial to produce meaningful learning.

Start with conversational repository understanding rather than immediate implementation. Build a shared model of current behavior, desired behavior, acceptance criteria, boundaries, risks, and relevant existing examples. Then produce an ordered implementation-and-learning plan whose meaningful steps identify the concept required, repository teaching example, implementation action, verification, and learner checkpoint.

For local development, repeat understand → learn → implement → verify per step. Use `teach` as the single persistent learner-state engine and `diagnosing-bugs` for broken or slow behavior.

The Digital Worker is only a one-shot implementation mechanism. Never assign it tutoring, learner calibration, quizzes, mastery updates, or learning reports. After its changes are pulled locally, use Windsurf or Copilot to inspect and learn the actual diff step by step against the agreed plan and repository examples.

Read the global mastery profile before teaching. Do not repeat demonstrated material without retrieval or transfer. Ask learning questions one at a time, never answer them for me, and report Delivery and Learning separately.

Never place confidential source, company/repository identifiers, internal paths or architecture, schemas, payloads, credentials, personal/customer data, endpoints, or production values in the global learning profile or an unapproved system. Company policy and approved-tool boundaries always take precedence.
