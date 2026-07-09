# Heroes of Legend — AI Copilot Instructions

## Project Overview

**Heroes of Legend** is a fantasy tabletop RPG (TTRPG) built on a custom **3d6 + modifiers** system with tiered success. This project is a **ground-up redesign** of an earlier playtest game — the original PDF is reference only, not a template.

This project is in the **core rules design phase**. The goal is to produce a complete core rulebook as AsciiDoc chapter files, assembled and built to PDF via `asciidoctor-pdf`.

## Designer

- **Bruce** — Lead designer and system architect

## Key Files

| File | Role |
|------|------|
| `docs/heroes-of-legend.adoc` | Master AsciiDoc document — includes all chapters to produce the full PDF. |
| `docs/chapters/*.adoc` | Individual chapter files. **The source of truth** for all game mechanics. Design changes go here. |
| `docs/design/implementation-plan.md` | Full implementation plan, chapter dependency graph, and issue tree. |
| `docs/themes/heroes-of-legend-theme.yml` | asciidoctor-pdf theme — fantasy tome aesthetic. |
| `source-doc/Heros of Legend-Playtest-v15.1.pdf` | Original playtest PDF. Read-only reference. |
| `source-doc/extracted/playtest.md` | Extracted markdown from original PDF. Read-only reference. |
| `assets/images/` | Extracted + new artwork for the rulebook. |
| `assets/svg/` | Decorative SVG elements (chapter dividers, stamps, etc.). |

## Design Principles

### 1. Chapter Files Are Authoritative
- `docs/chapters/*.adoc` files are the canonical documents.
- All mechanics, classes, spells, equipment, and setting details go into the chapter files.

### 2. New System Mechanics (Non-Negotiable)
- **Core roll:** 3d6 + Attribute Modifier + Skill Bonus + Game Modifiers
- **Attributes:** Brawn, Fortitude, Agility, Guile, Knowledge, Reason — range -2 to +2
- **Success tiers:** Weak (1-6), Standard (7-12), Strong (13-18+)
- **Critical:** Three natural 6s | **Fumble:** Three natural 1s
- **Attacks always hit** — weapons/spells have Weak/Standard/Strong damage values
- **Skills:** +1 (Novice), +2 (Adept), +3 (Master) — purchased with DP
- **Talents/Abilities:** 1 DP (Novice), 2 DP (Adept), 4 DP (Master)
- **Disciplines** serve as prerequisites for skills and abilities
- **No spell slots, no mana** — magic always fires

### 3. Discipline System
- Characters collect Disciplines (Fire, Earth, Wind, Water, Animal, Protection, Armor, Energy, Blades, Archery, Axes, Polearms, Great Weapons, etc.)
- All characters start with 3 generic dice
- Classes grant specific Disciplines
- Skills and abilities require specific Disciplines as prerequisites
- This is the game's unique mechanical identity — preserve its integrity

### 4. D&D 5e Spell Adaptation
- Reproduce core PHB spells (~300) as ability chains
- Each chain has three tiers: Novice → Adept → Master
- Example: Firebolt (Novice) → Fireball (Adept) → Volcanic Eruption (Master)
- Spells always fire — Weak/Standard/Strong outcomes replace saving throws
- Use SRD spell names where possible for legal safety

### 5. Tone and Setting
- **Generic fantasy** — flexible, not tied to a specific world
- **Heroic adventure** — players are exceptional individuals, not grim survivors
- **Accessible but deep** — quick to start, rewarding to master

### 6. Document Formatting
- Use proper AsciiDoc syntax with tables, cross-references, and admonitions
- Prefer tables for mechanical data (stats, skills, equipment, spells)
- Use `[NOTE]` admonitions for important rules clarifications
- Use `xref:` for all cross-chapter references
- Use `*bold*` for game terms on first use

### 7. Build & Reference Model
- The Neon Relic project (`../neon-relic/`) is the reference implementation for build pipeline and AsciiDoc patterns
- Study its `build.sh`, `neon-relic-theme.yml`, and chapter files for conventions
- Do NOT copy Neon Relic content — only its structure and patterns

