# TODO: Shack-Hartmann / wavefront-sensing review

Context: the Shack-Hartmann / light-field-camera material was split out of
`lightfields-02-measurement.qmd` into a new chapter,
`optics-08-wavefront-sensing.qmd`, with the light-field-camera principle
landing in `sensors-07-innovations.qmd` and the human-eye application
rewritten around David Williams' 1997 result in
`human-02-spatial-encoding.qmd`. This note tracks what still needs a pass:
duplicated history, thin physical explanation, missing applications, and
terminology drift across the now five touched chapters.

## Duplication to resolve

- [ ] Three separate tellings of the Hartmann → Shack & Platt history now
      exist: `chapters/resources/lightfield-measurements.qmd` (the dedicated
      historical resource page), the "Lightfield measurement instruments"
      callout in `lightfields-02-measurement.qmd`, and the new "Hartmann's
      screen" callout in `optics-08-wavefront-sensing.qmd`. Pick one
      canonical version (probably the resources page) and have the other two
      link to it instead of repeating the story.
- [ ] Check whether `optics-08`'s "Hartmann's screen" callout and the
      `lightfields-02` timeline callout now say inconsistent things about
      Shack & Platt's date/contribution once one is trimmed.

## Physical explanation gaps

- [ ] `optics-07-wavefront.qmd`: several sections are still stubs mixed with
      real content — "### Phase: Wave direction" (one line), "### Amplitude:
      Pupil shape and transmission" (has working paragraphs but also loose
      notes-to-self), "## ISETCam and wavefronts" (empty heading), and
      "### Flare" (stub plus a stray leftover line — "Here's a
      Quarto-formatted explanation..." — that reads like unedited LLM
      scaffolding, not prose). Needs a real drafting pass.
- [ ] `optics-08-wavefront-sensing.qmd` "## Adaptive optics": explains what
      a deformable mirror does but not how the closed-loop correction
      actually works (measure wavefront → compute mirror shape → apply →
      re-measure). Consider whether that level of detail belongs here or is
      fine left to the eye-specific description in `human-02`.
- [ ] Confirm the $\nabla W$ / local-slope explanation in `optics-08` is
      pitched at the right level given `optics-07` only defines $W(\rho,\theta)$
      and the pupil function — no worked example of a lenslet's spot
      displacement is given.

## Applications to check

- [ ] `human-02-spatial-encoding.qmd`: re-read the rest of the chapter (past
      the new Adaptive optics section) for other Shack-Hartmann/AOSLO
      mentions that might now be stale, redundant, or use different wording
      than the rewritten intro.
- [ ] Same file has a pre-existing, unrelated bug worth fixing while in
      there: the div id `#fig-physiological-optics` is reused for two
      different tabset figure groups (the eyeball image/sketch near the top,
      and the retinal-layers panels later) — should get distinct ids.
- [ ] `sensors-07-innovations.qmd` Light Field Cameras section: verify the
      autofocus/DPAF application paragraph still reads well now that the
      Shack-Hartmann cross-reference points into `optics-08` rather than
      `human-02`.
- [ ] Decide whether the astronomy guide-star example in `optics-08` needs
      its own figure/citation, or whether the shared `fig-wavefront-sensing`
      diagram (astronomy + ophthalmology) is enough on its own.

## Terminology consistency

- [ ] "Ray direction" framing (`lightfields-02`) vs. "wavefront slope/tilt"
      framing (`optics-07`/`optics-08`) describe the same lenslet
      measurement in two different vocabularies. Check the handoff between
      chapters is signposted, not just an abrupt switch in language.
- [ ] "Macropixel" / "subpixel" (`sensors-07`, light field camera) vs.
      "lenslet" / "sub-aperture" (`optics-08`, wavefront sensor) — same
      physical arrangement (lenslet over a group of sensing elements),
      different vocabulary per chapter. Either harmonize or add an explicit
      one-line correspondence.
- [ ] Confirm "Shack-Hartmann wavefront sensor" is now used consistently
      everywhere (the old "S-H wavefront sensor" abbreviation in `human-02`
      was removed in this pass — double check no other file still
      abbreviates it differently).
- [ ] New citation `@liang1997-sm` (Liang, Williams & Miller 1997) was added
      in `human-02`; confirm the bibliography renders correctly and that no
      other chapter refers to this result with different framing or year.

## Cross-reference sanity

- [ ] Reading order is now: `optics-08` (general Shack-Hartmann + adaptive
      optics) → `sensors-07` (light field cameras, cross-refs `optics-08`) →
      `human-02` (eye application, cross-refs `optics-08`). Double-check no
      remaining "as we'll see later" phrasing points backward, and no
      "as we saw earlier" points forward, now that the chapter order changed.
