# Council problem statement — Chapter 21, Glossary

**Source:** `21-glossary.qmd` (238 lines, 6 sections: a chapter opener with a figure and a
pagebreak, then Core Mechanic Terms, Character Terms, Combat Terms, Magic Terms, GM Terms).

**Question for the council:** is this chapter publishable as it stands? A glossary is a
different animal from a rules chapter: it defines nothing of its own, it RESTATES every
mechanical term the rest of the book uses. So the governing question is narrower and harsher
than usual: **does every entry agree with the chapter that owns the mechanic, and does the
chapter actually cover the terms it promises to cover?** Its own opening claim is "Every
mechanical term used in this book, defined in one place" (`21:13`), which is a coverage
promise the council should hold it to.

**Why this chapter is live.** The book was rebuilt twice on 2026-09-13/14: the damage bands
were renumbered (#532), the card library was split and then culled (#537, #538), currency was
removed from the game (#523), Grit was introduced as the recovery budget (#533), and the hero
DR law was ruled (armour grants DR by weight class and card DR adds). `21-glossary` was last
reviewed in Wave 1 on 2026-08-31, before all of those changes. Wave 1's own entry for this
chapter shows the failure mode a glossary is prone to: it had to gain Dazzled and Petrified
because conditions existed in ch13 that the glossary simply did not list. Residue of a retired
economy, band, or law lands here as a definition that quietly teaches the old rule.

## Topics

- **t-01** conformance to the locked conventions below (bands, prices, gates, Boon/Bane, DR,
  dice, vocabulary, currency, the one-card law)
- **t-02** definitional accuracy against the canon home: an entry that restates a rule from
  the chapter that owns it must agree with that chapter (the glossary never defines a mechanic
  first, so the owning chapter always wins)
- **t-03** coverage, structure and presentation: terms the book uses that the glossary does
  not define, entries that are duplicates or orphans of each other, section ordering, heading
  hierarchy, cross-references, and the render

Every finding MUST set `topic` to exactly `t-01`, `t-02`, or `t-03`. A finding may carry one
defect only; if you have several, file the strongest and name the rest in your reply.

## Locked conventions (current as of 2026-09-14 — these ARE the law this run tests against)

1. **Damage bands are flat and were RENUMBERED on 2026-09-13 (#532): Novice 4/6/8, Adept
   5/8/11, Master 7/10/14**, read Weak/Standard/Strong (`08-disciplines.qmd:205-217`).
   Success tiers: Weak 1-8, Standard 9-14, Strong 15+. **The retired rows 2/4/6, 6/9/12 and
   9/15/21 are valid nowhere in the book.** A basic attack card prints the Basic-card floor
   1/2/3 plus its attribute; unarmed is 1/1/2; cantrips print 1/3/5. A monster's attacks use
   its own tier's band.
2. **Attribute-Scaled damage is defined as "the budget row minus 3"** (`08-disciplines.qmd:230`
   states the rule; the same sentence appears at `21:47`). Whether a printed parenthetical
   follows from that rule under the CURRENT rows is a live question for this run, so do the
   arithmetic yourself against convention 1 rather than assuming either number is right.
3. **The one-card law (Sep 2026, #537/#538):** a card is bought once, at one tier, for one
   price (Novice 2 DP, Adept 4 DP, Master 8 DP), and never changes. Level gates are Novice 1,
   Adept 3, Master 7. A card's tier is a property of the card, not a count of its Disciplines.
   There are no rungs, no upgrade paths, no card that improves another card, and no spell
   chains; a single-tier card is complete. Upper-tier cards carry their own name and a single
   Effect line.
4. **Flat damage riders are dead.** "+1 damage tier" is the sanctioned way to increase damage.
   A flat "+N damage" never appears as a rider.
5. **Boon/Bane law.** Anything that changes how likely a roll is to succeed is a Boon or a
   Bane, never a numeric roll modifier; Boon and Bane cancel one for one. The numeric roll
   modifiers that survive are exactly: attributes (-2 to +2), skill tiers (+1 Novice / +2
   Adept / +3 Master), the difficulty dial, and a Challenge penalty. The difficulty dial runs
   +4 Trivial, +2 Easy, +0 Standard, -2 Hard, -4 Very Hard, -6 Nearly Impossible.
6. **Hero DR law (2026-09-13).** Armour grants DR by weight class: light 1, medium 2, heavy 3
   (`16-armor-shields.qmd:25, 35-44`, `15-equipment.qmd:79, 225`). **Card DR ADDS to it**
   (`09-talents-abilities.qmd:47`: Iron Skin, "Novice: +2 DR, in addition to your armor's DR"),
   and the book's own worked examples print totals built that way (Kael's armour 1 + Iron Skin
   2 = DR 3 at `16:27`; Roric's leather 1 + Iron Skin 2 = DR 3 at `16:86`). **The ceiling is
   band-relative, not a constant: 3 at Novice, 4 at Adept, 6 at Master** (`16:25`,
   `20-bestiary.qmd:661, 667`). Shields grant Parry and Shield Block, never DR. Only HERO DR
   follows the kit rules; a creature's or mount's DR is a stat-block value.
7. **Currency is REMOVED from the game (#523).** Nothing is bought: gear, packs, magic items,
   mounts and vehicles are granted, found, or earned. Any phrase implying a purchase, a price,
   a discount, funding, payment, or a coin amount is a defect, and commerce written without a
   coin word ("sell", "buy", "commission", "fund") is the exact class the #523 audit had to
   catch by hand.
8. **Challenge is the standard resolution for EVERY opposed contest (rolled 2026-09-13,
   #507):** the actor rolls `3d6 + attribute + skill - Challenge`, the opposition never rolls.
   A fixed difficulty ("a Medicine check (Standard)") is a different, legal shape.
9. **Zero em-dashes** anywhere in the book source.
10. **House emphasis in body text is Typst italic (`*word*`), never markdown bold.**
11. **The Discipline roster is 24, in nine types** (`08-disciplines.qmd:34-58`): Elemental
    (Fire, Earth, Wind, Water), Weapon (Blades, Axes, Polearms, Archery, Heavy Weapon,
    Unarmed), Defense (Protection, Armor), Primal (Animal, Plants), Arcane (Energy), Divine
    (Life, Religion), Esoteric (Mind, Summon, **Fate**), Subterfuge (Stealth, Sleight),
    Knowledge (Lore, Tactics). Fate is a real, printed Discipline with its own card line.
12. **Grit and recovery:** `13-combat.qmd:339-349` defines Grit (2 at Novice, 3 at Adept, 4 at
    Master; spending one resets HP to maximum and forces a Wound Table roll; it returns on a
    respite, a full night's rest). Wounds heal 1 per long rest, plus 1 more with a Standard
    Medicine check (`13:424`). HP does not rise with level; Grit does.
13. **Printed numbering carries a +2 offset.** This file is 21 in source order and prints as
    **Chapter 23**; its figure is `Figure 23.1`, and its art placeholder line is a book-wide
    convention. Do not file either as a defect.
14. **Crossref law.** A cross-reference renders with its own trailing period, so nothing is
    typed after a bare sentence-final ref or after a closing parenthesis that carries one.
15. **Skill keying and the defense skills** are fixed in `07-skills.qmd` and `06-core-resolution.qmd`:
    Dodge (Agility) and Parry (Brawn) exist; a shield enables Parry and Shield Block but never
    adds a roll bonus. Survival is Fortitude, Perception is Reason, Athletics is Brawn.

## Already checked by the orchestrator and CLEARED — do NOT file these

Reproduce anything you doubt, but these were verified against the source, and filing them
costs the run a round.

- **The chapter contains ZERO em-dashes** (grep: 0).
- **The dice the chapter prints are all non-damage and all legal:** `3d6` (the core roll, the
  death roll at `:185`, the morale roll at `:173`, initiative at `:175`), `4d6` keep-highest /
  keep-lowest (Boon and Bane at `:27, :29`), and `1d6` for Recharge at `:229`. No damage dice
  anywhere. Do not file dice findings here.
- **`Figure 23.1` and the art placeholder line are the book-wide convention** (convention 13).
- **The `#label("sec-chapter-glossary")` inside the Typst fence, duplicating the H1's own
  anchor, is the book-wide pattern** for every chapter. Not a defect.
- **`21:43` prints the CURRENT bands** (Novice 4/6/8, Adept 5/8/11, Master 7/10/14) and ends
  with a bare crossref carrying no typed period. Correct on both counts.
- **`21:113`'s Basic Maneuver list is exactly ch13's Table 13.1**, all ten, same names, same
  order: Defend, Disengage, Aid, Shove, Grapple, Command, Catch Breath, Search, Stand Up, Use
  Item. Do not file it as missing or extra entries.
- **`21:191`'s "Elemental family" is correct.** `13-combat.qmd:150` defines the Elemental
  damage family as Fire, Cold, Lightning, Acid, Poison, Thunder, so Thunder's membership and
  the five names listed alongside it match the canon home. This is the DAMAGE family, which is
  a different thing from the Elemental DISCIPLINE type in convention 11; do not conflate them.
- **`21:59`'s Carry Slots floor of 5 is the shipped ruling** (decisions-pending #19, PR #461):
  `max(5, 10 + (Brawn x 5))`.
- **`21:211`'s Artifact clause is the shipped definition** (decisions-pending #39, PR #384):
  artifacts are the tier above Legendary and do not count against the three-item attunement
  cap. The three-item cap itself matches `17-magic-items.qmd`.
- **`21:179`'s Cover grades are the sanctioned shape** (half cover = Bane on attacks against
  you, full = triple Bane). Not a defect, and not a dead tier.
- **`21:139`'s Protection Value** matches `22-reference-sheets.qmd:398` and the abilities it
  names: PV is a temporary +1 bonus to the defense roll from Bastion or Arcane Shield.
- **`21:219-237`'s GM terms are consistent with their homes:** Challenge ½ matches the bestiary's
  minion tier, the difficulty dial matches `06-core-resolution`, Passive Insight = Knowledge + 7
  matches `07-skills`, Recharge 5-6 matches the bestiary's Recharge convention, and the Rest
  entry's "short rest has no default mechanical effect" matches `19-gm-guidance`.
- **`21:101-129`'s weapon properties are the equipment chapter's set** (Finesse, Versatile,
  Reach, Thrown, Light, Loading, Two-Handed) and the parenthetical weapon lists match
  `15-equipment.qmd`. The `Versatile` collision with the Human trait is already disambiguated
  in the entry's own text and is the book's own convention, not a defect.
- **`21:131-137`'s effect vocabulary** (Lift X, Push X, Slide X, Trip) matches how the spell
  chapters print those effects.
- **Hero DR aside, the chapter defines no mechanics of its own**, so a finding should never be
  "this rule is a bad rule". If a rule is wrong, the fix belongs in the chapter that owns it
  (name it) plus a corrected gloss here.

## Worked leads — verify or REFUTE these, do not simply restate them

These are the orchestrator's own pre-audit leads, offered as things to TEST. **Your own
independent audit is the deliverable**; a ballot that only rules on this list is a wasted
ballot. Report a lead you cleared as a result in its own right, and if you find the defect is
bigger or smaller than described, say so with the evidence.

- `21:115` defines DR as coming "from your armor alone", says "Nothing else adds to it", and
  caps it at "never exceeds 3". Test that against convention 6 and against the entries at
  `09:47`, `16:25`, `16:27` and `16:86`. If it is wrong, check whether the same sentence
  survives in a sibling chapter before you call it chapter-local.
- `21:47` prints attribute-scaled Adept and Master bases as `3/6/9` and `6/12/18` while the
  rule it states is "the budget row minus 3". Do that subtraction against convention 1's rows
  and say what the current numbers are, then check whether the same printed pair appears
  elsewhere in the book. Decide whether the defect is the numbers or the rule.
- `21:67` enumerates the Discipline types and their members. Count the members listed and
  compare them, one by one, with the roster table at `08-disciplines.qmd:34-58`. Decide
  whether the list is complete, and if it is not, whether the fault is an omission in this
  chapter or a taxonomy that moved under it.
- `21:151` lists the conditions, and seven of the conditions the book actually carries (the
  leveled ones) are then defined individually below it. Some entries in the list also have
  their own fuller entries immediately after. Decide whether the list is a complete roster,
  whether the dual treatment is a structure defect, and what the missing count is against
  `13-combat.qmd:191-216`. If the list omits nothing, say so and close the lead.
- `21:13` claims "Every mechanical term used in this book, defined in one place". Test the
  claim against terms the book actually uses: `respite` (used at `21:183`, defined inline only
  at `13:347`), `Concealment` (used at `21:147` and `21:165`, defined only at `13:223`),
  `Potence` (`06-core-resolution.qmd:59-63`), `Cantrip` (`08:195`, and cantrips have their own
  price exception), `Damage Type` (the chapter defines individual types but never the term),
  and `Basic Attack` (the Basic-card floor is named at `21:47` and the floor itself never is).
  Decide which of these a glossary that makes that claim must define, and which are legitimately
  outside its scope.
- `21:224` and `21:233` use the term *Challenge* for two different things: Challenge Rating at
  `:221` (a monster difficulty measure) and the Challenge penalty in the difficulty dial at
  `:225` and in `06-core-resolution.qmd:97` (a penalty the DA applies to the roller's roll).
  Decide whether one glossary carrying both senses under near-identical words misleads a lookup,
  and if so which side owns the repair.
- `21:221` calls Challenge Rating "Challenge" in parentheses in the entry's own name. Check
  whether that parenthetical is the book's convention or an invention here.
- `21:109` says a Reaction is "One per round (resets at the start of your turn)" while
  `13-combat.qmd:41` prints only "1/round". Decide whether the reset timing is stated anywhere
  authoritative, and if it is not, whether the glossary is adding a rule or clarifying one.
- `21:141` glosses Shield Block as "reduces incoming damage by one tier" while
  `16-armor-shields.qmd:68-72` prints the precise ladder (Strong to Standard, Standard to Weak,
  Weak to 1 damage) plus "cannot reduce damage below 1". Decide whether the gloss is accurate
  enough for a glossary or whether it misleads, and whether the absence of the floor clause
  matters.
- `21:145` and `21:205` gloss Concentration without the difficulty or the repeat clause that
  `10-magic-system.qmd:103` states (Standard or better on 3d6 + Fortitude, checked again each
  time damage lands). Decide whether a glossary entry may omit the check's difficulty.
- `21:153` defines Asleep X as "Falls asleep for X minutes. Wakes on taking damage" while
  `13-combat.qmd:194` defines it as "Unaware for X minutes". Decide whether the glossary
  definition is weaker than the condition the book carries.
- `21:177` says Surprise is "Determined by Stealth vs passive Insight", and
  `13-combat.qmd:540` shows a worked example doing exactly that (19 against a passive Insight
  of 7). Decide whether that shape is compatible with convention 8's Challenge model or whether
  the book teaches a contest the locked law retired, and name which files carry it.
- `21:187` introduces *Wounded* ("Below half your maximum HP") as a defined term. Grep the book
  for other uses of the word as a state. If nothing else uses it, decide whether the glossary
  has defined a term that does not exist as a mechanic, and whether being below half HP is
  itself a state with effects anywhere.
- `21:117` gives each armour weight class a donning time but no speed penalty, while
  `16-armor-shields.qmd` carries a speed penalty on the heavier classes. Decide whether the
  omission is a glossary defect.
- `21:117` names the armours in each weight class while `16-armor-shields.qmd` and
  `15-equipment.qmd` carry the armour tables. Compare the membership lists for a name that
  appears in one and not the others.
- `21:207` and `21:209` say a focus is "Required for some spells", but the only other place the
  requirement appears is the cards' own `Kit: focus:arcane` field (`11-arcane-spells.qmd`). Check
  whether any chapter states the requirement as a rule, and whether the glossary is the first and
  only place a reader learns it.
- `21:189` says wounds "heal one per long rest (a Standard Medicine check during a rest heals
  one additional wound)". Check the Medicine check's tier and its cadence against `13:424`.
- `21:61`, `21:67` and `21:87` restate the class roster, the Discipline types and the rank
  ladder. Check the class list against `05-classes.qmd` (nine classes) and the rank ceiling
  against `08:65-70` and `10:65`.

## Cross-check chapters

`05-classes` (the nine classes and their signatures), `06-core-resolution` (the core roll,
Potence, Challenge, Dodge/Parry, the difficulty dial), `07-skills` (the skill roster and
keying, Passive Insight), `08-disciplines` (the 24-Discipline taxonomy, the bands, card
prices, tier gates, the Discipline rank ceiling), `09-talents-abilities` (Iron Skin, the card
format), `10-magic-system` (concentration, casting, the arcane/divine split), `11-arcane-spells`
and `12-divine-spells` (what spell cards actually print, the Kit focus field), `13-combat`
(the action economy, Table 13.1, Table 13.3 conditions, Grit, wounds, surprise, concealment,
damage types, Death's Door), `14-social-conflict` (Passive Insight in play), `15-equipment`
(kits, slots, armour DR, weapon properties), `16-armor-shields` (armour DR by class, the DR
ceiling, Shield Block), `17-magic-items` (attunement, rarity, artifacts), `18-advancement`
(level gates, DP), `19-gm-guidance` (rests, the DA's terms), `20-bestiary` (Challenge, minion
tiers, Recharge, creature DR and HP), `22-reference-sheets` (every mirror table).

**Note for t-02 work:** a defect whose home is another chapter must be reported as a defect in
THIS chapter's gloss as well, and you should name the owning file and line so the disposition
can reach both. Do not audit another chapter in its own right; ch11/ch12 are scheduled for
their own re-review.

## Citation rule

Every `evidence[].source` must cite either the registered source label `21-glossary`, another
chapter's filename, or the literal `reasoning`. Quotes go in `quote_or_excerpt` only, under
about 12 words. `argument` and `evidence[].claim` are wall-linted against this statement and
the source: never place 10 or more consecutive words from either into them.
