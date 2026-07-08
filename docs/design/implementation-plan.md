# Heroes of Legend — Core Rulebook Implementation Plan

> **Status:** Planning Phase  
> **Date:** 2026-07-07  
> **Source PDF:** `Heros of Legend-Playtest-v15.1.pdf` (111 pages, 46 images extracted)

---

## 1. Project Summary

Build a brand-new core rulebook for **Heroes of Legend** — a ground-up redesign of the original playtest game. The new system uses a **3d6 + modifiers** core mechanic with tiered success (Weak/Standard/Strong), a dice-type prerequisite system for abilities, and reproduces D&D 5e PHB spells adapted to the new framework.

The book is authored as individual `.adoc` chapter files with a master `.adoc` file that assembles them via `include::` directives, then built to PDF with `asciidoctor-pdf` — following the proven pattern from the **Neon Relic** project.

---

## 2. New System Mechanics Summary

### 2.1 Attributes (range: -2 to +2)
| Attribute | Domain |
|-----------|--------|
| **Brawn (BR)** | Physical strength, melee power |
| **Fortitude (FO)** | Endurance, resilience, health |
| **Agility (AG)** | Speed, reflexes, coordination |
| **Guile (GU)** | Cunning, deception, social finesse |
| **Knowledge (KN)** | Education, lore, information recall |
| **Reason (RE)** | Logic, problem-solving, magical aptitude |

### 2.2 Core Resolution
- **Roll:** 3d6 + Attribute Modifier + Skill Bonus + Game Modifiers
- **Weak:** 1-6 | **Standard:** 7-12 | **Strong:** 13-18+
- **Critical:** Three natural 6s (automatic strong + bonus)
- **Fumble:** Three natural 1s (automatic failure + complication)
- **Attacks always hit** — weapons/spells/abilities each have Weak, Standard, Strong damage values

### 2.3 Skills
- Provide +1 (Novice), +2 (Adept), +3 (Master) bonus
- Purchased with Development Points (DP) earned per level
- DP cost varies by class (e.g., Thief pays 1 DP for Stealth, Fighter pays 3, Mage pays 4)

### 2.4 Dice Type System
- **Types:** Fire, Earth, Wind, Water, Animal, Protection, Armor, Energy, Blades, Archery, Axes, Polearms, Great Weapons, etc. _(full catalog TBD during research)_
- Skills, abilities, and talents have **dice type requirements** as prerequisites
- Classes grant specific dice types at creation
- All characters start with **3 generic dice**
- Example: Long Sword skill requires 2 Blade dice; Dagger requires 1; Magic Missile requires 1 Archery die + 1 Energy die

### 2.5 Talents & Abilities
- Purchased for 1 DP (Novice), 2 DP (Adept), 4 DP (Master)
- D&D 5e PHB spells reproduced as ability chains: Firebolt (Novice) → Fireball (Adept) → Volcanic Eruption (Master)
- Spells always fire — no spell slots, no mana — but have Weak/Standard/Strong outcomes

### 2.6 Classes (8 Roles from original, redesigned)
| # | Class | Theme | Dice Focus |
|---|-------|-------|------------|
| 1 | Protector | Tank, defender | Armor, Protection, Shields |
| 2 | Blade | Melee striker | Blades, Axes, Polearms, Great Weapons |
| 3 | Arcanist | Arcane spellcaster | Fire, Wind, Energy, Water, Earth |
| 4 | Shepherd | Divine caster / healer | Protection, Animal, Energy |
| 5 | Intellect | Knowledge / skill expert | (flexible) |
| 6 | Odd | Wildcard / hybrid | (flexible) |
| 7 | Leader | Support / buffs | Protection, Energy |
| 8 | Unbalanced | High-risk / corruption | (unique — TBD) |

---

## 3. Repository Structure (mirrors Neon Relic)

