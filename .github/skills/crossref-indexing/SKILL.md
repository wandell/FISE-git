---
name: crossref-indexing
description: Use when adding backward-pointing cross-references from a chapter (especially a review/summary chapter) to the figures or sections in earlier chapters that first introduced each concept. Activate for "add references to earlier chapters," "link back to where this was introduced," building a review/recap chapter, or diagnosing "Unable to resolve crossref" warnings.
---

# Crossref Indexing

Building an index of cross-references means walking a chapter's concepts and,
for each one, pointing back to the specific figure or section elsewhere in
the book that first introduced it — the same instinct as a book's back-of-book
index, expressed as live Quarto crossrefs instead of page numbers.

## Workflow

1. **Enumerate LIVE candidate targets before writing anything.** A plain
   `rg` sweep for `\{#(fig|sec)-` is not enough — it matches labels sitting
   inside `<!-- ... -->` HTML comment blocks just as readily as real content,
   and this book comments out figures freely while chapters are being
   reorganized (a whole chapter's worth of pulse-sequence figures were
   commented out this way in one recent pass). A commented-out label will
   never resolve, no matter how correctly it's spelled. Filter comments out
   before you trust the list:

   ```sh
   awk '
     /<!--/{incomment=1}
     !incomment { while (match($0, /\{#(fig|sec)-[a-zA-Z0-9_-]+/)) {
       print substr($0, RSTART+2, RLENGTH-2); $0 = substr($0, RSTART+RLENGTH) } }
     /-->/{incomment=0}
   ' chapters/ch05-mr-signal-fundamentals.qmd
   ```

   Run this per chapter across the range you're indexing. Only cite labels
   that come out of this filtered list, never labels found via a raw
   `rg '\{#fig-'` sweep.

2. **Map each concept to its best target.** Prefer the figure whose caption
   states the concept in plain language over a generic title-slide figure.
   For a whole-topic pointer (not one figure), use an existing `{#sec-...}`
   label if the section already has one — most sections in this book do not,
   so fall back to a representative `@fig-` inside that section rather than
   inventing a chapter- or section-level label.

3. **Insert refs inline**, usually parenthetical, matching existing prose
   style in the book:

   ```md
   * Longitudinal magnetization (@fig-ch07-the-two-types-of-signals-longitudinal-recovery-t1)
   ```

4. **Verify every label before and after inserting it:**

   ```sh
   rg -n '#fig-ch07-the-two-types-of-signals-longitudinal-recovery-t1' chapters/
   ```

   A hit count of exactly one confirms the label is real and unique. Never
   guess a label from a figure's filename or topic — filenames and labels
   frequently diverge (e.g. `images/ch06/the-rf-signal-b1-causes-...png` vs.
   a differently-worded `#fig-` id).

5. **Render to confirm resolution:**

   ```sh
   quarto render 2>&1 | rg 'Unable to resolve crossref'
   ```

   If nothing prints, every crossref in the book resolved.

## Diagnosing "Unable to resolve crossref" warnings

In order of how often each cause actually turns out to be it:

1. **The label is inside an HTML comment.** By far the most common cause.
   Open the source file and check whether the figure sits between `<!--`
   and `-->`. Fix: pick a different, live figure covering the same concept
   (use the filtered `awk` sweep from step 1 to find one), or — if no live
   figure covers that concept yet — drop the parenthetical crossref rather
   than force a citation to content that isn't there. Don't uncomment the
   figure yourself to make your citation work; that's the chapter author's
   call, not something a crossref edit should trigger as a side effect.
2. **The `@fig-`/`@sec-` id doesn't match any real label** — a typo, or a
   reference to an id that was renamed/removed elsewhere. Grep for it
   (`rg -n '#the-exact-label' chapters/`); zero hits means it never existed
   or no longer does.
3. **A stray double-`@`** (`@@fig-...` instead of `@fig-...`) escapes Pandoc's
   citation syntax and is treated as literal text — the crossref filter never
   sees it, so it won't resolve. Grep for `@@fig-` / `@@sec-` to catch these.
4. **The id belongs to something crossref doesn't number**, e.g. a
   `{.panel-tabset #fig-...}` div rather than an actual figure/table/section.
   Crossref only tracks fig/tbl/eq/sec ids on the element types it numbers.
5. Only after ruling out 1–4: a stale `.quarto/xref` / `.quarto/idx` cache
   (both gitignored). Cheap to rule out — `rm -rf .quarto _book && quarto
   render` — but in practice this was not the explanation for any of the
   warnings encountered while building this skill; don't reach for it first.

Verify your hypothesis with real evidence (open the source file, check the
rendered `_book/**/*.html` for the anchor and its assigned figure number)
before concluding a fix. If a pre-existing, untouched reference elsewhere in
the book shows the same warning for the same reason, that's a pre-existing
early-draft issue in that chapter, not something your edit needs to fix —
per the repo's own guidance, flag it with the exact file and warning text
rather than silently working around it.

## Avoid

- Inventing `@sec-`, `@fig-`, or `@eq-` labels that aren't verified to exist.
- Linking chapters with bare markdown paths (`](ch05-mr-signal-fundamentals.qmd)`)
  — this book's convention is inline `@fig-`/`@sec-` crossrefs, not file links,
  for chapter-to-chapter pointers (file links are reserved for `chapters/resources/`).
- Adding a crossref to every sentence of a review chapter — one well-chosen
  anchor per concept is enough; over-citing a recap paragraph makes it harder
  to read, not easier to navigate.
