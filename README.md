# Heroes of Legend

**A fantasy tabletop RPG built on a custom 3d6 + modifiers system with tiered success.**

> *"Grab your swords. Stow your spell books. Adventure awaits."*

Heroes of Legend is a ground-up redesign of an earlier playtest game. It uses a unique dice-type prerequisite system where characters collect elemental, weapon, and arcane dice to unlock increasingly powerful abilities.

## Current Phase

**Core Rules Design** — Building the complete rulebook as AsciiDoc chapter files.

- 📋 [Implementation Plan](docs/design/implementation-plan.md)
- 🔄 [Agent Workflow](docs/WORKFLOW.md)
- 📖 [Original Playtest PDF](source-doc/Heros%20of%20Legend-Playtest-v15.1.pdf)

## Core Mechanics

- **Roll:** 3d6 + Attribute + Skill + Modifiers
- **Success Tiers:** Weak (1-8) | Standard (9-14) | Strong (15-18+)
- **Critical:** Three natural 6s | **Fumble:** Three natural 1s
- **Attacks always hit** — weapons have W/S/S damage values
- **No spell slots** — magic always fires

## Quick Build

```bash
gem install asciidoctor-pdf
./build.sh
# Output: starter-kit/heroes-of-legend-core-rules.pdf
```

## Designer

Bruce A. Moser — Lead designer and system architect.