```
heroes-of-legend/
├── AGENTS.md                          # AI assistant instructions
├── .gitignore
├── .github/
│   └── copilot-instructions.md        # Copilot behavior rules
├── build.sh                           # Linux/macOS build script
├── build.ps1                          # Windows build script
├── docs/
│   ├── heroes-of-legend.adoc          # Master document (include:: chapters/*.adoc)
│   ├── chapters/
│   │   ├── 00-front-matter.adoc       # Copyright, credits
│   │   ├── 01-introduction.adoc       # What is HoL, how to use this book
│   │   ├── 01b-opening-fiction.adoc   # Narrative hook
│   │   ├── 02-character-creation.adoc # Step-by-step PC creation
│   │   ├── 03-attributes.adoc         # The six attributes
│   │   ├── 04-ancestries-cultures.adoc# Human, Elf, Dwarf, Halfling + cultures
│   │   ├── 05-classes.adoc            # 8 roles with dice allocations & DP costs
│   │   ├── 06-core-resolution.adoc    # 3d6 mechanic, success tiers, crits/fumbles
│   │   ├── 07-skills.adoc             # Skill list, N/A/M bonuses, DP costs by class
│   │   ├── 08-dice-types.adoc         # Full dice type catalog & acquisition
│   │   ├── 09-talents-abilities.adoc  # Talent framework, DP costs, prerequisites
│   │   ├── 10-magic-system.adoc       # How magic works, always-fires, scaling
│   │   ├── 11-arcane-spells.adoc      # D&D 5e spells as ability chains (Part 1)
│   │   ├── 12-divine-spells.adoc      # Divine prayers as ability chains
│   │   ├── 13-combat.adoc             # Initiative, actions, always-hit, damage tiers
│   │   ├── 14-social-conflict.adoc    # Social resolution, influence
│   │   ├── 15-equipment.adoc          # Weapons with dice reqs + W/S/S damage
│   │   ├── 16-armor-shields.adoc      # Armor dice, protection
│   │   ├── 17-magic-items.adoc        # Magic items adapted
│   │   ├── 18-advancement.adoc        # DP, group reputation, titles
│   │   ├── 19-gm-guidance.adoc        # Running the game, encounters, difficulty
│   │   ├── 20-bestiary.adoc           # Monsters with dice types + W/S/S values
│   │   ├── 21-glossary.adoc           # Terms and definitions
│   │   ├── 22-reference-sheets.adoc   # Quick-reference tables
│   │   └── 23-license.adoc            # Open license / OGL
│   ├── themes/
│   │   └── heroes-of-legend-theme.yml # Fantasy tome PDF theme
│   └── design/
│       └── implementation-plan.md     # This file
├── assets/
│   ├── images/                        # Extracted + new artwork
│   └── svg/                           # Decorative elements, stamps
└── source-doc/
    ├── Heros of Legend-Playtest-v15.1.pdf  # Original PDF (read-only reference)
    └── extracted/
        └── playtest.md                # Extracted markdown (reference)
```

---

## 4. Chapter Dependency Graph

```
                          ┌──────────────────┐
                          │ 00 Front Matter   │
                          │ 01 Introduction   │
                          │ 01b Fiction       │
                          └────────┬─────────┘
                                   │
                    ┌──────────────┼──────────────┐
                    ▼              ▼              ▼
           ┌───────────┐  ┌───────────┐  ┌───────────┐
           │03 Attributes│  │06 Core Res│  │08 Dice Types│
           └─────┬─────┘  └─────┬─────┘  └─────┬───────┘
                 │              │              │
    ┌────────────┼──────────────┼──────────────┼────────────┐
    ▼            ▼              ▼              ▼            ▼
┌────────┐ ┌──────────┐ ┌───────────┐ ┌───────────┐ ┌──────────┐
│04 Ances│ │02 CharCreat│ │07 Skills  │ │09 Talents │ │10 Magic  │
│tries   │ └─────┬──────┘ └─────┬─────┘ │Abilities  │ │System    │
└────────┘       │              │       └─────┬─────┘ └────┬─────┘
                 │              │             │            │
         ┌───────┼──────────────┼─────────────┼────────────┘
         │       │              │             │
         ▼       ▼              ▼             ▼
    ┌────────┐ ┌──────────┐ ┌─────────────────────┐
    │05 Class│ │13 Combat │ │11 Arcane / 12 Divine │
    │es      │ └────┬─────┘ │Spells                │
    └───┬────┘      │       └──────────┬───────────┘
        │           │                  │
        │    ┌──────┼──────┐    ┌──────┼──────┐
        │    ▼      ▼      ▼    ▼      ▼      ▼
        │ ┌────┐┌────┐┌────┐┌────┐┌────┐┌────┐
        │ │15  ││16  ││14  ││17  ││18  ││20  │
        │ │Equip││Armor││Soc ││Mag ││Adv ││Best│
        │ │    ││    ││    ││Items││    ││iary│
        │ └────┘└────┘└────┘└────┘└────┘└────┘
        │           │
        ▼           ▼
    ┌─────────────────────┐
    │ 19 GM Guidance       │
    └─────────────────────┘
              │
              ▼
    ┌─────────────────────┐
    │ 21 Glossary          │
    │ 22 Reference Sheets  │
    │ 23 License           │
    └─────────────────────┘
```

---

## 5. GitHub Issue Tree

### Epic 0: Infrastructure & Build System _(Prerequisite for all work)_

