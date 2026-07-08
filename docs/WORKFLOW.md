# Agent Workflow

This document defines the mandatory workflow for every agent working on issues in this repository. All agents must follow this process at every turn. The workflow is designed to ensure thorough research, complete implementation, and honest review before any code is committed.

---

## The Cycle (Per Issue)

```
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│ 1. GRAB  │───▶│2. RESEARCH│───▶│3. IMPLEMENT│───▶│ 4. REVIEW │───▶│5. COMMIT │
│  ISSUE   │    │           │    │           │    │           │    │ & PUSH   │
└──────────┘    └──────────┘    └──────────┘    └──────────┘    └──────────┘
                                                                      │
                                                              ┌───────┘
                                                              ▼
                                                       ┌──────────┐
                                                       │6. NEXT   │
                                                       │  ISSUE   │
                                                       └──────────┘
```

---

## 1. GRAB — Assign the Issue

- Assign the issue to yourself (`gh issue edit N --add-assignee @me`).
- Add the `in-progress` label if available, or comment that work has begun.
- Read the **full issue description** and all linked/dependent issues.
- Read every chapter file the issue touches **before writing a single line**.
- State your plan before implementing:
  ```
  1. [Step] → verify: [check]
  2. [Step] → verify: [check]
  3. [Step] → verify: [check]
  ```

**Gate:** You understand the issue scope, dependencies, and success criteria. Do not proceed if anything is unclear — ask Bruce.

---

## 2. RESEARCH — Understand the Current State

Before implementing, you must understand the **full context** of what exists and how your change fits.

### 2a. Audit Existing Work
- Read all affected chapter files in `docs/chapters/`.
- Read the master document `docs/heroes-of-legend.adoc`.
- Read the implementation plan `docs/design/implementation-plan.md`.
- Check for related issues that may have already done partial work.
- Search for any existing mechanics that interact with your change.

### 2b. Consult External Sources (as needed)
- The original playtest PDF: `source-doc/Heros of Legend-Playtest-v15.1.pdf` (read-only reference).
- The extracted markdown: `source-doc/extracted/playtest.md` (searchable reference).
- D&D 5e SRD (for spell adaptation issues): https://dnd.wizards.com/resources/systems-reference-document
- Neon Relic repo (`../neon-relic/`) for build/formatting patterns.
- Web research for design precedents, probability math, or best practices.

### 2c. Evaluate Holistically
At every step, evaluate three lenses:

| Lens | Question |
|------|----------|
| **System** | Does this mechanic interact correctly with core resolution (3d6), dice types, DP economy? |
| **Mechanics** | Are the numbers right? Is it balanced? Does it break anything? |
| **Flavor** | Does this feel like heroic fantasy? Is it accessible to new players? Would a player understand it on first read? |

### 2d. Update the Issue
- Post a research summary comment on the issue with your findings.
- Note any design decisions made or assumptions confirmed.
- Flag anything that needs Bruce's input before you proceed.

**Gate:** You have a complete picture of the current state and how your change fits. Proceed to implementation.

---

## 3. IMPLEMENT — Work the Issue to Completion

### 3a. Make Surgical Changes
- Touch **only** the files the issue requires.
- Don't "improve" adjacent chapters, prose, or formatting.
- Match existing AsciiDoc style and cross-reference conventions.
- Follow the Design Principles in `AGENTS.md`.

### 3b. Implement Fully
- Don't leave `[PLACEHOLDER]` markers unless the issue explicitly calls for a stub.
- Write complete rules text, not outlines.
- Include tables, examples, and cross-references.
- Every spell needs Weak/Standard/Strong values. Every weapon needs dice prerequisites.

### 3c. Update Cross-References
- Update `xref:` links that YOUR changes broke.
- Don't fix pre-existing broken xrefs unless asked.

**Gate:** The implementation matches the issue description completely. No shortcuts.

---

## 4. REVIEW — Honest Self-Assessment

Before committing, review your work against the original goal.

### 4a. The Review Checklist
- [ ] Does the implementation match every task in the issue description?
- [ ] Does the build succeed? (`./build.sh` produces a PDF without errors)
- [ ] Are all cross-references valid?
- [ ] Did I touch only the files listed in the issue?
- [ ] Are there any `[PLACEHOLDER]` markers I left behind?
- [ ] Would a player understand this on first read?
- [ ] Does this interact correctly with core resolution (3d6), dice types, and DP economy?

### 4b. Identify Gaps
- Comment on the issue listing anything missed, incomplete, or questionable.
- Be honest — it's better to flag a gap now than ship broken rules.
- Example gap comments:
  - "The Weak/Standard/Strong values for Frostbite feel off — Standard (2d6) is higher than Firebolt (1d8). Intentional?"
  - "Missing cross-reference to the dying rules in chapter 13."
  - "This spell chain has no Master tier — is that intentional or a gap?"

### 4c. Work Through Gaps
- Fix every gap you identified.
- If a gap needs Bruce's input, flag it clearly and proceed with what you can.
- Re-review after fixes.

**Gate:** You would stake your reputation on this being correct. If not, go back.

---

## 5. COMMIT & PUSH

### Commit Format
Use Conventional Commits with the issue number:

```
feat(#N): short summary of what changed

- Bullet point of key change
- Bullet point of another change
```

Valid prefixes: `feat:`, `fix:`, `docs:`, `refactor:`, `design:`

### Branch Workflow
- Create a branch: `issue/N-short-description`
- Commit your changes
- Push the branch
- Open a PR targeting `main` with `Closes #N` in the description
- Merge (squash preferred)
- Delete the branch

**Gate:** PR is merged, branch is deleted, `main` is clean.

---

## 6. NEXT ISSUE

- Return to Step 1 with the next issue in the critical path.
- Respect dependency chains — resolve upstream issues before downstream ones.
- Key chains (from the implementation plan):
  1. **Core mechanics:** #8 → #10 → #13 (write chapter 06)
  2. **Dice types:** #15 (catalog) → #16 (taxonomy) → #17 (acquisition) → #18 (prerequisites) → #19 (write chapter 08)
  3. **Magic:** #32 (system) → #33 (spell catalog) → #35-39 (spell chains) → #40 (write chapter 11)
  4. **Character creation:** #9 (attributes) → #27 (creation flow) → #28-31 (chapters)

---

## Quick Reference Card

```
GRAB     → Assign, read issue + affected files, state plan
RESEARCH → Audit existing, consult sources, evaluate system/mechanics/flavor, comment findings
IMPLEMENT → Surgical changes, full implementation, update xrefs
REVIEW   → Checklist, identify gaps, comment honestly, fix gaps
COMMIT   → feat(#N): summary, branch, PR, squash merge, delete branch
NEXT     → Next issue in critical path, respect dependencies
```

---

## The Prime Directive

**Every changed line must trace directly to the issue being worked.**

If you find yourself improving adjacent prose, fixing unrelated xrefs, or refactoring mechanics that aren't broken — stop. That's a different issue.

---

*This workflow is authoritative. All agents must follow it at every turn. Deviations require explicit justification.*
