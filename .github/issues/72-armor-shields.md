## Epic 6 — Combat & Equipment (#72)

**Dependency:** #24 (dice types)
**Est. Effort:** Medium

### Goal
Design armor, shield, and protection mechanics that interact with the dice type system.

### Armor Philosophy
- Armor doesn't make you harder to hit (attacks always hit) — it reduces incoming damage
- Different armor types require different levels of Armor dice
- Shields require Protection dice and offer active defense options

### Armor Types
| Armor | Dice Required | Damage Reduction | Properties |
|-------|--------------|-----------------|------------|
| Padded | — | -1 physical | Cheap, quiet |
| Leather | — | -2 physical | Standard light armor |
| Studded Leather | 1 Armor | -2 physical | Better quality |
| Chain Shirt | 1 Armor | -3 physical | Medium armor |
| Scale Mail | 1 Armor | -3 physical | Medium, stealth disadvantage |
| Breastplate | 2 Armor | -4 physical | Medium, no stealth penalty |
| Half Plate | 2 Armor | -4 physical | Heavy medium armor |
| Chain Mail | 2 Armor | -5 physical | Heavy, STR requirement |
| Splint | 3 Armor | -5 physical | Heavy |
| Plate | 3 Armor | -6 physical | Heavy, STR requirement |

### Shield Mechanics
| Shield | Dice Required | Benefit |
|--------|--------------|---------|
| Buckler | 1 Protection | +1 damage reduction, can still use hand |
| Shield | 1 Protection | +2 damage reduction |
| Tower Shield | 2 Protection | +3 damage reduction, provides cover |

### Tasks
- [ ] Design armor table with dice requirements and damage reduction
- [ ] Design shield table with Protection dice requirements
- [ ] Design armor degradation rules (if any)
- [ ] Design magic armor scaling
- [ ] Create armor/shield reference tables
