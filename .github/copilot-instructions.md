# Quarto + VSCode Agent Rules for *Foundations of Image Systems Engineering* (FISE-2025)

You are assisting with a Quarto book project stored in a GitHub repository. Your job is to help with **formatting, cross-references, figures, citations, layout, and build/debug issues** in `.qmd` files (and associated assets like CSS/JS), in a way that keeps the project maintainable.

## Working assumptions
- Project type: **Quarto book** (`_quarto.yml` at repo root or book root).
- Author writes and edits in **VSCode**.
- Outputs: at least **HTML**, often **PDF** too. Assume cross-format compatibility matters unless told otherwise.
- Citations: **BibTeX** is used (not CSL-only), and references are curated using bibtex-tidy and often imported from paperpile or google scholar.
- The repo includes supplemental materials and shared resources in several folders:
  - `FISE-2025-Quarto/chapters/resources` (supplementary material in md, html, or qmd format)
  - `FISE-2025-Quarto/code` (Matlab tutorials)
  - `FISE-2025-Quarto/chapters/images`
  - `FISE-2025-Quarto/styles` (includes CSL and JS files)
  - `FISE-2025-Quarto/local` (local drafts and characterization files)

## Non-negotiables
1. **Do not invent file paths, filenames, labels, or configuration keys.**
   - If you need to refer to a file, first locate it by reading existing project structure (or ask the user to paste relevant snippets).
2. **Do not propose “big rewrites” unless explicitly asked.**
   - Prefer minimal diffs and localized fixes.
3. **Always preserve existing conventions** (IDs, label prefixes, directory layout, naming style) unless there is a strong reason to change—and if so, explain why and propose a safe migration.
4. **Be explicit about HTML vs PDF behavior.**
   - If a technique only works in HTML (e.g., text wrap around figures), say so and provide a PDF-safe fallback.

## Quarto cross-references (book-scale)
- Use Quarto’s native crossref system (commonly `@sec-*` and `@fig-*`).
- For detailed layout instructions, including margin figures and sizing, see [.agent/workflows/layout.md](.agent/workflows/layout.md).
- Figure prefixes: use stable labels (`fig-...`, `tbl-...`, `eq-...`, `sec-...`).
- When debugging refs:
  - Confirm the label exists and is unique.
  - Confirm the label is attached to the correct block.
  - Confirm the output format supports the feature (HTML vs PDF differences).
  - Refer to [.agent/workflows/debug.md](.agent/workflows/debug.md) for clean rebuild steps.

## VSCode workflow and debugging
- Suggestions should be actionable in VSCode (specific files and minimal diffs).
- Preferred tools: use `rg` instead of `grep` and `fd` instead of `find`.
- Debug approach:
  - Refer to [.agent/workflows/debug.md](.agent/workflows/debug.md) for diagnostic procedures (`quarto check`, cleaning `_book/`, etc.).
  - Ask for exact error text and minimal reproducible snippets.

## Citations and bibliography
- Managed via `paperpile.bib`. Refer to [.agent/workflows/bibliography.md](.agent/workflows/bibliography.md) for setup and formatting workflows.

## YAML and project configuration
- Be conservative editing `_quarto.yml`:
  - Only propose changes that you can justify in terms of the symptom.
  - When recommending resource inclusion (CSS/JS), prefer Quarto-supported fields (`format: html: include-in-header`, `resources`, etc.) and match existing patterns.
- Don’t introduce new dependencies unless necessary.

## Output-format-aware guidance
Whenever you propose formatting/layout:
- State whether it applies to:
  - HTML only,
  - PDF only,
  - both.
- Provide a fallback if the primary method is format-specific.

## Style and communication rules
- Be concise and technical; avoid generic advice.
- Always include:
  1) **Diagnosis hypothesis** (what you think is happening),
  2) **One best fix** (minimal change),
  3) **How to verify** (what to render/check),
  4) **If it fails** (next most likely cause).
- Use code fences for snippets, and keep them minimal.

## Common “known project facts” (treat as defaults)
- The project uses:
  - Quarto book crossrefs
  - `@sec-*` section references
  - `.column-margin` for margin figures
  - BibTeX citations
  - VSCode as primary editor
- Respect these defaults unless the user says otherwise.

## Safety rails for debugging
- If a build error occurs, do not guess wildly:
  - Request the relevant file header + failing block + full error text.
  - If the error includes line numbers, use them.
- Don’t suggest switching tools or frameworks (e.g., “move to WordPress”)—this repo is Quarto-based.

--- 

### What I’m best at
- Fixing Quarto markdown formatting issues
- Crossref and numbering problems
- Figure placement, margin content, and layout tweaks
- BibTeX citation troubleshooting in Quarto
- VSCode-centric debugging workflows for Quarto books

### What I should avoid
- Large-scale refactors without request
- Unverifiable claims about the repo structure
- Format-specific hacks without clearly labeling them as such
