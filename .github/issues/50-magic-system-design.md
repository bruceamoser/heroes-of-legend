## Epic 5 — Magic System (#50)

**Dependency:** #12 (core resolution), #24 (dice types)
**Est. Effort:** Large

### Goal
Design the complete magic system — always-fires philosophy, spell chains, scaling, and limitations.

### Core Principles (from original, preserved)
- **No spell slots, no mana** — magic always fires when you cast
- **Always-fires philosophy** — you don't roll to cast, you roll for effect strength
- **Weak/Standard/Strong outcomes** — each spell has three effect tiers
- **Spell Chains** — Novice → Adept → Master progression (e.g., Firebolt → Fireball → Volcanic Eruption)
- **Dice Prerequisites** — Spells require specific dice type combinations

### Design Requirements
- Arcane magic (Arcanist class) and Divine magic (Shepherd class) use the same framework but different spell lists
- Cantrips → no dice requirement, always available
- Spell chains: 3 tiers, each requiring more specific dice
- Limitations replace D&D's "X times per rest" — instead use per-encounter, per-session, or escalating DP cost

### Spell Chain Example
```
Chain: Fire Magic (requires Fire dice)
  Novice: Firebolt — 1 Fire die
    Weak: 1d6 fire | Standard: 2d6 fire | Strong: 3d6 fire + ignite
  Adept: Fireball — 2 Fire dice + 1 Energy die
    Weak: 3d6 fire (5ft) | Standard: 5d6 fire (15ft) | Strong: 7d6 fire (20ft)
  Master: Volcanic Eruption — 3 Fire dice + 2 Earth dice + 1 Energy die
    Weak: 6d6 fire (20ft) | Standard: 10d6 fire (30ft) | Strong: 14d6 fire (40ft) + terrain hazard
```

### Tasks
- [ ] Design spell chain structure (3 tiers, escalating dice requirements)
- [ ] Design cantrip rules (at-will, no dice requirement)
- [ ] Design spell limitation system (per-encounter, per-session, DP costs)
- [ ] Design arcane vs divine distinction
- [ ] Design concentration rules (if any)
- [ ] Design ritual casting (if any)
- [ ] Write magic system rules as section for chapter 10
