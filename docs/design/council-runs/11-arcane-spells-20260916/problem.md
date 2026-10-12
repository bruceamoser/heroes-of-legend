# Council problem statement — Chapter 11, Arcane Spells (Wave 3, chapter 2)

**Source:** `11-arcane-spells.qmd` — 665 lines, native Typst, **68 cards** (15 cantrips + 53 spell
cards: 23 Novice, 22 Adept, 8 Master), sections Fire / Water / Wind / Earth / Plants / Energy / Mind
/ Protection.

**Question for the council:** is this chapter publishable as it stands — do its 68 cards conform to
the locked conventions below, is the chapter internally consistent (its own stated rules and
promises against its own cards), and does every value, term or rule it restates agree with the
chapter that owns it?

**Why this chapter is high-risk right now.** The arcane list was rebuilt on 2026-09-13/14 (the
damage-band renumber #532 and the one-card refactor #537/#538, which replaced rung-carrying entries
with standalone cards) and has since taken four further passes: the band-residue sweep (#625), the
card-tier header convention (#632, #634), a nine-card re-row onto the Adept row (#633, #635), and
the tier-in-heading / Effect-label retirement pass (#636, #637). Parts of this file have therefore
been edited by four different waves and **no lens has ever read the file as a whole in its current
form.** A chapter assembled by four successive mechanical passes is exactly where a contradiction
between two of those passes survives: each pass was locally correct and verified only its own axis.

## Topics — every finding MUST set `topic` to exactly one of these three

- **t-01** conformance to the locked conventions below
- **t-02** internal consistency: the chapter's own stated rules, section introductions and promises
  against its own 68 cards, and against each other
- **t-03** cross-chapter canon: a value, row, term or mechanic this chapter restates from the
  chapter that owns it

Do not file under `problem-scoping`; that topic cannot be sealed and would stall the run.

## Locked conventions (current as of 2026-09-16 — these ARE the law this run tests against)

1. **Damage bands: Novice 4/6/8, Adept 5/8/11, Master 7/10/14**, read Weak/Standard/Strong
   (`08-disciplines.qmd:214-216`, `10-magic-system.qmd:46-48`). The retired rows 2/4/6, 6/9/12 and
   9/15/21 are valid nowhere in the book. A card whose outcome lines spell a retired row out as its
   own three numbers is the same defect as the closed-up string.
2. **A spell's outcome block keys to the card's OWN tier's row** (a Novice spell prints the Novice
   row, a Master spell the Master row). This differs from weapon maneuvers and class abilities, which
   key to the Novice row (Bruce's ruling, decision #103). Do not file a spell for printing its own
   tier's row.
3. **The one-card law (#537/#538):** a card is bought once, at one tier, for one price — Novice 2 DP,
   Adept 4 DP, Master 8 DP — with level gates Novice 1, Adept 3, Master 7. **Tier is a property of
   the card, not a count of its Disciplines** (`10-magic-system.qmd:61`). The prerequisite ladder and
   the rungs it gated are DELETED: do NOT file a card for printing more or fewer Discipline ranks
   than some tier implies, and do NOT file a missing Adept or Master rung. A single-tier card is
   complete, and a card that is complete at one tier needs no siblings.
4. **Cantrips are exempt from the bands.** They print 1/3/5 and require no Discipline. A cantrip
   whose three outcomes print 1/3/5 is correct; do not file it.
5. **DR law (rewritten 2026-09-15/16, #616-#619; `16-armor-shields.qmd:21-33`).** Read that section
   as the definition, and note that it is NEWER than any earlier briefing of this book:
   - DR comes from **one source at a time** — armour, a talent, or a spell — and the **highest**
     source governs. Armour, talents and wards do not add together.
   - **Shield DR is the exception:** a shield item grants no number of its own, shield DR comes from a
     card, it is added AFTER the ceiling, and no combination of shield sources ever adds more than +3.
   - **There is a ceiling:** total DR from armour, talents and wards cannot exceed 3 at Novice, 4 at
     Adept, 6 at Master.
   - **Temporary grants add:** DR granted by an ability for a stated duration adds to your DR while it
     lasts, and `16:29` names Guarding Stance, Warding Touch, Shield of Faith, Bulwark and Ironhide as
     working that way.
   - **Ranks set the size of a grant:** a DR grant requires Discipline ranks at least equal to the DR
     it grants (DR 2 costs 2 ranks, DR 3 costs 3).
6. **Boon/Bane law (near-zero maths):** a situational modifier to a roll is a Boon or a Bane, never
   +N/−N. Numbers survive only on attributes, skill tiers, the difficulty dial, and a Challenge
   penalty. Challenge is the standard resolution for every opposed contest; the opposition never rolls.
7. **Conditions are a leveled vocabulary** (Burning 2, Slowed 5, Frozen 2). A `*Keywords:*` line
   carries the bare tag only; the card's TEXT carries the level. "Slowed 5 for 1 round" is compliant.
8. **Flat damage riders are dead book-wide.** The sanctioned damage-increase form is
   "**+1 damage tier**". A rider that is numerically wrong is a different finding from a rider that
   exists.
9. **Currency is REMOVED (#523), and equipment is flavour (#554 purge).** Nothing is bought: no
   price, cost, discount or coin amount. Gear contributes no damage of its own. A `Requires:` field
   names the gear a card assumes, or a Discipline rank.
10. **Zero em-dashes** in source text. House emphasis is Typst italic (`*word*`), never markdown bold.
11. **The printed chapter numbering carries a +2 offset:** this file is source chapter 11 and prints
    as **Chapter 13**, so its figure is `Figure 13.1`, and the `_Placeholder for final art._` line is
    a book-wide convention. Neither is a defect. Do not file the art placeholder or the figure number.
12. **Crossref law:** a Typst crossref renders with its own trailing period, so nothing is typed after
    a bare sentence-final ref, or after a closing parenthesis that carries one.
13. **23 Disciplines, 9 categories** (`08:29-68`). The *Defense* category holds **Shields** (the
    martial half), **Protection** (the ward school) and **Armor**. A ward card keying to Protection is
    correct. `focus:arcane`, `focus:holy` and `focus:primal` are legal `Requires` tags (`19:557`).
14. **This chapter prints no damage-budget table of its own** and restates no band as a table; a row
    printed twice inside this file is a restatement, not a source of truth.

## Already checked by the orchestrator and CLEARED — do NOT file these

Reproduce anything you doubt, but these were verified against `origin/main`; filing them costs the
run a round. Report a cleared lead as a result in its own right if you test it.

- **Zero damage dice** (`\bd\d+\b` over the whole file: 0 hits) and **zero em-dashes** (0).
- **Exactly one `{=typst}` fence**, and both outbound `@sec-` references resolve.
- **The card count is 68** (15 cantrips, 23 Novice, 22 Adept, 8 Master) and the introduction's own
  counts ("fifteen cantrips", "fifty-three spell cards") are correct: 15 + 53 = 68.
- **Every card heading prints a tier** (`(Cantrip)` / `(Novice Arcane Spell)` / `(Adept Arcane
  Spell)` / `(Master Arcane Spell)`), which is the #634/#636 convention. Do not file a missing tier.
- **Every card carries its `*Disciplines:* ... *Action:* ... *Range:* ... *Keywords:*` header line.**
- **No retired band residue:** the strings 2/4/6, 6/9/12 and 9/15/21 appear zero times, and a parse of
  every card whose three outcomes all carry a damage figure finds **0 rows off the live band.**
- **The 15 cantrips print 1/3/5** (convention 4). Spark's Standard line's "+1 damage tier against
  metal armor" is the sanctioned form under convention 8.
- **The three `*Effect:*` cards** are Bark Skin / Stone Skin / Iron Skin, the ward ladder — single-line
  cards, legal under convention 3.
- **`focus:arcane` is a legal `Requires` tag** (`19:557`).

## Worked leads — verify or refute these; do not simply restate them

These are the orchestrator's own pre-audit leads, offered as things to TEST. **Your own independent
audit is the deliverable**; a ballot that only rules on this list is a wasted ballot, and a lead
reported CLEAN is a useful result too.

- **The ward ladder is duplicated, name for name, in two chapters.** `11:641-665` and
  `12-divine-spells.qmd:157-223` both define **Bark Skin / Stone Skin / Iron Skin** with the same
  +1/+2/+3, the same `Maneuver` action, the same `Range: Self`, the same 1-round duration, the same
  "does not stack" sentence, keyed `1/2/3 Protection` and differing only in `focus:arcane` against
  `focus:holy`. **Check whether that duplication is the book's convention or an accident:**
  `12:178-181` gives the *primal* twin of the same ladder its own three names (Beast Hide, Scaled
  Hide, Carapace) at identical values, so the book already has a precedent for how a second tradition
  carries this ladder. Then decide which is the defect: the shared names (every lookup becomes
  ambiguous, and the glossary/reference sheets can only list one), or the duplicated content. Name
  every chapter that references these three names (`16:33`, `16:102`, `16:108` do) so the principal
  can see the blast radius of a rename. Is the arcane ladder even needed, given the same ladder is
  available to a divine or primal caster at the same price?
- **`11:641` and `16:29` disagree about whether a ward adds.** This chapter's Protection section says a
  ward is a source and never an addition ("use the higher of the ward and the steel"), and each of the
  three ward cards prints its own "does not stack with any other source of DR" line. `16:29` states the
  opposite rule for a whole class of effects: DR granted by an ability **for a stated duration** adds,
  and it names five such abilities. A ward is granted by a spell, is self-only, and lasts exactly 1
  round when sustained. **Test the two readings against the rules as written and say which chapter is
  the outlier**, which is what a reader will do at the table. If the ward is meant to be the exception,
  what is the ONE sentence that makes it one, and which chapter must carry it? Neither the ceiling
  (convention 5) nor the rank rule (convention 5) appears in this chapter's ward section at all: check
  whether the ladder as printed can exceed the ceiling, and whether each of the three cards satisfies
  the ranks-equal-DR rule.
- **`11:325-333` Tilt (Adept).** Its Weak outcome carries no damage figure while Standard prints 8 and
  Strong 11. Read the card: is the missing figure a defect, or is the Weak outcome deliberately a
  positioning effect? If the latter, does the card still sit on a legible row for a reader keying its
  numbers to the budget?
- **`11:473-481` Turn the Air (Adept).** Its Weak outcome carries **1** damage and its Standard and
  Strong outcomes carry none. An Adept card whose only damage figure is 1 is not on the Adept row.
  Read it and say what the three outcomes are actually supposed to do.
- **`11:491-500` Ward of Iron (Master).** Its Strong line reads "the attacker takes 4 damage and the
  ward reflects 4 damage". Check whether that is one figure counted twice in one sentence, whether the
  card's DR figures (+1/+2/+3) satisfy the ranks-equal-DR rule at Master, and whether a 4-damage
  instance belongs on a Master card at all under conventions 1 and 8.
- **`11:334-344` Plants Spells contains exactly one card** (Venom Lance) while Energy holds 21 and
  Mind 11. Read the section and its neighbours: does the arcane list's own coverage claim survive an
  eight-section structure where one section is a single card, and is a one-card section a defect of
  the chapter or of the Discipline taxonomy (`08:29-68` places Plants in *Primal*) for a chapter whose
  `Requires` tags are all `focus:arcane`?
- **The `*Keywords:*` vocabulary in this file is much wider than the ones the book names.**
  `19:560` describes Keywords as "Bane, Boon, Prone, Slowed, Piercing, DR, and so on", yet this file
  also uses **Damage, Erase, Condition, Illusion, Insight, Oath, Ward, Zone, Push, Compel, Teleport,
  Control and Utility** (Control alone 20 times). Two cards print their tags in opposite orders
  ("Boon, Bane" and "Bane, Boon"). Test whether this chapter is using an open vocabulary or inventing
  one, and whether any tag contradicts the condition it names.
- **`11:19` promises "Every spell card prints its tier, and its outcome block keys to that tier's row
  of the damage budget."** Test that promise against every card in the file, including the three
  `*Effect:*` cards and the eight Master cards, and against the possibility that a reader takes
  "prints its tier" to mean the tier appears in the outcome block rather than only in the heading.
- **`11:23`** — the cantrip introduction says cantrips "don't require Disciplines, they don't cost
  anything to learn, and you can cast them as often as you like, at will, every round, all day."
  Check that claim against all 15 cantrips (three of them carry a `Keywords:` of Bane, five of Utility,
  and several have multi-round durations), and against how the magic-system chapter prices a cantrip.

## Cross-check chapters

`08-disciplines` (the taxonomy, the budget table, the one-card law, card prices), `10-magic-system`
(card format, tier as a card property, cantrips, spellcasting), `12-divine-spells` (the sibling list,
the duplicated ward ladder, the primal twin), `13-combat` (Action / Maneuver / Reaction, conditions,
the DR ceiling in play), `16-armor-shields` (the DR definition this chapter restates), `19-gm-guidance`
(card format and the `Requires`/`Keywords` fields), `21-glossary`, `22-reference-sheets` (whether these
68 cards are indexed), `05-classes` (which classes reach these cards, and their starting Disciplines),
`20-bestiary` (creature attacks and spells).

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
(`grep -rn` over `quarto-book/chapters/*.qmd`), not merely against the registered source. A conclusion
you could not test is reported as **untested**, never as **absent**. The registered source set for this
run is this chapter alone; if a question is about the whole book, say so and cite the other chapter by
filename from your own grep.

## Citation rule

Every `evidence[].source` must cite either the registered source label `11-arcane-spells`, another
chapter's filename (e.g. `16-armor-shields.qmd`), or the literal `reasoning`. Quotes belong in
`quote_or_excerpt` only, under about 12 words. `argument` and `evidence[].claim` are wall-linted
against this statement and the source: **do not quote 10 or more consecutive words** there.
