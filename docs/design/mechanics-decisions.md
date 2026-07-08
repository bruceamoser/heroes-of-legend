# Mechanics Design Decisions

> Resolved during Issue #8 research phase. These decisions feed into all Epic 1 implementation issues (#9-#14).

---

## 1. Attribute System

**Range:** -2 to +2 (0 = average human)  
**Starting Determination:** Point buy with 3 points to distribute across 6 attributes. No attribute may exceed +2 or go below -2 at creation.  
**Baseline:** 0 represents average human capability. -2 is significantly below average. +2 is exceptional (olympic-level).

| Score | Modifier | Description |
|-------|----------|-------------|
| -2 | -2 | Severely deficient |
| -1 | -1 | Below average |
| 0 | +0 | Average human |
| +1 | +1 | Above average |
| +2 | +2 | Exceptional |

**Attribute Increase:** At levels 4, 8, 12, 16, 20, increase one attribute by +1 (max +2).

---

## 2. Core Resolution (3d6)

**Roll:** 3d6 + Attribute Modifier + Skill Bonus + Game Modifiers  
**Tier Boundaries (fixed):**
| Result | Tier | Outcome |
|--------|------|---------|
| 1-6 | Weak | Partial success or success with complication |
| 7-12 | Standard | Full success, expected outcome |
| 13-18+ | Strong | Exceptional success, bonus effect |

**Natural Results:** Three natural 6s = Critical (auto-Strong + bonus). Three natural 1s = Fumble (auto-failure + complication).

**Difficulty:** Modifies the roll with a ± modifier, NOT the tier boundaries. Easier tasks get +2, harder tasks get -2 or -4.

**Opposed Rolls:** Both sides roll 3d6 + modifiers. Higher total wins. Ties go to the active party (attacker wins on attack, defender wins on defense).

**Baseline:** An unmodified roll (attribute 0, no skill) has a ~26% chance of Weak, ~44% chance of Standard, ~26% chance of Strong, ~0.5% chance of Critical, ~0.5% chance of Fumble.

---

## 3. Always-Hit Philosophy

**Attacks always hit.** No attack roll. The 3d6 resolution determines damage tier:
- Weak result → roll weapon's Weak damage
- Standard result → roll weapon's Standard damage
- Strong result → roll weapon's Strong damage
- Critical → maximize Strong damage + bonus effect

**Defense:** Armor provides damage reduction (subtract from incoming damage). Shields provide active defense (reaction to reduce damage tier by one step). Dodge/evasion is handled by the Agility modifier on the 3d6 roll — higher Agility pushes results toward Standard/Strong tiers.

---

## 4. Health & Damage

**Health Points:** Base HP = 10 + (Fortitude modifier × 2). At minimum Fortitude (-2), HP = 6. At maximum (+2), HP = 14.

**Wounded Threshold:** When HP drops below half (rounded down), you are Wounded. Healing is halved while Wounded.

**Dying:** At 0 HP, fall unconscious. Each round, roll 3d6: Strong = stabilize at 1 HP, Standard = remain unconscious, Weak = take 1 wound, Fumble = death. Critical = regain consciousness at half HP.

**Healing:** Rest heals HP equal to Fortitude modifier (minimum 1) per night. Magic healing uses spell's W/S/S values.

---

## 5. Development Points Economy

**DP per Level:** 3 DP at level 1, 2 DP per level thereafter.  
**Level Cap:** 20 (open to extension).  
**Total DP at level 20:** 3 + (19 × 2) = 41 DP.

**DP Costs:**
| Purchase | Novice | Adept | Master |
|----------|--------|-------|--------|
| Skill (favored class) | 1 DP | 2 DP | 4 DP |
| Skill (cross-class) | 2-4 DP | 3-6 DP | 6-8 DP |
| Talent/Ability | 1 DP | 2 DP | 4 DP |

---

## 6. Ancestries

**Keep the 4 from original:** Human, Elf, Dwarf, Halfling.  
**Mechanical weight:** Each ancestry grants 1-2 starting dice types and a unique trait.  
**Culture:** Sub-choice within ancestry that grants a skill bonus.

| Ancestry | Dice Types | Trait |
|----------|-----------|-------|
| Human | 1 Generic (bonus) | Versatile: +1 DP at creation |
| Elf | 1 Wind or 1 Water | Keen Senses: +1 to perception |
| Dwarf | 1 Earth or 1 Fire | Sturdy: +2 max HP |
| Halfling | 1 Animal | Lucky: reroll one 1 per session |

---

## 7. Classes (8 Roles)

Preserved from original, redesigned for new mechanics:

| # | Class | Primary Dice | Signature |
|---|-------|-------------|-----------|
| 1 | Protector | Armor, Protection | Damage reduction aura |
| 2 | Blade | Blades, Axes, Polearms, Great Weapons | Bonus damage on Strong hits |
| 3 | Arcanist | Fire, Wind, Energy, Water, Earth | Cantrip mastery |
| 4 | Shepherd | Protection, Animal, Energy | Bonus healing |
| 5 | Intellect | (flexible, 2 of any) | Skill expertise |
| 6 | Odd | (flexible, 2 of any) | Random bonus each session |
| 7 | Leader | Protection, Energy | Ally buffs |
| 8 | Unbalanced | (unique, 1 of each opposing pair) | High-risk corruption mechanic |

---

## 8. Spell Adaptation Scope

**SRD spells only** for legal safety. ~320 spells from D&D 5e SRD. Grouped into ~40 chains of 3 tiers each. Use SRD spell names.

---

*Decisions documented 2026-07-08. May be refined as chapters are written.*
