---
name: write-chapter
description: Write or substantially revise a rulebook chapter from outline to polished draft. Use when drafting a new chapter, rewriting a chapter, writing rules with examples, organizing chapter structure, or creating chapter content from scratch.
---

# Write Chapter

## When to Use
- Drafting a new chapter from an outline
- Substantially rewriting an existing chapter
- Need to follow the full PLAN → RESEARCH → DRAFT → REVIEW workflow

## Procedure

### 1. PLAN
- Identify the chapter number and file (e.g., `quarto-book/chapters/13-combat.qmd`).
- Read any related GitHub issues for requirements.
- State your approach: what sections will the chapter have?

### 2. RESEARCH
- Read all upstream chapters this chapter depends on (see dependency chain in `.github/copilot-instructions.md`).
- Study an existing, well-written chapter (06 is the model) for formatting conventions.
- Check `docs/design/implementation-plan.md` and `docs/design/mechanics-decisions.md` for relevant notes.

### 3. DRAFT
- Write the chapter introduction (2–4 paragraphs of thematic flavor).
- Write each section: rule explanation → mechanical detail → worked example.
- Format mechanical data in tables.
- Use `:::{.callout-note}` for optional rules and clarifications.
- Add `@sec-` cross-references to related chapters.
- Bold game terms on first use.

### 4. REVIEW
- Checklist against the original goal — does the chapter cover everything?
- Verify all cross-references point to valid chapter IDs (check `_quarto.yml`).
- Every major mechanic has a worked example.
- Build to validate: `cd quarto-book && ./build.sh` (or `.\build.ps1`).

### 5. SAVE
- Register the chapter in `quarto-book/_quarto.yml` if new.
- Commit with: `feat(#N): write chapter XX — [topic]`

## Chapter Structure Template
```markdown
# Chapter Title

[2–4 paragraphs of flavor introduction]

## Section 1: Core Concept

[Explain the fundamental idea. What is this chapter about?]

::: {.callout-example}
## Example: [Scenario]
[A concrete worked example.]
:::

## Section 2: Rules Detail

[Step-by-step rules. Use tables for numerical data.]

## Section 3: Advanced / Optional

[Edge cases, advanced techniques, optional rules.]
```

## Key References
- Chapter formatting model: `quarto-book/chapters/06-core-resolution.qmd`
- Cross-reference IDs: `quarto-book/_quarto.yml`
- Design decisions: `docs/design/mechanics-decisions.md`
