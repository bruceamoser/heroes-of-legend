## Epic 6 — Combat & Equipment (#71)

**Dependency:** #24 (dice types)
**Est. Effort:** Large

### Goal
Design complete weapon tables with dice prerequisites and Weak/Standard/Strong damage values.

### Weapon Categories
| Category | Dice Type | Example Weapons | Typical Damage (W/S/S) |
|----------|-----------|-----------------|------------------------|
| **Blades** | Blades | Dagger, Shortsword, Longsword, Greatsword | 1d4/1d6/1d8 → 2d6/3d6/4d6 |
| **Axes** | Axes | Handaxe, Battleaxe, Greataxe | 1d6/1d8/1d10 → 2d8/3d8/4d8 |
| **Polearms** | Polearms | Spear, Halberd, Glaive | 1d6/1d8/1d10 → 2d8/3d8/4d8 |
| **Great Weapons** | Great Weapons | Maul, Greatsword, Greataxe | 2d6/3d6/4d6 → 4d6/5d6/6d6 |
| **Archery** | Archery | Shortbow, Longbow, Crossbow | 1d6/1d8/1d10 → 2d8/3d8/4d8 |
| **Unarmed** | (none) | Fists, Gauntlets | 1/1d4/1d6 |

### Per-Weapon Format
```
=== Longsword
*Category:* Blades | *Dice Required:* 2 Blade dice
*Hands:* 1 (versatile 2 for +1 damage tier)
*Damage:* Weak: 1d8+BR / Standard: 2d8+BR / Strong: 3d8+BR
*Properties:* Versatile (d10 when two-handed)
*Cost:* 15 gp | *Weight:* 3 lbs
```

### Tasks
- [ ] Design 30-40 weapons across all categories
- [ ] Assign dice prerequisites per weapon
- [ ] Assign W/S/S damage values
- [ ] Design weapon properties (versatile, finesse, reach, thrown, etc.)
- [ ] Create weapon quick-reference tables
- [ ] Create weapon-by-dice-requirement table