## Mandatory Agent Workflow

**ALL agents MUST follow the workflow defined in `docs/WORKFLOW.md` at every turn.**

```
GRAB → RESEARCH → IMPLEMENT → REVIEW → COMMIT → NEXT
```

1. **GRAB** — Assign issue, read affected files, state plan
2. **RESEARCH** — Audit existing work, consult sources, evaluate system/mechanics/flavor holistically, comment findings
3. **IMPLEMENT** — Surgical changes, full implementation, update xrefs
4. **REVIEW** — Checklist against original goal, identify gaps, fix gaps
5. **COMMIT** — `feat(#N): summary`, branch, PR, squash merge
6. **NEXT** — Next issue in critical path

Read the full workflow: `docs/WORKFLOW.md`

---

## Agent Behavioral Guidelines

These principles govern how agents operate in this repo. They bias toward caution over speed. For trivial tasks, use judgment.

### 1. Think Before Writing
- State your assumptions explicitly. If uncertain, ask Bruce.
- If multiple mechanical interpretations exist, present them — don't pick silently.
- If a simpler rule design exists, say so. Push back when warranted.
- If a dependency or interaction is unclear, stop. Name what's confusing. Ask.

### 2. Simplicity First
- No mechanics beyond what the issue or plan calls for.
- No "flexibility" or "future-proofing" that wasn't requested.
- No edge-case handling for impossible scenarios.
- If a rule explanation runs 200 words and could be 50, rewrite it.
- Ask: "Would a player understand this on first read?" If no, simplify.

### 3. Surgical Changes
- Don't "improve" adjacent chapters, prose, or formatting.
- Don't refactor mechanics that aren't broken.
- Match existing AsciiDoc style and cross-reference conventions.
- If you notice an unrelated inconsistency, mention it — don't fix it silently.
- Update `xref:` links that YOUR changes broke. Don't fix pre-existing broken xrefs unless asked.
- Every changed line should trace directly to the issue being worked.

### 4. Goal-Driven Execution
- "Write chapter 06" → "Chapter covers all 5 resolution scenarios, has 3 worked examples, builds without AsciiDoc errors"
- "Add spell chain" → "Spell has Novice/Adept/Master tiers, correct dice prerequisites, Weak/Standard/Strong damage values, and cross-references the magic system chapter"
- For multi-step tasks, state a brief plan:
  1. Read affected chapters → verify: understand all dependencies
  2. Draft changes → verify: matches design principles and issue scope
  3. Validate build → verify: asciidoctor-pdf succeeds, output renders correctly
  4. Commit → verify: conventional commit format, references issue number

## Issue Workflow

Follow the standard workflow from AGENTS.md:

### 1. Branch
- Create from `main` named `issue/<number>-<short-description>`

### 2. Work
- Read the issue description and all related issues
- Read affected chapter files before making changes
- Follow the Design Principles above
- For cross-chapter issues, update every affected chapter

### 3. Commit & PR
- Commit with: `feat(#<number>): <short summary>` or `design(#<number>): <summary>`
- PR targets `main`, references `Closes #<number>`

### 4. Merge
- Squash merge preferred
- Delete branch after merge

## Dependency Chain (Critical Path)

```
Infrastructure → Core Mechanics → Dice Types → Skills/Talents → Character Creation → Magic → Combat/Equipment → GM Tools → Polish
```

Key dependency chains within epics:
1. **Core mechanics:** #12 (3d6 resolution) → #15 (write chapter 06)
2. **Disciplines:** #20 (catalog) → #21 (taxonomy) → #22 (acquisition) → #23 (prerequisites) → #24 (write chapter 08)
3. **Magic:** #50 (system) → #51 (spell catalog) → #53-57 (spell chains) → #58 (write chapter 11)
4. **Character creation:** #11 (attributes) → #40 (creation flow) → #41-44 (chapters)

Respect these chains — resolve upstream issues before downstream ones.
