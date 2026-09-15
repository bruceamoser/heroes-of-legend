# Council problem statement — Chapter 22, Quick Reference Sheets

**Source:** `22-reference-sheets.qmd` (472 lines, 18,851 bytes, 17 sections, almost entirely
`#table(` figures: Core Resolution, Difficulty Modifiers, Combat Quick-Reference, Conditions,
Effects, Morale, Dying, Cover, Damage Types, Skills, Discipline Catalog, Character Creation,
Level Progression, DP Cost, Damage Budget, Encounter Building, Common Item Reference).

**Question for the council:** is this chapter publishable as it stands?

**This chapter owns nothing.** It is the book's one-page-per-topic LOOKUP surface: every row is
a restatement of a rule that lives in another chapter. That makes it the highest-risk file in
the book and it changes what counts as a defect here. Three failure classes are native to a
mirror sheet and should be your targets:

1. **A drifted mirror.** A row disagrees with the chapter that owns the rule it restates. The
   owning chapter always wins; the mirror is what gets repaired.
2. **A self-contradiction.** The file disagrees with ITSELF, because two of its own sections
   restate the same rule and only one was updated. This is the sharpest class: the reader has
   both statements in one document and no way to tell which governs.
3. **A missing or unreachable row.** The reference surface omits something a reader will look
   for, or prints a row nothing can produce, or repeats one row across two tables with
   different values.

