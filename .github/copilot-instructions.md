# Heroes of Legend — project instructions

## Authority and source

Heroes of Legend is a world-agnostic fantasy TTRPG. Bruce A. Moser is the lead
designer and final authority. The system approved through October 17, 2026 is the
current baseline. Git history is the archive; do not restore superseded rules as
references or maintain parallel catalogs.

- Rules: `design/rules/`, `design/development.md`, `design/card-conventions.md`.
- Choices: `design/ancestries/`, `origins/`, `classes/`, `disciplines/`, `cards/`.
- Objects and recipes: `design/equipment/`, `recipes/`, `market.md`.
- Creatures: `design/bestiary/creatures/`; monster abilities: `design/monster-abilities/`.
- Summoned forms: `design/bestiary/summons/`; these are distinct player-facing profiles.
- Player teaching and layout: `design/player-book/manuscript/` and its Typst files.
- DA teaching and layout: `design/da-book/manuscript/` and its Typst files.
- Artwork: current book art directories and `design/bestiary/art/manifest.json`.

Edit authored Markdown directly. Builders may render catalogs, never overwrite
them. Generated files and PDFs are disposable build artifacts. Every starter-kit
release includes the Player’s Book and Dungeon Architect’s Guide & Bestiary.

## Rules to protect

Read the full relevant current rule before editing; this summary is not a second
rules source.

- Roll 3d6 + one of Brawn, Fortitude, Agility, Guile, Knowledge or Reason.
  Boons/Banes cancel; up to three net extra dice, retaining best/worst three.
- Weak ≤8 is progress, Standard 9–14, Strong ≥15. Natural retained 111 adds a
  complication to Weak; 666 adds a benefit to Strong.
- No separate skill bonuses, spell slots or prerequisite-card chains. Cards have
  level gates 1/3/7 and printed discipline requirements; buy discipline ranks in order.
- Main Action → Maneuver → movement conversions; a Reaction is separate.
- Players roll. NPC attacks use player defense outcomes, reversed from attacker
  outcomes. NPC-only resolution is in `design/rules/session-resolution.md`.
- Cards determine damage, range and effects. Ordinary weapons supply fictional
  appearance and compatibility; special items add only their explicit benefits.
- Use squares. Matching resistance uses the highest value, normal cap 3;
  minimum 1 damage per event. Stability is an explicit grant, 0–3.
- Summons are commanded energy forms, cannot receive healing and disappear at 0 HP.
- HP returns after a safe breath; wounds and spent Grit carry forward.
- “Skill” may be a card type. It does not reintroduce a skill modifier or skill sheet.

The current catalog is approved for playtesting. CV and encounter budgets remain
estimates. A structural audit or a successful PDF build is not balance evidence.

## Writing and presentation

Write for the table: evocative narrative followed by precise rules. Show what the
hero does, then state action, attribute, requirements, targets, outcomes, duration
and limits. Put shared explanations in introductions, not on every card.

Use Dungeon Architect (DA). Keep the world open to each group. Give examples of
important rules. Preserve stable IDs and links. Signature cards should express
class identity and be slightly stronger than shared cards of the same tier.

Both books use forest green, gold and parchment. Keep cards and short tables
intact, use clear action tables, and inspect rendered pages after layout edits.
Do not repeat an illustration within a book; functional logos and symbols may repeat.
Preserve source artwork, transparency and font licenses.

## Workflow

1. Create a focused issue before implementation. Split unrelated concerns.
2. Branch from current main using `codex/<issue>-<description>`. Never commit to main.
3. Implement the authorized scope. Resolve routine choices without asking again.
4. Run relevant audits and both builds when shared source or dependencies change.
5. Push and open a PR with `Closes #N`, concrete changes and validation evidence.
6. Independent review is required before merging. Bruce’s explicit approval in
   chat counts; approval of an earlier PR does not approve later changes.
7. Squash merge approved work and verify issue closure. Do not rewrite repository
   history during cleanup; it is the archive.
8. Update instructions/skills when they prove stale. New mechanics require visible
   review; never silently make a design change while formatting.

## Build and check

See `design/player-book/README.md`, `design/da-book/README.md` and
`release/README.md` for dependencies and the two-book release procedure.

```sh
python3 design/audit.py
python3 design/bestiary/audit.py
python3 design/bestiary/art/audit.py
python3 scripts/audit_repository.py
TYPST=/path/to/typst python3 scripts/build_starter_kit.py
```

The build requires Typst 0.15.1, Python dependencies in
`design/player-book/requirements.txt`, and Poppler. Review rendered PDFs as well as
machine checks. No simulation result from an earlier catalog certifies this one.
