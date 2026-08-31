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

For each selected flow, identify concepts that are causally required to explain runtime behavior. Build dependencies between concepts, then prioritize:

- `required now`: without it the selected main flow cannot be explained or safely reviewed;
- `required soon`: needed for the next likely depth or task, but not blocking the current flow;
- `later`: present in the repository but currently non-blocking.

Compare each concept with `learner/MASTERY.md`:

- level 0 or missing evidence: invoke `teach` when the concept becomes blocking;
- level 1: request a compressed application check;
- level 2 or 3: request a short transfer check and skip the lesson when causal understanding remains intact.

Do not teach the entire extracted list. Select one blocking concept at a time and reconnect every completed gate to the repository flow.

## Completion

Repository understanding can end at different depths. Report which flows were traced, which were only mapped, what remains inferred, and the next useful exploration block. Do not claim the whole repository is understood after sampling one path.
