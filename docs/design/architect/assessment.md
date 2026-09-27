# System assessment — the whole game, from the foundation up

**Owner:** the architect cycle. Method: `references/system-assessment.md`.
**Rule:** assess the whole before ordering the work. The ledger records what has been DECIDED, never
that what exists is good.

## What matters now

*Ranked by severity of failure x how much of the book depends on it. This is the queue's source.*

| # | Item | Why it outranks everything | Status |
|---|---|---|---|
| 1 | **The price of a card is stated two ways, and creation teaches the wrong one** | `02:204` (Step 7) and `22` (DP Cost Reference) both say cards cost "2/4/8 DP regardless of class", while `08:178` says "the flat card DP cost is only part of the price: you also pay rank costs for any required Disciplines you do not already possess". The true price of a Novice card is **2 to 6 DP** (held / Home / Adjacent / Foreign / Opposed). Every build budgeted from creation's own steps underfunds by the rank costs, which is the measured cause of the 26 DP shortfall at rank 9. | **measured 2026-09-26 (cycle 3)**; fix is a sentence, so it is a work order, not a ruling |
| 2 | **The casting procedure names a field it never defines** | `10:31` says every spell rolls `3d6 + Knowledge` (arcane) or `+ Reason` (divine) "plus **relevant skill**"; the phrase appears twice in the book and is defined nowhere. **114 of 114 spell cards name no skill**, no ch07 skill entry says "casting", and the only mapping anywhere is inside one worked example (`10:123`, Arcana). A player cannot cast a spell from the book alone, and a divine caster is told to pair a Reason roll with a Knowledge-keyed skill. | **measured 2026-09-26 (cycle 8)**; needs a ruling (ledger row 172) |
| 3 | **Primal is a half-built tradition: 12 cards, 7 requirements, 0 items, 0 glossary entries, 0 classes** | 12 cards are titled "Primal Spell" and 7 requirements ask for `focus:primal`, but ch15 carries no primal focus item, ch21 no entry, ch05 no mention, and ch10 declares only two traditions. `12:359`/`12:370` are titled Divine and demand a primal focus. "Primal" already names a discipline category (Animal, Plants). A listed thing that cannot be bought or cast is the Cohesive criterion failing outright. | **measured 2026-09-26 (cycle 8)**; needs a ruling (ledger row 173) |
| 4 | **The difficulty dial is asymmetric** | Trivial +4 down to Nearly Impossible -6. More room to make things hard than easy. Combined with a competent hero at +3, a Trivial task cannot fail. Deliberate or drift? Unruled. | needs a ruling |
| 5 | **Failure collapse at the top of the range** | At mod +5 (Master: attr +2, skill +3) P(Weak) = 0.46%, 1 in 216. At +6 it is mathematically 0. A master cannot fail a Standard task, so the "succeed with a catch" band stops existing for them. May be intended (that is what mastery means) but it must be stated as intent. | needs a ruling |
| 6 | **The price of a card is stated two ways, and creation teaches the wrong one** | `02:204` (Step 7) and `22` (DP Cost Reference) both say cards cost "2/4/8 DP regardless of class", while `08:178` says "the flat card DP cost is only part of the price: you also pay rank costs for any required Disciplines you do not already possess". The true price of a Novice card is **2 to 6 DP** (held / Home / Adjacent / Foreign / Opposed). Every build budgeted from creation's own steps underfunds by the rank costs, which is the measured cause of the 26 DP shortfall below. | **measured 2026-09-26 (cycle 3)**; fix is a sentence, so it is a work order, not a ruling |
| 7 | **The Adept cadence is stated two ways** | `10:99` says "Adept and Master spells can only be used once per combat. You can't drop an Adept spell every round", while the chapter's own worked example reads the limit as **per card** (`10:127`). Per-card, a level-7 caster holding four Adept cards casts one every round, which is the outcome the sentence forbids; per-tier, the second Adept card is near-dead content. The whole spotlight economy turns on which. | **measured 2026-09-26 (cycle 8)**; needs a ruling (ledger row 174) |
| 8 | **The Shepherd cannot pay for its own loadout and a card** | `05:202` prints 7 DP of loadout ranks and claims "which still leaves room for a card"; the class pool is 8 DP (`02:204`) and a Novice card is 2 DP, so the line costs **9 DP**. Eight of nine classes close; the Shepherd does not. | needs a ruling (ledger row 166) |
| 9 | **Creation's printed builds are unfunded and the skill ledger never closes** | 7 of 9 printed heroes cannot pay for the gear their own loadout requires (26 DP); all 9 spend 2 DP on the skill their culture already grants +1 in (18 DP). **Cycle 7: the level-1 grant that creation never awards would pay 6 of those 7 builds, cutting 26 DP to 2.** | rows 161/162; one word each |
| 10 | **Master is not an efficiency tier, and nothing says so** | Cards cost 2/4/8 while the bands are 4/6/8, 5/8/11, 7/10/14: damage per DP falls **3.00 -> 2.00 -> 1.25** with ranks already paid. The premium buys per-action impact and a once-per-session spotlight (`10:101`), which is a real thing to buy, but a player optimising damage per DP will buy breadth and be right on the numbers. | needs a ruling (ledger row 167) |
| 11 | Fate unpriced / Summon uncarded | Advertised, unusable. Ruled, specced, undispatched (rows 125/151, issue #655). | work order filed |
| 12 | ch09 tier-labelled headings | Three cards titled "Novice Talent" whose requirements are Adept and Master (row 160). Player-facing promise defect. **Cycle 7: the tier RULE itself was the larger half of this - `09:15` keyed tier to the count of Disciplines, mispricing 59 of 102 cards; fixed in #665. The three cards remain.** | row filed; rule fixed |
| 13 | **The focus downgrade has no defined bottom for most cards** | `15:40`/`21:217` end the ladder "Weak becomes **1 damage**" - a clause that only means something if the rung is damage. **23 of the 59 focus-carrying cards have a non-damage Weak rung**, and on a heal it inverts (Mending Touch's "Restore 4 HP" becomes 1 damage). | **measured 2026-09-26 (cycle 8)**; needs a ruling (ledger row 175) |
| 14 | **Fortitude and Knowledge pay twice** | Each point adds +1 HP (`03:78`) and +1 Background DP (`02:115`). No other attribute feeds a pool. At +2/+2 against -2/-2 that is 8 DP and 4 HP on the same two points, and at -2/-2 the hero has 6 HP and 4 DP (Assessment 3). | needs a ruling (ledger row 168) |
| 15 | **Every level-1 hero is 4 DP short of the book's own career total** | `18:66` grants 4 DP at level 1 with "Class signature, Starting Disciplines" as its milestones (creation's own grants), and `22:272` counts it inside the printed 44-52 DP career. Creation's eleven steps (`02:43-275`), `22`'s checklist and all nine printed builds assign only 8+K+F and 8. | needs a ruling (ledger row 169) |
| 16 | **The healing and flat-number axes** | Healing was never converted to the live rows (4 cards, fixed in #665; 3 items still need a ruling - rows 170/171). **Cycle 8 closed the third axis: 7 of 7 ch17 item ladders and 5 ch05 Master riders were still on the retired rows and are now on the live ones.** | rows 170/171; flat axes fixed |

## Re-assessment 2026-09-26 (cycle 3) — priority 1 was measured, and it holds

Assessment 1 promoted **static HP vs scaling damage** to priority 1 as "the game's biggest structural
bet, unassessed beyond the numbers". Cycle 3 computed it. The verdict reverses: **the compensation
works, and time-to-kill is flat across the whole career.** Recorded here rather than overwritten,
per the re-assessment rule.

HP is static (8-14) but it is not the resource that decides a fall: Grit is `13:341` (2 Novice /
3 Adept / 4 Master; at 0 HP you spend one, reset to maximum, and keep fighting). Effective pools are
therefore HP x 3 / x 4 / x 5, and armour DR rises with the tier a hero actually plays at
(1 / 2 / 3 by weight class). Expected damage per hit, at each tier's typical attack modifier
(Novice attr +2 & skill +1 = +3; Adept +4; Master +5), against that tier's band:

| Tier | Band | E[dmg] per hit, no DR | E[dmg] with the tier's armour DR | Hits to fall (HP 11) |
|---|---|---|---|---|
| Novice | 4/6/8 | 6.66 | 5.66 (DR 1) | **5.8** |
| Adept | 5/8/11 | 9.44 | 7.44 (DR 2) | **5.9** |
| Master | 7/10/14 | 12.49 | 9.49 (DR 3) | **5.8** |

Flat to one decimal place, and flat at every HP value in the printed range (HP 8: 4.2 / 4.3 / 4.2;
HP 14: 7.4 / 7.5 / 7.4). Damage scales, DR and pools scale with it, and the two cancel. Even with no
armour at all the compression is mild (5.0 -> 4.7 -> 4.4), because Grit's pools grow in step with the
band. **Verdict: GOOD.** The design bet pays off.

Two corrections to the earlier framing follow from the same numbers:

- **"At Master tier a Strong hit (14) one-shots a 14-HP hero" is not true as printed.** At Master, a
  Strong hit lands 14 against DR 3 = 11: a 14-HP hero survives on 3 HP, and an 11-HP hero reaches 0,
  spends Grit and resets to full. A hero FALLS only when 0 HP arrives with no Grit left, which takes
  3 such events at Novice, 4 at Adept, 5 at Master inside one fight. A pool can be one-shot; a hero
  cannot.
- **The residue that is still unmeasured is the Wound Table, not the HP pool.** Every Grit spend
  rolls it (`13:375`), so a hero who spends 2-4 Grit in a fight takes 2-4 wound rolls, and part 1's
  effects are mostly per-encounter Banes (Cracked Ribs is a Bane on all physical rolls for the
  encounter). Whether those compound faster than the pools absorb is the open question, and it is a
  round-walkthrough measurement, not an arithmetic one.

## Assessment 1 — Core resolution (the roll everything sits on)

**As printed.** `3d6 + Attribute Modifier (-2..+2) + Skill Bonus (+1/+2/+3) + Difficulty Modifier`.
Bands: **Weak 1-8, Standard 9-14, Strong 15-18+**. Boon/Bane = 4d6 keep highest/lowest three, cancelling
one for one. Opposed = the target's attribute negated as Challenge. **Computed 2026-09-26, exact
distribution over all 216 rolls, independently re-derived in cycle 3 (all six rows verified correct).**

| Total modifier | Weak | Standard | Strong | Who this is |
|---|---|---|---|---|
| 0 | 25.9% | 64.8% | 9.3% | untrained, baseline task |
| +1 | 16.2% | 67.6% | 16.2% | attribute +1 |
| +2 | 9.3% | 64.8% | 25.9% | attribute +2, or skill +1 |
| +3 | 4.6% | 57.9% | 37.5% | attr +2 + Novice skill (a typical hero) |
| +4 | 1.9% | 48.1% | 50.0% | attr +2 + Adept skill |
| +5 | 0.5% | 37.0% | 62.5% | attr +2 + Master skill |

**PROMISE — GOOD.** The bell curve does what the book claims. One point buys ~6.5-8.8 points of
P(Strong) across the reachable range (+1->+2: +8.3 pts, +2->+3: +8.8, +3->+4: +7.9), so "every
attribute point matters" is literally true and "+2 is enormous" is quantified rather than asserted.

**DISCRIMINATION — GOOD, with a curve shift worth naming.** At mod 0 the profile is 26/65/9: Strong is a
1-in-11 event. At mod +4 it is 2/48/50: Strong is a coin flip. The *feel* of the game changes across the
level range from "Strong is a rare treat" to "Strong is routine". That is presumably deliberate heroic
progression, but it should be a stated intent, because it means the tier a player experiences most is
not the same tier at level 1 and level 7.

**RANGE — OK at the bottom, BAD-ish at the very top.** The bands and the dial are sound from -6 to +4.
Above that the Weak band collapses (4.6% at +3, 1.9% at +4, 0.46% at +5, exactly 0% at +6) — see
priority 4. **Note on the band's own notation:** "Strong 15-18+" must be read as unbounded above, and
a checker that caps it at 18 silently drops 4 of 216 outcomes at +2 and 56 of 216 at +6 (this
assessment's own verification script made exactly that error before it was corrected against raw
counts). The `+` is load-bearing; a reference sheet that prints "15-18" would misprice the top of the
range.

**Boon/Bane — GOOD.** Measured: Boon 10.5 / 66.4 / 23.1, Bane 48.8 / 48.5 / 2.8 against a 25.9 / 64.8 /
9.3 baseline. A Boon raises P(Strong) 2.5x and a Bane raises P(Weak) 1.9x: a real lever, and
cancel-one-for-one keeps it honest with no bookkeeping.

**COST — GOOD.** One roll, no damage roll, no margin arithmetic, every modifier drawn from the sheet.
The resolution mechanic earns its page.

**Verdict: GOOD as a foundation.** The core roll is not where this game's problems are.

## Assessment 2 — The economy (DP, card costs, rank costs, level gates)

**As printed.** Two creation pools: **Background DP** = `8 + Knowledge + Fortitude` (so 4-12; Human
+1) and **Class DP** = 8 flat, both spend-all-or-lose (`02:20`, `02:28`, `02:115`, `02:204`). Cards
cost a flat **2/4/8** by tier, gated Novice level 1 / Adept level 3 / Master level 7
(`02:129`, `08:144-147`). Discipline ranks cost **Home 1/2/4 - Adjacent 2/4/8 - Foreign 3/6/12 -
Opposed 4/8/16** (`08:162-166`). The **true price of a card = its flat cost + the rank costs of any
required Discipline not already held** (`08:175-178`). Advancement gives 3-4 DP per level, **32 by
level 10**, a Discipline rank at levels 3/6/9, and 2 attribute increases (`18:46-63`); unspent DP
carries, and retraining is 1:1 at any level (`18:40`, `18:103`). **All numbers below computed
2026-09-26 from those tables, not quoted.**

**Career budget.** 32 advancement + 8 class + (8 + Knowledge + Fortitude) = **44-52 DP**, which is
`22`'s printed total and checks out exactly.

**The true price of a Novice card is 2 to 6 DP, not 2.**

| Discipline status | Rank cost | + flat 2 DP | = true price |
|---|---|---|---|
| already held | 0 | 2 | **2 DP** |
| new, Home | 1 | 2 | **3 DP** |
| new, Adjacent | 2 | 2 | **4 DP** |
| new, Foreign | 3 | 2 | **5 DP** |
| new, Opposed | 4 | 2 | **6 DP** |

A 3x spread on a purchase the book advertises at one price. This is the mechanism behind priority 5:
a player who budgets from Step 7 or the reference sheet pays 2 DP in their head and 3-6 DP at the
table.

**Damage per DP falls by more than half as tier rises** (bands `10:46-48`; midpoints 6 / 8 / 10.33):

| Tier | Price | Mid damage | Damage per DP |
|---|---|---|---|
| Novice | 2 DP | 6.0 | **3.00** |
| Adept | 4 DP | 8.0 | **2.00** |
| Master | 8 DP | 10.33 | **1.29** |

Master costs **4x** the DP of Novice for **1.72x** the damage. The higher tier is not an efficiency
purchase, and the book never says what it is instead. `10:101` says the once-per-session limit is
about spotlight, which is the honest answer, but it is not presented as the reason to pay the premium.
A player reading only the cost and damage tables will buy breadth, be right on the numbers, and never
reach the top tiers the economy says it is built to make "a plan, not an accident" (`18:65`).

**Rank supply is the real gate, and it is three picks wide.** Rank 1 comes from ancestry, culture and
class grants; rank 2 from one Background deepen at creation; rank 3 from a progression pick, of which
there are exactly three in a career (levels 3, 6, 9). A discipline at rank 3 therefore costs 2 of the
3 picks if rank 2 was bought at creation, and all 3 if it was not. The practical consequence: a career
can hold rank 3 in one discipline plus rank 2 in one other, which is the "2 + 1" Master requirement
shape, so **the Master column of a discipline's card list is reachable in roughly one pattern per
career, not as a library**. That is a defensible scarcity (Master is a capstone), but the book never
states it and the reference sheet does not show it.

**The 8-DP promise, checked class by class.** `05:45` states the model plainly: the loadout's
remaining ranks are "paid from the same Development Points that buy your cards", and every class line
ends "...which still leaves room for a card". Priced against each class's own table: Protector 6 + 2 =
8 (exact); Leader 4 + 2 + 2 = 8; Shadow 5 + 2 = 7; Blade, Arcanist, Unbalanced 4 + 2 = 6; Intellect
3 + 2 = 5; Odd 2 + 2 = 4. **Eight of nine close. The Shepherd does not:** `05:202` prints Melee rank 1
(Foreign, 3) + Armor rank 1 (Opposed, 4) = 7 DP, and 7 + a 2 DP Novice card = **9 DP against a pool
of 8**.

**PROMISE — GOOD.** Two pools, spend-all at creation, no banking; the free floor is honestly placed
(cantrips are 1/3/5, below the Novice row's 4/6/8 at every tier, and `10:77` says why); unspent DP
carries after creation and retraining is 1:1, so no purchase is ever a trap and "never a null turn"
survives at every budget.

**RANGE — GOOD at the top, OK at the bottom.** 44-52 career DP buys a coherent career: 4 Master cards,
or ~16 Novice purchases, or the breadth/depth mixes between. The bottom end is the weak one: a hero
who dumps Knowledge and Fortitude starts with 4 Background DP instead of 12, and whether the tightest
legal hero can be built is exactly the 26 DP shortfall in priority 5.

**DISCRIMINATION — OK.** The ladder separates impact per action cleanly (bands never overlap, and the
doubling prices are memorable), with one unstated gradient (damage per DP, above) and one unstated
incentive (Knowledge and Fortitude pay twice: +1 HP *and* +1 DP each, which no other attribute does).

**LEARNABLE — BAD.** The advertised price and the true price differ by up to 3x because the book
states the price in two places with different completeness: creation's own steps and the reference
sheet give the flat figure and stop, while the disciplines chapter gives the formula. Four class lines
compound it by naming the wrong structure: Blade, Arcanist, Shepherd (Armor) and Unbalanced each
describe a **4/8/16** charge as "at your Foreign rate", where the printed structures make Foreign
**3/6/12** and 4/8/16 **Opposed**. The numbers are right and the names are wrong, so a player who
cross-checks the comprehensive table finds a 1 DP disagreement and no way to tell which wins.

**COST — GOOD.** Two tables and one formula cover the whole economy, and the structures are powers of
two once learned.

**STRESS — one live break, one arithmetic slip (in the checker, not the book).** The Shepherd
overspends its pool (above). The Leader's line, by contrast, is **correct** and was worth the
check: "the weapon ranks cost 4 DP at your Home rates" is Melee ranks 1 and 2 at Home (1 + 2 = 3 DP)
plus Two-Handed rank 1 at Home (1 DP), because the class grant covers Shields and nothing else, so
4 DP for weapons + 2 DP for the Adjacent Armor rank + a 2 DP card = 8 DP exactly. The first pass
of this assessment read the claimed 4 DP as a mis-sum against a Melee-rank-2-only reading; the
scripted check (`scripts/class-loadout-economy.py`, which pays every step above the granted rank)
corrected it. A third stress case is closed by design: the One-Card Law (`08`, "every card is
bought once, at one tier... no ladder to climb") means no DP is ever stranded in a superseded
purchase, and retraining refunds at 1:1.

**Verdict: OK, with LEARNABLE failing.** The economy's prices are sound and its pools are adequate;
what fails is that the book does not tell a player the price it is actually charging.

## Assessed so far

| # | Subsystem | Verdict | Date |
|---|---|---|---|
| 1 | Core resolution | GOOD (two range notes) | 2026-09-26 |
| 2 | The economy | OK (LEARNABLE fails; one class over-pool; 4 mislabelled structures) | 2026-09-26 |
| 3 | Creation and progression | **GOOD on the arithmetic, OK on progression.** All 9 printed builds' HP/Initiative/Carry re-derive exactly; the reachable space is Background DP 4-12, HP 6-14, career 44-52 DP, ranks 1-3. No dead level (skills are a gate-free sink); the binding constraint after level 3 is the 3-rank ceiling, not DP. Two rule-statement defects found and repaired in the same cycle (#665). | 2026-09-26 |
| 4 | Combat and action economy | **BAD (pacing).** An even fight, read from the book's own encounter rule, resolves in ~1 round at every tier; root cause is a premise mismatch between `19:53` and `20:659`. Re-assessed and re-costed cycle 5. **Cycle 6: the repair is chosen and filed as #663** (per-hero encounter budget, one and a half creatures per hero); the encounter's challenge-point budget is the wrong instrument for duration, and the count is the right one. | 2026-09-26 |
| 5 | Magic and the spell system | **OK on the core loop, BAD on learnability and cohesion.** 114 spell cards (68 arcane, 46 divine); one roll, three rungs, no slots. Bands discriminate from mod -2 to +3 (Weak 48.2% -> 4.6%); damage/DP 3.00 / 2.00 / 1.25. 32 of 114 cards print a damage row; 0 of them on a retired row, but the third band-change axis (flat printed numbers) was still unconverted: 7 of 7 ch17 item ladders + 5 ch05 Master riders, repaired this cycle. Two entry-point rules are unnamed or self-contradicted (the casting skill, the Adept cadence) and the 12-card Primal tradition has no item, no glossary entry, no class, and no place in the tradition rule. | 2026-09-26 |
| 6 | Social conflict | not assessed | |
| 7 | Equipment | not assessed | |
| 8 | Content (classes, disciplines, cards) | not assessed | |
| 9 | Bestiary and GM tools | not assessed | |

**Coverage: 5 of 9 subsystems, non-contiguous.** Rows 1, 2, 3, 4 and 5 are assessed; the pacing pass took
combat and action economy early, on Bruce's ruling 165. Social (6), equipment (7), content
(8) and the bestiary (9) are still open. Until the table is full, the queue is a guess with good manners.

**Next (cycle 9):** subsystem 6, social conflict - the last subsystem whose every interaction is a
single skill check, and the one place the book's own Challenge law (`06:97`) has not yet been
reconciled with its opposed tables. Then equipment (7), content (8), bestiary (9). The pacing row 165
still carries its chosen lever and needs nothing from the ledger except the dispatch gate.

## Assessment 5 - Magic and the spell system (cycle 8, 2026-09-26)

**The mechanic as printed.** One roll, always: `3d6 + Knowledge` (arcane) or `+ Reason` (divine) plus
"relevant skill", read on the card's three rungs (10:19-33). No slots, no mana, no casting check and no
failure percentage; holding an ongoing spell is the one thing that asks for more (Concentration,
10:104). A card is bought at its tier - Novice 2 DP / level 1 / 4/6/8, Adept 4 DP / level 3 / 5/8/11,
Master 8 DP / level 7 / 7/10/14 (10:39-56) - and its Discipline requirements are met with 1, 2 or 3
ranks (10:59-67). Focuses (`focus:arcane`, `focus:holy`, `focus:primal`) are 0-cost items; a spell cast
without one "resolves one outcome lower" (15:31-40). Limits are per-encounter (Adept + Master),
per-session (Master), concentration (one spell, Fortitude check when damaged), and ritual (a slower
mode that does not spend the card's use).

**The corpus, computed.** 114 spell cards: `11-arcane-spells` parses as 68 (15 cantrips + 53 spells,
matching the chapter's own "fifteen cantrips ... fifty-three spell cards"), `12-divine-spells` as 46
(6 cantrips + 40 spells). Tier split 54 Novice / 45 Adept / 15 Master. 59 cards demand a focus, 34
non-cantrip spells demand none, 21 cantrips are exempt by law (row 110).

**1. The bands discriminate across the whole realistic caster range.** Exact enumeration of the 216
3d6 outcomes, against caster modifier (Knowledge or Reason -2..+2, skill 0..+3):

| mod | -2 | -1 | +0 | +1 | +2 | +3 | +4 | +5 | +6 |
|---|---|---|---|---|---|---|---|---|---|
| Weak | 48.2% | 37.0% | 25.9% | 16.2% | 9.3% | 4.6% | 1.9% | 0.46% | 0.00% |
| Standard | 48.2% | 57.9% | 64.8% | 67.6% | 64.8% | 57.9% | 48.2% | 37.0% | 25.9% |
| Strong | 1.9% | 4.6% | 9.3% | 16.2% | 25.9% | 37.5% | 50.0% | 62.5% | 74.1% |

All three rungs are live from -2 to +3, which is where nearly all play sits; the Weak rung is decorative
only at +5 and above, where the player has already bought Mastery (priorities 3 and 4 in the queue own
that question, and it is a property of the 3d6 core, not of magic).

**2. The price of a spell is front-loaded.** Damage per DP at the flat card price, Standard band:
**3.00 / 2.00 / 1.25** (Weak 2.00 / 1.25 / 0.88; Strong 4.00 / 2.75 / 1.75). Master is not an efficiency
tier - that is row 167's question, and magic only supplies its numbers.

**3. Casts to drop a 14-HP peer** (expected damage per cast at mod +2: Novice 6.33, Adept 8.50, Master
10.76): **2.21 / 1.65 / 1.30 casts**. A single Standard hit is 43-77% of a hero's entire HP pool, which
is the arithmetic behind the pacing failure - owned by #663, cited here because a magic chapter cannot
be tuned in isolation from it.

**4. Conformance, damage axis: clean. The FLAT axes were not.** 45 cards carry a three-rung damage body;
**0 sit on a retired row** (the earlier waves hold). A naive first-integer-per-rung extractor reports 16
"off-row" cards; every one is a push distance, a weight, a DR value, a duration or a minion count - the
false-positive class row 132 documented, and the vocabulary the number is produced under is stated here
because the count is not the finding.

The 2026-09-15 band change was verified with **slash-triples**, and a slash triple is how a *card*
prints damage. Three axes print damage without one, and each was invisible to that sweep:

| axis | state before this cycle | evidence |
|---|---|---|
| healing (one HP value per line) | found and fixed in #665 (row 170: 4 cards -> 0) | `heal-row-census.py` |
| **magic-item granted-power ladders (ch17 tables)** | **7 of 7 ladders on a retired row, 21 figures** - 5 ladders at 2/4/6, 2 at 6/9/12 | `17:59-61`, `115-117`, `269-271`, `341-343`, `473-475` (Novice), `225-227`, `293-295` (Adept) |
| **class-ability flat riders (ch05)** | **5 Master abilities printing 9/9/15/15/9** | `05:540`, `588`, `589`, `707`, `708` |

ch17 states the law it was breaking in its own header (`17:34`: "Damaging powers key to the damage
budget ... Novice 4/6/8, Adept 5/8/11, Master 7/10/14"). Closed issue #546 ("band residue ... ch11/ch12
and their mirrors") names ch17 **0 times** and ch05 **0 times**, so this is a new site group, not a
re-opened one. Repaired this cycle by positional mapping onto the live row (retired Novice 2/4/6 ->
4/6/8, retired Adept 6/9/12 -> 5/8/11, and a lone 9 -> 8 / 15 -> 14 for the Master riders).

**5. Two entry-point rules a player cannot follow from the book alone (LEARNABLE fails twice).**
- **The casting skill is never named.** `10:31` says "3d6 + Knowledge + **relevant skill**"; the phrase
  appears twice in the book and is defined nowhere. **114 of 114 spell cards name no skill**, ch07's 23
  skills describe Arcana as "magical knowledge, spell identification" and Religion as "gods, rituals,
  divine lore" - neither says casting - and there is exactly one mapping anywhere in the book, inside a
  worked example (`10:123`, Sera rolls Arcana for an arcane spell). A divine caster is told to roll
  Reason plus a skill whose own attribute is Knowledge, with no rule that says a skill may ride another
  attribute. A player at the table must ask.
- **The Adept cadence is stated two ways.** `10:99` says "Adept and Master spells can only be used once
  per combat. You can't drop an Adept spell every round", but the chapter's own worked example reads the
  limit as **per card** ("The Brimstone Burst is per-encounter. Sera won't cast it again this fight",
  `10:127`). Per-card, a level-7 caster holding four Adept cards (16 of a 44-52 DP career) casts an Adept
  spell every round - the exact outcome the sentence forbids. Per-tier, the second Adept card is nearly
  dead content. Both readings are defensible and the difference is the whole spotlight economy.

**6. Two cohesion failures.**
- **The focus downgrade has no defined bottom for most cards.** `15:40` and `21:217` end the ladder
  "Strong becomes Standard, Standard becomes Weak, and **Weak becomes 1 damage**" - a clause that only
  means something if the Weak rung is damage. **23 of the 59 focus-carrying cards have a non-damage Weak
  rung** (`11:271` Wind Wall "missile attacks through the wall have Bane", `11:317` Ward of Iron "+1 DR
  against one attack"), and on a healing card it inverts the effect (Mending Touch's Weak "Restore 4 HP"
  literally becomes 1 damage).
- **Primal is a half-built construct.** 12 cards are titled "Primal Spell" and 7 requirements ask for
  `focus:primal`, but there is **no primal focus item** (15's item table lists Arcane Focus and Holy
  Symbol), **no glossary entry** (21 has both siblings, no primal), **no class mention** (ch05 never says
  primal), and ch10 declares **two** traditions (10:83-89) that do not include it - ch12:19 is the only
  text that names a primal caster ("Shepherds use them"). The two Divine-titled cards that demand a
  primal focus (`12:359` Beast Tongue, `12:370` Briar Wall) are where the vocabularies collide. And
  "Primal" already names a **discipline category** (Animal, Plants - `21:69`, `22:229`), so the word
  carries two senses with one of them unqualified. **A listed thing that cannot be bought and cannot be
  cast is the Cohesive criterion failing outright.**

**7. Cantrip breadth is 15 / 5 / 1, and the divine list does no damage.** Arcane 15, divine 5, primal 1,
against `10:75`'s promise that "each tradition has its own full list". Three arcane cantrips deal damage
on the ruled 1/3/5 line (row 110); **no divine cantrip deals damage at all**. The never-a-null-turn
pillar still holds for every caster (attacks always hit and a weapon is always in hand), so this is
breadth asymmetry rather than a hole - but the primal tradition's "full list" is one card.

**8. Stress: no free-recovery loop.** The ritual clause ("does not spend the card's once-per-encounter or
once-per-session use") reads dangerous against out-of-combat casting, and it is not: all 3 ritual cards
are Mind spells (teleport, oath, insight) - none heals, none damages. Concentration is one spell at a
time with a Fortitude check per damage event. The at-will layer (cantrips + weapon) means a caster is
never out of options, which is the pillar delivered.

**Verdict: OK on the core loop, BAD on learnability and cohesion.** The loop does exactly what the book
promises - magic always fires, one roll decides how well, the three rungs discriminate everywhere play
happens, and no caster ever has a null turn. It fails the two criteria a *reader* needs: the procedure
names a field it never defines (the casting skill), states its most important limit two ways (the Adept
cadence), and carries a 12-card tradition with no item, no glossary entry, no class and no home in its
own tradition rule. The band-change residue on the flat axes was measurable and is now repaired; the
learnability and primal defects are rule-text work.

**Instrument:** `scripts/architect-magic-census.py` (per-discipline tier coverage, rung grading with the
retired-row check, recurring per-round x duration totals, non-damage-rung and focus-downgrade scope,
focus/tradition mismatches, cantrip conformance; `--selftest` carries three negative controls).


## Pacing assessment - combat and action economy (2026-09-26, on Bruce's ruling 165)

**The mechanic as printed:** attacks always hit; one roll sets both outcome and damage; HP is
`10 + Fortitude + Knowledge` (8-14) and never grows, with Grit as the stated staying-power pool;
monster HP in ch20 runs 10-20 (51 stat blocks, avg 14.8); damage bands scale 4/6/8 -> 5/8/11 ->
7/10/14; DR subtracts per hit with a 1-damage floor.

**The standard, verified rather than assumed.** The DMG's own CR math is computed on average output
over **three rounds** (Angry GM, rpgbot, giantitp each cite this); community encounter builders
target **3-4 rounds**, and D&D Beyond's encounter formula uses Easy 3 / Medium 3.5 / Hard 4+ rounds.
MCDM's **Draw Steel**, the benchmark this book sits closest to, runs longer at roughly 5-6 rounds.
So 3-4 is a defensible mainstream target, slightly on the fast side of the benchmark: Bruce's
number sits where it should.

**The numbers, computed rather than quoted.** 4 heroes vs 4 even enemies:

| tier | E[dmg]/attack | party DPR | rounds to resolve | party wiped in |
|---|---|---|---|---|
| Novice | 6.66 | 26.6 | 2.22 | 1.80 rounds |
| Adept | 9.44 | 37.8 | 1.57 | 1.27 rounds |
| Master | 12.49 | 49.9 | 1.18 | 0.96 rounds |

**Verdict: BAD against the stated goal, at every tier, and worse as the book gets more heroic.**
The game does not hold a stable encounter length; it compresses, because damage scales and the HP
pool it is measured against does not. Failing criterion: PACING. Two secondary failures follow. At
Adept and above an even fight is a mutual rout decided in one or two exchanges, which removes the
tactical middle of the fight where the best choices live. And Grit, the intended staying-power
mechanic, is pressed into service as the only thing standing between a Master-tier fight and a
one-round wipe.

**The book already prints the drift.** `13:532` presents a resolved combat as "About 8 minutes. Two
full rounds." The expectation is being taught, not merely implied.

**Repair space, most honest first.** (1) Flatten the damage bands' growth rate: to hold 3.5 rounds
the bands must be ~60% of current at Novice and ~32% at Master. (2) Scale enemy HP with tier, so an
"even fight" pool grows with the party's output. (3) Add defensive texture (DR) rather than raw HP.
Hero HP does not move; it is static by design.

**Evidence:** `scripts/rounds-to-resolve.py` - exits 1 today, 3 of 3 tiers outside the window.
Deterministic, calibrated against the printed bands, re-runnable on every change to the numbers.

## Re-assessment (cycle 5, 2026-09-26) - the model was the bug, and the truth is sharper

Recorded beside the assessment above, never over it. Two of its three numbers were artifacts of the
checker, exactly the failure this loop is built to catch in someone else.

**Correction 1: a Master-tier party was paired with the bestiary's global average HP.** The gate
averaged all 48 stat blocks (14.9 HP) and used that pool at every tier. (The 51 / 14.8 figure in the
assessment above is a naive `HP n` text count, not a population: three of those mentions are not stat
blocks - a summoned Lesser Treant at `20:607`, the Death Knight's reforming armour at `20:637`, and
the `20:659` guideline line itself - so 48 is the population and 14.9 its mean.) Monster HP is not flat. It is
calibrated per band by `20:659` (`HP = 3 x (band average - its DR)`), and monster DR is what scales
across the career, not HP:

| tier | band | n | avg HP | avg DR | party E[hit] after that DR |
|---|---|---|---|---|---|
| Novice | C1/2-2 | 24 | 15.1 | 0.67 | 5.99 |
| Adept | C3-6 | 20 | 14.8 | 2.40 | 7.04 |
| Master | C7+ | 3 | 15.0 | 4.67 | 7.82 |

DR growth is why the printed bands (4/6/8 -> 5/8/11 -> 7/10/14) do not show up undiminished in play:
the party's effective per-hit damage rises only **1.31x** across the whole career, not the 1.88x the
raw bands suggest. Stratified at 4v4 the compression is **2.52 / 2.10 / 1.92 rounds**, not 2.22 /
1.57 / 1.18.

**Correction 2: "the party is wiped in 1.80 / 1.27 / 0.96 rounds" is withdrawn.** That line divided
raw hero HP by incoming damage with no Grit (`13:341`) and no armour DR (`16:23`). With both, a party
is dropped after **12.7 / 12.9 / 12.7 rounds, flat** - and the flatness holds at every tier for the
same reason the tier-3 re-assessment found in the other direction. So the two "secondary failures"
above are false: there is no mutual rout, no one-round wipe to avert, and Grit is not the only thing
standing between a Master fight and disaster. It is not standing in front of anything, because an
even fight never gets near it:

| tier | rounds to clear a STANDARD encounter | rounds before a hero is actually dropped |
|---|---|---|
| Novice | 1.26 | 12.7 |
| Adept | 1.05 | 12.9 |
| Master | 0.96 | 12.7 |

**Correction 3: the encounter size this was measured at is the book's DEADLY, not its Even.**
`19:53` defines the tiers: Easy x1 party level, **Standard x2**, Hard x3, Deadly x4+, and spells the
Standard case out - "roughly two Challenge 1 creatures" for a level 1 party. So an even fight as the
book itself builds one is a party of four against **two** creatures, and it resolves in about **one
round at every tier**. The gate now measures that case; the 4v4 figure is still printed, labelled as
what it is.

**The real root cause is a cross-chapter premise mismatch, not the damage bands.** `20:659`'s HP rule
is a SOLO-DUEL calibration: it sizes a monster to absorb three rounds of ONE hero's output. `19:53`
then hands a party of four two creatures, so four heroes focus-firing one target at a time finish the
whole encounter in about a round. Both rules are internally sensible; they were written on different
assumptions about how many heroes point at one monster. `19:57` already states the doctrine that
resolves it ("count actions, not just hit points").

**Repair space, re-costed against the corrected model** (the old estimates - "bands at ~60% of
current at Novice and ~32% at Master" - were built on the artifact, and lever 2 of the original list,
"scale enemy HP with tier", turns out to be already implemented as monster DR):

1. **Re-anchor `20:659`'s HP rule on the encounter the book actually builds.** The 3-round target is
   right; it is attached to the wrong unit. Monster HP ~ 3.5 x the party's post-DR per-hit damage
   gives **42 / 49 / 55** at Novice / Adept / Master for a 2-creature Standard fight, against ~15
   printed today. Cost: the guideline plus all 48 stat blocks, and it makes a Novice monster a
   seven-hero-hit object.
2. **Size the Standard encounter to the party's actions: about one creature per hero.** Six creatures
   of the tier's band resolve in **3.79 / 3.15 / 2.88 rounds** (in-window at Novice and Adept, 0.1
   round fast at Master), and the other direction finally bites: six creatures drop a party in ~4.2
   rounds instead of 12.7. That is what makes an even fight cost something, and it is the first lever
   that gives Grit a job. Cost: `19:53`'s budget line, its worked example and its party-size step, and
   nothing else - no stat block, no band, no hero number moves.
3. **Flatten the bands.** Now known to require roughly a **2.9x** reduction, which guts advancement,
   and rejected on the same grounds as before.

**Recommendation: lever 2**, on cost and on doctrine. It uses the book's own "count actions, not just
hit points" and it is the only lever that leaves every printed number standing.

**Verdict after re-assessment: still BAD against the stated goal, but for a different and cheaper
reason than recorded above.** The failure is one of encounter sizing at the seam between ch19 and
ch20, at every tier, and it is not a collapse. The 3-4 round law stands; the gate exits 1.

**Evidence:** `scripts/rounds-to-resolve.py` (skill) - rewritten this cycle to stratify by challenge
band, subtract DR on both sides, measure the Standard encounter, report the other direction against
Grit's real pool, and carry a **positive and a negative control** (`--selftest`: HP sized for exactly
3.5 rounds must pass; the same HP cut to a quarter must fail and name every tier). Both controls
behave. Exit 1 today.

## Cycle 6 - the repair, and why the encounter BUDGET cannot be the instrument

The pacing defect is not the encounter table's arithmetic. It is that the table's instrument, a pool
of challenge points, has no fixed relationship to how long a fight lasts, and duration is the only
thing ruling 165 constrains.

An encounter's duration is **total monster HP divided by the party's damage per round**. Creature HP
is roughly flat across the whole bestiary (avg 15.0-15.1 in every band) while Challenge runs from 1/2
to 12, so the HP a challenge point buys collapses as the party levels - and minions are the worst of
it, near a full creature's HP for half a point:

| band | stat blocks | avg HP | HP per challenge point |
|---|---|---|---|
| Novice (C 1/2 - 2) | 24 | 15.1 | **15.78** |
| Adept (C3-6) | 21 | 15.0 | **3.74** |
| Master (C7-10) | 3 | 15.0 | **1.80** |

(One further heading, the Ancient Dragon at C12, sits above the gate's Master band.) The printed
budget (`19:53`, x2 party level) happens to yield a nearly constant **31.6 / 29.9 / 28.8 HP** of
creature at those tiers, which is a coincidence of how the challenge scale is printed rather than a
property of the rule, and it is about one round of a four-hero party's output. Because the HP yield
per point moves 8.8x across the bands, no value of that multiplier holds the law at every tier: it is
the wrong instrument, not a mis-set one. A second defect is in the same place: the budget does not
know how many heroes are fighting, so a party of four and a party of six are handed the same points,
and a sentence ("six or more heroes fight one step harder") is asked to cover what arithmetic should.

The creature count is the instrument that works, because it is the HP. Six creatures (one and a half
per hero for a party of four) land **3.79 / 3.15 / 2.88 rounds**, and they need 14.0 / 16.4 / 18.2 HP
per monster against **15.1 / 14.8 / 15.0 printed**. Every stat block in ch20 is therefore already the
right size for a Standard fight. Master wants seven (3.36 rounds) because the party's output grows
1.31x across the career while monster HP is flat.

**Decision (veto-revertible default, cycle 6):** the repair is lever 2, and it is specified as a
per-hero budget - Easy x1, Standard x1.5, Hard x2, Deadly x3 party level, multiplied by the number of
heroes - with the field size stated directly in the text: **about one and a half creatures per hero,
six for a party of four, seven at Adept and Master.** No damage band, no stat block, no hero HP, no
Grit and no DR number moves. Filed as **#663**; dispatch is still gated off, so the work order carries
every number it needs and no agent has run it.

**Evidence:** `scripts/rounds-to-resolve.py` lever-sizing table (N=2/4/6/8 per band, per-monster HP
needed at each size) plus the bestiary grouped by challenge band from `origin/main` this cycle.

## Assessment 3 - Creation and progression (cycle 7, 2026-09-26)

**As printed.** Background DP = 8 + Knowledge + Fortitude (`02:115`); Class DP = 8 flat (`02:204`); six
attributes in -2..+2 summing to exactly +3 (`02:47`); HP = 10 + Fortitude + Knowledge (`02:214`);
Initiative = 3d6 + Agility; Carry = 10 + Brawn x 5, floor 5. Advancement is 32 DP over ten levels
(4,3,3,3,4,3,3,3,3,3), one Discipline rank at levels 3/6/9, one attribute increase at 4/8 (`18:66-90`,
`22:258-269`).

**The reachable space, computed.** The sum constraint leaves the pool pair free across its whole window:
K+F can be any value from -4 to +4 (the other four attributes must absorb 3-(K+F), a reachable band of
-8..+8, so no corner is blocked). Every quantity that follows from it:

| Quantity | Floor | Ceiling | Where it comes from |
|---|---|---|---|
| Background DP | **4** | **12** | `02:115`; +1 Human Versatile -> 5-13 (`02:64`) |
| HP at level 1 | **6** | **14** | `02:214`; +2 Dwarf Sturdy -> 8-16 (`02:66`) |
| Career DP by level 10 | 44 | 52 | 32 advancement + 8 class + (8+K+F) (`22:272`) |
| Discipline ranks in a career | 1 (a grant) | **3** | 3 progression picks; rank 2 buyable at creation (`08:99`) |

All nine printed heroes re-derive: HP, Initiative and Carry come out exactly right from their printed
attributes in **9 of 9** cases. Creation's arithmetic is sound; its defects are in funding (rows 161/162)
and in what the level-1 grant actually is (row 169).

**RANGE at the bottom is legal, and nothing warns that it is the worst build in the game.** The tightest
legal hero (K and F both -2) has **6 HP and 4 Background DP**. At every tier a Strong monster hit minus
that tier's armour DR exceeds 6 (8-1, 11-2, 14-3), so that hero is dropped by a single strong hit in
every band and stands back up twice on Grit: 3.2 hits to be put out of a fight against 5.8 for an 11-HP
hero, a 45% cut in staying power, for 8 DP and 8 HP surrendered on the same two points. This is the
measured bottom of row 168's double bank, and the fix shape is a sentence in ch02 either way (the
formula is fine; the omission is that nothing says the dump is the expensive one).

**Progression: no dead levels, but the real gate is ranks, not DP.** The sink is never empty, because
skills share the card tiers and gate nothing (23 skills x 3 tiers = 322 DP of legal sink against a 44-52
DP career), so every level has something to buy. What is scarce is the *card* sink, and it is gated by
ranks rather than DP: rank 1 across the 4-5 granted disciplines at level 1, Adept only in the single
discipline the level-3 pick deepens, Master only after picks at 3 *and* 6 land on the same discipline
(`08:99`). Per discipline the book prints 11 Novice / 7 Adept / 3 Master cards at Energy down to 1/0/0
at Tactics, Animal, Lore and Sleight, so the level-1 pool buys a real but partial slice of a wide shelf,
and after level 3 the binding constraint is the three-rank ceiling. That is Assessment 2's finding
restated on the progression axis (the career is rank-limited), and row 167's Master-efficiency gradient
is its pricing consequence.

One structural residue, not a defect: awards are 3 or 4 DP against costs of 2/4/8, so each level leaves
a 1 DP remainder. It carries over by rule (`18:70`) and is spendable as a new rank 1 at a Home-priced
discipline (`08:162`), so nothing is stranded; the residue simply means a career's purchases never
exactly consume its pool.

**Two defects found and repaired this cycle (PR #665):** the rule that prices every card was stated in a
way that disagrees with the corpus (see below), and the healing axis of the damage-budget table was
never converted to the live rows.

*The tier sentence.* `09:15` defined a card's tier as "the number of Disciplines on its header". The
corpus keys tier to the **total Discipline ranks** required: 99 of 102 printed headings agree with the
rank reading against 43 of 102 for the literal sentence, `10:63` states the rank rule explicitly ("a
card that asks for two Discipline ranks and covers an area is an Adept card"), and `08:193`'s grammar
reads "2 Fire" as rank 2. Under the literal wording **59 of 102 cards drop a tier** - 174 DP of price
movement and the level-3 gate opening early on cards that print the Adept damage row. Sentence aligned
to the corpus; no card changed. The three cards that contradict under *both* readings remain with row
160.

*The healing axis.* The 2026-09-15 band change was verified by grepping slash-triples, which is how
**damage** prints; a healing card prints one HP value per line, so the axis was invisible to that sweep
and to row 132's damage-specific extractor. Four cards were still on the retired rows and are now on
their own tier's row: Mending Touch 2/4/6 -> 4/6/8, Restoration / Tide of Life / Soulmend 6/9/12 ->
5/8/11, the Potion of Healing 2/4/6 -> 4/6/8 (which puts the potion ladder on the three live rows by
rarity), Second Breath's Adept gift 6 -> 5. Instrument: `scripts/heal-row-census.py`; **4 cards on a
retired row before, 0 after.** Three items need a ruling and are logged (rows 170/171): Flesh Renewal's
recurring heal, the two Adept cards printing the Master row, and the untiered critical-effect heal.

**Verdict: GOOD on the arithmetic (9 of 9 builds re-derive) and OK on progression (no dead level), with
two rule-statement defects found and repaired in the same cycle and one flagged item at the HP floor.**

## Assessment 5 - Magic and the spell system (cycle 8, 2026-09-26)

**The mechanic as printed:** one roll decides everything. `10:31`: arcane spells roll `3d6 + Knowledge +
relevant skill`, divine spells `3d6 + Reason + relevant skill`; the result reads the card's Weak /
Standard / Strong line. No slots, no mana, no failure percentage; magic always fires. Tier sets both
price and row: Novice 2 DP at level 1 on 4/6/8, Adept 4 DP at level 3 on 5/8/11, Master 8 DP at level 7
on 7/10/14 (`10:46-48`). Cards require Discipline ranks (1/2/3, ceiling 3, Master may blend). Limits
(`10:97-112`): per-encounter for Adept and Master, per-session for Master, one concentration spell, a
ritual casting mode (3 cards), and an opposed roll to end another caster's effect (row 146). Focuses
(`15:31-33`, `21:215-217`, `22:394-408`): `focus:arcane` / `focus:holy` / `focus:primal`, each costed
0, and a missing focus resolves one outcome lower.

**Numbers, computed from the corpus rather than quoted** (`architect-magic-census.py`, `--selftest`
plants a retired-row card, a focus mismatch and a blank-label card and requires all three):

- **Corpus.** 114 spell cards: ch11 68 (15 cantrips + 53 spells, the chapter's own total), ch12 46 (6
  cantrips + 40 spells). Tiers: 54 Novice / 45 Adept / 15 Master. 59 cards carry a focus; 21 cantrips are
  exempt by ruling (row 110); 34 non-cantrip spells demand no implement, which `15:40` explicitly allows.
- **The bands stay live across the realistic caster range.** Exact enumeration of the 216 outcomes:
  at mod -2 / -1 / 0 / +2 / +4 / +5, P(Weak) is 48.15 / 37.04 / 25.93 / 9.26 / 1.85 / 0.46% and P(Strong)
  is 1.85 / 4.63 / 9.26 / 25.93 / 50.00 / 62.50%. A working caster (attribute +1, skill +2) sits at +3,
  where all three rungs are worth reading. Only the top of the range (mod +6, P(Weak) = 0) collapses, the
  known priority-4 note.
- **Master is not an efficiency tier**: damage per DP at the Standard band is 3.00 / 2.00 / 1.25 with
  ranks already paid, and casts to drop a 14-HP peer are 2.21 / 1.65 / 1.30. Row 167's ruling question
  covers this; magic adds the second half of the answer (a Master cast is a once-per-session spotlight,
  `10:101`).
- **Conformance on the damage axis is clean**: **32 of the 114 cards print any damage row at all, and 0 of
  them sit on a retired row** (the 54 pure-utility and 7 healing cards make the remainder). The crude
  first-integer extractor's 16 "off-row" hits are all push distances, weights, DR values,
  durations and minion counts, which is row 132's documented false-positive class, and the vocabulary is
  stated here because the count is not the finding.
- **The third band-change axis was still unconverted.** The 2026-09-15 sweep grepped slash-triples, which
  is how damage prints; three axes print without them, and healing was only the second. The third:
  **7 of 7 damaging item ladders in ch17 (21 figures) sat on the retired rows** (5 ladders on 2/4/6 at
  `17:59`, `17:115`, `17:269`, `17:341`, `17:473`; 2 on 6/9/12 at `17:225` and `17:293`) even though
  `17:34` prints the live rows in the chapter's own header text, plus **5 Master abilities in ch05**
  printing 9 or 15 (`05:540`, `588`, `589`, `707`, `708`). The closed band-residue issue #546 named
  ch11/ch12 "and their mirrors" and references neither file. Repaired this cycle: 26 figures moved onto
  their own tier's live row by position. Logged as row 176.
- **Coverage.** Master (rank-3) spells exist in 5 of 23 disciplines: Energy 5, Mind 4, Protection 4,
  Religion 3, Wind 1. Fire, Water, Earth, Plants, Life and Animal carry none, and rank 3 is optional and
  flavour-led (the coverage standard), so this is a fact, not a defect. Rank-1 breadth is where magic is
  thin: 54 Novice cards over 12 discipline keys.
- **Cantrip breadth is 15 arcane / 5 divine / 1 primal** while `10:75` promises "each tradition has its
  own full list". Three arcane cantrips deal damage on the ruled 1/3/5 line (row 110); **none of the five
  divine cantrips deal any**, so a divine caster's at-will layer is utility only. The primal list is one
  card.

**Two learnability failures, both at the entry point:**

1. **The casting skill is never named.** `10:31` and `10:75` both say "a relevant skill"; 114 cards name
   no skill, no ch07 entry says casting (Arcana is "Magical knowledge, spell identification", Religion is
   "Gods, rituals, divine lore", Nature is "Plants, animals, natural phenomena"), and the only mapping in
   the book is inside one worked example (`10:123`, Sera adds Arcana). A player cannot cast from the book
   alone, and a divine caster is told to pair a Reason roll with a Knowledge-keyed skill. Row 172.
2. **The Adept limit contradicts its own justifier.** `10:99`: "Adept and Master spells can only be used
   once per combat. You can't drop an Adept spell every round", while the worked example (`10:125`) reads
   it per card ("The Brimstone Burst is per-encounter. Sera won't cast it again this fight"). Per card, a
   level-7 caster holding four Adept cards does exactly what the sentence forbids. Row 174.

**Two cohesion failures:**

1. **The focus downgrade's floor is defined only for damage.** Measured: of the 59 focus-carrying cards,
   **23 have a non-damage Weak rung** (Wind Wall's "missile attacks through the wall have Bane", Ward of
   Iron's "+1 DR against one attack", Flicker Step's "teleport 5 ft"), where "Weak becomes 1 damage" has
   no meaning, and on a heal the literal rule inverts the effect. `10:37` over-promises the same grammar
   ("its outcome block keys to that tier's row of the damage budget") when only 32 of the 114 cards print
   a damage row at all (32 damage / 7 healing / 54 pure utility among the 93 non-cantrip spells). Row 175.
2. **Primal is a half-built tradition: 12 cards, 7 requirements, 0 items, 0 glossary entries, 0 classes.**
   12 cards are titled "Primal Spell" and 7 requirements ask for `focus:primal`, but ch15's item table
   carries Arcane Focus and Holy Symbol and no primal focus, ch21 has entries for those two and none for
   primal, ch05 never uses the word, and `10:83-91` declares **two** traditions while `12:19` says the
   chapter holds "divine and primal" spells and "Shepherds use them". Only 3 of the 12 Primal-titled
   cards demand the focus at all, and 2 cards titled **Divine** demand it (`12:359`, `12:370`). "Primal"
   also already names a discipline category (`21:69`, `22:229`). A listed thing that cannot be bought or
   cast is the Cohesive criterion failing outright. Row 173.

**Stress:** the ritual mode cannot be abused into free recovery: the 3 ritual cards are all Mind
(Teleport, Oath, Insight), and none of them heals or damages, so it opens no attrition loop. Concentration
is one at a time with a Fortitude check per hit. Attacks always hit and cantrips are at-will, so the null
turn does not exist in this subsystem (it would take a silence-style lockout, which the book does not
print).

**Verdict: OK on the core loop, BAD on learnability and cohesion.** The loop delivers the pillars (always
fires, one roll, never a null turn) and its three bands discriminate everywhere a real caster plays, from
mod -2 to +3. What fails is the entry point: two rules a player must have are unnamed or self-contradicted,
and a 12-card tradition cannot be bought, cast, or looked up.
