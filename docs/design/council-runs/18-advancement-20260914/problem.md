# Council problem statement — Chapter 18, Advancement

**Source:** `18-advancement.qmd` — the `Advancement` chapter (107 lines, one Typst block, no tables
beyond two small ones). It covers milestone leveling, the Development Point progression, Group
Reputation, Reveling, Earned Titles, and Retraining.

**Question for the council:** is this chapter publishable as it stands — does it conform to the
locked conventions below, is it internally consistent (its two tables vs their own prose vs the
numbers those tables print), and does every value or mechanic it restates agree with the chapter
that defines it?

**Context that makes this chapter live:** the book was rebuilt twice on 2026-09-13/14 (the damage
band renumber #532, the one-card refactor #537/#538) and gold was removed from the game entirely
(#523). `18-advancement` is the chapter that tells a player how progression is bought, so any
residue of the retired DP economy, the retired damage rows, or the retired currency lands here.
Its last review was in Wave 1 (2026-08-30), before all three changes.

## Topics

- **t-01** conformance to the locked conventions below
- **t-02** internal consistency: the DP table and the reputation table against their own prose,
  and against the numbers the chapter prints
- **t-03** cross-chapter canon: a value or mechanic this chapter restates from the chapter that
  defines it

Every finding MUST set `topic` to exactly `t-01`, `t-02`, or `t-03`.

## Locked conventions (current as of 2026-09-14 — these ARE the law this run tests against)

1. **Damage bands are flat and were RENUMBERED on 2026-09-13 (#532)**: **Novice 4/6/8, Adept
   5/8/11, Master 7/10/14**, read Weak/Standard/Strong (`08-disciplines.qmd:210-212`,
   `10-magic-system.qmd:46-48`). Success tiers are Weak 1-8, Standard 9-14, Strong 15+. **The
   retired rows 2/4/6, 6/9/12 and 9/15/21 are not valid anywhere in the book.** Cantrips print
   1/3/5 by explicit exemption; basic attacks are 1/2/3 + Brawn and unarmed is 1/1/2.
2. **The one-card law (Sep 2026, #537/#538)**: a card is bought once, at one tier, for one price
   (**Novice 2 DP, Adept 4 DP, Master 8 DP**), and never changes. Level gates are Novice 1, Adept
   3, Master 7. **The card's tier is a property of the card, not a count of its Disciplines**
   (`10-magic-system.qmd:61`). The Adept-requires-2 / Master-requires-3 ladder is DELETED, and so
   are rungs: there is no upgrade path, no "improves another card", no "gains +N at a higher tier".
   A single-tier card is complete, not incomplete.
3. **Flat damage riders are DEAD.** "+1 damage tier" is the sanctioned damage-increase convention.
   `+N damage` never appears as an always-on or flat rider.
4. **Boon/Bane law.** Anything that changes how likely a roll is to succeed is a Boon or a Bane,
   never a numeric roll modifier. Boon = 4d6 keep highest three, Bane = 4d6 keep lowest three, and
   they cancel one for one. The only numeric roll modifiers that survive are attributes, skill
   tiers, the difficulty dial, and a Challenge penalty.
5. **DR law (2026-09-13, #516/#517/#529).** Armour grants DR by weight class: light 1, medium 2,
   heavy 3. Cards add: the Iron Skin talent is a SINGLE-TIER talent whose Novice (and only) line
   reads "+2 DR, in addition to your armor's DR" (`09-talents-abilities.qmd:45-47`). It carries no
   Adept or Master rung, and that is correct under the one-card law (convention 2): a card that is
   complete at one tier needs no siblings. Do NOT file a missing-rung finding against it.
   Shields grant Parry and Shield Block, never DR. Creature and mount DR are stat-block values, not
   gear. **The DR invariant: three distinct damage tiers survive a flat subtraction only while DR
   is at or below the band's Weak value (Novice 4, Adept 5, Master 7).**
6. **Conditions are a leveled vocabulary**: a condition with a magnitude prints it (Burning 2,
   Slowed 15, Frozen 2), and `Keywords:` lines carry the bare tag only. The condition list lives in
   ch13.
7. **Currency is REMOVED from the game (#523, 2026-09-13).** Nothing is bought: gear, packs, magic
   items, mounts and vehicles are granted, found, or earned. Any phrase that implies a purchase, a
   price, a discount, funding, payment, or a coin amount is a defect. Commerce written without a
   currency word ("purchase", "buy", "fund", "for a price", "it costs") is the exact class the
   #523 audit had to catch by hand.
8. **Challenge is the standard resolution for every opposed contest (ruled 2026-09-13, #507):** the
   actor rolls `3d6 + attribute + skill - Challenge`; the opposition never rolls. A fixed difficulty
   ("Knowledge check, Standard 9-14") is a different, legal shape.
9. **Zero em-dashes** anywhere in book source text. Use a comma, a colon, or a full stop.
10. **House emphasis inside body text is Typst italic (`*word*`), never markdown bold.**
11. **The book's printed chapter numbering carries a +2 offset**: this chapter is 18 in source order
    and prints as **Chapter 20**. Its figure is therefore `Figure 20.1`. This is a book-wide
    convention, not a defect.
12. **Cross-reference law.** A Typst crossref renders with its own trailing period, so nothing is
    typed after a bare sentence-final ref or after a closing parenthesis that carries one.
13. **Two reputation systems coexist and are NOT the same thing**: this chapter's **Group
    Reputation** track (Unknown / Known / Renowned / Heroic / Legendary, 1-15+) and the faction
    **Reputation Track** in `19-gm-guidance.qmd:392-438` (-3 to +3, per faction). A chapter that
    restates one must not print the other's numbers under its own tier names.

## Already checked by the orchestrator and CLEARED — do NOT file these

Reproduce anything you doubt, but these were verified against the source; filing them costs the run
a round.

- **The DP table's arithmetic is correct.** 4 + 3 + 3 + 3 + 4 + 3 + 3 + 3 + 3 + 3 = 32, matching the
  chapter's own "Total DP by level 10: 32" and the `22-reference-sheets.qmd:272` mirror.
- **The level gates are correct**: Adept at level 3 and Master at level 7 match
  `08-disciplines.qmd:143-144` and `21-glossary.qmd:79`.
- **The attribute increases are correct**: +1 at levels 4 and 8, up to a +2 maximum, matching
  `03-attributes.qmd:72`.
- **`Figure 20.1` and the `_Placeholder for final art._` line are book-wide conventions.** The
  caption numbering is the +2 offset; every chapter carries the placeholder line.
- **The chapter contains ZERO em-dashes** (verified by grep). Do not file em-dash findings here.
- **Retraining's "equal or lower DP cost" is sound**, and "3 Progression Disciplines" matches the
  three Progression lines in the table (levels 3, 6, 9).
- **`22-reference-sheets.qmd:255-272` mirrors this chapter's DP table** and agrees with it
  row for row, including the "Milestones" column.

## Worked leads — verify or refute these, do not simply restate them

These are the orchestrator's own pre-audit leads, offered as things to TEST. **Your own independent
audit is the deliverable**; a ballot that only rules on this list is a wasted ballot. Report a lead
you cleared as a result in its own right.

- `18-advancement.qmd:93` — Reveling says a hero may "fund one revel" and that it "costs what a
  night costs". Check against convention 7, the currency removal.
- `18-advancement.qmd:77` — the reputation table's first column header is the abbreviation "Rep"
  while every other header in the book's tables is a full word. Check it against the book's table
  header convention and against this table's own "Reputation Tier" column.
- `18-advancement.qmd:51` — the "Other Gains" column prints "DP windfall" on the same row whose DP
  column prints 4. Check that against the book's no-restating-a-table's-own-columns law.
- `18-advancement.qmd:40,78-81` — ranges are written with hyphens ("3-4 DP", "1-3", "4-6", "7-9",
  "10-14") while the same chapter writes "3-4" and other chapters use en-dashes for ranges.
  Determine which form is the book's convention and whether this chapter deviates from it.
- `18-advancement.qmd:103` — Retraining lets a player "exchange one skill rank or talent purchase".
  Check the phrase "skill rank" against the book's current skill vocabulary.
- `18-advancement.qmd:97` — the *Archmage* title "learns one Adept-tier spell card at no DP cost".
  Check that a title can grant a card against the one-card economy (convention 2) and against the
  book's existing pattern for granting cards.
- `18-advancement.qmd:81` — the Heroic reputation row promises "Followers, a hall of your own".
  Strongholds were cut from the first edition (#523). Check whether anything this row promises
  still exists in the book.
- `18-advancement.qmd:93` — Reveling awards "one point of reputation for the session". Determine
  which of the two reputation tracks (convention 13) that point belongs to, and whether the chapter
  says.

## Cross-check chapters

`02-character-creation` (DP pools, background DP), `03-attributes` (attribute increases),
`05-classes` (class signature, the advancement pointer at 05:747), `08-disciplines` (card prices,
tier gates, the damage budget), `09-talents-abilities` (card format, Iron Skin),
`10-magic-system` (card tiers and level gates), `13-combat` (Grit, wounds, conditions),
`19-gm-guidance` (milestone pacing, the faction reputation track, Heroic Mode's extra DP),
`21-glossary` (Level, Development Points), `22-reference-sheets` (the advancement mirror).

## Citation rule

Every `evidence[].source` must cite either the registered source label `18-advancement`, another
chapter's filename, or the literal `reasoning`. Quotes go in `quote_or_excerpt` only, under about
12 words. `argument` and `evidence[].claim` are wall-linted against this statement and the source:
do not quote 10 or more consecutive words there.
