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
| 4 | **The difficulty dial is asymmetric** | Trivial +4 down to Nearly Impossible -6. More room to make things hard than easy. Combined with a competent hero at +3, a Trivial task cannot fail. Deliberate or drift? Unruled. | **DECIDED 2026-09-26 (architect, cycle 12) - BALANCE, not a Bruce question; veto to revert.** Not a defect: the asymmetry is load-bearing. A Master specialist reaches mod +5, and a *symmetric* +/-4 dial leaves that hero unfailable on every dialled task (+5 - 4 = +1, P(Weak) still 16.2%); the -6 end exists to make exactly that hero's task a coin flip (+5 - 6 = -1, P(Weak) 37.5%). The dial is deliberately wider than the dice. **No number changes.** Evidence: Assessment 6 re-assessment section. |
| 5 | **Failure collapse at the top of the range** | At mod +5 (Master: attr +2, skill +3) P(Weak) = 0.46%, 1 in 216. At +6 it is mathematically 0. A master cannot fail a Standard task, so the "succeed with a catch" band stops existing for them. May be intended (that is what mastery means) but it must be stated as intent. | **DECIDED 2026-09-26 (architect, cycle 12) - premise corrected, NOT a defect; veto to revert.** The row measured the Weak *band* and reported it as failure. The Weak band at +5 holds exactly one roll of 216 and that roll is (1,1,1), the fumble; the fumble is an automatic failure that **overrides the tier** (`06:161/189`, `13:358/362`, unconditional in six homes to one scoping clause). So **P(failure) is flat at 1/216 at +5 and +6 and never reaches 0**; what retires at +6 is the *ordinary* failure, which is what mastery means. Bands still discriminate at +5 (Standard 37.0%, Strong 62.5%). **No number changes.** |
| 6 | **The price of a card is stated two ways, and creation teaches the wrong one** | `02:204` (Step 7) and `22` (DP Cost Reference) both say cards cost "2/4/8 DP regardless of class", while `08:178` says "the flat card DP cost is only part of the price: you also pay rank costs for any required Disciplines you do not already possess". The true price of a Novice card is **2 to 6 DP** (held / Home / Adjacent / Foreign / Opposed). Every build budgeted from creation's own steps underfunds by the rank costs, which is the measured cause of the 26 DP shortfall below. | **measured 2026-09-26 (cycle 3)**; fix is a sentence, so it is a work order, not a ruling |
| 7 | **The Adept cadence is stated two ways** | `10:99` says "Adept and Master spells can only be used once per combat. You can't drop an Adept spell every round", while the chapter's own worked example reads the limit as **per card** (`10:127`). Per-card, a level-7 caster holding four Adept cards casts one every round, which is the outcome the sentence forbids; per-tier, the second Adept card is near-dead content. The whole spotlight economy turns on which. | **measured 2026-09-26 (cycle 8)**; needs a ruling (ledger row 174) |
| 8 | **The Shepherd cannot pay for its own loadout and a card** | `05:202` prints 7 DP of loadout ranks and claims "which still leaves room for a card"; the class pool is 8 DP (`02:204`) and a Novice card is 2 DP, so the line costs **9 DP**. Eight of nine classes close; the Shepherd does not. | needs a ruling (ledger row 166) |
| 9 | **Creation's printed builds are unfunded and the skill ledger never closes** | 7 of 9 printed heroes cannot pay for the gear their own loadout requires (26 DP); all 9 spend 2 DP on the skill their culture already grants +1 in (18 DP). **Cycle 7: the level-1 grant that creation never awards would pay 6 of those 7 builds, cutting 26 DP to 2.** | rows 161/162; one word each |
| 10 | **Master is not an efficiency tier, and nothing says so** | Cards cost 2/4/8 while the bands are 4/6/8, 5/8/11, 7/10/14: damage per DP falls **3.00 -> 2.00 -> 1.25** with ranks already paid. The premium buys per-action impact and a once-per-session spotlight (`10:101`), which is a real thing to buy, but a player optimising damage per DP will buy breadth and be right on the numbers. | needs a ruling (ledger row 167) |
| 11 | Fate unpriced / Summon uncarded | Advertised, unusable. Ruled, specced, undispatched (rows 125/151, issue #655). | work order filed |
| 12 | ch09 tier-labelled headings | Three cards titled "Novice Talent" whose requirements are Adept and Master (row 160). Player-facing promise defect. **Cycle 7: the tier RULE itself was the larger half of this - `09:15` keyed tier to the count of Disciplines, mispricing 59 of 102 cards; fixed in #665. The three cards remain.** | row filed; rule fixed |
| 13 | **The focus downgrade has no defined bottom for most cards** | `15:40`/`21:217` end the ladder "Weak becomes **1 damage**" - a clause that only means something if the rung is damage. **23 of the 59 focus-carrying cards have a non-damage Weak rung**, and on a heal it inverts (Mending Touch's "Restore 4 HP" becomes 1 damage). | **measured 2026-09-26 (cycle 8)**; needs a ruling (ledger row 175) |
| 14 | **Fortitude and Knowledge pay twice** | Each point adds +1 HP (`03:78`) and +1 Background DP (`02:115`). No other attribute feeds a pool. At +2/+2 against -2/-2 that is 8 DP and 4 HP on the same two points, and at -2/-2 the hero has 6 HP and 4 DP (Assessment 3). | needs a ruling (ledger row 168) |
| 15 | **Every level-1 hero is 4 DP short of the book's own career total** | `18:47` grants 4 DP at level 1 with "Class signature, Starting Disciplines" as its milestones (creation's own grants), and `22:272` counts it inside the printed 44-52 DP career. Creation's eleven steps (`02:43-275`), `22`'s checklist and all nine printed builds assign only 8+K+F and 8. | needs a ruling (ledger row 169) |
| 16 | **The healing and flat-number axes** | Healing was never converted to the live rows (4 cards, fixed in #665; 3 items still need a ruling - rows 170/171). **Cycle 8 closed the third axis: 7 of 7 ch17 item ladders and 5 ch05 Master riders were still on the retired rows and are now on the live ones.** | rows 170/171; flat axes fixed |
| 17 | **Social conflict: a dead score, and an example that inverts its own rule** | (a) **Passive Insight is a number nothing consumes** - printed as `Knowledge + 7` in three homes (`14:29`, `07:197`, `21:235`), it spans 5 to 9 and reaches Strong 0 times out of 5, while the same paragraph's actual mechanic uses the Knowledge *modifier* as a Challenge. (b) **The worked example applies the attitude shift on a Standard and skips it on the Strong** (`14:114` vs `14:88`/`14:128`), inverting the rule it demonstrates. Both are the smallest possible repair with no new rule. | **MERGED 2026-09-26 (cycle 13): PR #678, main `f0c9af3`, issue #677 closed.** Six sites across 3 files, audited line by line and verified in the render: "Knowledge score + 7" reads 0 in the built PDF, both new Challenge clauses read 1-2, and the worked example's 13 / 13 / 18 and 1+2=3 are unchanged. |
| 18 | **Three item classes the slot system cannot price, and one dominated weapon row** | (a) A **shield** has no slot cost anywhere (`16`, `22`, `15`): twenty tower shields ride free. Derived value, mirroring the class ladder the shield already uses for entry and DR: small 1 / medium 2 / large 3. (b) **Scholar's robes** sit in three printed builds (`02:362`, `02:403`, `02:641`) and in no table: 1 slot, which is the only value that keeps the tightest build legal (5 of 5 at the floor). (c) A **bundle of thrown weapons** is unpriced (Pip: 9 of 10 as one item, 15 as six). (d) The **Crossbow** prints a thrown weapon's 20/60 band while paying 2 slots and a Loading Maneuver, so the Throwing Dagger dominates it on every printed axis; its band moves to 60/120, the bow ladder's next step, and Loading stays as the identity price with the trade named. | **measured 2026-09-26 (cycle 13)**; work order filed (**#680**), dispatch next cycle |

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
| 4 | Combat and action economy | **OK (pacing repaired, cycle 9).** An even fight, read from the book's own encounter rule, resolved in ~1 round at every tier; root cause was a premise mismatch between `19:53` and `20:659`. **Cycle 9: the repair LANDED as #669 (main `262cd47`)** - the encounter table is per hero (Easy x1 / Standard x1.5 / Hard x2 / Deadly x3 party level, multiplied by the number of heroes), the field size is printed (roughly one and a half creatures per hero: six for a party of four, seven past the Novice band), and the duplicate table in the ch22 quick reference was mirrored on the branch before merge. The gate was itself stale (it hard-coded the pre-#663 two-creature Standard) and was updated to the amended law; `rounds-to-resolve.py --selftest` passes both controls and the gate reads **3.79 / 3.68 / 3.36 rounds at Novice / Adept / Master, exit 0**, against 1.26 / 1.05 / 0.96 before, with no stat block, band, HP, Grit or DR number moved. | 2026-09-26 |
| 5 | Magic and the spell system | **OK on the core loop, BAD on learnability and cohesion.** 114 spell cards (68 arcane, 46 divine); one roll, three rungs, no slots. Bands discriminate from mod -2 to +3 (Weak 48.2% -> 4.6%); damage/DP 3.00 / 2.00 / 1.25. 32 of 114 cards print a damage row; 0 of them on a retired row, but the third band-change axis (flat printed numbers) was still unconverted: 7 of 7 ch17 item ladders + 5 ch05 Master riders, repaired this cycle. Two entry-point rules are unnamed or self-contradicted (the casting skill, the Adept cadence) and the 12-card Primal tradition has no item, no glossary entry, no class, and no place in the tradition rule. | 2026-09-26 |
| 6 | Social conflict | **GOOD on the extended conflict and the attitude ladder; BAD on two entry-point details.** Face modifier reaches -4 to +7; the conflict discriminates 12.4% -> 100% with a real coin flip at mod -2 (51.2%) and a duration that peaks at 4.02 rounds, on the pacing law's 3-4 through the playable middle. Scoring asymmetry (party scores on Standard, NPC only on Weak) is the pillar; the named cost is that a tense scene needs Challenge +2 or more. Defects: Passive Insight is a dead 5-9 score whose own paragraph uses the Knowledge modifier, and the worked example inverts the attitude-shift rule. | 2026-09-26 |
| 7 | Equipment | **OK.** No weapon carries a number and no gear adds one beyond DR; post-DR bands read 3/5/7, 3/6/9, 4/7/11 and the printed DR ceilings (3/4/6) sit exactly on the invariant boundary (DR <= Weak-1). Nothing stacks (ruling 145), shields are one source by Shield Block. All nine printed builds fit their slot budget (tightest: Lirael 5 of 5). Fails LEARNABLE on three unpriced item classes (shields, robes, thrown-weapon bundles) and carries one dominated row (the Crossbow: same 20/60 band as a thrown dagger plus a Loading Maneuver, for 2 slots). Two mirror residuals and a phantom gold economy repaired in this cycle's micro-PR (#679). | 2026-09-26 |
| 8 | Content (classes, disciplines, cards) | not assessed | |
| 9 | Bestiary and GM tools | not assessed | |

**Coverage: 7 of 9 subsystems, non-contiguous.** Rows 1-7 are assessed; the pacing pass took combat and
action economy early, on Bruce's ruling 165. Content (8) and the bestiary (9) are still open. Until the
table is full, the queue is a guess with good manners.

**Next (cycle 14):** audit whatever lands next, dispatch the equipment work order filed in cycle 13
(#680), then assess subsystem 8, content (classes, disciplines, the card library), with the bestiary (9)
last. Row 177's Catch Breath model gap still needs measuring before any pacing lever is chosen.

## Assessment 5 (first pass, superseded in the same cycle by the audited version below) - Magic and the spell system (cycle 8, 2026-09-26)

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

ch17 states the law it was breaking in its own header (`17:29`: "Damaging powers key to the damage
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
(4,3,3,3,4,3,3,3,3,3), one Discipline rank at levels 3/6/9, one attribute increase at 4/8 (`18:42-63`,
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
  `17:29` prints the live rows in the chapter's own header text, plus **5 Master abilities in ch05**
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

## Assessment 6 - Social conflict (cycle 12, 2026-09-26)

**Coverage: 6 of 9.** Instrument: `scripts/architect-social-census.py` (exact 3d6 enumeration over all
216 rolls; self-test asserts probabilities normalise, P(party) is monotone in the modifier and duration
peaks at the balanced point; a negative control re-runs the walk with the NPC scoring 2 on a Weak and
moves every row, so the walk reads the rule rather than baking it in).

**As printed.** Five social skills carry the chapter (`14:23-31`): Deception and Persuasion and
Performance on Guile, Intimidation on Brawn, Insight on Reason (`07:185-189`, mirrored at `22:205-208`).
Two resolution paths, and the book scopes them on both sides (`14:54`, `14:86`), so the older
"two tables with no scoping sentence" concern is **already repaired** - the single-roll path uses the
attitude ladder and the extended path uses the success table. Extended conflicts (`14:62-88`): the party's
face is the only scorer; every other player assists for a Boon and never a success; **the NPC never rolls**
and instead sets a Challenge from its own Knowledge modifier, negated (`14:68`) - which is ch06's Challenge
grammar, not an opposed roll. Tier to successes: Weak NPC +1, Standard party +1, Strong party +2, Critical
wins outright, Fumble NPC +2 (`14:75-79`). First to 3 takes the conflict (`14:88`).

**Numbers computed.**

| Face modifier | P(Weak) | P(Standard) | P(Strong) | E[rounds] | P(party wins) | P(NPC wins) |
|---|---|---|---|---|---|---|
| -4 | 74.1% | 25.9% | 0.0% | 3.75 | **12.4%** | 87.6% |
| -3 | 62.5% | 37.0% | 0.5% | 3.98 | 28.2% | 71.8% |
| **-2** | 50.0% | 48.1% | 1.9% | **4.02** | **51.2%** | 48.8% |
| -1 | 37.5% | 57.9% | 4.6% | 3.84 | 73.8% | 26.2% |
| 0 | 25.9% | 64.8% | 9.3% | 3.50 | 89.5% | 10.5% |
| +1 | 16.2% | 67.6% | 16.2% | 3.10 | 96.9% | 3.1% |
| +3 | 4.6% | 57.9% | 37.5% | 2.47 | 99.8% | 0.2% |
| +5 | 0.5% | 37.0% | 62.5% | 2.14 | 100.0% | 0.0% |
| +7 | 0.0% | 16.2% | 83.8% | 2.03 | 100.0% | 0.0% |

The reachable face modifier is **-4 to +7** (attribute -2..+2, skill 0..+3, Challenge +2..-2), and that
whole range is exercised above.

**Verdicts.**

- **Extended social conflict: GOOD.** It discriminates across its entire reachable range, 12.4% to 100%,
  with a genuine coin-flip at **mod -2** (51.2%) - reachable by an untrained talker facing a savvy NPC,
  which is exactly the exchange the table should make doubtful. Duration peaks at **4.02 rounds** at the
  balanced point and sits on the pacing law's 3-4 rounds straight through the playable middle (-3 to 0:
  3.98 / 4.02 / 3.84 / 3.50), so a social scene costs what a fight costs. The foregone conclusion at
  +5..+7 needs a maxed face **and** a dull NPC, which is the DA's choice of opposition, not the
  mechanic's failure - the same shape as a level-7 party against Challenge 1 monsters.
- **The attitude ladder: GOOD.** Strictly escalating - Hostile needs a Strong, Neutral a Standard,
  Friendly a Weak, Allied no roll at all (`14:44-47`) - so each step up the ladder costs less. No dead
  row: what changes at every step is the tier the NPC demands, so the higher tier does real work.
- **The scoring asymmetry is the pillar, not a defect, and it is named here as the trade it is.** The
  party scores on a Standard (64.8% of the mid range) while the NPC scores only on a Weak, so the party
  is ahead at *every* modifier and the NPC's only route to 3 is a run of Weak results. The consequence a
  DA must know: at mod +1 or better the NPC's win chance is under 3.1%, so **a scene the DA wants tense
  requires a Challenge of +2 or more**; the dial, not the dice, is the tension control. Grade OK rather
  than GOOD for that named cost.
- **Passive Insight: BAD.** Criterion **RANGE** (table-integrity class 4). Printed as a score,
  `Knowledge + 7` (`14:29`, `07:197`, `21:235`), it spans **5 to 9** because Knowledge spans -2..+2.
  Strong begins at 15, so the score reaches the top of its own ladder **0 times out of 5**, and nothing
  in the book consumes it as a target. The same paragraph gives the actual mechanic and it uses the
  Knowledge *modifier*, not the score: the liar's roll "carries a Challenge set by your Knowledge
  modifier, negated". **Smallest repair, no new rule:** state all three sites as that Challenge and
  retire the +7 score. This is not the rejected opposed-roll model (Bruce, on this exact defect: "the
  opposed roll isn't right, it should provide a modifier or banes"); the book's own Challenge grammar is
  already printed at the site and is what survives.
- **The worked example contradicts the shift rule it exists to demonstrate: BAD.** `14:88` is explicit -
  a Weak or Fumble shifts the NPC one step toward Hostile, **a Strong result shifts the NPC one step
  closer to you**, one shift per roll. The example shifts on Round 1's **Standard** ("her attitude shifts
  one step closer to you. Neutral to Friendly", `14:114`) and then does **not** shift on Round 2's
  **Strong** (`14:128`), inverting the rule in the book's own teaching instrument. **Smallest repair, no
  new rule and no change of outcome:** move the shift onto the Strong roll. The scene still ends with a
  Friendly warden; it just teaches the rule the chapter prints. Keeping the rule and moving the example
  is the right side of the trade because the rule is what makes Strong better than Standard in *two* ways
  (two successes *and* a shift), and widening the rule to "any success shifts" would flatten that to the
  success count alone.

**Coverage notes - what is NOT a defect (checked, so the next pass does not re-file them).**

- The chapter figure label `_Figure 16.1_` is **correct**. Hardcoded labels run file+2 across the book
  (13 to 15, 14 to 16, 15 to 17, 16 to 18, 18 to 20, 19 to 21), so 16 is this chapter's rendered number.
- Assists are capped by the Boon potence ladder (Boon 3 = 6d6), not unbounded, and each assist costs its
  player a turn; the spotlight cost is the balance.
- The DA rolling an NPC's Deception for a passive Insight is covered by `06` ("when no hero is involved
  at all, the DA rolls the Defense on the defender's behalf"), so it does not breach "players make all
  rolls".
- `ch19:205` and `ch22` mirror the social rules correctly (the Challenge, the tier table, first to 3,
  the stakes rule; GU/BR keys match ch07).

**Work order filed:** one issue covering both defects, batched because they are the same file group
(`14` + `07` + `21`). Dispatched next cycle - one work order per cycle is the cap, and this cycle's went
to the recurring-effect repair (#672/#676).

## Re-assessment 2026-09-26 (cycle 12) - "What matters now" rows 4 and 5 are both premised on the band, not on failure

Two rows sat in the queue marked "needs a ruling". Both are BALANCE questions with a derivable answer,
so both are decided here rather than carried; recorded beside the original rows per the re-assessment
rule, never overwritten.

- **Row 4, the difficulty dial's asymmetry (Trivial +4 to Nearly Impossible -6): NOT a defect.** The
  asymmetry is load-bearing, not drift. A Master specialist reaches mod +5 (attribute +2, skill +3), and
  a **symmetric** +/-4 dial would leave that hero unfailable on every dialled task, because +5 - 4 = +1
  still means P(Weak) of 16.2%. The -6 end exists to make exactly that hero's task a coin flip
  (+5 - 6 = -1, P(Weak) 37.5%). The dial is also wider than the dice on purpose (10 points against a
  3d6 spread of about +/-5), which is what lets a DA challenge a maxed specialist without touching the
  bands.
- **Row 5, "failure collapse at the top": premise corrected, NOT a defect.** The row measured the Weak
  *band* and reported it as failure. At mod +5 the Weak band holds exactly one of the 216 rolls, and
  that roll is (1,1,1) - the fumble; at mod +6 the band is empty. But the fumble is an **automatic
  failure that overrides the tier** (`06:161/189`, `13:358/362`, and unconditional at `01:105`,
  `07:57-58`, `21:33-35`, `22:28-29` - six homes to one scoping clause). So **P(failure) is flat at
  1/216 at +5 and at +6**, and it never reaches 0. What actually retires at +6 is the *ordinary* failure,
  which is precisely what mastery means. The success bands still discriminate at +5 (Standard 37.0%,
  Strong 62.5%), so the outcome space is not a foregone conclusion either. No number changes.

## Assessment 7 - Equipment and gear (cycle 13, 2026-09-26)

**Coverage: 7 of 9.** Instrument: a fresh parse of `origin/main` (ch15 340 lines, ch16 147, ch22's
equipment sheets, the 76 card `Requires:` lines in ch09/ch11/ch12, and all nine printed builds' equipment
lines). Every count below comes from the file.

**The mechanic as printed.** Equipment carries no damage of its own: `15:82`, "Gear adds no number beyond
DR ... Cards are damage ... No separate damage dice." Four weapon categories at 1 rank each and 17 weapon
rows; armor by weight class (DR 1/2/3, 2-4 slots); shields by size class (`16:80-90`: 1/2/3 Shields,
shield DR 1/2/3); 38 adventuring-gear rows priced in slots; 17 packs; mounts and vehicles as stat blocks.
Every card that asks for gear names exactly one of 8 `Requires:` tags. Gear is granted, earned, or taken.

**PROMISE - GOOD.** The three-part law is delivered without exception. No weapon row carries a number of
any kind (the weapon table has no Cost and no damage column), so the choice is category, properties and
fiction. The only numbers a possession adds are DR (armor) and its own slot cost. The Charge-from-mount
benefit is a damage TIER bump (`15:272`, +1 tier), the sanctioned convention, not a flat rider. Vehicles
express positional protection as COVER (chariot sides and rear, the armored upgrade, `15:330-332`), never
as DR, which is the positional-protection law holding under the subsystem most tempted to break it.

**RANGE - GOOD, and measured at both ends.** With the tier's own armor DR (1/2/3) the live bands read:

| Tier | Band | Post-DR with the tier's armor | Invariant (DR <= Weak-1) | Printed ceiling |
|---|---|---|---|---|
| Novice | 4/6/8 | 3/5/7 | <= 3 | 3 |
| Adept | 5/8/11 | 3/6/9 | <= 4 | 4 |
| Master | 7/10/14 | 4/7/11 | <= 6 | 6 |

Three distinct tiers survive the subtraction at every level, and the printed ceiling is exactly the
invariant's boundary at all three (3 = 4-1, 4 = 5-1, 6 = 7-1). Nothing stacks: `15:137`, `16:23`, `16:27`,
`22:248`, `22:361`, `22:388` and all four DR cards agree (Bark/Stone/Iron Skin each print "does not stack
with any other source of DR"), which is ruling 145 in the manuscript ("as a rule armor DR does NOT stack
period"). Shield DR is a separate channel applied by Shield Block, reduced to one source, so the old
additive-shield collapse at Master no longer exists. The floor-1 rule is not load-bearing anywhere in this
subsystem: no printed combination reaches a band's Weak value.

**Slots, measured across all nine printed builds.** Budget `10 + Brawn x 5` with a floor of 5
(`15:160`). Slot costs are read from the tables: weapons 1 (two-handed 2), armor 2-4, gear per the
38-row table.

| Build | Brawn | Budget | Load | Note |
|---|---|---|---|---|
| Lirael | -1 | 5 | 5 | exactly at the floor once robes are priced |
| Haldra | -1 | 5 | 4 | |
| Pip | +0 | 10 | 9 | 15 if each throwing dagger is an item rather than a bundle |
| Sera | +0 | 10 | 5 | |
| Makeva | +1 | 15 | 7 | |
| Marta | +1 | 15 | 5 + shield | |
| Vaelith | +1 | 15 | 5 | |
| Corwin | +1 | 15 | 10 | six reagent vials at 1 slot each |
| Gorma | +2 | 20 | 7 + shield | |

Every printed build fits under the book's own conventions. The tightest is Lirael at 5 of 5, and that
tightness is itself a finding: it pins the price of a worn garment at 1 slot (2 would put a printed build
over budget), which is the value the work order uses.

**DISCRIMINATION - OK.** The weapon table is a spread of identity options, and `15:82` says so in as many
words ("Pick the weapon that fits your hero, not the one that looks best on paper. They all hit the
same"). Measured: 6 of the 17 rows carry no property at all (Mace, Battleaxe, Warhammer; Greatsword,
Greataxe, Maul), so they are interchangeable with each other and option-dominated by a same-category peer
at identical entry cost. That is the stated design, not a defect. **One row breaks the reading.** The
Crossbow prints the same 20/60 band as a thrown dagger while costing 2 slots (Two-Handed) and a Maneuver
between shots (Loading, its own property), and the Throwing Dagger costs the same single Ranged rank, 1
slot, prints the same band and pays no penalty; the Shortbow (60/120) and Longbow (100/200) outrange it.
Nothing anywhere in the book gives a crossbow a compensating benefit (ch08 lists crossbows in the Ranged
discipline, ch21 and ch22 repeat the property and the band, and no card, talent or rule names one).
`21:123`/`21:131`/`15:131` also fix the two flavour properties (Versatile, Loading) to a single named
weapon each, so the table has exactly one drawbacked weapon and it is the dominated one.

**LEARNABLE - the criterion that fails, in one place.** The slot system prices every item class it lists,
but **three item classes that the book and its own printed builds carry have no price at all**: a shield
(no Slots column in `16`, `22` or `15` - a hero may carry twenty tower shields for nothing), scholar's
robes (in three printed equipment lines, `02:362`, `02:403`, `02:641`, and in no table anywhere), and a
bundle of thrown weapons (Pip's "throwing daggers (6)" reads 1 slot by the ammunition convention the table
already uses for Arrows and Bolts, or 15 by the per-item reading, and the book never says which). Work
order filed (#678) with the derived values.

**COST - the reverse finding, recorded so no future pass re-files it.** The `Requires:` vocabulary is
clean: 8 tags rostered at `15:26-33`, 8 consumed, 76 card-level tags and 0 orphan tags, 0 rostered tags
with no consumer. 59 of the 114 spell cards carry a focus tag, matching the focus-downgrade count already
measured at row 175. The pack table's 17 `Tag` cells look like the same vocabulary but are referenced only
by `21:77` as names; they gate nothing, which reads as deliberate (a pack is a capability) and is not
re-filed.

**STRESS - the subsystem survives its adversarial cases.** The free Adventurer's Pack carries no rope,
pitons, picks or charts by design (`15:48`) so "we forgot the rope" stays legal; the exempt container is
one container at a time and containers do not nest (`22:460`); barding's numbers are a mount stat block and
stay out of the hero-DR sweep (`15:259`, DR scope law); a mount at 0 HP is survived by an Agility check at
Standard. No degenerate loop found: nothing in the tables generates a resource, and the only stacking
opportunity the subsystem offers (many shields) is closed by `16:90` (the -5 ft Speed applies once) and by
Shield Block's one-attack-per-round cap.

**Verdict: OK.** The subsystem delivers its pillar, holds the DR invariant at both ends with the printed
ceilings landing exactly on the boundary, and fits every printed build. It fails LEARNABLE on three
unpriced item classes and carries one dominated weapon row; both are table edits with derived values, and
both are specced in #678. Two mirror residuals of already-ruled directions were corrected in this cycle's
micro-PR (#679): the `weapon:two-hand` tag still demanded 2 Two-Handed after the requirements sweep closed
that direction, and `15:123`/`15:154` still described the retired two-size shield model. A third claim went
with them: `15:44` and `21:27` promised a gold economy the book does not have (0 prices, 0 coins, 0
starting wealth in all 25 chapters), against `15:15`, `15:239` and `19:73`'s "granted, earned, or taken".
