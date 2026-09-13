# Task Mentor for GitHub Copilot and Windsurf

`task-mentor` turns GitHub Copilot or Windsurf Cascade into a senior mentor for real engineering tasks. It inspects the existing system, gives one implementation step at a time, reviews the code you write, checks your mental model, and tracks only useful learning signals. It never edits production code for you.

## Install once for both

Both tools discover skills in the shared `~/.agents/skills/` directory. Clone this repository so its root `SKILL.md` lands inside the skill folder:

```bash
mkdir -p ~/.agents/skills
git clone https://github.com/dselimozcelik/my-skills.git ~/.agents/skills/task-mentor
```

To update the installed copy later:

```bash
git -C ~/.agents/skills/task-mentor pull --ff-only
```

For repository-scoped use instead, place this repository at `.agents/skills/task-mentor/` inside the target repository.

## Invoke it

GitHub Copilot can select the skill automatically from the request. To make the choice explicit, start with:

```text
Use the task-mentor skill. Help me implement <task>. Inspect the repository first and guide me one step at a time.
```

In Windsurf Cascade, invoke it directly with:

```text
@task-mentor Help me implement <task>. Inspect the repository first and guide me one step at a time.
```

The mentor maps the relevant flow and shows a concise roadmap, but details only Step 1. You implement that step, return with the code, answer one ownership-focused question, and continue when your mental model is sufficient. Important foundations are marked for later study rather than expanded into a separate course.

## Learning tracking

The `knowledge/` directory is the canonical learning graph. Each concept is one Markdown note with YAML learning metadata and `[[Wiki Links]]` to related concepts. States are `DISCOVERED`, `FOUNDATION_RECOMMENDED`, `LEARNING`, and `LEARNED`; task-specific understanding is recorded separately and never promotes a topic to `LEARNED` by itself.

Open `knowledge/` as an Obsidian vault and use Graph View. Notes and links become nodes and edges automatically; no graph service or generated database is needed.

When the canonical graph is directly writable, the mentor updates only the affected notes. Otherwise it enters transfer mode, leaves canonical notes untouched, and appends only changed learning events to `learning-delta.md`. Transfer that small file, paste its events, or provide screenshots in a canonical-mode session and ask:

```text
Use the task-mentor skill to merge this learning delta into my canonical knowledge graph.
```

The mentor preserves stronger learning states, shows the merge summary, and clears the delta after you confirm the transfer. It never commits or pushes learning changes unless you ask.

See [`SKILL.md`](SKILL.md) for the behavior contract and [`learning-system.md`](references/learning-system.md) for the delta and concept-note schemas.
