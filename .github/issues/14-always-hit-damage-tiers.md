## Epic 1 — Core Mechanics (#14)

**Dependency:** #12
**Est. Effort:** Small

### Goal
Define the "attacks always hit" design philosophy and the damage tier system that replaces attack rolls.

### Core Principle
In Heroes of Legend, you don't roll to see IF you hit — you always hit. Instead, you roll to determine HOW WELL you hit. Every weapon, spell, and ability has three damage values: Weak, Standard, Strong.

### Design Requirements
- Remove attack rolls entirely — combat flows directly to damage determination
- Each weapon has a damage profile: `Weak: XdY / Standard: XdY / Strong: XdY`
- The 3d6 resolution determines which damage tier applies
- Armor/shields reduce incoming damage rather than making you harder to hit
- This makes combat faster (fewer rolls) and more cinematic (every swing matters)

### Example Weapon Profile
```
Longsword (requires 2 Blade dice)
  Weak:   1d8+BR  (glancing blow)
  Standard: 2d8+BR (solid hit)
  Strong:  3d8+BR (devastating strike)
```

### Open Questions
- How does evasion/dodging work if attacks always hit? (Armor as damage reduction? Active defense as a reaction?)
- Do spells use the same W/S/S structure?
- How do area-of-effect attacks work?
- How does cover affect damage tiers?

### Tasks
- [ ] Write the always-hit philosophy section
- [ ] Define damage tier structure for all weapon categories
- [ ] Define how armor interacts (damage reduction? threshold?)
- [ ] Define how active defense works (dodge reaction? parry?)
- [ ] Include 2 combat examples showing the flow
