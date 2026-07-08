## Epic 5 — Magic System (#51)

**Dependency:** #20 (dice catalog)
**Est. Effort:** Extra Large

### Goal
Catalog all D&D 5e PHB spells (~300-360) and group them into spell chains for the Heroes of Legend system.

### Approach
1. Extract the D&D 5e SRD spell list (legally safe)
2. Group spells by theme into chains (e.g., all fire spells → Fire Magic chain)
3. Assign each chain: Novice spell, Adept spell, Master spell
4. Assign dice prerequisites per tier
5. Determine Weak/Standard/Strong damage/effect values

### Spell Chain Categories
| Category | Example Chains | Dice Types |
|----------|---------------|------------|
| **Elemental** | Fire, Ice, Lightning, Acid, Poison | Fire/Water/Wind/Earth |
| **Control** | Charm, Fear, Sleep, Hold | Guile, Energy |
| **Protection** | Shield, Armor, Ward, Counterspell | Protection, Armor |
| **Healing** | Cure, Restore, Revive, Regenerate | Animal, Energy |
| **Divination** | Detect, Identify, Scry, True Seeing | Knowledge, Reason |
| **Summoning** | Animal, Elemental, Undead, Demon | Animal, Fire/Earth/etc. |
| **Illusion** | Image, Invisibility, Mirage, Phantasm | Guile, Wind |
| **Transmutation** | Enhance, Polymorph, Teleport, Time Stop | Energy, Reason |

### Tasks
- [ ] Extract D&D 5e SRD spell list into spreadsheet
- [ ] Group spells into ~30-40 chains of 3 tiers each
- [ ] Assign spell levels from D&D to Novice/Adept/Master tiers
- [ ] Assign dice prerequisites per spell
- [ ] Design Weak/Standard/Strong effects for each spell
- [ ] Create master spell catalog document
- [ ] Flag any SRD-unsafe spell names for renaming

### Reference
- D&D 5e SRD: https://dnd.wizards.com/resources/systems-reference-document
- Original PDF spell lists for adaptation patterns
