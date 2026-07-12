---
name: design-spell-chain
description: Design a complete Novice→Adept→Master spell chain for the rulebook. Use when adapting a D&D 5e spell into a three-tier chain, creating new spell content, designing spell damage for success tiers, or writing spell stat blocks.
---

# Design Spell Chain

## When to Use
- Adapting a D&D 5e SRD spell into Heroes of Legend
- Creating a new three-tier spell chain
- Need to write spell stat blocks with correct formatting

## Procedure

### 1. RESEARCH
- Read `quarto-book/chapters/10-magic-system.qmd` for magic rules.
- Read `quarto-book/chapters/11-arcane-spells.qmd` or `12-divine-spells.qmd` for existing spell patterns.
- Look up the SRD spell for reference (use SRD names for legal safety).
- Identify the appropriate Discipline for the spell.

### 2. DESIGN THE CHAIN
Map the spell to three escalating tiers:

| Tier | Power Level | Target Pattern |
|------|-------------|----------------|
| Novice | Cantrip/1st-level equivalent | Single target, basic effect |
| Adept | 3rd-level equivalent | Area or multi-target, expanded effect |
| Master | 5th+ level equivalent | Large area or devastating single target |

### 3. ASSIGN DAMAGE
Use these damage ranges:

| Tier | Weak (1–6) | Standard (7–12) | Strong (13–18+) |
|------|------------|-----------------|-----------------|
| Novice | 1d4–1d6 | 2d6 or 1d8+2 | 2d8 or 3d6 |
| Adept | 2d6 or 1d8+2 | 3d6 or 2d8+2 | 4d6 or 3d8 |
| Master | 3d6 or 2d8+2 | 4d6 or 3d8+2 | 6d6 or 4d8+2 |

Reduce damage if the spell has powerful secondary effects (stun, paralysis). Increase for pure damage spells.

### 4. WRITE STAT BLOCKS
Follow the exact format from existing spells:

```markdown
### [Spell Name] (Novice)
**Discipline:** [Required]
**Range:** [Distance]
**Duration:** [Time]
**Description:** [One evocative sentence, then clear mechanical description.]

| Outcome | Effect |
|---------|--------|
| Weak (1–6) | [Effect] |
| Standard (7–12) | [Effect] |
| Strong (13–18+) | [Effect] |
```

### 5. ADD CHAIN HEADER
```markdown
## [Chain Name] Chain
**Disciplines:** [Primary Discipline]
*[One-sentence theme description.]*

*See @sec-magic-system for how spellcasting works.*
```

### 6. REVIEW
- Damage values are within guidelines.
- Each tier is meaningfully more powerful than the previous.
- All three stat blocks use identical format.
- Cross-reference to @sec-magic-system is present.
