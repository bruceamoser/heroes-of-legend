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
- [ ] Use the current approved design references and latest user decisions. The fresh system rolls 3d6 + one attribute; there is no numerical skill bonus.
- [ ] Success tiers used correctly: Weak ≤8, Standard 9–14, Strong ≥15. Weak means progress, not automatic success; retained 111 adds a complication and retained 666 adds a benefit.
- [ ] NPC-only actions may be rolled by a player or the DA assuming the player role. NPC-versus-NPC attacks use one defender roll and the attacker’s defense-outcome table; healing/tasks use the acting NPC’s attribute. Dice handling does not transfer control.
- [ ] Damage values within established ranges for the content type.
- [ ] Numerical weakness adds its value to an included matching damage component before resistance, once per event; highest same-type value only, normal cap 3. Do not infer extra damage from a narrative vulnerability.
- [ ] Collision damage uses movement remaining on contact before the newly struck creature’s Stability is deducted; apply applicable resistance to damage. Moving groups stop at the last position where everyone fits in separate legal spaces, with DA placement and no extra forward movement or passage through walls; preserve the original mover’s backward bounce where possible.
- [ ] Ability tier/minimum levels 1/3/7 and DP costs 2/4/8 are correct. Discipline ranks use the current class-affinity schedule and are bought sequentially; no retired card chains.
- [ ] Discipline prerequisites valid and consistent.
- [ ] Summon tether uses ordinary grid distance between nearest occupied squares of controller and summon: 6 remains valid, beyond 6 immediately ends the summon, including forced movement. Do not measure from centers or farthest edges.
- [ ] A summoned healer’s printed HP cost is paid once by its controller, before resolution, bypassing resistance and leaving the controller above 0 HP. Preserve the summon’s own attribute/outcomes and ordinary unsummoned healers’ self-payment.
- [ ] Summons are energy forms, cannot receive healing, and disappear at 0 HP without a body. Keep ordinary creatures’ healing separate; do not infer new intangibility or damage/control immunities.
- [ ] No mechanics contradict current `design/rules/`, `design/development.md`, card conventions, or later explicit decisions. Historical documents are not newer authority.

### Cross-References
- [ ] Cross-references resolve in the affected output: Quarto IDs for Quarto chapters; Typst labels, page links and manifest coverage for the player book.
- [ ] New content includes cross-references to related chapters.
- [ ] No broken or circular references.

### Terminology & Style
- [ ] Game terms bolded on first use in each affected chapter.
- [ ] Consistent term usage across changes.
- [ ] Matches Writing Style Guide (active voice, player-facing, heroic tone).
- [ ] No sentence confusing on first read.

### Build
- [ ] Build the affected artifact: `python3 design/player-book/build.py --compile` and `python3 design/player-book/audit.py` for the player book; `cd quarto-book && ./build.sh` for legacy Quarto chapter changes.
- [ ] For the DA Markdown manuscript, run `python3 design/da-book/assemble.py`, then `--check`, plus `design/audit.py` and `design/bestiary/audit.py`. Check unique catalog coverage, preserved wound rows and separate combat/design sections. Markdown assembly is not PDF layout validation or balance certification.
- [ ] For the DA PDF, run `design/da-book/build_pdf.py --compile` with Typst and the PDF Python runtime, then `design/da-book/audit_pdf.py`. Check source/build hashes, actual art placements, complete single-page cards, bookmark coverage, wound rows, link destinations and compression parity. Render every page for a contact-sheet review and inspect representative/dense pages at readable scale. A text-only audit cannot certify layout.
- [ ] New adventure/hazard numbers remain proposals until Bruce approves them. Do not keep presenting already approved/merged manuscript examples as unresolved proposals. Existing card mechanics come from shared authored sources, not copied editable catalogs.
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
4. Run the build and audits for the artifact actually changed (see Build above). Inspect PDF page renders when layout changes.
5. Work through the checklist above.
6. Post the review using the response template. An author’s QA is not independent approval. Do not approve or merge your own changes on behalf of the human reviewer.
7. **Create GitHub issues** for findings that won't be fixed in this PR (see [GitHub Issue Creation](#github-issue-creation) below).
8. If approved, proceed to `squash-merge` skill.
9. If changes needed, request them and re-review after updates.

### GitHub Issue Creation

Every finding at **Critical** and **Major** severity **MUST** become a GitHub issue. **Minor** findings may be batched into a single "Polish" issue. **Suggestions** should be filed as issues if they represent actionable improvements.

- Use the `create-issue` skill for each issue.
- Follow the bite-sized issue rule: **one concern per issue**.
- Each issue must include: specific file paths, line numbers, severity, and the relevant section of the review.
- If the PR itself introduces a new problem, create an issue referencing the PR number.

> **Chat reports are ephemeral. GitHub issues are the permanent record. If it isn't an issue, the finding doesn't exist.**
