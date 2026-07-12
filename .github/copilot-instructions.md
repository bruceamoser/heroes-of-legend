# Heroes of Legend — AI Copilot Instructions

## What We're Building

**Heroes of Legend** is a fantasy tabletop RPG (TTRPG) rulebook. We're writing a complete core rulebook as Quarto Markdown (`.qmd`) chapter files, assembled and built to a gorgeous PDF via **Quarto + Typst**.

This is a **book-writing project**, not a software project. Every file we touch is prose, rules text, tables, and formatting — not code. Think of yourself as a collaborative editor, game designer, and technical writer rolled into one.

- **Lead designer:** Bruce — final authority on all design decisions.
- **Phase:** Core rules design — writing and polishing the full rulebook.
- **Canonical source:** `quarto-book/chapters/*.qmd` — all rules, mechanics, and prose live here.
- **Build:** `cd quarto-book && ./build.sh` (or `.\build.ps1` on Windows) produces `_output/heroes-of-legend-core-rules.pdf`.

---

## The Rulebook at a Glance

| Chapter | File | Content |
|---------|------|---------|
| 00 | `00-front-matter.qmd` | Credits, table of contents |
| 01 | `01-introduction.qmd` | What is a TTRPG, how to use this book |
| 01b | `01b-opening-fiction.qmd` | Opening fiction vignette |
| 02 | `02-character-creation.qmd` | Step-by-step character creation |
| 03 | `03-attributes.qmd` | Brawn, Fortitude, Agility, Guile, Knowledge, Reason |
| 04 | `04-ancestries-cultures.qmd` | Ancestries and cultures |
| 05 | `05-classes.qmd` | Character classes |
| 06 | `06-core-resolution.qmd` | 3d6 resolution, success tiers |
| 07 | `07-skills.qmd` | Skills and skill system |
| 08 | `08-disciplines.qmd` | Discipline catalog and system |
| 09 | `09-talents-abilities.qmd` | Talents and abilities |
| 10 | `10-magic-system.qmd` | How magic works |
| 11 | `11-arcane-spells.qmd` | Arcane spell catalog (~150 spells) |
| 12 | `12-divine-spells.qmd` | Divine spell catalog (~150 spells) |
| 13 | `13-combat.qmd` | Combat rules |
| 14 | `14-social-conflict.qmd` | Social conflict system |
| 15 | `15-equipment.qmd` | Weapons, gear, adventuring equipment |
| 16 | `16-armor-shields.qmd` | Armor and shields |
| 17 | `17-magic-items.qmd` | Magic items |
| 18 | `18-advancement.qmd` | Leveling, DP, progression |
| 19 | `19-gm-guidance.qmd` | GM advice and tools |
| 20 | `20-bestiary.qmd` | Monster stat blocks |
| 21 | `21-glossary.qmd` | Glossary of terms |
| 22 | `22-reference-sheets.qmd` | Quick-reference sheets |
| 23 | `23-license.qmd` | OGL / license |

---

## Core Game Mechanics (Non-Negotiable)

These are the pillars of the system. Every design decision flows from them.

### The Core Roll
- **3d6 + Attribute Modifier + Skill Bonus + Game Modifiers**
- **Attributes:** Brawn, Fortitude, Agility, Guile, Knowledge, Reason — range **-2 to +2**
- **Success tiers:** Weak (1–6), Standard (7–12), Strong (13–18+)
- **Critical:** Three natural 6s — automatic Strong success with bonus effect
- **Fumble:** Three natural 1s — automatic failure with complication
- **Attacks always hit** — weapons and spells have distinct Weak/Standard/Strong damage values
- **No spell slots, no mana** — magic always fires; outcomes replace saving throws

### Skills
- +1 (Novice), +2 (Adept), +3 (Master) — purchased with Development Points (DP)
- Class determines DP cost per skill

### Talents & Abilities
- 1 DP (Novice), 2 DP (Adept), 4 DP (Master)
- Organized as three-tier chains, same as spells

### Disciplines
- This is the game's **unique mechanical identity** — preserve its integrity
- Disciplines are keywords like Fire, Earth, Wind, Water, Animal, Protection, Armor, Energy, Blades, Archery, Axes, Polearms, Great Weapons
- All characters start with 3 General Disciplines
- Classes grant specific Disciplines
- Skills and abilities require specific Disciplines as prerequisites

### Spell Design
- ~300 D&D 5e spells adapted as three-tier ability chains
- Each chain: Novice → Adept → Master (e.g., Firebolt → Fireball → Volcanic Eruption)
- Use SRD spell names where possible for legal safety
- Spells always fire — Weak/Standard/Strong outcomes replace saving throws

