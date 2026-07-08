## Epic 2 — Dice Types (#23)

**Dependency:** #21, #22
**Est. Effort:** Medium

### Goal
Design the dice prerequisite system — the rules that gate skills, abilities, and talents behind dice type requirements.

### Prerequisite Rules
- Skills require a minimum number of specific dice types (e.g., Longsword requires 2 Blade dice)
- Abilities (spells) require specific combinations of dice types (e.g., Fireball requires 2 Fire + 1 Energy)
- Talents may require any dice type as a gate (e.g., "Shield Master" requires 2 Protection dice)
- Generic dice can substitute for any specific type BUT at reduced effectiveness or higher DP cost

### Design Questions
- What's the ceiling for dice requirements? (max 3? 5?)
- Can a character "over-invest" — have more dice than required? What benefit?
- How do multi-class characters handle conflicting dice requirements?
- What happens if a prerequisite is lost (e.g., magic item removed)?

### Tasks
- [ ] Design prerequisite tiers (Minor: 1 die, Standard: 2 dice, Major: 3+ dice)
- [ ] Create prerequisite tables for all planned skills
- [ ] Create prerequisite tables for all spell chains (by school/level)
- [ ] Design generic dice substitution rules
- [ ] Write prerequisite rules as AsciiDoc with examples
