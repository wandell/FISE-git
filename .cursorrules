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
- Use Quarto’s native crossref system consistently.
- Sections: use the project’s established approach for section refs (commonly `@sec-*`).
  - If the user reports `@chapter-*` not working, do not insist on it; use `@sec-*` or whatever the project already uses.
- Figures/tables/equations: use stable labels and consistent prefixes.
  - Prefer `fig-...`, `tbl-...`, `eq-...`, `sec-...` (or match the repo convention).
- When debugging refs:
  - Confirm the label exists and is unique.
  - Confirm the label is attached to the correct block.
  - Confirm the output format supports the feature (HTML vs PDF differences).
  - Suggest a clean rebuild if stale intermediates are suspected (but don’t hand-wave; be specific).

## Figures, sizing, placement, and margin content
- The project uses Quarto figure options heavily. Prefer Quarto-native syntax:
  - `fig-cap`, `fig-alt`, `fig-align`, `fig-width`/`fig-height`, `out-width`, etc.
- Margin figures:
  - Use `.column-margin` where appropriate (this is a known working approach in this project).
  - Provide guidance that works with the project’s chosen HTML theme/CSS.
- “Half-page width with text wrapping”:
  - Be clear: **true text wrap around figures is usually HTML/CSS-driven**, not reliably portable to PDF.
  - Offer:
    1) an HTML solution (float + width + margins),
    2) a PDF-safe alternative (side-by-side columns, callouts, or figure placement without wrap).
- Images:
  - Encourage predictable repo paths (e.g., `images/`, `figures/`, `resources/`) and relative links.
  - Always suggest `fig-alt` for accessibility in HTML.

## WordPress-like needs inside Quarto
The author is used to LaTeX-style numbering and referencing:
- Ensure figures are numbered via Quarto crossrefs and can be referenced in text.
- If the author wants “LaTeX-like” behavior, prefer Quarto-native crossrefs rather than custom JS.

## Citations and bibliography
- Bibliography is BibTeX-managed via `paperpile.bib`. Assume this file is authoritative.
- Formatting is enforced by `bibtex-tidy` (via local CLI + VS Code settings). Refer to `.agent/workflows/bibliography.md`.
- Do not “correct” citation keys by guessing. If keys appear invalid, verify against the `.bib` file first.
- When suggesting tooling:
  - Be aware that certain BibTeX tooling can introduce unwanted formatting. Prefer the established `bibtex-tidy` workflow.

## VSCode workflow expectations
- Suggestions should be actionable in VSCode:
  - Point to which file to edit and what to change.
  - Prefer small, testable edits.
- Debug approach:
  - Ask for the exact error text and the smallest reproducible snippet (YAML header + the block that fails).
  - Recommend running `quarto check` and `quarto render` locally, and describe what to look for in the output logs.
  - If the issue smells like caching/stale build, suggest cleaning `_book/` or `_site/` (as appropriate) and re-rendering—state exactly which folder applies.

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
