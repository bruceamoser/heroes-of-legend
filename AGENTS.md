# AGENTS.md

This file provides guidance to agents when working with code in this repository.

## Build Commands

This project has no package.json. Build uses **asciidoctor-pdf** (Ruby gem):

| Command | Platform | Description |
|---------|----------|-------------|
| `./build.sh` | Linux/macOS (bash) | Full build: rulebook PDF from AsciiDoc chapters |
| `.\build.ps1` | Windows (PowerShell) | Full build counterpart |

**Prerequisites:** asciidoctor-pdf, asciidoctor-diagram (Ruby gems). No npm/node.

## Source of Truth Hierarchy

| Layer | Path | Mutability |
|-------|------|------------|
| **Canonical rules** | `docs/chapters/*.adoc` | Read-write. Edit here for all game mechanics changes |
| **Master document** | `docs/heroes-of-legend.adoc` | Read-write. Add new chapters via `include::` directives |
| **Theme** | `docs/themes/heroes-of-legend-theme.yml` | Read-write. asciidoctor-pdf "fantasy tome" theme |
| **Design docs** | `docs/design/*.md` | Reference. Implementation plans and design notes |
| **Original PDF** | `source-doc/Heros of Legend-Playtest-v15.1.pdf` | Read-only. Historical reference only |
| **Extracted markdown** | `source-doc/extracted/playtest.md` | Read-only. Generated reference, not source of truth |
| **Extracted images** | `assets/images/` | Read-write. Source images for the rulebook |

## Architecture

- **Chapter naming matters:** Files are included by numeric prefix (00-, 01-, 01b-, 02-...). Inserting a new chapter requires correct ordering prefix.
- **Theme:** Fantasy tome aesthetic — aged parchment, dark brown ink, serif fonts, ornamental dividers.
- **Build output:** `starter-kit/heroes-of-legend-core-rules.pdf` (gitignored).

## Chapter Dependency Rules

- **Chapter 06 (Core Resolution)** and **Chapter 08 (Dice Types)** are foundational — all mechanical chapters depend on them.
- **Chapter 11 (Arcane Spells)** and **Chapter 12 (Divine Spells)** are the largest chapters (~300 spells total).
- Always update cross-references (`xref:`) when moving or renumbering chapters.
- When a mechanic changes, search ALL chapters for affected references.

## Contribution Workflow

- **Branch naming:** `issue/<n>-<slug>` (e.g., `issue/12-core-resolution`)
- **Commits:** Conventional Commits (`feat:`, `fix:`, `docs:`, `refactor:`, `design:`)
- **Workflow:** Assign → Branch → Work → Commit → PR → Merge → Delete branch

## Key Design Decisions

See `docs/design/implementation-plan.md` for the full plan, dependency graph, and issue tree.

### Core Mechanics (non-negotiable)
- **3d6 + attribute + skill + modifiers** (NOT d20)
- **Attributes:** Brawn, Fortitude, Agility, Guile, Knowledge, Reason — range -2 to +2
- **Success tiers:** Weak (1-6), Standard (7-12), Strong (13-18+)
- **Critical:** Three natural 6s | **Fumble:** Three natural 1s
- **Attacks always hit** — weapons/spells have Weak/Standard/Strong damage values

### Dice Type System
- Skills, abilities, and talents have dice type prerequisites
- Classes grant specific dice types
- All characters start with 3 generic dice
- Dice types: Fire, Earth, Wind, Water, Animal, Protection, Armor, Energy, Blades, Archery, Axes, Polearms, Great Weapons, etc.

### Magic
- No spell slots, no mana — magic always fires
- Spells are ability chains: Novice → Adept → Master (e.g., Firebolt → Fireball → Volcanic Eruption)
- ~300 D&D 5e PHB spells adapted to the dice system

### Skills & Progression
- Skills: +1 (Novice), +2 (Adept), +3 (Master)
- Purchased with Development Points (DP) per level
- Class determines DP cost for each skill
- Talents/Abilities: 1 DP (Novice), 2 DP (Adept), 4 DP (Master)

## Mandatory Agent Workflow

**ALL agents MUST follow the workflow defined in `docs/WORKFLOW.md` at every turn.** The workflow is authoritative — deviations require explicit justification.

Quick reference:
```
GRAB → RESEARCH → IMPLEMENT → REVIEW → COMMIT → NEXT
```

Read the full workflow: `docs/WORKFLOW.md`

---

## Agent Behavioral Guidelines

These principles govern how agents should operate in this repo. They bias toward caution over speed. For trivial tasks, use judgment.

### 1. Think Before Writing

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before writing or editing chapter content:
- State your assumptions explicitly. If uncertain, ask Bruce.
- If multiple mechanical interpretations exist, present them — don't pick silently.
- If a simpler rule design exists, say so. Push back when warranted.
- If a dependency or interaction is unclear, stop. Name what's confusing. Ask.

### 2. Simplicity First

**Minimum rules that solve the design problem. Nothing speculative.**

- No mechanics beyond what the issue or plan calls for.
- No "flexibility" or "future-proofing" that wasn't requested.
- No edge-case handling for impossible scenarios.
- If a rule explanation runs 200 words and could be 50, rewrite it.

Ask: "Would a player understand this on first read?" If no, simplify.

### 3. Surgical Changes

**Touch only the chapter you're working on. Clean up only your own mess.**

When editing chapter files:
- Don't "improve" adjacent chapters, prose, or formatting.
- Don't refactor mechanics that aren't broken.
- Match existing AsciiDoc style and cross-reference conventions.
- If you notice an unrelated inconsistency, mention it — don't fix it silently.

When your changes create stale cross-references:
- Update `xref:` links that YOUR changes broke.
- Don't fix pre-existing broken xrefs unless asked.

The test: Every changed line in a chapter should trace directly to the issue being worked.

### 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform issues into verifiable goals:
- "Write chapter 06" → "Chapter covers all 5 resolution scenarios, has 3 worked examples, builds without AsciiDoc errors"
- "Add spell chain" → "Spell has Novice/Adept/Master tiers, correct dice prerequisites, Weak/Standard/Strong damage, and cross-references the magic system chapter"

For multi-step tasks, state a brief plan:
```
1. Read affected chapters → verify: understand all dependencies
2. Draft changes → verify: matches design principles and issue scope
3. Validate build → verify: asciidoctor-pdf succeeds, output renders correctly
4. Commit → verify: conventional commit format, references issue number
```

---

## Critical Gotchas

- `.gitignore` ignores `source-doc/extracted/` (it's generated, not source)
- This is a documentation project — no package.json, no linting, no testing framework
- The original PDF is a D20 roll-under system — the new system is 3d6 roll-over with tiers
- Do NOT copy mechanics directly from the original PDF — it's reference only for content/structure
- **Build validation is the test suite** — always run `./build.sh` after chapter changes to catch AsciiDoc syntax errors and broken xrefs
