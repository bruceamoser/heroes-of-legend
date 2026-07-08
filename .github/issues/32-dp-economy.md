## Epic 3 — Skills & Talents (#32)

**Dependency:** #31, #42 (classes)
**Est. Effort:** Medium

### Goal
Design the Development Point economy — how many DP characters earn, how they spend them, and the cost curves.

### Design Requirements
- DP is earned per level (individual progression, unlike original's group rep)
- Different classes have different DP costs for the same skill
- Talents/Abilities cost 1/2/4 DP for Novice/Adept/Master
- DP should feel scarce enough that choices matter but plentiful enough for progression

### Proposed DP Economy
| Level | DP Earned | Cumulative |
|-------|-----------|------------|
| 1 | 3 (starting) | 3 |
| 2 | 2 | 5 |
| 3 | 2 | 7 |
| ... | ... | ... |
| 10 | 3 | ~25 |
| ... | ... | ... |
| 20 | 4 | ~55 |

### Class DP Cost Matrix (example)
| Skill | Protector | Blade | Arcanist | Shepherd | Intellect | Odd | Leader | Unbalanced |
|-------|-----------|-------|----------|----------|-----------|-----|--------|------------|
| Melee Combat | 1 | 1 | 3 | 2 | 2 | 2 | 2 | 2 |
| Arcana | 4 | 3 | 1 | 2 | 2 | 2 | 3 | 1 |
| Stealth | 3 | 2 | 3 | 3 | 3 | 1 | 3 | 2 |
| ... | | | | | | | | |

### Tasks
- [ ] Design DP-per-level curve (1-20 or 1-10)
- [ ] Design class DP cost matrix for all skills (~20 skills × 8 classes)
- [ ] Define DP costs for talents/abilities (1/2/4 for N/A/M)
- [ ] Design DP refund/respec rules (if any)
- [ ] Create DP economy reference table
