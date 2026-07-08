## Epic 7 — GM Tools (#82)

**Dependency:** #24 (dice types), #74 (combat)
**Est. Effort:** Large

### Goal
Design the bestiary — monster stat blocks using the dice type system with Weak/Standard/Strong values.

### Monster Stat Block Format
```
=== Monster Name
*Challenge:* X | *Type:* Beast/Monstrosity/Undead/etc.
*Dice:* [types the monster uses]

*Brawn:* +X | *Fortitude:* +X | *Agility:* +X
*Guile:* +X | *Knowledge:* +X | *Reason:* +X

*Health:* X | *Damage Reduction:* X

ATTACKS
*Claw:* Weak: X / Standard: X / Strong: X
*Bite:* Weak: X / Standard: X / Strong: X

ABILITIES
*[Name]:* [Effect description with W/S/S outcomes]
```

### Beast Categories (from original PDF)
| Category | Examples |
|----------|----------|
| **Beasts** | Wolf, Bear, Giant Spider, Dire Boar |
| **Monstrosities** | Owlbear, Basilisk, Chimera, Hydra |
| **Seelie (Fey)** | Pixie, Brownie, Dryad, Satyr |
| **Unseelie (Dark Fey)** | Boggart, Redcap, Hag |
| **Undead** | Skeleton, Zombie, Wraith, Lich |
| **Dragons** | Wyrmling → Adult → Ancient |
| **Humanoids** | Bandit, Cultist, Knight, Archmage |

### Tasks
- [ ] Design 25-40 monster stat blocks
- [ ] Assign dice types to monsters
- [ ] Design Challenge Rating system (or equivalent)
- [ ] Create monster-by-environment tables
- [ ] Create NPC quick-build templates
