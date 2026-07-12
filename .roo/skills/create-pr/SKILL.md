---
name: create-pr
description: Create a well-formed pull request for the Heroes of Legend rulebook project. Use when ready to submit work for review, opening a PR from an issue branch, or requesting feedback on changes.
---

# Create Pull Request

## When to Use
- Work on an issue branch is complete and ready for review
- Need to open a PR to merge changes into main
- Submitting chapter content, fixes, or design changes for approval

## PR Template

### Title
```
<type>(#N): Brief summary of changes
```
Examples:
- `feat(#42): add Fire spell chain to chapter 11`
- `fix(#42): correct Firebolt damage values`
- `design(#42): balance combat maneuver DP costs`

### Body
```markdown
Closes #N

## What Changed
- [Bullet 1: specific change]
- [Bullet 2: specific change]

## Chapters Affected
| Chapter | File | Change |
|---------|------|--------|
| 11 | quarto-book/chapters/11-arcane-spells.qmd | Added Fire chain |
| 10 | quarto-book/chapters/10-magic-system.qmd | Updated spell ref |

## Design Decisions
- [Any decisions made that reviewers should know about]
- [Tradeoffs considered]

## Review Checklist
- [ ] Builds clean: `cd quarto-book && ./build.sh`
- [ ] Cross-references (@sec-) are valid
- [ ] Mechanics consistent with core system (3d6, success tiers, disciplines)
- [ ] Terminology consistent across affected chapters
- [ ] Every new mechanic has a worked example
- [ ] Flavor text matches heroic adventure tone
```

## Procedure
1. Ensure all changes are committed on the issue branch.
2. Push the branch: `git push origin issue/<N>-<slug>`
3. Create the PR: `gh pr create --title "feat(#N): summary" --body "..." --base main`
4. Add the PR link to the issue as a comment.
5. Request review (use Reviewer mode or tag Bruce).

## After PR Creation
- Monitor for review comments.
- Address feedback with additional commits on the same branch.
- Re-request review after changes.
- Once approved, proceed to the `squash-merge` skill.
