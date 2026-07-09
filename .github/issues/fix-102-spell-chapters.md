## Critical Fix #2 — Write Arcane & Divine Spell Chapters

**Status:** Must fix before publication  
**Affects:** Chapters 11, 12

### Problem
Chapters 11 (Arcane Spells) and 12 (Divine Spells) are placeholders with zero spell entries. These are the two largest chapters in the book (~300 spells total) and they contain no content.

### Scope
- ~200-250 arcane spells
- ~50-80 divine spells
- Each spell: Novice/Adept/Master tier, Discipline prerequisites, flat Weak/Standard/Strong values

### Research Required
1. **Extract D&D 5e SRD spell list** (legally safe source): https://dnd.wizards.com/resources/systems-reference-document
2. **Group spells into chains of 3 tiers** (Novice → Adept → Master)
3. **Assign Discipline prerequisites per spell**
4. **Assign flat W/S/S values per spell**
5. **Rename any SRD-unsafe spell names** (e.g., "Mordenkainen's" → "Arcane")

### Spell Chain Categories
Organize by element/school:

| Chain | Novice | Adept | Master | Disciplines |
|-------|--------|-------|--------|-------------|
| Fire Magic | Firebolt | Fireball | Volcanic Eruption | Fire |
| Ice Magic | Ray of Frost | Ice Storm | Cone of Cold | Water |
| Lightning | Shocking Grasp | Lightning Bolt | Chain Lightning | Wind |
| Acid Magic | Acid Splash | Melf's Acid Arrow | Vitriolic Sphere | Earth |
| Force Magic | Magic Missile | Spiritual Weapon | Disintegrate | Energy |
| Healing Touch | Cure Wounds | Prayer of Healing | Mass Cure Wounds | Animal |
| Protection | Shield | Magic Circle | Globe of Invulnerability | Protection |
| Charm | Charm Person | Suggestion | Dominate Person | Guile |
| Illusion | Minor Illusion | Mirror Image | Greater Invisibility | Wind |
| Necromancy | Chill Touch | Animate Dead | Finger of Death | Energy |
| Divination | Detect Magic | Clairvoyance | True Seeing | Knowledge |
| Transmutation | Enlarge/Reduce | Polymorph | Time Stop | Reason |

### Per-Spell Format
```
=== Firebolt
*Tier:* Novice | *Disciplines Required:* 1 Fire
*Casting Time:* 1 action | *Range:* 120 ft
*Chain:* Firebolt → Fireball → Volcanic Eruption

*Weak (2):* Singes target for 2 fire damage
*Standard (3):* Blast deals 3 fire damage
*Strong (5):* Deals 5 fire damage and ignites flammable objects
```

### Implementation Approach
1. Phase 1: Cantrips (20-30 spells, no Discipline requirement)
2. Phase 2: Elemental chains (Fire, Ice, Lightning, Acid — ~60 spells)
3. Phase 3: Utility chains (Charm, Illusion, Divination, Protection — ~60 spells)
4. Phase 4: High magic chains (Necromancy, Conjuration, Transmutation — ~40 spells)
5. Phase 5: Divine chains (Healing, Blessings, Holy Light, Wards — ~60 spells)
6. Phase 6: Quick-reference tables by chain, by Discipline, by tier

### Success Criteria
- Every spell has W/S/S flat values
- Every spell has correct Discipline prerequisites
- Every spell is part of a 3-tier chain
- No SRD-unsafe names
- Quick-reference tables at end of each chapter
- Builds without errors


---
## Status Log — 2026-07-09

**BLOCKED.** Waiting on #110 (Master Discipline requirements) and #107 (DP economy) before spell chain design can begin. ~300 D&D 5e spells to adapt into Novice→Adept→Master chains. Largest remaining content task.

---
## Scope Revision — 2026-07-09

**Reduced from ~300 to ~100 iconic spells.** Start small, get balance right, expand later. Top 100 most recognizable D&D SRD spells adapted into Novice→Adept→Master chains.
