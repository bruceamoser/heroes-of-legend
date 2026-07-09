## Critical Fix #1 — Convert All Damage to Flat Values

**Status:** Must fix before publication  
**Affects:** Chapters 06, 10, 11, 12, 13, 15, 17, 20

### Problem
The entire rulebook uses dice-based damage (e.g., Longsword: 1d8/2d8/3d8). Bruce's design intent is flat damage values (e.g., Longsword: 2/3/5). This is not a balance tweak — it's a fundamental mechanical rewrite.

### Why Flat Damage
- With dice damage: avg Strong hit = 13.5 dmg vs typical 10 HP → one-shot kills are the norm
- With flat damage: Strong hit = 5 damage vs 10 HP → 2-3 hits to down someone
- Flat damage makes combat tactical (players can count hits remaining)
- Flat damage eliminates the weird double-random: you already rolled 3d6 to determine tier, rolling again for damage adds nothing

### What to Change

#### Chapter 15 — Equipment (weapon tables)
Replace every damage column. Before/after examples:

| Weapon | Old W | Old S | Old St | New W | New S | New St |
|--------|-------|-------|--------|-------|-------|--------|
| Dagger | 1d4 | 1d6 | 1d8 | 1 | 2 | 3 |
| Shortsword | 1d6 | 1d8 | 1d10 | 2 | 3 | 4 |
| Longsword | 1d8 | 2d8 | 3d8 | 2 | 3 | 5 |
| Greatsword | 2d6 | 3d6 | 4d6 | 3 | 5 | 8 |
| Handaxe | 1d6 | 1d8 | 1d10 | 2 | 3 | 5 |
| Battleaxe | 1d8 | 2d8 | 3d8 | 3 | 4 | 6 |
| Greataxe | 1d12 | 2d12 | 3d12 | 3 | 5 | 8 |
| Spear | 1d6 | 1d8 | 1d10 | 2 | 3 | 4 |
| Halberd | 1d10 | 2d10 | 3d10 | 3 | 5 | 7 |
| Shortbow | 1d6 | 1d8 | 1d10 | 2 | 3 | 4 |
| Longbow | 1d8 | 2d8 | 3d8 | 3 | 4 | 6 |
| Crossbow | 1d10 | 2d10 | 3d10 | 3 | 5 | 7 |
| Unarmed | 1 | 1d4 | 1d6 | 1 | 1 | 2 |

#### Chapter 10 — Magic System (spell damage)
Convert all spell W/S/S values from dice to flat. Example:

| Spell | Tier | Old Damage | New Damage |
|-------|------|-----------|------------|
| Firebolt | Novice | W: 1d6 / S: 1d8 / St: 1d10+ignite | W: 2 / S: 3 / St: 5 + ignite |
| Fireball | Adept | W: 3d6 / S: 5d6 / St: 7d6 | W: 6(5ft) / S: 10(15ft) / St: 15(20ft) |
| Volcanic Eruption | Master | W: 6d6 / S: 10d6 / St: 14d6 | W: 12(20ft) / S: 20(30ft) / St: 28(40ft)+terrain |

#### Chapter 06 — Core Resolution
Remove all references to "roll weapon's Weak damage" — replace with "apply weapon's Weak damage value."

#### Chapter 13 — Combat
Replace the damage roll procedure with direct application of flat values.

#### Chapter 20 — Bestiary
Convert all monster attack damage to flat values.

#### All worked examples
Every example that shows damage being rolled must be rewritten to show flat damage being applied.

### Research Required Before Starting
**Ask Bruce:** What are the final flat damage values for every weapon? The table above is a starting proposal — Bruce needs to review and confirm. Also: does Brawn (or other attributes) add to flat damage? E.g., if Longsword Strong = 5 and Brawn = +2, is final damage 7 or 5?

### Implementation Steps
1. Get Bruce's confirmed flat damage values for all weapons
2. Update weapon table in chapter 15
3. Update spell damage in chapters 10, 11, 12
4. Update combat procedure in chapters 06 and 13
5. Update monster stat blocks in chapter 20
6. Update all worked examples
7. Rebuild and verify zero errors


---
## Decision Log — 2026-07-09

**RESOLVED.** All damage converted to flat values.

- All weapon damage is now flat W/S/S (e.g., Longsword: 2/3/5)
- **Brawn is factored into the 3d6 attack roll**, NOT added to damage. Higher Brawn = higher tier = higher damage from the flat value column.
- Finesse weapons use Agility on the 3d6 roll instead of Brawn.
- "Great Weapons" Discipline renamed to **Heavy Weapon** Discipline.
- Weapons may require multiple Disciplines (e.g., Longsword: 1 Blade + 1 Heavy Weapon; Halberd: 1 Polearm + 1 Axe).
- Final weapon table confirmed in Chapter 15.
- All bestiary damage, spell damage, and worked examples updated.
- PR #90 closed.
