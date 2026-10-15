# Heroes of Legend — fresh authoring draft

**Updated October 13, 2026. Draft for Bruce’s review. Markdown is the source.**

Build characters people want to play, with abilities they are excited to use.
Character creation and development can be crunchy; resolving a turn should be clear.
Powerful, memorable heroes still carry wounds and eventually run out of Grit.

This is a fresh catalog built from the agreed HOL foundations. The old book and
playtest cards were not used as templates for these entries. Named abilities,
traits, origins, the new discipline taxonomy and its affinities are proposals.
This is an authoring draft, not a claim that every option has been approved or tested.

## Start here

1. [Design intent](design-intent.md): the experience each choice should create.
2. [Foundations](rules/foundations.md) and [character development](development.md).
3. [Character paths](fantasy-paths.md): choose a fantasy and a role, then find its abilities.
4. [Ancestries](ancestry.md), [origins](culture-background.md), [classes](class.md), [disciplines](disciplines.md).
5. [Catalog](catalog.md): all universal references, shared abilities and signatures.
6. [Equipment](equipment.md), [recipes](recipes.md), [wounds and treatment](rules/recovery.md).
7. [Six complete level-1 characters](characters/README.md), [earlier worked characters](starter-characters.md), and [example scenes](example-scenes.md).
8. [Open decisions](open-decisions.md), [reference research](references.md), [coverage](coverage.md).

## Editing

Edit an entry’s `.md` file directly. Its stable ID is the reference key; changing a
name need not change the ID. Cards live together in `cards/`, with indexes by type,
action and discipline. Ancestry traits, origin pairs, disciplines, items and recipes
have their own files because their acquisition rules differ from learned abilities.

A card starts with the imagined action, then states what happens. Its printed rules
must be sufficient to use it. Shared conventions belong in [one reference](card-conventions.md).
Do not move gameplay rules into flavor text. Give noncombat expertise something
useful to do in a scene, not just a small bonus to a seldom-used roll.

The read-only audit checks links and required fields; it does not generate card text
or certify fun, balance, build legality or completeness. No new simulations are part
of this authoring pass. The existing `playtest/` tree remains historical test material.

The book’s Quarto chapters and layout are unchanged. This draft supersedes the old
catalog only as the destination for new authoring; it does not retroactively change
what historical experiments measured.

## Expanded fantasy pass

The draft now offers 36 mixable character paths, 18 cultures and 32 backgrounds.
Ancestry traits lean into their familiar stories, and 108 new shared abilities give
those stories somewhere to go. Read [three contrasting builds](path-examples.md)
for a Knowledge fighter, a beast-form brawler and a healing/control nature caster.

Run `python3 design/index.py` after editing names or adding entries to refresh
navigation; it reads the Markdown and never rewrites card text. Run
`python3 design/audit.py` for structural checks. These tools serve the writing.

## Adventure and card-writing revision

Read [Heroes between battles](adventure-development.md) for the new utility routes,
fourteen shared passives, mixed requirements and worked purchase checks. Every card
now separates narrative from Rules. New details remain proposals for review.

[Full card review and per-record findings](reviews/1149-full-card-review.md) — October 13, 2026; table play, clarity and VTT readiness.
