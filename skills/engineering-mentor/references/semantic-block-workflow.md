# Semantic Block Workflow

A semantic block changes one coherent behavior or boundary. It may touch several files; file count does not define the block. Keep migrations, external side effects, public API changes, and distinct business behaviors in separate blocks when they can be understood and verified independently.

## 1. Orient

Show current behavior, the exact boundary, the closest repository example, the intended outcome, and why this block is ordered now. Identify relevant files and symbols without dumping unrelated code.

## 2. Learning gate

Derive concepts from the current behavior, changed boundary, concrete symbols, configuration, tests, and expected runtime effect. Do not consult a predefined curriculum or use mastery rows as a topic list. List only concepts that causally block ownership of this block, then invoke `teach` for the smallest gap. Do not implement while the learning result is `in-progress`.

## 3. Approval gate

Ask the learner to explain the intended runtime effect or key decision in their own words. Then ask one explicit approval question for this block. Do not treat agreement with the overall task as approval for every block.

## 4. Focused implementation

Change only the approved behavior. Preserve unrelated user work. If new scope appears, stop and reopen planning. Do not commit, push, merge, or create a pull request without separate approval.

## 5. Diff review

Review the actual diff together:

- what changed and why;
- runtime behavior and responsibility boundaries;
- meaningful alternatives and why this one was selected;
- realistic failure paths;
- unexpected, missing, or unnecessary changes.

## 6. Explain-back

Ask the learner to trace the changed behavior without repeating a prepared explanation. If a causal gap appears, invoke `teach` only for that gap and retest with a changed example.

## 7. Verify

Run the smallest check that observes the changed behavior, then state exactly what it proves and what remains unproven. Use a proportionate broader check only after focused evidence exists.

## 8. Checkpoint

Persist the completed block, validation, demonstrated learning, open risk, and next proposed block. Do not start the next block until it is oriented and approved.
