---
name: review-chapter
description: Systematically review a chapter for mechanical accuracy, clarity, cross-references, and consistency. Use when doing a pre-commit review, quality check before merging, or finding gaps and errors.
---

# Review Chapter

## When to Use
- Before committing chapter changes
- Quality assurance pass on completed content
- Finding gaps, errors, and inconsistencies

## Procedure

### 1. READ DEEPLY
- Read the target chapter in full — don't skim.
- Read all upstream chapters the target depends on.
- Read `docs/design/mechanics-decisions.md` and `implementation-plan.md`.

### 2. RUN CHECKLISTS

#### Mechanical Accuracy
- [ ] All rules consistent with 3d6 + attribute + skill core resolution.
- [ ] Success tiers (Weak 1–6, Standard 7–12, Strong 13–18+) used correctly.
- [ ] Damage values within established ranges for the content type.
- [ ] DP costs correct (Skills: 1/2/3, Talents: 1/2/4).
- [ ] Discipline prerequisites valid and consistent.
- [ ] Attacks follow always-hit model with Weak/Standard/Strong damage.
- [ ] No mechanics contradict `mechanics-decisions.md`.

#### Cross-References
- [ ] Every `@sec-` reference points to a valid chapter ID in `_quarto.yml`.
- [ ] No broken or circular references.
- [ ] New content includes cross-references to related chapters.

#### Terminology Consistency
- [ ] Game terms bolded on first use in the chapter.
- [ ] Same term used everywhere across chapters.
- [ ] Attribute names exact: Brawn, Fortitude, Agility, Guile, Knowledge, Reason.

#### Clarity & Completeness
- [ ] Every major mechanic has at least one worked example.
- [ ] Rules are in player-facing language (active voice, second person).
- [ ] No unexplained terms.
- [ ] Tables complete with no missing values.

### 3. BUILD VALIDATION
Run `cd quarto-book && ./build.sh` (or `.\build.ps1`). Report all errors and warnings.

### 4. REPORT FINDINGS

#### 🔴 Critical (breaks the game or build)
[Issues that must be fixed before the chapter is usable.]

#### 🟡 Major (incorrect or inconsistent)
[Issues that affect gameplay or rules understanding.]

#### 🔵 Minor (style, clarity, formatting)
[Issues that don't affect rules but reduce quality.]

#### 💡 Suggestions
[Nice-to-have improvements with rationale.]

### 5. CREATE GITHUB ISSUES

Every finding at 🔴 **Critical** and 🟡 **Major** severity **MUST** become a GitHub issue. 🔵 **Minor** findings may be batched into a single "Polish" issue. 💡 **Suggestions** should be filed as issues if they represent actionable improvements.

- Use the `create-issue` skill for each issue.
- Follow the bite-sized issue rule: **one concern per issue**.
- Each issue must include: specific file paths, line numbers, severity, and the relevant section of the report.

> **Chat reports are ephemeral. GitHub issues are the permanent record. If it isn't an issue, the finding doesn't exist.**
