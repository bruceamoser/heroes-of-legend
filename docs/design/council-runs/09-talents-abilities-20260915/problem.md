# Council problem statement — Chapter 09, Talents & Abilities (Wave 3, chapter 1)

**Source:** `09-talents-abilities.qmd` — 577 lines, native Typst, **72 cards** (29 Talents, 4 Basic
Attacks, 39 Weapon Maneuvers), no budget table of its own.

**Question for the council:** is this chapter publishable as it stands — do its 72 cards conform to
the locked conventions below, is the chapter internally consistent (its own stated rules against its
own cards), and does every value or rule it restates agree with the chapter that owns it?

**Why this chapter is the highest-risk file in the book right now.** The card library was rebuilt
twice on 2026-09-13/14 — the damage-band renumber (#532) and the one-card refactor
(#537/#538, which replaced 288 rungs with 177 standalone cards) — and then the addition pass (#542)
landed 68 new cards. **This file went from 129 cards to 72 and no lens has ever read the
standalone-card form.** Its last review (Wave 2, run `20260911-2024`, 2026-09-11) read the OLD
rung-carrying library, and it explicitly verified the OPPOSITE of what the live bands now require
(its progress row records "Riposte 2/4/6->6/9/12->9/15/21, Cyclone/Cleave/Pinpoint/Charge/Crushing
Blow/Executioner's Cut on-row, Renewal 2/4/6->6/9/12->9/15/21" as correct). Treat every earlier
verification of this file as expired.

## Topics — every finding MUST set `topic` to exactly one of these three

- **t-01** conformance to the locked conventions below
- **t-02** internal consistency: the chapter's own stated rules, introductions and promises against
  its own 72 cards, and against each other
- **t-03** cross-chapter canon: a value, row, term or mechanic this chapter restates from the
  chapter that owns it

## Locked conventions (current as of 2026-09-15 — these ARE the law this run tests against)

1. **Damage bands (renumbered 2026-09-13, #532): Novice 4/6/8, Adept 5/8/11, Master 7/10/14**, read
   Weak/Standard/Strong (`08-disciplines.qmd:214-216`, `10-magic-system.qmd:46-48`). **The retired
   rows 2/4/6, 6/9/12 and 9/15/21 are valid nowhere in the book.** A retired row is not only the
   closed-up string: **a card whose outcome lines spell each value out as its own number is the same
   defect** — that is the exact residue class carried by issue #546 for ch11/ch12, and this chapter
   has never been swept for it. Basic attacks are the floor (1/2/3 + Brawn; unarmed 1/1/2); cantrips
   are 1/3/5 by explicit exemption.
2. **The one-card law (#537/#538):** a card is bought once, at one tier, for one price — **Novice
   2 DP, Adept 4 DP, Master 8 DP** — level gates Novice 1, Adept 3, Master 7. **Tier is a property
   of the card itself, not a count of its Disciplines** (`10:61`): do NOT file a card for printing
   more or fewer Discipline ranks than some tier implies, and do NOT file a missing Adept/Master
   rung. That ladder and the rungs it gated are deleted; a single-tier card is complete.
3. **Weapon-maneuver damage base = the Novice row** (Bruce's ruling, decision #103, 2026-09-12;
   the chapter states it itself at `:215`), while **spells key their block to their own tier**.
   Convention 1 fixes what "the Novice row" now means: 4/6/8.
4. **Flat damage riders are DEAD book-wide.** The sanctioned damage-increase form is
   "**+1 damage tier**".
5. **Boon/Bane law:** a situational modifier to a roll is a Boon or a Bane, never +N/−N. Numbers
   survive only on attributes, skill tiers, the difficulty dial, and a Challenge penalty.
6. **DR law:** armour grants 1/2/3 DR by weight class and **cards add to it**. A card's own "+N DR"
   is legal (Iron Skin is the canonical example).
7. **Conditions are a leveled vocabulary** (Burning 2, Slowed 15, Frozen 2); `Keywords:` lines carry
   the bare tag only; a card's text carries the level.
8. **Currency is REMOVED (#523):** nothing is bought. Any phrasing implying a purchase, price,
   cost, discount or coin amount is a defect.
9. **Challenge** is the standard resolution for every opposed contest; the opposition never rolls.
10. **Zero em-dashes** in book source text. House emphasis is Typst italic (`*word*`), never markdown
    bold.
11. **The printed chapter numbering carries a +2 offset:** this file is source chapter 9 and prints
    as **Chapter 11**, so its figure is `Figure 11.1`, and the `_Placeholder for final art._` line is
    a book-wide convention. Neither is a defect.
12. **Crossref law:** a Typst crossref renders with its own trailing period, so nothing is typed
    after a bare sentence-final ref (or after a closing parenthesis that carries one).
13. **A card's own effect line is the statement of its numbers; no rule is restated in a card.** The
    chapter prints no budget table, so a row printed twice in this file is a restatement, not a
    source of truth.

## Already checked by the orchestrator and CLEARED — do NOT file these

Reproduce anything you doubt, but these were verified against the source; filing them costs the run
a round.

- **Zero em-dashes and zero damage dice** (grep-verified). Do not file either class.
- **The card count is 72** (29 Talents, 4 Basic Attacks, 39 Weapon Maneuvers) and every talent in the
  file carries a tier line (`*Novice:*` / `*Effect:*`). Every card carries its
  Disciplines/Action/Range/Keywords header.
- **All four outbound `@sec-` references resolve** to labels that exist, and no bare table ref is
  followed by a typed period.
- **The four Basic Attacks conform:** 1/2/3 + Brawn (melee), flat 1/2/3 (archery, thrown), 1/1/2
  (unarmed), and the two-band range notation they use is defined in the section itself at `:171`.
- **The `+1 damage tier` sites are the sanctioned convention, not flat riders**: Power Strike `:229-233`,
  Pinpoint Strike `:256-260`, Death Blow `:78`, Dangerous Gambit `:132`, Charge `:301-305`,
   Crushing Blow `:328-332`, Executioner's Cut `:337-341`, Throw `:346-350`. Do not file them as
  riders. (A rider that is *numerically off* is a different finding from a rider that exists.)
- **Kit tags in use** (`weapon:one-hand`, `weapon:ranged`, `weapon:two-hand`, `weapon:unarmed`,
  `shield`, `focus:arcane`) are members of the 16-tag utility vocabulary.
- **Iron Skin** (`:45-47`, `*Novice:* +2 DR, in addition to your armor's DR`) is a complete
  single-tier card under convention 2. Do not file a missing rung against it.

## Worked leads — verify or refute these; do not simply restate them

These are the orchestrator's own pre-audit leads, offered as things to TEST. **Your own independent
audit is the deliverable**; a ballot that only rules on this list is a wasted ballot. Report a lead
you cleared as a result in its own right.

- **`:220-224`, `:238-242`, `:265-269`, `:310-314`, `:319-323`, `:364-368`** — Riposte, Cyclone,
  Shield Slam, Brace, Dual Strike and Renewal print **2/4/6, one number per outcome line**, as their
  damage, retaliation or healing. 2/4/6 is the retired Novice row. Confirm the class, and say for
  each card which of its figures is a budget row, which is a secondary/retaliation figure, and what
  it must become under conventions 1 and 3. Dual Strike prints two attacks "each dealing 1 damage
  (2 total)" — check the division against the row it must divide.
- **`:463-467`, `:472-476`, `:490-494`, `:517-521`** (5/8/11) and **`:535-539`, `:571-575`**
  (7/10/14) — Battering Hurl, Through the Blind Spot, Pinning Shot, Rolling Thunder, Sunshot and
  Break the Order print the Adept and Master rows. Test these against convention 3 and this
  chapter's own statement at `:215` on one side, and against `08:207-217` (the budget table, whose
  header column is **Tier**, and which calls itself the balance spine for "every damaging spell,
  ability, and maneuver") plus the addition pass (#542, which authored these cards) on the other.
  **Name which law governs, or name the fork precisely and say what turns on it.** This is the one
  question in this chapter that may not have a purely mechanical answer; do not paper over it with a
  row that satisfies one reading and contradicts the other.
- **`:278`** — Parry's Strong line reads "+3 DR against one attack and counterattack for 2 damage",
  on a reaction whose own progression is DR 1/2/3. Check 2 against the budget table, and check
  whether a DR-ladder card's third rung buying a damage figure is coherent at all.
- **`:78`** — Death Blow: "+1 damage tier (one row up on the damage budget, **maximum 21**)". Check
  the printed ceiling against the live bands and against `06`'s critical maximum.
- **`:87`** — Miracle Worker restores "**half their maximum HP**". Check a non-flat healing figure
  against the book's healing and resurrection conventions (the retired "non-flat resurrection HP"
  class in the closing balance audit).
- **`:215`** — the Weapon Maneuvers introduction: its first sentence calls every maneuver's block a
  Novice-row effect while its second sentence describes "Adept and Master members of the family" —
  family/rung vocabulary the one-card law deleted — and it promises "The Adept and Master members of
  the family are separate cards with their own rows and their own names". Check the paragraph
  against the 39 maneuver cards it introduces.
- **`:23`** — the Talents introduction says "**a talent that grants kit grants one kit point and
  nothing else**". Verify whether any talent in this file grants a kit point at all, and whether the
  sentence describes anything that exists.
- **`:13`** — the opener defines talents as "Most talents are passive ... a few are activated
  talents, and their card's Action field says so". Count this file's 29 talents by their Action
  field, test the claim, and check its mirror at `21:85`.
- **`:167-171`** — the Basic Attacks introduction calls these four "the attacks every character can
  make, no Discipline required" while three of the four carry a `Kit:` field. Check whether "no
  Discipline required" and a kit gate are compatible statements for a reader.

## Cross-check chapters

`02-character-creation` (DP pools), `03-attributes`, `05-classes` (class abilities that share a name
with a maneuver, e.g. Vicious Riposte `05:684`), `06-core-resolution` (the roll, criticals, the
maximum-damage ladder), `07-skills`, `08-disciplines` (the budget table, the one-card law, card
prices), `10-magic-system` (card format, tier as a card property, cantrips), `13-combat` (Action /
Maneuver / Reaction, conditions, the Riposte worked example at `13:474-484`), `15-equipment` and
`16-armor-shields` ("the weapon contributes no damage of its own"), `20-bestiary` (attack rows),
`21-glossary` (Maneuver, Parry, Talent), `22-reference-sheets`.

## Disposition plan (required)

Every finding must carry a **disposition class**, and the librarian's Stage-4 recommendation must
group the ledger by these three tiers:

- **MECHANICAL** — chapter-local, zero mechanics change, no content judgement (wording, a stale
  parenthetical, a heading level, a crossref, a row that must conform to a locked number).
- **SUBSTANTIVE** — new content, a multi-file rewrite, or a reconciliation that changes numbers on
  more than one card.
- **DESIGN** — needs the principal: two defensible readings, neither of which has a defining home.

## Scope law (absence claims)

A claim that something does NOT exist anywhere must be shown by a command actually run BOOK-WIDE
(`grep -rn` over `quarto-book/chapters/*.qmd`), not merely against the registered source. A
conclusion you could not test is reported as **untested**, never as **absent**. The registered
source set for this run is this chapter alone; if a question is about the whole book, say so and
cite the other chapter by filename from your own grep.

## Citation rule

Every `evidence[].source` must cite either the registered source label `09-talents-abilities`,
another chapter's filename (e.g. `08-disciplines.qmd`), or the literal `reasoning`. Quotes belong in
`quote_or_excerpt` only, under about 12 words. `argument` and `evidence[].claim` are wall-linted
against this statement and the source: **do not quote 10 or more consecutive words** there.
