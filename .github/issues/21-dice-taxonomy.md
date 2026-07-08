## Epic 2 — Dice Types (#21)

**Dependency:** #20
**Est. Effort:** Medium

### Goal
Create the taxonomy that organizes dice types into logical groups. This structure determines how dice types are presented to players and how they interact mechanically.

### Proposed Taxonomy
```
DICE TYPE TAXONOMY
├── Elemental Dice
│   ├── Fire
│   ├── Earth
│   ├── Wind
│   └── Water
├── Weapon Dice
│   ├── Blades        (swords, daggers)
│   ├── Axes          (hand axes, battle axes)
│   ├── Polearms      (spears, halberds)
│   ├── Great Weapons (two-handed swords, mauls)
│   └── Archery       (bows, crossbows)
├── Defense Dice
│   ├── Protection    (shields, warding)
│   └── Armor         (heavy armor proficiency)
├── Primal Dice
│   └── Animal        (beast handling, shapeshifting, nature)
├── Arcane Dice
│   └── Energy        (raw magical force, metamagic)
└── Generic Dice      (starting dice, usable anywhere)
```

### Tasks
- [ ] Validate taxonomy against all planned skills, spells, and equipment
- [ ] Determine if any dice type crosses category boundaries
- [ ] Design visual/icons for each category (for eventual character sheet)
- [ ] Write taxonomy documentation as AsciiDoc table
- [ ] Create reference table: "If you want to X, you need Y dice"
