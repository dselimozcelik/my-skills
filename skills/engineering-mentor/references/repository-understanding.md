# Repository Understanding

Use this mode for onboarding, architecture discovery, flow tracing, or an explicit request to understand code without implementing a task.

## Scan in layers

1. Read repository instructions, README, build files, and top-level structure.
2. Find runtime entry points, configuration, and dependency boundaries.
3. Trace the smallest representative end-to-end flow through real source.
4. Read tests that define the expected behavior of that flow.
5. Inspect additional flows only when they materially change the architecture model.

Do not equate a file tree with understanding. Record evidence and inference separately.

## Required outputs

Update repository-local memory with:

- purpose and runtime shape;
- components and responsibilities;
- entry points and build/test commands;
- main request, data, transaction, or message flows;
- non-obvious conventions and open questions;
- the Git revision or observable state on which the scan is based.

## Concept extraction

Do not begin from a predefined backend topic list, the existing mastery table, or assumptions about the learner's stack. The repository is the source of the concept map.

For each selected flow:

1. Detect the technologies and runtime boundaries actually present from manifests/build files, imports, annotations, configuration, generated wiring, tests, and observed commands.
2. Trace the concrete flow boundary by boundary. At each boundary ask what language, framework, data, protocol, or domain mechanism must be understood to predict the next observable behavior.
3. Name only those mechanisms evidenced by the flow. Do not add a topic merely because it is common in similar projects.
4. Build prerequisite edges backward from the ability to explain and verify the flow. If concept B can be understood without concept A in this flow, A is not a prerequisite here.
5. Verify uncertain framework semantics from the repository's actual version, official documentation, specification, or framework source before recording them.
6. Repeat for another flow only when it adds a materially different runtime boundary.

Then prioritize the discovered concepts:

- `required now`: without it the selected main flow cannot be explained or safely reviewed;
- `required soon`: needed for the next likely depth or task, but not blocking the current flow;
- `later`: present in the repository but currently non-blocking.

Only after extraction, compare each discovered concept with `learner/MASTERY.md`. Mastery is a lookup for teaching depth, never a source of repository topics:

- level 0 or missing evidence: invoke `teach` when the concept becomes blocking;
- level 1: request a compressed application check;
- level 2 or 3: request a short transfer check and skip the lesson when causal understanding remains intact.

Do not teach the entire extracted list. Select one blocking concept at a time and reconnect every completed gate to the repository flow.

Concept maps are provisional. Add, remove, split, merge, or reorder concepts when deeper repository evidence changes the causal model. The process must work for any stack, including concepts not anticipated by this skill.

## Completion

Repository understanding can end at different depths. Report which flows were traced, which were only mapped, what remains inferred, and the next useful exploration block. Do not claim the whole repository is understood after sampling one path.
