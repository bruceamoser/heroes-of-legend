---
name: design-class
description: Design a complete character class with disciplines, skills, abilities, and progression. Use when creating a new class, writing class entries for chapter 05, or designing class features and progression tables.
---

# Design Class

## When to Use
- Creating a new character class for chapter 05
- Designing class abilities, skill lists, and progression

## Procedure

### 1. RESEARCH
- Read `quarto-book/chapters/05-classes.qmd` for existing class patterns.
- Read chapters 03 (attributes), 07 (skills), 08 (disciplines), 09 (talents), 18 (advancement).

### 2. DEFINE THE CLASS CONCEPT
- **Class fantasy:** What does the player imagine?
- **Role:** Combat, support, utility, social, mixed?
- **Uniqueness:** How is it different from existing classes?

### 3. DESIGN MECHANICS

#### Starting Disciplines (2–4)
- Martial: Blades, Axes, Polearms, Great Weapons, Archery, Armor, Shield
- Magic: Fire, Earth, Wind, Water, Energy, Protection, Animal
- Hybrid: Mix of martial and magical

#### Class Skills (6–10)
Skills the class excels at (reduced DP cost). Include combat, knowledge/social, and utility.

#### Class Abilities (3–6)
Follow talent format: Novice (1 DP), Adept (2 DP), Master (4 DP).

#### Progression Table
| Level | Benefits |
|-------|----------|
| 1 | Starting abilities, disciplines, skills |
| 2–5 | New ability tiers, DP grants |
| 6–10 | Master-tier abilities, capstone |

### 4. WRITE THE CLASS ENTRY
```markdown
## [Class Name]

[1–2 paragraphs of flavor.]

### Starting Disciplines
- [Discipline], [Discipline], [Discipline]

### Class Skills
[Class] characters excel at: [Skill], [Skill], [Skill]...

### Class Abilities
#### [Ability Name] (Novice)
[Description and mechanical effect.]

#### [Ability Name] (Adept)
**Prerequisite:** [Ability Name] (Novice)
[Description and mechanical effect.]

### Progression
| Level | DP | Class Features |
|-------|----|----------------|
| 1 | — | [Starting features] |
```

### 5. REVIEW
- Compare power level against existing classes.
- Verify all Discipline references are correct.
- Check DP economy — are ability costs balanced?
- Does the class have a clear, distinct identity?
