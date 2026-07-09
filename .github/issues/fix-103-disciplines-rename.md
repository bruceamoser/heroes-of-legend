## Critical Fix #3 — Rename "Dice Types" to "Disciplines" System-Wide

**Status:** Must fix before publication  
**Affects:** Every chapter file, AGENTS.md, copilot-instructions.md, glossary

### Problem
The word "dice" currently means two completely different things:
1. The physical 3d6 you roll at the table
2. A meta-currency representing trained expertise ("I have 3 Fire dice")

This confuses readers. "Disciplines" clearly conveys training/instruction levels.

### Find-and-Replace Map (Apply Everywhere)

| Find | Replace |
|------|---------|
| `dice type` | `Discipline` |
| `dice types` | `Disciplines` |
| `Dice Type` | `Discipline` |
| `Dice Types` | `Disciplines` |
| `Fire dice` | `Fire Disciplines` |
| `Blade dice` | `Blade Disciplines` |
| `generic dice` | `General Disciplines` |
| `Generic dice` | `General Disciplines` |
| `Generic Dice` | `General Disciplines` |
| `starting dice` | `Starting Disciplines` |
| `progression die` | `Progression Discipline` |
| `progression dice` | `Progression Disciplines` |
| `dice prerequisite` | `Discipline prerequisite` |
| `dice requirements` | `Discipline requirements` |
| `dice catalog` | `Discipline catalog` |
| `Dice Type System` | `Discipline System` |
| `Dice Type Catalog` | `Discipline Catalog` |
| `Dice Prerequisites` | `Discipline Prerequisites` |
| `Dice Acquisition` | `Discipline Acquisition` |
| `Dice Taxonomy` | `Discipline Taxonomy` |

### Files to Update
1. `docs/chapters/08-dice-types.adoc` — Rename file AND all content. Chapter title becomes "Disciplines"
2. `docs/chapters/05-classes.adoc` — Starting Discipline tables
3. `docs/chapters/07-skills.adoc` — Discipline prerequisite column
4. `docs/chapters/10-magic-system.adoc` — Spell Discipline requirements
5. `docs/chapters/15-equipment.adoc` — Weapon Discipline requirements
6. `docs/chapters/02-character-creation.adoc` — Starting Discipline step
7. `docs/chapters/04-ancestries-cultures.adoc` — Ancestry Discipline grants
8. `docs/chapters/06-core-resolution.adoc` — Any dice type references
9. `docs/chapters/09-talents-abilities.adoc` — Talent prerequisites
10. `docs/chapters/18-advancement.adoc` — Progression Discipline rules
11. `docs/chapters/21-glossary.adoc` — Definitions
12. `docs/chapters/22-reference-sheets.adoc` — Reference tables
13. `docs/heroes-of-legend.adoc` — Master document includes
14. `AGENTS.md` — Key design decisions section
15. `.github/copilot-instructions.md` — Design principles
16. `docs/design/mechanics-decisions.md` — Decision document
17. `docs/design/implementation-plan.md` — Plan references

### Prose Rewrites Required (not just find-replace)
Some sentences need restructuring:

Old: "A warrior with 3 Blade dice has spent years mastering swords."
New: "A warrior with 3 Blade Disciplines has spent years mastering the art of the sword."

Old: "Characters collect dice types representing their mastery of elements."
New: "Characters earn Disciplines — levels of formal training in elemental and martial arts."

Old: "All characters start with 3 generic dice."
New: "Every hero begins with 3 General Disciplines — foundational training applicable to any path."

### Implementation
1. Rename `docs/chapters/08-dice-types.adoc` to `docs/chapters/08-disciplines.adoc`
2. Update the master document's include path
3. Find-and-replace all terms in all chapters
4. Rewrite prose passages where the word "dice" was confusing
5. Rebuild and verify zero errors
6. Verify no broken xref links to the renamed chapter
