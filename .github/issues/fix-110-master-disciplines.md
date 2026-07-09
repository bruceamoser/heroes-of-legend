## Major Fix #10 — Fix Master Spell Discipline Requirements

**Status:** Should fix before publication  
**Affects:** Chapter 08, Chapter 10, Chapter 18

### Problem
Master-tier spells require 6 specific Disciplines (e.g., Volcanic Eruption: 3 Fire + 2 Earth + 1 Energy). An Arcanist starts with 4 elemental Disciplines and gains 6 progression Disciplines by level 18. To reach a single Master spell, they must dedicate 3 of 6 progression choices to specific types — earliest access is level 9.

A caster who diversifies their Disciplines across elements may never qualify for ANY Master spell. The system punishes breadth.

### Options to Present to Bruce

#### Option A: Reduce Master Requirements (Recommended)
Master spells require 4 specific Disciplines (not 6):
- Volcanic Eruption: 2 Fire + 1 Earth + 1 Energy
- Chain Lightning: 2 Wind + 1 Energy + 1 Reason
- Time Stop: 2 Reason + 1 Energy + 1 Knowledge

This still requires investment but doesn't consume 60% of all progression choices.

#### Option B: Allow General Disciplines at Higher Tiers
General Disciplines can substitute for specific Disciplines at ANY tier, but at a cost:
- Novice: 1 General = 1 specific (as now)
- Adept: 2 General = 1 specific
- Master: 3 General = 1 specific

A caster with 3 General Disciplines could substitute for 1 specific Discipline at Master tier — expensive but possible.

#### Option C: Elemental Affinity
When a caster purchases a Master spell in one element, they gain a bonus Discipline in a related element. E.g., purchasing Volcanic Eruption grants +1 Earth Discipline.

#### Option D: Hybrid Master Spells
Allow Master spells that accept alternative Discipline combinations:
- Volcanic Eruption: 3 Fire + 2 Earth + 1 Energy OR 3 Earth + 2 Fire + 1 Energy
- Blizzard: 3 Water + 2 Wind + 1 Energy OR 3 Wind + 2 Water + 1 Energy

### Implementation
1. Present options to Bruce with math for each (earliest level to reach Master, total Master spells possible at L20)
2. Get decision
3. Update Discipline prerequisite tables in chapters 08 and 10
4. Update spell prerequisite listings in chapters 11 and 12
5. Update the worked example in chapter 08 (Kael's spell chain progression)


---
## Status Log — 2026-07-09

**AWAITING DECISION.** Bruce needs to choose how Master-tier abilities are unlocked:

- **Option A:** 3 matching Disciplines (e.g., 3 Fire for Master Fire spells)
- **Option B:** 4 matching Disciplines (tighter gate, later access)
- **Option C:** Level-gated (e.g., Master unlocks at level 7 regardless of Disciplines)
- **Option D:** Hybrid (2 matching Disciplines + level 5 minimum)

This gates all high-level spell/ability progression. Must be decided before spell chapters can be written.
