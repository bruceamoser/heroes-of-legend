# Council problem statement — Named Equipment Purge (issue #554)

**Source:** the tree that ships named gear. `15-equipment.qmd` (433 lines) is the centre: `== Kits`
`:19-158` (the live, category-based model), `== Weapons` `:161-222` (a 17-row named table whose only
differentiating column is `[Disciplines Required]`), `== Armor` `:223-248`, `== Adventuring Gear`
`:266-323`, `== Mounts & Vehicles` `:324-433`. Echoes of named gear also sit in `16-armor-shields.qmd`,
`08-disciplines.qmd`, `21-glossary.qmd`, `22-reference-sheets.qmd`, `17-magic-items.qmd`,
`20-bestiary.qmd`, `02-character-creation.qmd` and `05-classes.qmd`.

**Question for the council:** should the named-equipment catalog be removed from the book, and if so,
what exactly replaces the mechanical content it currently carries?

**What this is.** The book has already decided, in prose, that equipment is flavour. `15:163` states
the law in its own words: discipline is permission, equipment is possession, cards are damage. The
kit model at `:19-158` implements that law, offering four lines whose options are categories rather
than items: Armament (Unarmed 0, One-handed weapon 1, Ranged weapon 1, One-handed weapon and shield 2,
Two-handed weapon 2), Covering, Focus, Calling. No named item appears in it.

The named tables were never removed. They sit below the kit section, and their load-bearing column is
the one that grants permission by name: a specific weapon requires specific Discipline ranks. So the
chapter simultaneously teaches that a weapon is "just the thing that happens to be there" and that a
weapon is a permission gate. **The book cannot do balance work against a two-model tree**, which is
why this run precedes the gating and balance evaluation.

Four failure classes are native here and should be your targets:

1. **A surviving duplicate gate.** Any place where a named item still gates access by Discipline, when
   the card layer already gates it, is a redundant rule and a contradiction of the stated law.
2. **Mechanical content with nowhere to live.** If a named table is removed, anything genuinely
   load-bearing inside it must land somewhere. Content that is decorative and content that is
   structural look identical in a table and must be separated before anything is deleted.
3. **A dangling reference.** Examples that equip a named item, cross-references to a removed table,
   lookup surfaces that index the catalog, and counts stated in prose all break silently. The purge
   must find every one.
4. **A silently changed game.** Removing a table can change what a hero may do. Any consumer of the
   catalog that turns out to be the ONLY consumer of a rule is a balance consequence and must be
   named as such rather than buried in the edit.

## Topics

- **t-01** kit completeness: does the category-based kit express everything the named catalog
  expresses? If a player can no longer name a weapon, what do they lose in play, and is anything the
  named table allowed now unexpressible?
- **t-02** mechanical residue: which of the named content is load-bearing and where does it go? The
  seven weapon properties (Finesse, Versatile, Reach, Thrown, Light, Loading, Two-Handed), the armour
  weight classes and their DR, shields and their requirements, encumbrance and slots, mounts and
  vehicles. Separate the structural from the decorative, and state where each survivor lives.
- **t-03** consequences and dangling references: every consumer of the named catalog across the nine
  touched files, every worked example that equips a named item, every crossref and lookup-surface
  index, and every rule whose ONLY consumer is a named item — including whether a Discipline rank
  that is justified only by equipment becomes a dead rank once equipment is flavour.

Every finding MUST set `topic` to exactly `t-01`, `t-02`, or `t-03`. One finding carries one defect;
name any others in your reply.

## Locked conventions (current as of 2026-09-15 — these ARE the law this run tests against)

1. **Equipment is flavour.** It grants no numbers and decides no damage. It conveys possession, not
   permission.
2. **Cards are damage.** Attack ability cards carry the Weak/Standard/Strong values; the weapon does
   not. The damage bands are **Novice 4/6/8, Adept 5/8/11, Master 7/10/14**; the retired rows
   2/4/6, 6/9/12 and 9/15/21 are valid nowhere.
3. **Discipline is permission.** Cards name the Discipline ranks they need. A Discipline rank is a
   prerequisite resource, bought once and spent twice at most (levels 3, 6 and 9 grant the only three
   extra ranks a career holds).
4. **The kit is the equipment system.** Four lines, six points, categories not items.
5. **The card format is fixed.** Disciplines / Action / Range / Keywords, bought once at one tier for
   one price, 2/4/8 DP by tier.
6. **The book's conventions hold.** Native Typst, one `{=typst}` fence per file, `outlined: false` on
   every table, zero em-dashes, no damage dice, house emphasis, the crossref law.