---

## Writing Style Guide

### Tone
- **Heroic adventure** — players are exceptional individuals, not grim survivors
- **Generic fantasy** — flexible, not tied to a specific world
- **Accessible but deep** — quick to start, rewarding to master
- **Player-facing** — write rules as if explaining to a new player
- **Confident, not academic** — authoritative but warm

### Prose Rules
1. **Clarity over cleverness.** If a rule takes 200 words and could take 50, rewrite it.
2. **One concept per paragraph.** Don't bundle unrelated rules together.
3. **Examples are mandatory.** Every major mechanic needs at least one worked example.
4. **Active voice.** "You roll 3d6" not "3d6 are rolled."
5. **Bold game terms on first use.** `**Brawn**`, `**Discipline**`, `**Success Tier**`

### Formatting
- **Tables** for mechanical data (stats, skills, equipment, spells, DP costs)
- **Callout blocks** for important rules clarifications:
  ```markdown
  :::{.callout-note}
  ## Optional Rule: Cinematic Damage
  If you want larger-than-life combat...
  :::
  ```
- **Cross-references** use Quarto syntax: `@sec-chapter-combat`, `@sec-magic-system`
- **Spell stat blocks** follow the pattern in existing chapters 11 and 12
- **Monster stat blocks** follow the pattern in chapter 20

---

## Working with Chapters

### Reading Order Matters
Respect the chapter dependency chain:
```
Core Mechanics (06) → Disciplines (08) → Skills (07) → Magic (10) → Spells (11,12) → Combat (13) → Equipment (15,16) → GM Tools (19)
```

Always read upstream chapters before working on downstream ones. A change to chapter 06 (core resolution) affects everything.

### Editing a Chapter
1. Read the full chapter first — don't skim
2. Read any upstream chapters it depends on
3. Check GitHub issues for related tasks and dependencies
4. Make surgical changes — don't "improve" adjacent chapters
5. Update cross-references your changes break
6. Build to validate: `cd quarto-book && ./build.sh`

### Creating a New Chapter
1. Study an existing chapter for conventions (chapter 06 is a good model)
2. Start with the chapter outline
3. Write rules, then examples, then flavor
4. Add all cross-references to related chapters
5. Register the chapter in `quarto-book/_quarto.yml`
6. Build and fix all warnings

---

## Reference Files

| File | Use |
|------|-----|
| `quarto-book/_quarto.yml` | Book structure, chapter ordering, Typst settings |
| `quarto-book/_extensions/heroes-of-legend/template.typ` | PDF theme — fantasy tome aesthetic |
| `source-doc/Heros of Legend-Playtest-v15.1.pdf` | Original playtest (read-only historical reference) |
| `source-doc/playtest-full.txt` | Extracted playtest text (searchable reference) |
| `assets/images/` | Artwork for the rulebook |

---

## Workflow

For all substantive work, follow this cycle:

```
PLAN → RESEARCH → DRAFT → REVIEW → SAVE → NEXT
```

1. **PLAN** — Read the issue, identify affected chapters, state your approach
2. **RESEARCH** — Read all affected chapters and upstream dependencies, consult reference files
3. **DRAFT** — Write or edit the chapter content, update cross-references
4. **REVIEW** — Checklist against the original goal, identify gaps, fix them, build to validate
5. **SAVE** — Commit with conventional format: `feat(#N): summary` or `design(#N): summary`
6. **NEXT** — Move to the next issue in the critical path

---

## Behavioral Guidelines

### Think Before Writing
- State assumptions. If uncertain, ask Bruce.
- If multiple mechanical interpretations exist, present them — don't pick silently.
- If a simpler rule design exists, say so. Push back when warranted.
- If a dependency is unclear, stop and ask.

### Simplicity First
- No mechanics beyond what the task calls for.
- No "future-proofing" that wasn't requested.
- No edge-case handling for impossible scenarios.
- Ask: "Would a player understand this on first read?" If no, simplify.

### Surgical Edits
- Don't "improve" adjacent chapters, prose, or formatting.
- Don't refactor mechanics that aren't broken.
- If you notice an unrelated inconsistency, mention it — don't fix it silently.
- Every changed line should trace directly to the task.

### Goal-Driven
Define success criteria before starting:
- "Write resolution chapter" → "Chapter covers all success tiers, has 3 worked examples, builds clean"
- "Add spell chain" → "Spell has Novice/Adept/Master tiers, correct Discipline prerequisites, Weak/Standard/Strong damage, cross-references magic chapter"
