# Heroes of Legend

**A fantasy tabletop RPG built on a custom 3d6 + modifiers system with tiered success.**

> *"Grab your swords. Stow your spell books. Adventure awaits."*

Heroes of Legend is a ground-up redesign of an earlier playtest game. It uses a unique dice-type prerequisite system where characters collect elemental, weapon, and arcane dice to unlock increasingly powerful abilities.

## Current Status

**Core Rules Complete** — 26 chapters written and layout-passed, building to a single PDF via Quarto + a custom Typst theme.

- 📖 [Original Playtest PDF](source-doc/Heros%20of%20Legend-Playtest-v15.1.pdf)
- 🎨 [Visual Style Guide](docs/visual-style-guide.md)
- 📐 [Layout Guidelines](docs/layout-guidelines.md)
- 🖼️ [Illustration List](docs/illustration-list.md)
- 🤖 [Agent Instructions](.github/copilot-instructions.md) (via `AGENTS.md` pointer)

## Core Mechanics

- **Roll:** 3d6 + Attribute + Skill + Modifiers
- **Success Tiers:** Weak (1–8) | Standard (9–14) | Strong (15–18+)
- **Critical:** Three natural 6s | **Fumble:** Three natural 1s
- **Attacks always hit** — weapons have Weak/Standard/Strong damage values
- **No spell slots** — magic always fires

## Quick Build

Requires [Quarto](https://quarto.org/docs/get-started/) **1.10+** (the build uses the orange-book Typst book template; a vendored template shim enforces the US-Letter theme geometry).

```bash
cd quarto-book
./build.sh                 # Linux/macOS — or .\build.ps1 on Windows
# Output: quarto-book/_output/Heroes-of-Legend.pdf
```

## Repository Layout

- `quarto-book/` — book source (`chapters/*.qmd`), Quarto config (`_quarto.yml`), Typst theme (`_extensions/heroes-of-legend/`)
- `docs/` — visual style guide, layout guidelines, illustration list
- `source-doc/` — original playtest PDF reference
- `.github/issues/` — issue specifications used during development

## Workflow

ISSUE → BRANCH → IMPLEMENT → PR → REVIEW → SQUASH MERGE → CLOSE (see `.github/copilot-instructions.md`).

## Designer

Bruce A. Moser — Lead designer and system architect.