**Why this chapter is live.** The book was rebuilt on 2026-09-13/14: the damage bands were
renumbered (#532), the card library was split then culled (#537, #538), currency was removed
(#523), Grit became the recovery budget (#533), the hero DR law was ruled (armour grants DR by
weight class and card DR ADDS to it), and Challenge became the resolution for every opposed
contest. This chapter was last reviewed on 2026-09-01 and is the single most-mirrored file in
the book, so it is where a superseded rule survives longest. **Four of its cells were already
repaired today by PR #549** (`:234`, `:248`, `:365`, `:398`), which shows the class is present
here; treat those four as done and do not re-file them.

## Topics

- **t-01** conformance to the locked conventions below (bands, prices, gates, Boon/Bane, DR,
  dice, vocabulary, currency, the one-card law)
- **t-02** mirror fidelity: every row against the chapter that owns the rule it restates, and
  every row against the same file's other statements of the same rule
- **t-03** coverage and usability: rows a reader needs but cannot find, dead or unreachable
  rows, duplicated rows, section order, heading hierarchy, cross-references, and the render

Every finding MUST set `topic` to exactly `t-01`, `t-02`, or `t-03`. One finding carries one
defect; name any others in your reply.

## Locked conventions (current as of 2026-09-14 — these ARE the law this run tests against)

1. **Damage bands, flat, renumbered 2026-09-13 (#532): Novice 4/6/8, Adept 5/8/11, Master
   7/10/14** (Weak/Standard/Strong). **The retired rows 2/4/6, 6/9/12 and 9/15/21 are valid
   nowhere in the book.** Success tiers: Weak 1-8, Standard 9-14, Strong 15+. Basic attack card
   floor 1/2/3 plus the attribute; unarmed 1/1/2; cantrips 1/3/5.
2. **The one-card law (#537/#538):** a card is bought once at one tier for one price (Novice
   2 DP, Adept 4 DP, Master 8 DP) and never changes. Level gates: Novice 1, Adept 3, Master 7.
   No rungs, no upgrade paths, no spell chains, no card that improves another card.
3. **Discipline cost structures:** Home 1/2/4, Adjacent 2/4/8, Foreign 3/6/12, Opposed 4/8/16,
   the three numbers being the rank-1/2/3 prices in DP. No-prereq Novice basics cost only the
   flat 2 DP. **Cantrips are free and carry no Discipline requirement** (decisions-pending
   #109; `10-magic-system.qmd:71-77`).
4. **Flat damage riders are dead.** "+1 damage tier" is the sanctioned increase. A flat
   "+N damage" rider never appears.
5. **Boon/Bane law.** Anything changing how likely a roll is to succeed is a Boon or a Bane,
   never a numeric roll modifier; Boon and Bane cancel one for one. The numeric modifiers that
   survive are exactly: attributes (-2 to +2), skill tiers (+1/+2/+3), the difficulty dial, and
   a Challenge penalty. The dial runs +4 Trivial, +2 Easy, +0 Standard, -2 Hard, -4 Very Hard,
   -6 Nearly Impossible.
6. **Hero DR law (2026-09-13).** Armour grants DR by weight class: light 1, medium 2, heavy 3.
   **Card DR ADDS to it** (`09-talents-abilities.qmd:47`), and the ceiling is **band-relative:
   3 Novice / 4 Adept / 6 Master** (`16-armor-shields.qmd:23-27`). **Shields grant NO DR.**
   Shields enable Parry and Shield Block and never add a roll bonus (`06:107`, `07:155`,
   `13:113`, `15:247`, `16:70`). A shield's printed number is its PROTECTION DISCIPLINE
   REQUIREMENT, not a DR value. Only HERO DR follows the kit rules; a creature's or mount's DR
   is a stat-block value (barding +1/+3, bestiary DR = Challenge ÷ 2, max 6).
7. **Currency is REMOVED (#523).** Nothing is bought. Any row implying a purchase, a price, a
   coin amount, funding or payment is a defect, and commerce written without a coin word
   ("buy", "sell", "commission") is the class the #523 audit had to catch by hand.
8. **Challenge is the standard resolution for EVERY opposed contest (#507):** the actor rolls
   `3d6 + attribute + skill - Challenge`; the opposition never rolls. A fixed difficulty ("a
   Medicine check (Standard)") is a different, legal shape.
9. **Zero em-dashes** anywhere in the book source.
10. **House emphasis in body text is Typst italic (`*word*`), never markdown bold.**
11. **The Discipline roster is 24 in nine types** (`08-disciplines.qmd:34-58`): Elemental
    (Fire, Earth, Wind, Water), Weapon (Blades, Axes, Polearms, Archery, Heavy Weapon,
    Unarmed), Defense (Protection, Armor), Primal (Animal, Plants), Arcane (Energy), Divine
    (Life, Religion), Esoteric (Mind, Summon, Fate), Subterfuge (Stealth, Sleight), Knowledge
    (Lore, Tactics). A Discipline rank never exceeds 3.
12. **Conditions:** `13-combat.qmd:191-216` Table 13.3 is the canon list of 23, and the
    condition LEVEL (`Burning 3`, `Slowed 10`) is the magnitude the effect sets.
13. **Grit and recovery:** Grit is 2 Novice / 3 Adept / 4 Master, spending one resets HP to
    maximum and forces a Wound Table roll, and it returns on a respite, a full night's rest
    (`13:339-349`). Wounds heal 1 per long rest, plus 1 with a Standard Medicine check.
14. **Printed numbering carries a +2 offset.** This file is 22 in source order and prints as
    **Chapter 24**; its figure is `Figure 24.1`, and its art placeholder line is a book-wide
    convention. Do not file either as a defect.
15. **Crossref law.** A cross-reference renders with its own trailing period, so nothing is
    typed after a bare sentence-final ref or after a closing parenthesis carrying one.
16. **Skills are keyed as `07-skills.qmd` keys them:** Athletics BR, Parry BR, Acrobatics AG,
    Dodge AG, Endurance FO, Survival FO, Lore KN, History KN, Arcana KN, Nature KN, Religion KN,
    Medicine RE, Insight RE, Perception RE, Craft RE, Alchemy RE, Persuasion GU, Deception GU,
    Performance GU, Stealth AG, Sleight of Hand AG, Thievery AG, Intimidation BR.
17. **Encounter building:** `20-bestiary.qmd` owns the Challenge bands (C½–2 / C3–6 / C7+) and
    the Challenge Budget table (Easy = × party level, Standard = ×2 party level, Hard = ×3).

## Already checked by the orchestrator and CLEARED — do NOT file these

- **Zero em-dashes. Zero retired damage rows. Zero currency words. Zero flat damage riders.
  Zero retired DR-law or flat-cap language outside the one lead named below.** Verified by grep
  on the file; a mechanically clean chapter means the round is hunting deeper than the obvious.
- **`Figure 24.1`, the art placeholder line, and the duplicated `#label("sec-chapter-…")` inside
  the Typst fence are all book-wide convention** (conventions 14 and the book's own pattern).
- **`:311-323`'s Damage Budget table prints the live bands** with the Challenge-band labels
  (Novice C½–2 / Adept C3–6 / Master C7+). Correct on every count.
- **`:340-354`'s armour table's DR column is CORRECT and newly restored** (Padded/Leather/
  Studded Leather 1, Chain Shirt/Breastplate 2, Half Plate/Chain Mail/Plate 3). The shipped
  hero-DR law re-established this column; do NOT flag it as a retired-DR residual.
- **`:357-363`'s shield table's `[Protection Req]` column is the PROTECTION DISCIPLINE
  REQUIREMENT, not a DR value.** Its 1/1/2 are Discipline ranks. Do not file it as the retired
  shield-DR column.
- **`:398`'s defense summary was corrected today in PR #549** (armour plus talents, banded
  ceiling, shields grant none). Do not re-file it.
- **`:381-397`'s weapon table has 17 rows** and its prerequisites are legal discipline shapes
  (a 2+1 is a three-rank requirement, which is the ceiling, not a violation).
- **`:254-274`'s level progression totals check out:** 4+3+3+3+4+3+3+3+3+3 = 32 advancement DP,
  plus 8 Class DP, plus background DP (8 + Knowledge + Fortitude) = 44-52 career DP, matching
  the advancement chapter.
- **`:239-252`'s creation checklist** matches ch02's steps and the attribute rule (-2 to +2,
  total +3).
- **`:172-186`'s damage-type list matches `13-combat.qmd:144-152`** (the Elemental family is
  Fire, Cold, Lightning, Acid, Poison, Thunder; the Magical family is Force, Radiant, Necrotic,
  Psychic). Note this is the damage FAMILY, a different thing from the Elemental DISCIPLINE
  type; do not conflate them.
- **`:220-237`'s Discipline catalog carries all 24 members including Fate.**

## Worked leads — verify or REFUTE these, do not simply restate them

Your own independent audit is the deliverable. **A ballot that only rules on this list is a
wasted ballot.** A lead you clear is a result; report it as one.

- **`:194`'s Parry row says a shield "enables Parry and gives DR, never a roll bonus".** Test
  that against convention 6 and against THIS FILE'S OWN `:365`, which says the opposite in the
  same document. If it is wrong, decide which side is the outlier and whether any other row in
  the file carries the same retired claim.
- **`:290`'s DP Cost table's last row is "No-prereq basic (Novice) 2 DP" and there is no
  cantrip row.** Under convention 3 cantrips are free and have no Discipline requirement. Does
  a reference sheet that lists every purchase price owe the reader a free row, and is an
  omission a defect or a scope choice?
- **The Discipline catalog at `:220-237` orders its nine categories as Elemental, Weapon,
  Defense, Primal, Subterfuge, Arcane, Divine, Knowledge, Esoteric.** Compare with the owning
  roster's order at `08-disciplines.qmd:34-58`. Decide whether a lookup surface benefits from
  matching its owner or from a deliberate reordering, and whether the change matters.
- **`22:87-115`'s Conditions table** carries 23 rows? Count them against Table 13.3 exactly,
  comparing the NAME, the EFFECT and the ENDS column of each, and report every cell that
  differs. A quick-reference condition table is where a drifted condition definition hides.
- **`22:50-86`'s combat section** (`:52` Your Turn, `:67` Basic Maneuvers) against
  `13-combat.qmd:31-45`'s action economy and Table 13.1's ten maneuvers: compare the resource
  list, the per-turn counts, and every maneuver row.
- **`22:120-133`'s Effects table** against the effect vocabulary the spell chapters actually
  print (Lift X, Push X, Slide X, Trip, and whatever else is listed). Check for an effect that
  appears on cards but not in the table, or a table row no card uses.
- **`22:134-146`'s morale**, **`:147-159`'s dying** and **`:160-171`'s cover** against
  `13-combat.qmd`'s morale, Dying and cover rules. Cover in particular: the book's sanctioned
  shape is half cover = Bane on attacks against you, full cover = triple Bane.
- **`22:326-339`'s encounter-building table** against `20-bestiary.qmd:645-660`'s Challenge
  Budget table. Compare every row's multiplier AND its worked example.
- **`22:17-49`'s core resolution and difficulty-dial rows** against `06-core-resolution.qmd`:
  the roll, the tiers, the Critical and Fumble handling, and the exact dial values.
- **`22:187-219`'s skill table (the Parry row is `:194`)** against `07-skills.qmd`'s roster: the attribute keying of
  every row, and whether any skill in the owner is missing here or appears here and nowhere in
  the owner.
- **`22:276-310`'s DP Cost Reference** against ch08's card prices and the four cost structures:
  is every purchase a reader can make represented, and does the "total cost of a card" sentence
  match how the classes chapter computes it?
- **`22:340-354`'s armour table** (the shield table's header is `:359`) against `16-armor-shields.qmd`'s armour tables: the weight
  class of every armour listed, and the SLOTS column. A slot count is a number a reader will
  trust this sheet for.

## Cross-check chapters

`02-character-creation`, `03-attributes`, `05-classes`, `06-core-resolution`, `07-skills`,
`08-disciplines`, `09-talents-abilities`, `10-magic-system`, `11-arcane-spells`,
`12-divine-spells`, `13-combat`, `15-equipment`, `16-armor-shields`, `17-magic-items`,
`18-advancement`, `19-gm-guidance`, `20-bestiary`, `21-glossary`.

**Note for t-02 work:** a drifted mirror is repaired in THIS file, but name the owning file and
line in your evidence so the disposition can reach both sides where the owner is also wrong.
Do not audit another chapter in its own right.

## Citation rule

Every `evidence[].source` must cite the registered source label `22-reference-sheets`, another
chapter's filename, or the literal `reasoning`. Quotes go in `quote_or_excerpt` only, under
about 12 words. `argument` and `evidence[].claim` are wall-linted against this statement and
the source: never place 10 or more consecutive words from either into them.
