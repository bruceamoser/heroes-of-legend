---
name: design-monster
description: Design a monster stat block for the bestiary (chapter 20). Use when creating monster entries, writing NPC stat blocks, designing combat encounters, or building the bestiary catalog.
---

# Design Monster

## When to Use
- Creating a monster entry for chapter 20 (Bestiary)
- Designing NPC/enemy stat blocks for GM use

## Procedure

### 1. RESEARCH
- Read `quarto-book/chapters/20-bestiary.qmd` for existing monster patterns.
- Read chapters 13 (combat) and 06 (core resolution).
- Check D&D 5e SRD for reference monsters (SRD-safe names).

### 2. DEFINE THE MONSTER
- **Challenge level:** Low, Medium, High, Epic
- **Role:** Brute, skirmisher, controller, spellcaster, support, boss
- **Concept:** What makes this monster memorable?

### 3. DESIGN STATS

#### Challenge Guidelines
| Challenge | Attribute Bonus | Skill Bonus | Damage (Standard) | Special Abilities |
|-----------|----------------|-------------|-------------------|-------------------|
| Low | −1 to +1 | +0 to +1 | 1d6–2d6 | 0–1 simple |
| Medium | +0 to +2 | +1 to +2 | 2d6–3d6 | 1–2 moderate |
| High | +1 to +3 | +2 to +3 | 3d6–4d6 | 2–3 significant |
| Epic | +2 to +4 | +3 | 4d6–6d6 | 3+ powerful |

### 4. WRITE THE STAT BLOCK
```markdown
### [Monster Name]
**Challenge:** [Low/Medium/High/Epic]
**Description:** [2–3 sentences of flavor.]

| Attribute | Modifier |
|-----------|----------|
| Brawn | +X |
| Fortitude | +X |
| Agility | +X |
| Guile | +X |
| Knowledge | +X |
| Reason | +X |

**Skills:** [Skill] +X, [Skill] +X

**Abilities:**
- **[Ability]:** [Description and effect.]

**Attacks:**

| Attack | Weak (1–6) | Standard (7–12) | Strong (13–18+) |
|--------|------------|-----------------|-----------------|
| [Name] | XdY damage | XdY damage | XdY + [effect] |
```

### 5. REVIEW
- Stats appropriate for challenge level.
- Attack damage follows guidelines.
- Clear tactical identity (what does it DO in combat?).
- Format exactly matches existing entries in chapter 20.
