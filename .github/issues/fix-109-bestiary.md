## Major Fix #9 — Expand Bestiary to 25-30 Creatures

**Status:** Should fix before publication  
**Affects:** Chapter 20

### Problem
The bestiary has 5 entries: Wolf, Bear, Skeleton, Wraith, Young Red Dragon. A core rulebook needs 25-30 creatures for DAs to run varied encounters.

### Required Categories & Minimum Counts

| Category | Minimum | Examples |
|----------|---------|----------|
| **Beasts** | 5 | Wolf, Bear, Giant Spider, Dire Boar, Swarm of Rats |
| **Humanoids (NPCs)** | 5 | Bandit, Guard, Cultist, Knight, Archmage |
| **Undead** | 4 | Skeleton, Zombie, Ghoul, Wraith, Lich |
| **Monstrosities** | 3 | Owlbear, Basilisk, Chimera |
| **Fey** | 3 | Pixie, Dryad, Hag |
| **Dragons** | 3 | Young, Adult, Ancient (one color as template) |
| **Elementals** | 2 | Fire Elemental, Water Elemental |
| **Giants** | 2 | Hill Giant, Stone Giant |
| **Extraplanar** | 2 | Demon (Vrock), Devil (Barbed Devil) |
| **Oozes** | 1 | Gelatinous Cube |

Total: 30 creatures

### Stat Block Format
Use flat damage values consistent with Critical Fix #1:

```
=== Skeleton
*Challenge 1* | *Undead*
*BR +1 · FO +0 · AG +0 · GU -2 · KN -1 · RE -2*
*HP 6 · DR 1 (piercing/slashing)*

*Shortsword:* W: 2 · S: 3 · St: 4
*Shortbow:* W: 2 · S: 3 · St: 4

*Vulnerable (Bludgeoning):* Damage tier +1 against bludgeoning attacks.
*Undead Nature:* Immune to poison and charm. Does not need to breathe.
```

### Implementation
1. Design 30 stat blocks using flat W/S/S damage
2. Assign appropriate HP, DR, and attribute modifiers
3. Add 1-2 special abilities per creature
4. Create encounter building table (Challenge 1-10 with example pairings)
5. Add monster creation guidelines for DAs
6. Add monster-by-environment quick reference table


---
## Decision Log — 2026-07-09

**RESOLVED.** Bestiary expanded to 30 creatures across 10 categories.

- Categories: Beasts, Constructs, Dragons, Elementals, Fey, Giants, Humanoids, Monstrosities, Undead, Vermin.
- 3 creatures per category (one low-CR, one mid-CR, one high-CR).
- All stat blocks use flat damage values.
- PR #89 closed.

---
## Scope Revision — 2026-07-09

**Expanding from 30 to ~75 iconic creatures.** Initial 30 done (PR #89). Now scaling up to the creatures every fantasy TTRPG expects before niche entries. Same 10 categories, deeper rosters.
