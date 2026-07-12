---
name: work-issue
description: Work a GitHub issue through to completion: branch, implement, commit with conventional format. Use when starting work on an issue, implementing a fix or feature, or committing changes for a specific issue.
---

# Work an Issue

## When to Use
- Starting implementation on an assigned issue
- Need to follow the branch → implement → commit workflow
- Ready to commit changes for a specific issue

## Procedure

### 1. START — Create the Branch
```bash
git checkout main
git pull origin main
git checkout -b issue/<N>-<short-slug>
```
Example: `git checkout -b issue/42-add-fire-spells`

### 2. IMPLEMENT — Make Your Changes
- Read the full issue description and all linked issues.
- Read affected chapter files before making ANY changes.
- Read upstream dependencies (see dependency chain in copilot-instructions.md).
- Check `docs/design/mechanics-decisions.md` for resolved decisions.
- Make surgical changes — don't "improve" adjacent chapters.
- Update cross-references your changes break.
- Build to validate: `cd quarto-book && ./build.sh` (or `.\build.ps1`).

### 3. COMMIT — Conventional Format
Choose the right prefix:

| Prefix | Use When |
|--------|----------|
| `feat(#N):` | New chapter content, spells, classes, major additions |
| `design(#N):` | Mechanics design, balance changes, system decisions |
| `fix(#N):` | Corrections, bug fixes, rule errors |
| `docs(#N):` | Documentation, reference files, design notes |
| `style(#N):` | Formatting, layout, prose polish, no mechanics changed |

Examples:
```
feat(#42): add Fire spell chain (Firebolt → Fireball → Volcanic Eruption)
design(#42): balance Fire spell damage values for 3d6 curve
fix(#42): correct Firebolt Weak damage from 2d6 to 1d6
style(#42): format Fire spell stat blocks to match chapter 11 conventions
```

### 4. VERIFY
Before pushing:
- [ ] Build succeeds: `cd quarto-book && ./build.sh`
- [ ] Cross-references are valid
- [ ] All affected chapters read and updated
- [ ] Commit message follows conventional format
- [ ] No unrelated files changed

### 5. NEXT — Open a PR
Proceed to the `create-pr` skill.