| Issue | Title | Depends On | Est. Effort |
|-------|-------|------------|-------------|
| #1 | Initialize repo structure and build pipeline | — | S |
| #2 | Create fantasy tome PDF theme | #1 | M |
| #3 | Create master .adoc file with chapter stubs | #1 | S |
| #4 | Organize and catalog extracted PDF images | — | S |
| #5 | Write AGENTS.md and copilot-instructions.md | #1 | S |
| #6 | Create .gitignore and initial README | #1 | S |

### Epic 1: Core Mechanics Foundation _(Everything depends on this)_

| Issue | Title | Depends On | Est. Effort |
|-------|-------|------------|-------------|
| #10 | Research: catalog all mechanical decisions needed before writing | — | M |
| #11 | Design: attribute system (-2 to +2, six attributes) | #10 | S |
| #12 | Design: 3d6 core resolution with Weak/Standard/Strong tiers | #10 | M |
| #13 | Design: critical hits (3×6) and fumbles (3×1) | #12 | S |
| #14 | Design: always-hit philosophy and damage tier tables | #12 | S |
| #15 | Write chapter 06 — Core Resolution Mechanics | #11, #12, #13, #14 | M |
| #16 | Write chapter 03 — Attributes | #11 | S |

### Epic 2: Dice Type System _(Gateway to skills, magic, equipment)_

| Issue | Title | Depends On | Est. Effort |
|-------|-------|------------|-------------|
| #20 | Research: catalog all dice types from original PDF and D&D 5e | #4 | L |
| #21 | Design: dice type taxonomy (elemental, weapon, armor, etc.) | #20 | M |
| #22 | Design: dice acquisition rules (starting dice, class grants, progression) | #21 | M |
| #23 | Design: dice prerequisite system for skills and abilities | #21, #22 | M |
| #24 | Write chapter 08 — Dice Types | #20-#23 | L |

### Epic 3: Skills & Talents Framework

| Issue | Title | Depends On | Est. Effort |
|-------|-------|------------|-------------|
| #30 | Research: skill list from original PDF and D&D 5e skill analogs | #20 | M |
| #31 | Design: novice/adept/master skill bonus tiers (+1/+2/+3) | #30 | S |
| #32 | Design: DP economy — how many DP per level, cost curves | #31 | M |
| #33 | Design: class-based DP cost matrix for all skills | #32, #25 (classes) | L |
| #34 | Design: talent/ability framework (1/2/4 DP for N/A/M) | #32 | M |
| #35 | Write chapter 07 — Skills | #30-#33 | L |
| #36 | Write chapter 09 — Talents & Abilities | #34, #24 | L |

### Epic 4: Character Creation

| Issue | Title | Depends On | Est. Effort |
|-------|-------|------------|-------------|
| #40 | Design: step-by-step character creation flow | #11, #16 | M |
| #41 | Write chapter 04 — Ancestries & Cultures | #40 | L |
| #42 | Design: 8 class roles with dice allocations & DP cost tables | #21, #32 | XL |
| #43 | Write chapter 05 — Classes | #42 | XL |
| #44 | Write chapter 02 — Character Creation (assembly chapter) | #40, #41, #43, #35, #36 | L |

### Epic 5: Magic System _(Largest scope — ~300 spells)_

| Issue | Title | Depends On | Est. Effort |
|-------|-------|------------|-------------|
| #50 | Design: magic system mechanics (always-fires, scaling, limitations) | #12, #24 | L |
| #51 | Research: catalog D&D 5e PHB spells — group into dice chains | #20 | XL |
| #52 | Write chapter 10 — Magic System | #50 | M |
| #53 | Design & write: cantrip spell chains (all schools) | #50, #51 | L |
| #54 | Design & write: 1st-level spell chains (Fire, Ice, etc.) | #50, #51 | XL |
| #55 | Design & write: 2nd-3rd level spell chains | #50, #51 | XL |
| #56 | Design & write: 4th-5th level spell chains | #50, #51 | XL |
| #57 | Design & write: 6th-9th level spell chains | #50, #51 | XL |
| #58 | Write chapter 11 — Arcane Spells (assembly) | #53-#57 | L |
| #59 | Design & write: Divine spell/prayer chains | #50, #51 | XL |
| #60 | Write chapter 12 — Divine Spells | #59 | L |

### Epic 6: Combat & Equipment

| Issue | Title | Depends On | Est. Effort |
|-------|-------|------------|-------------|
| #70 | Design: combat round structure, initiative, action economy | #12 | M |
| #71 | Design: weapon tables — dice requirements + Weak/Standard/Strong damage | #24 | L |
| #72 | Design: armor & shield mechanics with dice types | #24 | M |
| #73 | Design: conditions and afflictions | #12 | M |
| #74 | Write chapter 13 — Combat | #70, #73 | L |
| #75 | Write chapter 15 — Equipment (weapons, gear, kits) | #71 | L |
| #76 | Write chapter 16 — Armor & Shields | #72 | M |
| #77 | Write chapter 14 — Social Conflict | #12 | M |
| #78 | Design & write chapter 17 — Magic Items | #50, #71 | L |

