# Task start prompt

Use the `ai-native-task-tutor` skill for this task.

Do not start implementing immediately. First inspect the repository and talk through the task with me until we share a clear model of:

- what currently happens;
- what must change and what is out of scope;
- the request/data/message flow involved;
- acceptance criteria, risks, and validation;
- the closest existing repository examples.

Then create an ordered implementation-and-learning plan. For every meaningful step state the code boundary, concept I need, repository example that will teach it, implementation action, focused verification, and a short learner checkpoint. Read my global mastery profile and do not reteach demonstrated concepts without a retrieval or transfer check.

If we implement locally, work one step at a time using: orient → retrieve → teach → checkpoint → implement → verify → connect. Use `teach` for the smallest missing concept before that step is treated as understood. For a bug or performance issue, use `diagnosing-bugs` to build the red-capable feedback loop first.

If we use the Digital Worker, treat it only as a one-shot implementation mechanism. Give it the agreed implementation plan and normal acceptance criteria; do not ask it to teach me, quiz me, evaluate mastery, or produce a learning report. After I pull its changes locally, inspect the actual diff step by step with me using Windsurf or Copilot. Map each change back to the plan, teach required concepts from the repository, verify locally, and have me explain the change before marking that step understood.

At the end, ask me to synthesize the complete flow, key mechanism, and one failure signal, one question at a time. Persist only capability I demonstrate and sanitize all records so they contain no company identifiers, source, repository paths, internal architecture, schemas, payloads, credentials, endpoints, customer data, or production values. Report Delivery and Learning separately.
