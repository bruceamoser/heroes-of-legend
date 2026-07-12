---
name: review-pr
description: Review a pull request for the Heroes of Legend rulebook. Use when reviewing chapter changes, checking mechanical accuracy, verifying cross-references, or approving a PR for merge.
---

# Review Pull Request

## When to Use
- A PR is open and needs review
- Checking submitted chapter changes for quality
- Verifying mechanical accuracy before merge
- Final approval gate before squash merging

## Review Checklist

### Content Review
- [ ] Changes match the issue description and goals.
- [ ] No unrelated "drive-by" changes to adjacent chapters.
- [ ] Every changed line traces to the issue being worked.

### Mechanical Review
- [ ] All rules consistent with 3d6 + attribute + skill core resolution.
- [ ] Success tiers (Weak 1–6, Standard 7–12, Strong 13–18+) used correctly.
- [ ] Damage values within established ranges for the content type.
- [ ] DP costs correct (Skills: 1/2/3, Talents: 1/2/4).
- [ ] Discipline prerequisites valid and consistent.
- [ ] No mechanics contradict `docs/design/mechanics-decisions.md`.

### Cross-References
- [ ] All `@sec-` references point to valid chapter IDs (check `_quarto.yml`).
- [ ] New content includes cross-references to related chapters.
- [ ] No broken or circular references.

### Terminology & Style
- [ ] Game terms bolded on first use in each affected chapter.
- [ ] Consistent term usage across changes.
- [ ] Matches Writing Style Guide (active voice, player-facing, heroic tone).
- [ ] No sentence confusing on first read.

### Build
- [ ] `cd quarto-book && ./build.sh` succeeds with no errors.
- [ ] No new build warnings introduced.

## Review Response Template
```markdown
## PR Review: #N

### Status: ✅ Approved / 🔄 Changes Requested / ❌ Blocked

### Summary
[One-paragraph overview of what was reviewed.]

### Findings
#### Critical (must fix)
- [Issue with chapter, section, and specific reference]

#### Major (should fix)
- [Issue with chapter, section, and specific reference]

#### Minor (nice to fix)
- [Issue with chapter, section, and specific reference]

### Verdict
[Approved / Changes requested — see above / Blocked — see Critical items]
```

## Procedure
1. Read the PR description and linked issue.
2. Check out the branch locally: `gh pr checkout <N>`
3. Read all changed files in full.
4. Run the build: `cd quarto-book && ./build.sh`
5. Work through the checklist above.
6. Post the review using the response template.
7. If approved, proceed to `squash-merge` skill.
8. If changes needed, request them and re-review after updates.
