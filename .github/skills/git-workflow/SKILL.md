---
name: git-workflow
description: Manage git branches, commits, pushing, and pull requests for FISE. Use whenever preparing, committing, or pushing changes, creating branches, or opening pull requests on GitHub.
---

# FISE Git and Pull Request Workflow

## Core Principle: Never Push Directly to `main`

All commits to the codebase must enter `main` via a **pull request (PR)** on GitHub (<https://github.com/wandell/FISE-git>), never via a direct `git push origin main`. This guarantees:
- Every change is reviewed on the main site before landing.
- Automated CI (`.github/workflows/ci.yml`) validates Quarto rendering and internal link integrity before merging.
- Git history remains clean, traceable, and revertible.

## Step-by-Step Workflow

### 1. Start from an Up-to-Date `main`
Always ensure your local `main` is fresh before branching:
```bash
git checkout main
git pull origin main
```

### 2. Create a Feature Branch
Create a descriptive branch for the task:
```bash
git checkout -b <branch-name>
```
Naming conventions:
- `dev-<topic>` or `feat-<topic>` for content, chapters, figures, or feature additions (e.g., `dev-sensors-update`, `feat-wavefront-figs`)
- `fix-<topic>` for corrections, broken links, errata, or formatting fixes (e.g., `fix-bib-links`, `fix-callout-syntax`)
- `refactor-<topic>` for prose revisions, chapter re-organization, or asset restructuring

### 3. Stage and Commit Changes
Keep commits focused and coherent. Inspect changes before staging:
```bash
git status
git diff
git add <target-files>
git commit -m "type(scope): concise description"
```
Rules for commits:
- Do not commit generated build outputs (`_book/`, `.quarto/`, `.html.md` debug files) or OS cruft (`.DS_Store`).
- Verify with `git status` that only intended files are staged.

### 4. Push Feature Branch to GitHub
Push the branch and set upstream:
```bash
git push -u origin <branch-name>
```

### 5. Open a Pull Request on the Main Site
Open the PR in the browser using the GitHub CLI:
```bash
gh pr create --web
```
If running non-interactively or web opening is unavailable:
```bash
gh pr create --title "Short PR Title" --body "Summary of changes" --base main
```
Always provide the user with the direct URL to the PR on GitHub (`https://github.com/wandell/FISE-git/pull/...`) so it can be reviewed on the main site.

### 6. Review and CI Verification
- The GitHub Actions `CI` workflow (`.github/workflows/ci.yml`) automatically triggers on the PR:
  - Renders the full Quarto book.
  - Runs `utility/check_internal_links.py`.
- Review the PR diff and CI check results on GitHub before merging.

### 7. Merge on GitHub and Sync Locally
- Complete the merge on GitHub ("the main site").
- Once merged on the main site, update the local repository:
```bash
git checkout main
git pull origin main
git branch -d <branch-name>       # delete local feature branch
git fetch --prune origin          # clean up remote tracking refs
```

## Prohibited Actions
- **DO NOT** run `git push origin main` or `git push` while checked out on `main`.
- **DO NOT** commit directly to `main` without creating a feature branch first.
- **DO NOT** bypass PR review on GitHub for book edits, chapter revisions, or configuration changes.
- **DO NOT** force-push (`--force`) to `main`.