### Epic 7: GM Tools & World

| Issue | Title | Depends On | Est. Effort |
|-------|-------|------------|-------------|
| #80 | Design: advancement system (DP per level, group reputation, titles) | #32, #43 | M |
| #81 | Write chapter 18 — Advancement | #80 | M |
| #82 | Design: bestiary — monster stat blocks with dice types & W/S/S values | #24, #74 | L |
| #83 | Write chapter 20 — Bestiary | #82 | L |
| #84 | Write chapter 19 — GM Guidance | #74, #81, #83 | L |

### Epic 8: Front Matter & Polish

| Issue | Title | Depends On | Est. Effort |
|-------|-------|------------|-------------|
| #90 | Write chapter 00 — Front Matter (copyright, credits) | — | S |
| #91 | Write chapter 01 — Introduction | #15 | M |
| #92 | Write chapter 01b — Opening Fiction | — | M |
| #93 | Write chapter 21 — Glossary | #15-#84 | M |
| #94 | Write chapter 22 — Quick Reference Sheets | #15-#84 | M |
| #95 | Write chapter 23 — License | — | S |
| #96 | Cross-reference validation pass (all xref: links) | #15-#95 | L |
| #97 | Full build, PDF generation, and review | #96 | M |

---

## 6. Implementation Order (Critical Path)

```
Phase 0  (Week 1):  Epic 0 — Infrastructure (#1-#6)
Phase 1  (Week 2):  Epic 1 — Core Mechanics (#10-#16)
Phase 2  (Week 3):  Epic 2 — Dice Types (#20-#24)
Phase 3  (Week 4):  Epic 3 — Skills & Talents (#30-#36)
Phase 4  (Week 5):  Epic 4 — Character Creation (#40-#44)
Phase 5  (Weeks 6-9): Epic 5 — Magic System (#50-#60) ← LONGEST PHASE
Phase 6  (Weeks 10-11): Epic 6 — Combat & Equipment (#70-#78)
Phase 7  (Week 12): Epic 7 — GM Tools (#80-#84)
Phase 8  (Week 13): Epic 8 — Polish & Build (#90-#97)
```

---

## 7. Key Design Decisions Required (Before Writing)

These questions must be resolved during Epic 1 research (#10):

1. **Attribute range:** -2 to +2 confirmed. What's the baseline (0 = average human)? How are starting attributes determined — point buy? Array? Random?
2. **Success tier boundaries:** Weak 1-6, Standard 7-12, Strong 13-18+. Are these fixed or adjustable? Do modifiers shift the range?
3. **DP economy:** How many DP per level? How many levels total? What's the curve?
4. **Dice type catalog:** How many dice types total? ~20? ~50? What's the taxonomy?
5. **Spell adaptation scope:** Full PHB (362 spells)? Or SRD only (which is ~320)?
6. **Combat always-hit:** Does "always hit" mean zero attack rolls, only damage rolls? How does armor interact?
7. **Ancestries:** Keep the 4 from original (Human, Elf, Dwarf, Halfling)? Add more?
8. **Level cap:** What's the maximum level? 10? 20? Open-ended?

---

## 8. Build Pipeline

Adapted from Neon Relic's proven pipeline:

```bash
# Prerequisites (one-time)
gem install asciidoctor-pdf asciidoctor-diagram
# Optional: Chrome/Chromium for HTML→PDF

# Build
./build.sh          # Full build → starter-kit/neon-relic-core-rules.pdf
./build.sh --skip-magic  # Skip spell chapters for faster iteration (TBD)

# Inside build.sh:
asciidoctor-pdf \
    -a pdf-fontsdir="docs/themes/fonts" \
    -o "starter-kit/heroes-of-legend-core-rules.pdf" \
    "docs/heroes-of-legend.adoc"
```

---

## 9. Theme: Fantasy Tome

The PDF theme should evoke an aged fantasy tome:
- **Palette:** Aged parchment (#f4e4c1), dark brown ink (#3a2a1a), deep red accents (#8b0000)
- **Fonts:** Serif body (e.g., Crimson Text, Garamond), display font for headings
- **Decorations:** Ornamental chapter dividers, drop caps for chapter openings
- **Tables:** Alternating warm-tone rows, decorative borders
- **Callouts:** Illuminated manuscript styling for important rules

---

*Plan last updated: 2026-07-07*
