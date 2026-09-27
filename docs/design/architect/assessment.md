# System assessment — the whole game, from the foundation up

**Owner:** the architect cycle. Method: `references/system-assessment.md`.
**Rule:** assess the whole before ordering the work. The ledger records what has been DECIDED, never
that what exists is good.

## What matters now

*Ranked by severity of failure x how much of the book depends on it. This is the queue's source.*

| # | Item | Why it outranks everything | Status |
|---|---|---|---|
| 1 | **The price of a card is stated two ways, and creation teaches the wrong one** | `02:204` (Step 7) and `22` (DP Cost Reference) both say cards cost "2/4/8 DP regardless of class", while `08:178` says "the flat card DP cost is only part of the price: you also pay rank costs for any required Disciplines you do not already possess". The true price of a Novice card is **2 to 6 DP** (held / Home / Adjacent / Foreign / Opposed). Every build budgeted from creation's own steps underfunds by the rank costs, which is the measured cause of priority 5's 26 DP shortfall. | **measured 2026-09-26 (cycle 3)**; fix is a sentence, so it is a work order, not a ruling |
| 2 | **The Shepherd cannot pay for its own loadout and a card** | `05:202` prints 7 DP of loadout ranks and claims "which still leaves room for a card"; the class pool is 8 DP (`02:204`) and a Novice card is 2 DP, so the line costs **9 DP**. Eight of nine classes close; the Shepherd does not. | needs a ruling (ledger row 166) |
| 3 | **The difficulty dial is asymmetric** | Trivial +4 down to Nearly Impossible -6. More room to make things hard than easy. Combined with a competent hero at +3, a Trivial task cannot fail. Deliberate or drift? Unruled. | needs a ruling |
| 4 | **Failure collapse at the top of the range** | At mod +5 (Master: attr +2, skill +3) P(Weak) = 0.46%, 1 in 216. At +6 it is mathematically 0. A master cannot fail a Standard task, so the "succeed with a catch" band stops existing for them. May be intended (that is what mastery means) but it must be stated as intent. | needs a ruling |
| 5 | **Creation's printed builds are unfunded and the skill ledger never closes** | 7 of 9 printed heroes cannot pay for the gear their own loadout requires (26 DP); all 9 spend 2 DP on the skill their culture already grants +1 in (18 DP). The root cause of the first is now measured: priority 1. **Cycle 7: the level-1 grant that creation never awards (priority 10) would pay 6 of those 7 builds, cutting 26 DP to 2.** | rows 161/162; one word each |
| 6 | **Master is not an efficiency tier, and nothing says so** | Cards cost 2/4/8 while the bands are 4/6/8, 5/8/11, 7/10/14: damage per DP falls **3.00 -> 2.00 -> 1.29** with ranks already paid. The premium buys per-action impact and a once-per-session spotlight (`10:101`), which is a real thing to buy, but a player optimising damage per DP will buy breadth and be right on the numbers. | needs a ruling (ledger row 167) |
| 7 | Fate unpriced / Summon uncarded | Advertised, unusable. Ruled, specced, undispatched (rows 125/151, issue #655). | work order filed |
| 8 | ch09 tier-labelled headings | Three cards titled "Novice Talent" whose requirements are Adept and Master (row 160). Player-facing promise defect. **Cycle 7: the tier RULE itself was the larger half of this - `09:15` keyed tier to the count of Disciplines, mispricing 59 of 102 cards; fixed in #665. The three cards remain.** | row filed; rule fixed |
| 9 | **Fortitude and Knowledge pay twice** | Each point adds +1 HP (`03:78`) and +1 Background DP (`02:115`). No other attribute feeds a pool. At +2/+2 against -2/-2 that is 8 DP and 4 HP on the same two points, and at -2/-2 the hero has 6 HP and 4 DP (Assessment 3). | needs a ruling (ledger row 168) |
| 10 | **Every level-1 hero is 4 DP short of the book's own career total** | `18:66` grants 4 DP at level 1 with "Class signature, Starting Disciplines" as its milestones (creation's own grants), and `22:272` counts it inside the printed 44-52 DP career. Creation's eleven steps (`02:43-275`), `22`'s checklist and all nine printed builds assign only 8+K+F and 8. | needs a ruling (ledger row 169) |
| 11 | **The healing axis was never converted to the live rows** | The 2026-09-15 band change was verified with slash-triples, which is how damage prints; a healing card prints one HP per line. Four cards were still on the retired rows (fixed in #665, 4 -> 0) and three items still need a ruling: a recurring heal whose per-round figure cannot total its own row, two Adept cards printing the Master row, and an untiered critical-effect heal. | rows 170/171 |

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
| 5 | Magic | not assessed | |
| 6 | Social conflict | not assessed | |
| 7 | Equipment | not assessed | |
| 8 | Content (classes, disciplines, cards) | not assessed | |
| 9 | Bestiary and GM tools | not assessed | |

**Coverage: 4 of 9 subsystems, non-contiguous.** Rows 1, 2, 3 and 4 are assessed; the pacing pass took
combat and action economy early, on Bruce's ruling 165. Magic (5), social (6), equipment (7), content
(8) and the bestiary (9) are still open. Until the table is full, the queue is a guess with good manners.

**Next (cycle 8):** subsystem 5, magic and the spell system - the next in dependency order, and the
place the two flagged healing items (rows 170/171) live. The HoT question is a magic-system question
before it is a card question: the recurring-effect convention and the live bands cannot both hold, so
the assessment must decide whether the per-round figure, the duration or the total is the graded
quantity. Then social conflict (6), equipment (7), content (8), bestiary (9). The pacing row 165 still
carries its chosen lever and needs nothing from the ledger except the dispatch gate.

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
