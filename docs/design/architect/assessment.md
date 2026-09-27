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
| 5 | **Creation's printed builds are unfunded and the skill ledger never closes** | 7 of 9 printed heroes cannot pay for the gear their own loadout requires (26 DP); all 9 spend 2 DP on the skill their culture already grants +1 in (18 DP). The root cause of the first is now measured: priority 1. | rows 161/162; one word each |
| 6 | **Master is not an efficiency tier, and nothing says so** | Cards cost 2/4/8 while the bands are 4/6/8, 5/8/11, 7/10/14: damage per DP falls **3.00 -> 2.00 -> 1.29** with ranks already paid. The premium buys per-action impact and a once-per-session spotlight (`10:101`), which is a real thing to buy, but a player optimising damage per DP will buy breadth and be right on the numbers. | needs a ruling (ledger row 167) |
| 7 | Fate unpriced / Summon uncarded | Advertised, unusable. Ruled, specced, undispatched (rows 125/151, issue #655). | work order filed |
| 8 | ch09 tier-labelled headings | Three cards titled "Novice Talent" whose requirements are Adept and Master (row 160). Player-facing promise defect. | row filed |
| 9 | **Fortitude and Knowledge pay twice** | Each point adds +1 HP (`03:78`) and +1 Background DP (`02:115`). No other attribute feeds a pool. At +2/+2 against -2/-2 that is 8 DP and 4 HP on the same two points. | needs a ruling (ledger row 168) |

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
| 3 | Creation and progression | not assessed | |
| 4 | Combat and action economy | **BAD (pacing).** An even fight, read from the book's own encounter rule, resolves in ~1 round at every tier; root cause is a premise mismatch between `19:53` and `20:659`. Re-assessed and re-costed cycle 5. | 2026-09-26 |
| 5 | Magic | not assessed | |
| 6 | Social conflict | not assessed | |
| 7 | Equipment | not assessed | |
| 8 | Content (classes, disciplines, cards) | not assessed | |
| 9 | Bestiary and GM tools | not assessed | |

**Coverage: 3 of 9 subsystems, non-contiguous.** Rows 1, 2 and 4 are assessed; the pacing pass took
combat and action economy early, on Bruce's ruling 165, leaving creation and progression (row 3)
unassessed. Until the table is full, the queue is a guess with good manners.

**Next (cycle 5):** subsystem 3, creation and progression - unchanged as the sweep's next act, and
still inheriting the same measured dependency: Assessment 2 shows the rank supply is 3 picks and the
class pool is 8 DP, so the question "can a leaner hero be built at all, and does a level ever arrive
with nothing worth buying" is answerable from the same tables, and it closes priorities 2 and 5
together. The pacing row 165 now carries a re-costed lever set and needs one word from Bruce.

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
