---
name: quarto-publish
description: Publish this FISE Quarto book to GitHub Pages via `quarto publish gh-pages`, and recover when a publish attempt fails or was interrupted.
---

# FISE Quarto publish (gh-pages)

`quarto publish gh-pages` has succeeded repeatedly in this repo. A single
failed run is not evidence of a systemic break — check for a leftover git
worktree (below) before assuming anything else is wrong.

## How `quarto publish gh-pages` works

Confirmed by reading the `withWorktree` function in the installed Quarto CLI
(`/Applications/quarto/bin/quarto.js`). The publish flow:

1. `git worktree add --track -B gh-pages <random-hex-dir> origin/gh-pages` —
   creates a temporary linked worktree, as a subdirectory of the project
   root, checked out to `gh-pages` (force-resetting the local `gh-pages`
   branch to match `origin/gh-pages`).
2. `git rm -r --quiet .` inside that worktree — wipes it clean.
3. Renders the book and writes the new site into that worktree directory.
4. Commits and pushes that worktree's branch to `origin/gh-pages`.
5. In a `finally` block: `git worktree remove <random-hex-dir>` — removes the
   temporary worktree.

The worktree directory name is a new random hex string on every run (e.g.
`dbcdf2381318b96b`, `ace24c804b788bb9` were both observed in this repo).

## If publish fails or is interrupted: leftover worktree

If step 5 never runs — the process is killed, crashes, or errors out mid-way
— the temporary worktree from step 1 is left behind on disk, still
registered with git. The next `quarto publish` attempt then fails with two
`fatal` lines, for example:

```
fatal: unable to stat '<some-file>': No such file or directory
fatal: '<hash>' contains modified or untracked files, use --force to delete it
```

The **second** line is the actual blocker: git refuses to silently
reset/reuse a worktree directory that still has uncommitted state in it.
(The filename in the first line varied between occurrences seen in this repo
— `chapters/resources/PCC.qmd` once, `chapters/resources/HEIC.md` another
time — so it is not reliably tied to any specific file. Treat the second
`fatal` line as the one to act on.)

**Why cleanup is required, not optional:** step 1's `-B gh-pages` forces git
to check out/reset the `gh-pages` branch, and git will not let two worktrees
hold the same branch checked out at once. As long as the old worktree from a
prior failed run still exists, it holds `gh-pages`, so any new attempt fails
immediately at the checkout step — retrying without cleanup cannot work.
This explains why *retries* kept failing; it does not explain what
interrupted the *original* run (see below).

### Recovery steps (confirmed safe)

1. `git worktree list` — find the leftover worktree (a subdirectory of the
   project root, checked out to `gh-pages`).
2. Before removing anything, confirm nothing would be lost:
   `git rev-parse gh-pages origin/gh-pages` — if both hashes match, the
   local `gh-pages` branch has nothing un-pushed, so the leftover worktree's
   uncommitted contents are just regenerable build output, safe to discard.
3. `git worktree remove --force <the-directory>`.
4. Retry `quarto publish gh-pages`.

This sequence resolved the failure in this repo on 2026-08-26 (twice, with
two different leftover worktrees). A subsequent `quarto publish gh-pages`
run completed successfully afterward, confirmed by `git worktree list`
showing no leftover worktree and `gh-pages` no longer marked as checked out
anywhere — the cleanup `finally` block ran to completion that time.

## Prevention

After any `quarto publish` run that errors, exits early, or is interrupted
(including Ctrl-C), run `git worktree list` before doing anything else
(including before retrying) and clean up per the Recovery steps above.

## A separate, confirmed observation — cause not established

The `gh-pages` branch's HEAD commit (as of 2026-08-26) contains ~18 raw
source files (`.qmd`/`.md`) under `chapters/resources/` (e.g. `PCC.qmd`,
`HEIC.md`, `Lightfield notes.qmd`) — confirmed with `git ls-tree -r
gh-pages`. A gh-pages branch should normally contain only the rendered
static site (HTML/CSS/JS/images), not source markdown, so this looks like
leftover pollution from some earlier publish.

Whether this is related to the intermittent "unable to stat" failure above
is **not established**: a from-scratch checkout of that exact commit was
tested twice (once outside the repo, once nested inside it in the same
layout Quarto uses) and both reproduced cleanly with every file present and
no error. So the stat failure is intermittent and was not reproduced outside
of an actual `quarto publish` run — don't present the stray source files as
a confirmed root cause, only as an anomaly worth cleaning up on its own
merits.

Ruled out as explanations for the intermittent stat failure (checked
directly in this repo, all negative):

- iCloud Drive Desktop/Documents sync — disabled on this Mac
  (`FXICloudDriveDesktop = 0`, `FXICloudDriveDocuments = 0`).
- Case-insensitive-filesystem path collisions in the `gh-pages` tree —
  `git ls-tree -r gh-pages | awk '{print tolower($0)}' | sort | uniq -d`
  returned nothing.
- Git hooks — no active (non-`.sample`) files in `.git/hooks`, no
  `core.hooksPath` configured.
- `.gitattributes` / Git LFS — neither is present or configured in this repo.
