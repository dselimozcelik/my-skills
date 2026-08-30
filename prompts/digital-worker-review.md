# Digital Worker review prompt

Use the `ai-native-task-tutor` skill in Digital Worker review mode.

The Digital Worker has finished a one-shot implementation and its changes are now available in this local repository. Do not trust or teach from the worker's summary. Inspect the actual repository state, base-to-head diff, changed tests, configuration, and local build behavior.

First reconstruct or verify the shared model:

- current behavior before the change;
- desired behavior and acceptance criteria;
- the implementation plan we agreed before dispatch, if available;
- changed boundaries and end-to-end flow.

Map every meaningful changed hunk to a plan step. Separate:

1. changes that match the plan;
2. planned behavior that is missing;
3. extra or unexpected changes;
4. new concepts or risks introduced by the implementation.

Then replay the implementation locally one plan step at a time. For each step:

1. show the closest existing repository example;
2. ask what I think the relevant code or diff does;
3. use `teach` for the smallest missing concept based on my global mastery profile;
4. inspect the actual diff with me;
5. run focused local validation and explain what it proves and does not prove;
6. have me explain the behavior before marking the step understood;
7. reconnect the step to the updated end-to-end flow.

Do not ask the Digital Worker for lessons, quizzes, mastery evaluation, or learning reports. The local repository is the lesson surface and this local AI is the tutor.

At the end, review Spec and Standards separately. Ask me to synthesize the complete flow, key mechanism, and one realistic failure signal, one question at a time. Persist only demonstrated, sanitized capability with no company identifiers, source, repository paths, internal architecture, schemas, payloads, credentials, endpoints, customer data, or production values. Report Delivery and Learning separately.
