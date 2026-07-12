---
name: create-issue
description: Create a well-formed GitHub issue for the Heroes of Legend rulebook project. Use when creating a new issue for a feature, bug, design task, or any work that needs tracking.
---

# Create GitHub Issue

## When to Use
- Starting a new piece of work that needs tracking
- Reporting a bug or inconsistency in the rulebook
- Proposing a design change or new mechanic
- Creating a task for yourself or another agent

## Bite-Sized Issue Rule

Issues MUST be small enough to complete in one focused session. If a task spans multiple unrelated changes, split it into multiple issues. A well-formed issue:
- Addresses ONE concern (typography, or bestiary, or table formatting — not all three)
- Can be completed in a single implementation session
- Has a clear, testable Definition of Done
- References specific files and line numbers where possible

If an issue description exceeds ~200 words, it is probably too large and should be split.

## Issue Template

### Feature / Content Issue
```
Title: [Chapter or System]: Brief description

## Goal
What should exist when this issue is closed?

## Chapters Affected
- quarto-book/chapters/XX-name.qmd

## Design Notes
- Any specific mechanical requirements
- Reference to upstream chapters or design docs
- Probability math or balance considerations

## Success Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Builds clean: cd quarto-book && ./build.sh
- [ ] Cross-references valid
```

### Bug / Fix Issue
```
Title: Fix: [Chapter]: Brief description of the problem

## Problem
What's wrong? Be specific about the chapter, section, and line.

## Expected Behavior
What should it say/do instead?

## Impact
What other chapters or mechanics does this affect?
```

### Design Issue
```
Title: Design: [System]: Brief description of the design question

## Context
What system or mechanic is being designed? Link to related chapters.

## Design Goals
What should this mechanic accomplish?

## Constraints
- Must be consistent with: [list core mechanics]
- Must not break: [list affected systems]

## Options (if known)
A. Option one — pros/cons
B. Option two — pros/cons
```

## Procedure
1. Determine the issue type (feature, fix, design).
2. Fill in the appropriate template above.
3. Add relevant labels if available.
4. Create via: `gh issue create --title "..." --body "..." --label "enhancement"`
5. Note the issue number for branch naming: `issue/<N>-<slug>`
