# Heroes of Legend

**A fantasy tabletop RPG built on a custom 3d6 + modifiers system with tiered success.**

> *"Grab your swords. Stow your spell books. Adventure awaits."*

Heroes of Legend is a ground-up redesign of an earlier playtest game. Characters are built from **Disciplines** (23 disciplines across 9 categories: Elemental, Weapon, Defense, Primal, Arcane, Divine, Esoteric, Subterfuge, Knowledge), with a flat damage budget, one-roll resolution, and no spell slots. Magic always fires; the dice decide how well.

## Current Status

**Core Rules Complete** — 25 chapters, reviewed and balance-audited through the full Council pipeline (Game Architect, Author, Editor-in-Chief), building to a single PDF via Quarto + a custom Typst theme.

- 📕 [Latest Build (PDF)](https://github.com/bruceamoser/heroes-of-legend/releases/latest/download/Heroes-of-Legend.pdf) — 518 pages, post-Council draft (2026-08-12)
- 📖 [Original Playtest PDF (legacy reference)](source-doc/Heros%20of%20Legend-Playtest-v15.1.pdf)
- 🎨 [Visual Style Guide](docs/visual-style-guide.md)
- 📐 [Layout Guidelines](docs/layout-guidelines.md)
- 🖼️ [Illustration List](docs/illustration-list.md)
- 🤖 [Agent Instructions](.github/copilot-instructions.md) (via `AGENTS.md` pointer)

## Core Mechanics

- **Roll:** 3d6 + Attribute + Skill + Modifiers
- **Success Tiers:** Weak (1–8) | Standard (9–14) | Strong (15–18+)
- **Critical:** Three natural 6s | **Fumble:** Three natural 1s
- **One-roll principle:** the hit/casting roll IS the damage roll. No damage dice.
- **Flat damage budget:** Novice 2/4/6 · Adept 6/9/12 · Master 9/15/21 (Weak/Standard/Strong); riders sum to the row
- **Attribute-scaled damage:** a mixture by design. Melee weapons add Brawn (Finesse weapons use Agility); missile weapons and arrows are flat; most spells are flat; some cards state a keyed attribute (e.g. 1/2/3 + Knowledge). Minimum 1 damage.
- **Attacks always hit** — outcomes determine damage, not whether you connect
- **No spell slots, no mana, no components** — magic always fires
- **Discipline economy:** flat card costs (2/4/8 DP by tier), four rank-cost structures per class (1/2/4 · 2/4/8 · 3/6/12 · 4/8/16), level gates (Adept at 3, Master at 7), ~52 career DP by level 10
- **Starting disciplines:** rank 1, two picks, distinct disciplines per class bundle

## Quick Build

Requires [Quarto](https://quarto.org/docs/get-started/) **1.10+** (the build uses the orange-book Typst book template; a vendored template shim enforces the US-Letter theme geometry).

```bash
cd quarto-book
./build.sh                 # Linux/macOS — or .\build.ps1 on Windows
# Output: quarto-book/_output/Heroes-of-Legend.pdf
```

## Repository Layout

- `quarto-book/` — book source (`chapters/*.qmd`), Quarto config (`_quarto.yml`), Typst theme (`_extensions/heroes-of-legend/`)
- `docs/` — visual style guide, layout guidelines, illustration list, Typst package notes (`docs/design/` is dev-local and untracked)
- `source-doc/` — original playtest PDF + extracted text reference
- `.github/` — agent instructions and issue specifications used during development

## Workflow

ISSUE → BRANCH → OPencode IMPLEMENT → PR → WINSTON AUDIT → SQUASH MERGE → CLOSE.

Large work items split into per-chapter sub-issues under an umbrella tracker, implemented by parallel worktree agents. Review passes run through the Council: Game Architect (mechanics) → Author (prose and canon) → Editor-in-Chief (completeness and the closing balance audit against the damage budget table).

House style laws: **zero em-dashes** in book text, flat damage only, one roll.

## Designer

Bruce A. Moser: Lead designer and system architect.
