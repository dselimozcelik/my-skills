# HTML Lesson Format

Create a compact, self-contained teaching artifact at `<learning-home>/learner/lessons/<concept-slug>.html`. Use a stable lowercase kebab-case slug. Update the same file when the concept deepens.

## Required content

1. **Title and status:** concept, last updated date, and current evidence status (`lesson created`, `in progress`, or demonstrated level).
2. **Why this mattered now:** a sanitized description of the repository flow or semantic block that triggered the lesson.
3. **Mental model:** the smallest causal explanation that makes the observed behavior predictable.
4. **Flow:** a short accessible diagram using semantic HTML/CSS or inline SVG with text labels.
5. **Sanitized example:** a minimal generic example derived from the repository mechanism without proprietary identifiers or copied source.
6. **Common misconception or failure:** what incorrect model would predict and why it fails.
7. **Self-check:** one to three high-signal questions. Put each answer in a collapsed `<details>` element.
8. **Next proof:** what the learner must explain, apply, or diagnose to advance mastery.
9. **Sources:** only official documentation, specifications, or framework source used for factual claims.

## Presentation requirements

- Use valid HTML5 with `lang="tr"` unless learner preferences specify another language.
- Put all CSS in one `<style>` block. Do not load remote assets, JavaScript, trackers, or fonts.
- Use a restrained readable layout, strong contrast, visible focus states, responsive widths, and semantic headings.
- Use `<code>` and `<pre>` for technical material and preserve keyboard readability.
- Keep the page focused on one concept. Do not turn it into a broad course chapter.

## Index

Create or update `<learning-home>/learner/lessons/index.html` with:

- concept title and link;
- last updated date;
- current mastery/evidence status;
- next proof.

The index must also be self-contained and must not expose proprietary context.
