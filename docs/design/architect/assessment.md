# System assessment — the whole game, from the foundation up

**Owner:** the architect cycle. Method: `references/system-assessment.md`.
**Rule:** assess the whole before ordering the work. The ledger records what has been DECIDED, never
that what exists is good.

## What matters now

*Ranked by severity of failure x how much of the book depends on it. This is the queue's source.*

| # | Item | Why it outranks everything | Status |
|---|---|---|---|
| 1 | **The price of a card is stated two ways, and creation teaches the wrong one** | `02:204` (Step 7) and `22` (DP Cost Reference) both say cards cost "2/4/8 DP regardless of class", while `08:178` says "the flat card DP cost is only part of the price: you also pay rank costs for any required Disciplines you do not already possess". The true price of a Novice card is **2 to 6 DP** (held / Home / Adjacent / Foreign / Opposed). Every build budgeted from creation's own steps underfunds by the rank costs, which is the measured cause of the 26 DP shortfall at rank 9. | **LANDED 2026-09-26 (cycle 15): PR #687, `main` `1c06fa0`.** The card's true price is stated at all three sites, with the five figures re-derived from ch08's own rate table and matching its printed worked example. The dispatch gate caught that a quarter of the work order had already landed. |
| 2 | **The casting procedure names a field it never defines** | `10:31` says every spell rolls `3d6 + Knowledge` (arcane) or `+ Reason` (divine) "plus **relevant skill**"; the phrase appears twice in the book and is defined nowhere. **114 of 114 spell cards name no skill**, no ch07 skill entry says "casting", and the only mapping anywhere is inside one worked example (`10:123`, Arcana). A player cannot cast a spell from the book alone, and a divine caster is told to pair a Reason roll with a Knowledge-keyed skill. | **work order filed as #668**; dispatch gate run 2026-09-27 (cycle 18) - cites corrected (`10:75` -> `10:77`), and the primal attribute, which the work order never fixed, is DECIDED: Knowledge + Arcana / Reason + Religion / Reason + Nature. **LANDED 2026-09-27 (cycle 18): PR #692, `main` `76e5f98`** (row 172 records the landing; this cell read "Dispatch-ready" a cycle after the merge). |
| 3 | **Primal is a half-built tradition: 12 cards, 5 requirements, 0 items, 0 glossary entries, 0 classes** | 12 cards are titled "Primal Spell" and 5 requirements ask for `focus:primal`, but ch15 carries no primal focus item, ch21 no entry, ch05 no mention, and ch10 declares only two traditions. `12:359`/`12:370` are titled Divine and demand a primal focus. "Primal" already names a discipline category (Animal, Plants). A listed thing that cannot be bought or cast is the Cohesive criterion failing outright. | **work order filed as #668**, amended 2026-09-27 (cycle 18) after the dispatch gate: primal focus item, glossary entry, tradition sentence, and the two cards whose titles contradict their own Requires field - **the repair is the TITLE (Divine -> Primal), reversed from the original focus change**; see the reversal evidence in Assessment 5. **LANDED 2026-09-27 (cycle 18): PR #692, `main` `76e5f98`** (row 173 records the landing). |
| 4 | **The difficulty dial is asymmetric** | Trivial +4 down to Nearly Impossible -6. More room to make things hard than easy. Combined with a competent hero at +3, a Trivial task cannot fail. Deliberate or drift? Unruled. | **DECIDED 2026-09-26 (architect, cycle 12) - BALANCE, not a Bruce question; veto to revert.** Not a defect: the asymmetry is load-bearing. A Master specialist reaches mod +5, and a *symmetric* +/-4 dial leaves that hero unfailable on every dialled task (+5 - 4 = +1, P(Weak) still 16.2%); the -6 end exists to make exactly that hero's task a coin flip (+5 - 6 = -1, P(Weak) 37.5%). The dial is deliberately wider than the dice. **No number changes.** Evidence: Assessment 6 re-assessment section. |
| 5 | **Failure collapse at the top of the range** | At mod +5 (Master: attr +2, skill +3) P(Weak) = 0.46%, 1 in 216. At +6 it is mathematically 0. A master cannot fail a Standard task, so the "succeed with a catch" band stops existing for them. May be intended (that is what mastery means) but it must be stated as intent. | **DECIDED 2026-09-26 (architect, cycle 12) - premise corrected, NOT a defect; veto to revert.** The row measured the Weak *band* and reported it as failure. The Weak band at +5 holds exactly one roll of 216 and that roll is (1,1,1), the fumble; the fumble is an automatic failure that **overrides the tier** (`06:161/189`, `13:358/362`, unconditional in six homes to one scoping clause). So **P(failure) is flat at 1/216 at +5 and +6 and never reaches 0**; what retires at +6 is the *ordinary* failure, which is what mastery means. Bands still discriminate at +5 (Standard 37.0%, Strong 62.5%). **No number changes.** |
| 7 | **The Adept cadence is stated two ways** | `10:99` says "Adept and Master spells can only be used once per combat. You can't drop an Adept spell every round", while the chapter's own worked example reads the limit as **per card** (`10:127`). Per-card, a level-7 caster holding four Adept cards casts one every round, which is the outcome the sentence forbids; per-tier, the second Adept card is near-dead content. The whole spotlight economy turns on which. | **IMPLEMENTED DEFAULT 2026-09-26 (cycle 13), veto to revert: PR #681, `main` `b08afb0`** - the Adept limit is per card (the book's own worked example at `10:129`) and the false justification sentence is gone. The other reading (one Adept spell per fight) stays available with one word. |
| 8 | **The Shepherd cannot pay for its own loadout and a card** | `05:202` prints 7 DP of loadout ranks and claims "which still leaves room for a card"; the class pool is 8 DP (`02:204`) and a Novice card is 2 DP, so the line costs **9 DP**. Eight of nine classes close; the Shepherd does not. | **DECIDED and IMPLEMENTED 2026-09-26 (cycle 9 ruling; PR #674, `5c52f12`)** - every ledger re-derives and all nine builds close at their named pool. The Shepherd's printed "still leaves room for a card" is false at 8 DP and true at the 12 the book's own `18:47` grants. |
| 9 | **Creation's printed builds are unfunded and the skill ledger never closes** | 7 of 9 printed heroes cannot pay for the gear their own loadout requires (26 DP); all 9 spend 2 DP on the skill their culture already grants +1 in (18 DP). **Cycle 7: the level-1 grant that creation never awards would pay 6 of those 7 builds, cutting 26 DP to 2.** | **BOTH CLOSED 2026-09-26**: 161 retracted in place (the armour gate was the wrong premise), 162 decided in cycle 9 and IMPLEMENTED in PR #674 (`5c52f12`) - the culture's +1 IS that skill's Novice tier, so the purchase was explicit waste. |
| 10 | **Master is not an efficiency tier, and nothing says so** | Cards cost 2/4/8 while the bands are 4/6/8, 5/8/11, 7/10/14: damage per DP falls **3.00 -> 2.00 -> 1.25** with ranks already paid. The premium buys per-action impact and a once-per-session spotlight (`10:101`), which is a real thing to buy, but a player optimising damage per DP will buy breadth and be right on the numbers. | **DECIDED 2026-09-26 (architect, cycle 9), veto to revert** - state the intent in one sentence, no reprice: a reprice would break invariant 4 (cards cost 2/4/8). |
| 11 | Dead ranks: Fate unpriced, Summon uncarded, **and Sleight rank 2 unconsumed** | Advertised, unusable. **All three are closed.** Fate **landed** (PR #696, 2026-09-27); Summon **landed** (PR #699, 2026-09-27, six cards, rank coverage 1x2 / 2x2 / 3x2); Sleight **closed** (PR #684, `ecc59f7`, Filch re-keyed to `1 Stealth, 2 Sleight`). Every one of the 23 Disciplines now has a consumer at rank 1 and 2, and the scorecard's dead-rank line reads 0. | Fate: #655 (merged). Summon: #698 (merged). Sleight: #684 (merged) |
| 12 | ch09 tier-labelled headings | Three cards titled "Novice Talent" whose requirements are Adept and Master (row 160). Player-facing promise defect. **Cycle 7: the tier RULE itself was the larger half of this - `09:15` keyed tier to the count of Disciplines, mispricing 59 of 102 cards; fixed in #665. The three cards remain.** | **LANDED 2026-09-27 (architect, cycle 21) - PR #700, `main` `4cca6ab`.** Re-derived rather than trusted: the class is **four** cards, not the three this row recorded (`Borrowed Eye`, `09:179`, `1 Tactics · 1 Mind` = 2 ranks, was invisible to the original instrument). All four retitled and relabelled to their requirement tier; `scripts/tier-census.py` now reads **114/114** agreement (was 110/114). |
| 13 | **The focus downgrade has no defined bottom for most cards** | `15:40`/`21:217` end the ladder "Weak becomes **1 damage**" - a clause that only means something if the rung is damage. **23 of the 59 focus-carrying cards have a non-damage Weak rung**, and on a heal it inverts (Mending Touch's "Restore 4 HP" becomes 1 damage). | **LANDED 2026-09-27 (architect, cycle 19) - PR #695, `main` `db7bb8f`, issue #694 closed** (row 175): scope the downgrade's floor to the card's own rungs, keep `1 damage` for damaging rungs, then `10:37` keys to the tier's row where the card deals damage or healing. This cell read "default logged, not implemented ... rides with #668's file group" for two cycles after the merge. |
| 14 | **Fortitude and Knowledge pay twice** | Each point adds +1 HP (`03:78`) and +1 Background DP (`02:115`). No other attribute feeds a pool. At +2/+2 against -2/-2 that is 8 DP and 4 HP on the same two points, and at -2/-2 the hero has 6 HP and 4 DP (Assessment 3). | **CLOSED 2026-09-26 (architect, cycle 9) - measured, premise partly false, no change owed.** Fortitude and Knowledge are the only pool-feeding pair and the duplication is the deliberate trade. |
| 15 | **Every level-1 hero is 4 DP short of the book's own career total** | `18:47` grants 4 DP at level 1 with "Class signature, Starting Disciplines" as its milestones (creation's own grants), and `22:272` counts it inside the printed 44-52 DP career. Creation's eleven steps (`02:43-275`), `22`'s checklist and all nine printed builds assign only 8+K+F and 8. | **DECIDED and IMPLEMENTED 2026-09-26 (cycle 9 decision; PR #674, `5c52f12`)** - `18:47`'s level-1 4 DP award is real and is exactly the size of the hole creation never showed. |
| 16 | **The healing and flat-number axes** | Healing was never converted to the live rows (4 cards, fixed in #665; 3 items still need a ruling - rows 170/171). **Cycle 8 closed the third axis: 7 of 7 ch17 item ladders and 5 ch05 Master riders were still on the retired rows and are now on the live ones.** | **BOTH CLOSED 2026-09-27 (architect, cycle 21).** Rows 170 (healing axis) and 171 (recurring convention) are closed: items (1) and (2) of row 170 landed in PR #676 and item (3) measured as conforming, and row 171's "grade the total, the per-round figure paces it" is implemented on Flesh Renewal; `scripts/heal-row-census.py` reads **0 cards on a retired row**. The flat axes are fixed. Third axis (ch17 item ladders + ch05 class grants) closed in cycle 8. |
| 17 | **Social conflict: a dead score, and an example that inverts its own rule** | (a) **Passive Insight is a number nothing consumes** - printed as `Knowledge + 7` in three homes (`14:29`, `07:197`, `21:235`), it spans 5 to 9 and reaches Strong 0 times out of 5, while the same paragraph's actual mechanic uses the Knowledge *modifier* as a Challenge. (b) **The worked example applies the attitude shift on a Standard and skips it on the Strong** (`14:114` vs `14:88`/`14:128`), inverting the rule it demonstrates. Both are the smallest possible repair with no new rule. | **MERGED 2026-09-26 (cycle 13): PR #678, main `f0c9af3`, issue #677 closed.** Six sites across 3 files, audited line by line and verified in the render: "Knowledge score + 7" reads 0 in the built PDF, both new Challenge clauses read 1-2, and the worked example's 13 / 13 / 18 and 1+2=3 are unchanged. |
| 18 | **Three item classes the slot system cannot price, and one dominated weapon row** | (a) A **shield** has no slot cost anywhere (`16`, `22`, `15`): twenty tower shields ride free. Derived value, mirroring the class ladder the shield already uses for entry and DR: small 1 / medium 2 / large 3. (b) **Scholar's robes** sit in three printed builds (`02:362`, `02:403`, `02:641`) and in no table: 1 slot, which is the only value that keeps the tightest build legal (5 of 5 at the floor). (c) A **bundle of thrown weapons** is unpriced (Pip: 9 of 10 as one item, 15 as six). (d) The **Crossbow** prints a thrown weapon's 20/60 band while paying 2 slots and a Loading Maneuver, so the Throwing Dagger dominates it on every printed axis; its band moves to 60/120, the bow ladder's next step, and Loading stays as the identity price with the trade named. | **MERGED 2026-09-27 (cycle 14): PR #682, main `aaab1ca`, issue #680 closed.** Audit re-derived every site: file set exactly the three chapters, 0 em-dashes / 0 dice / 0 retired rows in added lines, native gate exit 0, independent build exit 0, render verified (392 pages, `60/120 ft` 6, `Robes` 2, new `Slots` column present, both bundle sentences). Regression check for the new shield slot cost against every printed build carrying a shield: 02:483 is 8 of 15, 02:600 is 9 of 20, the Protector loadout 8 against a Brawn-keyed pool - all fit, and the tightest build in the book (02:403, 5 of 5) carries no shield. One spec-authored redundancy fixed on the branch (the ladder was restated twice). |
| 19 | **The bestiary's HP rule counts three rounds of ONE attacker, so a solo creature is not a fight** | `20:659` says "HP = 3 x (your tier's band average minus its DR)" without naming who it is counted against. Measured against the corpus it is one attacker: the 49 blocks average ~1.5 creatures per hero, so each is attacked about once a round. Against a party of four a printed creature dies in **~0.75 rounds**. That is why the pacing window has to be bought with creature COUNT (`19:53`'s six-to-seven), and it is the arithmetic root of row 177's pool collision. It also makes the book's own starter-adventure climax a one-round fight: **Kelvath, the Drowned Warden (`19:335`), HP 8, DR 3, no Multiattack - party output through DR 3 is 13.9 a round, so he dies at 0.58 rounds**, and his scene's 1d4+1-round seal clock, three tactical options and flooding timer can never happen. | **DECIDED 2026-09-27 (cycle 15) - BALANCE, architect, veto to revert.** Name the unit in one sentence at `20:659` and its template mirror ("multiply by the number of heroes who will attack it"), then Kelvath HP 8 -> 32 (3 x 2.67 x 4 attackers), putting his fight at 2.3 rounds inside his own scene's 2-5. No band, no DR and no corpus HP moves: the 49 printed blocks already sit at ~1 attacker each. Work order **#686**, MERGED cycle 17 as **PR #689** (`main` `26a5be3`). **Cycle 17 correction to this cell's recorded wording:** the first form ("multiply by the number of heroes who will attack it") reads as the party ROSTER and would hand a DA six creatures at 4x HP (60 each, a 15-round fight), since in a six-creature fight every creature is attacked by all four heroes across the scene. The delivered text multiplies by the **rate** - attackers per round - which is what the formula counts: "Those three rounds are counted per attacker, so multiply the result by the number of attackers the creature faces each round: about one for a creature standing in a group, one per hero for a creature that fights the party alone." Reversal: delete the sentence, restore 8. |
| 20 | **The difficulty ladder's words are not its measured fractions** | Pool = HP x (Grit+1) per hero per respite (`13:341-347`), plus Catch Breath (`13:69`, a MANEUVER restoring ceil(max HP/3), Grit uses per combat: +8/+12/+16 HP per hero per combat). Measured spend across the whole ladder: **Easy 49/53/49 %, Standard 73/80/73 %, Hard 97/106/98 %, Deadly 146/160/147 %**. The shape is right (monotone, evenly spaced, exactly proportional to the 1/1.5/2/3 multipliers, and the top two rungs match their words), but `19:50`'s "Easy ... costs few resources" is really half the day and "the party should win while expending some resources" is really most of it. | **DECIDED 2026-09-27 (cycle 15) - BALANCE, architect, veto to revert.** Smallest lever is the frame: one sentence naming the pool and each rung's measured fraction, the four rung descriptions restated in that currency, plus `19:53`'s own two-quantity fact (total encounter HP sets the fight's LENGTH, creature count sets the drain). No band, HP, DR, Grit or #663 number moves. **LANDED 2026-09-27 (cycle 16): PR #688, `main` `e426c94`** - the four rung phrases now read "about half the day / about three quarters / the whole day / more than a day" against the gate's 49 / 73 / 97 / 146 percent. Reversal: restore the four rung phrases, delete the pool sentence. |

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

**MEASURED 2026-09-27 (architect cycle 37), and the answer is that it does not compound. Verdict: GOOD,
unchanged.** New instrument `scripts/wound-spiral.py` (parses the two D666 tables out of `origin/main`,
enumerates the outcome space, classifies every row's effect, and walks the pool against the band's own
stat blocks; `--selftest` carries the reversal oracle below plus a planted-deletion control).

| quantity | measured |
|---|---|
| D666 coverage | **56/56** reachable outcomes mapped, 0 gaps, 0 ambiguous, 0 empty rows |
| any effect per Grit spend | 78.2% impose something; **0.9%** impose nothing |
| sustained DEFENCE-roll Bane | **11.1%** per spend (Cracked Ribs 9.7% + Shattered Spirit 1.4%) |
| P(>=1 such Bane) | 11% / 21% / 30% / 38% after 1 / 2 / 3 / 4 spends |
| tax per source | **~0.3 rounds** of pool life, and the potence cap is **3** (`06:63`) |

Rounds of pool life against the Standard encounter's own creatures, unwounded -> at the potence ceiling:
Novice **5.2 -> 4.1** (fight clears in 3.79), Master **4.1 -> 3.3** (3.27), Adept **4.2 -> 3.3** (3.73).
Novice and Master clear at every potence they can reach. Adept is the one tail: it opens at potence 2
(3.5 rounds vs 3.73) and needs **2 of the 11.1% events** inside 3 Grit spends, i.e. **3.4% of heroes**,
and only once every Grit is gone. **No hero is dropped while holding Grit**, which is the test that
matters: the printed failure condition is `13:346` (0 HP with no Grit left), so a drop after exhausting
Grit is the design working rather than a spiral. **Nothing on the Wound Table needs to move.**

Two facts found while measuring, both reported rather than fixed:

- **The row that carries the whole tax was scope-ambiguous.** `13:395` keyed its Bane to "physical rolls",
  a token printed **once in the book** and never defined for a roll; `ch07:134` groups skills as
  Physical/Knowledge/Social/Subterfuge/Crafting, so the reading covers a Dodge or Parry Defense Roll but
  **not** the attribute-only roll at `06:103`. Fixed as PR #730 (cycle 37), naming the three physical
  attributes the book already prints. The same token at `11:56` ("next physical action") was fixed with it.

- **The monster direction of `rounds-to-resolve.py` is mapped the attacker's way, not the book's.**
  `06:115` and its table at `06:122` reverse the Defence Roll (a Weak defence roll reads the attacker's
  Strong value); the gate reads the distribution forward, so its `E[dmg]` column is `5.66 / 7.44 / 9.49`
  where the book's mapping with the band's own Challenges gives `4.90 / 7.42 / 9.96` for an untrained
  defender and `4.57 / 6.49 / 8.36` trained. **The verdict does not move** (within 13% at the untrained end, and the
  window is set by the clear direction, which is mapped correctly), so this is an erratum to record, not a
  repair to rush: the gate's hits-to-fall is right in level and mildly wrong in shape (its flat 5.8 / 5.9 /
  5.8 becomes ~7.2 / 6.8 / 6.6 at HP 11 for a trained defender, drifting down instead of sitting flat).

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
| 8 | Content (classes, disciplines, cards) | **GOOD.** 196 cards + 90 class abilities = 286 containers, exactly 10 abilities per class; tier split 51 / 52 / 64 / 25 (+4 five-rank capstones); career budget 6 ranks against a deepest printed requirement of 5. Four law gates across nine content chapters read 0 / 0 / 0 / 0. One dead rank found and repaired in-cycle: Sleight rank 2 was priced in all nine class tables and consumed by nothing. | 2026-09-27 |
| 9 | Bestiary and GM tools | **OK.** 49 stat blocks; HP means 15.1 / 15.0 / 14.0 against the printed rule's 15.0 / 15.1 / 14.0; 82 of 84 damage triples on their own band's row; all 49 DR values inside the band ceiling. BAD on one missing unit: `20:659`'s HP rule counts three rounds of ONE attacker, so a solo creature dies in 0.75 rounds - which is the arithmetic root of the per-respite pool collision (row 177) and of the starter adventure's 0.58-round boss. | 2026-09-27 |

**Coverage: 9 of 9 subsystems. The sweep is complete.** Both subsystems that were open at cycle 13 are
assessed, and the two defects they produced are decided and filed rather than queued for a ruling.

**Next (cycle 16):** audit the dispatched #661 PR and merge it; then dispatch the two work orders filed
in cycle 15 (`19:50`'s ladder-in-pool-currency frame plus Kelvath's HP; `20:659`'s HP-rule unit). Row
177's model gap is now measured and its lever chosen, so the pacing queue is unblocked. After those,
the remaining queue is #675 (crossref punctuation, 15 sites), #668 (magic entry points + Primal) and
#655 (Fate landed 2026-09-27); #698 (Summon landed 2026-09-27).

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
- **Primal is a half-built construct.** 12 cards are titled "Primal Spell" and 5 requirements ask for
  `focus:primal` (3 on the primal DR ladder, 2 on cards mis-titled Divine - corrected count, cycle 18),
  but there is **no primal focus item** (15's item table lists Arcane Focus and Holy
  Symbol), **no glossary entry** (21 has both siblings, no primal), **no class mention** (ch05 never says
  primal), and ch10 declares **two** traditions (10:83-89) that do not include it - ch12:19 is the only
  text that names a primal caster ("Shepherds use them"). The two Divine-titled cards that demand a
  primal focus (`12:359` Beast Tongue, `12:370` Briar Wall) are where the vocabularies collide. **REVERSED
  in cycle 18: the TITLE is the defect, not the focus.** `19:551` prints the valid spell Kinds as
  `(Cantrip)`, `(Novice Arcane Spell)`, `(Adept Divine Spell)`, `(Master Primal Spell)`, so Primal is a
  first-class Kind; both cards' Disciplines are in the Primal category (`12:360` is `1 Animal`, `12:371` is
  `2 Plants`, and `21:69` prints `Primal (Animal, Plants)`); and the established primal ladder carries
  `focus:primal` on Primal-titled cards (`12:170`/`12:204`/`12:227`, "the primal twin of the ladder",
  `12:168`). Changing the two to `focus:holy` would hand an Animal spell a Holy Symbol and delete the
  primal focus's only non-ladder use. #668 item 2 now retitles the two cards. And
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

1. **The casting skill is never named.** `10:31` and `10:77` both say "a relevant skill"; 114 cards name
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
2. **Primal is a half-built tradition: 12 cards, 5 requirements, 0 items, 0 glossary entries, 0 classes.**
   12 cards are titled "Primal Spell" and 5 requirements ask for `focus:primal`, but ch15's item table
   carries Arcane Focus and Holy Symbol and no primal focus, ch21 has entries for those two and none for
   primal, ch05 never uses the word, and `10:85-95` (the `== Arcane vs. Divine Magic` section; `10:83` is a
   pagebreak) declares **two** traditions while `12:19` says the
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

## Assessment 8 - Content: ancestries, classes, disciplines, the card library (cycle 14, 2026-09-27)

**The mechanic as printed.** Four ancestries each grant one Discipline and one trait, tabulated in three
agreeing homes (`02:63` `@tbl-ancestries`, `04:42-44`, `21:97`); nine classes each print a grant, a
signature, favoured skills, a starting loadout and a 22-row Discipline cost table (Fate absent, row 125);
a 23-Discipline / 9-category roster (`08:29`); and the card library across `09`, `11`, `12`.

**The numbers, computed rather than quoted** (`scripts/architect-content-census.py`, calibrated against
the book's own printed totals before any figure below is read):

- **196 cards** = 82 (`09`) + 68 (`11`: 15 cantrips + 53 spells) + 46 (`12`: 6 cantrips + 40 spells), plus
  **90 class abilities** = 286 containers all told. `11` and `12` both parse exactly to their printed
  chapter totals.
- **Exactly 10 abilities per class**, 9 x 10 = 90. Bruce's "about 10 for each class" is met exactly, with
  no class over or under.
- **Tier distribution** (tier = total Discipline ranks, `10:63`): 51 no-prereq/basic, 52 one-rank Novice,
  64 two-rank Adept, 25 three-rank Master, 4 capstone maneuvers. Every tier-worded card agrees with the
  total-ranks reading (99 of 102, `scripts/tier-census.py`).
- **Law gates over the content chapters (`04/05/08/09/11/12/15/16/17`): 0 retired band rows, 0 damage
  dice, 0 flat `+N damage` riders, 0 numeric roll modifiers.** First chapter group in the sweep where all
  three content laws come back clean in one pass, which is the measurable form of "the band, weapon-rider
  and Boon/Bane waves are complete in the content".

**RANGE - the deepest gate in the book leaves exactly one rank of slack.** A career grants six Discipline
ranks (three starting rank-1 grants from ancestry, culture and class at `08:100`, plus three discretionary
at levels 3/6/9) with a ceiling of 3 in any single Discipline. The most demanding printed requirement is
**5** (`3 Ranged/Two-Handed/Unarmed + 1 Tactics + 1 support` on Sunshot, Harvest the Fear, Groundbreaker,
Taken Alive), so every requirement in the book is reachable, with one rank spare.

**The four five-rank maneuvers are NOT defects, and are recorded so no future pass re-files them.** The
ladder rule ("4+ ranks is illegal") is scoped to RUNGED cards, where the rank total IS the tier. These
four print no tier word, sit on the Novice row by the maneuver law (`09:215`), and break no printed cap:
`08:193` caps a card at 3 ranks in any SINGLE Discipline, and each holds 3 in its own weapon Discipline
plus two single-rank supports. The audit rule would have flagged all four; reading them is what settled it.

**DISCRIMINATION - coverage, rank-2 floor** (consumers counted from all four sources: standalone cards,
`05` class abilities, equipment entry requirements, `17` grants):

| Discipline | r1 | r2 | r3 | verdict |
|---|---|---|---|---|
| Summon | 2 | 2 | 2 | **LANDED 2026-09-27 (PR #699)**: six cards in ch11's new `== Summon Spells` section, rank coverage 1x2 / 2x2 / 3x2, so the rank-2 floor is met with room. The discipline that was priced in all nine class tables and required by nothing now has a consumer at every rank |
| Fate | 3 | 3 | 1 | **LANDED 2026-09-27 (PR #696)**: priced in all nine class cost tables and the comprehensive table, 7 cards, rank coverage 1x3 / 2x3 / 3x1, so the rank-2 floor is met |
| Sleight | 8 | 1 | 0 | **CLOSED 2026-09-27 (PR #684, `ecc59f7`)** - Filch re-keyed from `2 Stealth, 1 Sleight` to `1 Stealth, 2 Sleight`, so rank 2 is consumed and the rank-2 floor is met. (This table still read `0` for rank 2 a cycle after the fix landed; the status cell was not moved with the implementation.) |

Every other Discipline clears the floor. Category totals: Weapon 67, Defense 52, Arcane 39, Elemental 38,
Knowledge 33, Divine 28, Esoteric 34, Subterfuge 22, Primal 14. (Esoteric was 28 before cycle 20's Summon cards added six consumers.) Within-category spreads: Unarmed 5 against
Melee 21 is the widest in Weapon; Animal 5 against Plants 9 in Primal.

**DECIDED (BALANCE, architect, veto to revert): re-key Filch to `1 Stealth, 2 Sleight`.** Sleight is
priced in every class table and bought by nine sites at rank 1, and rank 2 unlocks nothing anywhere in the
book, which violates invariant 8 (no dead content) and coverage rule 1 (the rank-2 floor is the hard one;
rule 3's rank-1 offset applies only to rank 3). Smallest lever, and the book already uses it: the standard's
own Fate resolution re-keys existing content rather than authoring cards. Filch (`05:660`, the Shadow/Blade
Master theft ability) holds 3 ranks either way, so the table's own `[Master]` label survives; Stealth's
floor stays met by Ghost (`2 Stealth, 1 Mind`); and the price for the only two classes that can take it is
unchanged or cheaper (Sleight is Home 1/2/4 for both Blade and Shadow, while Stealth is Home for the Shadow
and Foreign for the Blade, so the swap is cost-neutral for one and cheaper for the other). One line, one
file. **Reversal: put the 2 back on Stealth.**

**COST - nine dead rank slots become one.** After the change, the only remaining rank with no consumer
anywhere is Summon (LANDED 2026-09-27, PR #699, row 151: six cards, rank coverage 1x2 / 2x2 / 3x2), Fate having landed 2026-09-27 (PR #696). Master
remains thin at 25 cards, which is by design: rule 2 of the coverage standard makes rank 3 optional and
flavour-led, and rank-1 breadth is its stated offset.

**STRESS.** The library's adversarial cases hold: the four deepest maneuvers are reachable but leave no
slack for a second capstone, which is the intended shape of a capstone; the ungated layer exists and is
named (`08:197`); and no card demands a Discipline the roster does not carry, nor any single Discipline
above 3.

**Verdict: GOOD**, with one named defect repaired by decision (Sleight rank 2) and two dead ranks already
ruled and queued (both LANDED: Summon rows 151/159 in PR #699, Fate in PR #696). The content's law compliance is the strongest measured
result in the sweep so far: four gates, four zeros, across nine chapters.

## Assessment 9 - Bestiary and GM tools (cycle 15, 2026-09-27) - the last subsystem

**The mechanic as printed.** 49 stat blocks across 17 creature-type sections, Challenge 1/2 to 12
(`20:36-639`). Heroes and monsters share one rule set (always-hit W/S/S damage, no DP, no levelling,
0 HP ends it, `20:9`). `20:19` defines the block's eight fields. `20:659` is the creation law: assign
attributes -2..+2, give 1-3 attacks on the damage budget, add 1-2 abilities, and
**HP = 3 x (your tier's band average minus its DR)** with band averages 5.67 / 7.50 / 9.59 and
DR capped at the tier ceiling (3 / 4 / 6). `20:641` mirrors `19:49`'s encounter ladder
(Easy x1 / Standard x1.5 / Hard x2 / Deadly x3 party level, per hero). ch19's GM tools are the
difficulty dial, encounter building, treasure pacing, NPC creation, resting plus two variants,
exploration and travel, crafting, resource management (with an optional resource die), corruption, the
extended social pointer, a four-scene starter adventure, a seven-point faction reputation track, and
card templates.

**Instrument.** `scripts/architect-bestiary-census.py` (new, with a planted-defect `--selftest`):
regex-parses `origin/main`, never a hand-typed copy, and grades every block against the band row, the
band ceiling and the template.

**Numbers computed, not quoted.**

- **CONFORMANCE - HP: GOOD, and the rule is calibrated to the corpus.** Block means by band are
  **15.1 / 15.0 / 14.0**; the printed rule predicts **15.0 / 15.1 / 14.0**. The mechanism is that DR
  absorbs the tier growth: HP stays flat at ~15 while the band's average damage climbs 5.67 -> 7.50 ->
  9.59, so absorption (HP + 3 x DR) is held roughly constant. The HP guideline is a real gate and the
  bestiary passes it.
- **CONFORMANCE - damage: 82 of 84 attack triples sit on their own band's row** (4/6/8, 5/8/11,
  7/10/14). Both misses are legal: the Archmage's at-will Ember Lance (4/6/8) is exactly one band below
  its primary Dagger (5/8/11), and the Treant's 4/6/8 belongs to the Lesser Treant its own Animate
  Trees summons, not to the Treant.
- **CONFORMANCE - DR: all 49 blocks are inside their band ceiling (3 / 4 / 6).** **The GATE had to be
  corrected before the number could be trusted:** the census was first written with
  "DR = Challenge // 2, round down, max 6", which is quoted as bestiary law in the skill itself and
  appears in **no chapter** (`git grep` book-wide returns zero hits for any Challenge-based DR formula).
  That invented rule manufactured **25 false deviations** in the first run. The book prints a CEILING,
  not a formula. Logged as a phantom-rule instance and removed from the instrument.
- **CONFORMANCE - attack count: 48 of 49 blocks print 1-3 attacks.** The Ancient Dragon prints four
  (Bite / Claw / Tail / Breath) plus Multiattack - the C12 capstone, and `20:659` is guidance for
  CREATING a monster, not a gate on a printed one.
- **RANGE: the Challenge population is C1/2 10, C1 8, C2 5, C3 14, C4 4, C5 4, C6 4, C7 1, C8 1,
  C10 1, C12 1.** C9 and C11 are empty and the whole Master tier (levels 7-10) holds **4 blocks**.
  Named cost, not a defect: the encounter rule sizes a Master fight by count (seven creatures), so it
  is filled from the populated C5-C6 pool, and `19:53` already states the count rises by one as party
  damage outgrows flat monster HP.

**BAD - the HP rule is missing its UNIT, and it is the invariant behind the pool collision.**
`20:659` reads "HP = 3 x (your tier's band average minus its DR)". Three of WHAT? Measured against the
corpus the answer is **three rounds of one attacker**: the 49 blocks average ~1.5 creatures per hero, so
each is attacked by roughly one hero per round, and the rule is calibrated for exactly that. Against a
party of four, **one printed creature dies in ~0.75 rounds** - which is why the pacing window has to be
bought with creature COUNT. `19:53`'s six-to-seven creatures is not a flavour choice; it is the
arithmetic consequence of a per-attacker unit.

Two measurable consequences, both settled below:

1. **The per-respite pool collision (ledger row 177).** Because the window is bought with count, and
   count is what sets incoming damage, the drain of a Standard fight is fixed by the rule pair.
2. **A solo creature is not a fight, and the book's own starter adventure contains one.** Scene 4 of
   _The Sunken Vault_ (`19:325`) pits a level-1 party of four against **Kelvath, the Drowned Warden**:
   HP 8, DR 3, **no Multiattack**. HP 8 is exactly what the printed rule yields for a DR-3 Novice
   creature (3 x (5.67 - 3) = 8.0), so the block is compliant and the fight is still broken. Party
   output through DR 3 is 1 / 3 / 5 per hit (mod +3 on 3d6: Weak 4.6%, Standard 67.1%, Strong 28.2%),
   so **E[damage] = 3.47 per hero and 13.9 per round: Kelvath dies inside the party's first round**
   (8 / 13.9 = 0.58 rounds). The scene is built on a 1d4+1-round seal clock, three tactical options and
   a flooding timer, and none of them can happen in round one.

**DECIDED (BALANCE, architect, cycle 15, veto to revert).** State the HP rule's unit in one sentence at
`20:659` and its quick-template mirror - "multiply by the number of heroes who will attack it" - then
apply it to the solo boss the book itself prints: **Kelvath's HP 8 -> 32** (3 x (5.67 - 3) x 4
attackers), which puts his fight at **2.3 rounds** inside his own scene's 2-5 round seal clock. No band,
no DR and no printed creature HP moves: the 49 corpus blocks already sit at ~1 attacker each, so the
sentence is a clarification for them and a correction only where a creature stands alone. Work order
filed with the exact text. **Reversal: delete the sentence and put 8 back.**

**ROW 177 - the ladder's words are not its fractions. Settled on the completed model.**

- **Invariant:** a difficulty ladder must be *discriminating and survivable across its whole range* -
  each rung a distinct fraction of the party's per-respite pool, none above it - **and the words on a
  rung must be the fraction it actually costs.**
- **The row's named model gap, closed first.** Catch Breath (`13:69`) is a **Maneuver, not an Action**
  (it sits in the Basic Combat Maneuvers table, `13:59-69`), and it restores ceil(max HP / 3) with uses
  per combat equal to Grit. So it costs no attack: it adds **4 x Grit HP per hero per combat** -
  **+8 / +12 / +16** at Novice / Adept / Master - raising the absorbable total from 36 / 48 / 60 to
  **44 / 60 / 76 per hero**.
- **Measured across the WHOLE ladder** (pool = HP x (Grit+1) per hero per respite, `13:341-347`, plus
  the Catch Breath term; rungs scale with the challenge multiplier):

  | rung | x party level | spend, Novice / Adept / Master |
  |---|---|---|
  | Easy | x1 | 49 / 53 / 49 % |
  | Standard | x1.5 | 73 / 80 / 73 % |
  | Hard | x2 | 97 / 106 / 98 % |
  | Deadly | x3 | 146 / 160 / 147 % |

- **Verdict: the SHAPE is right, the bottom two rungs' WORDS are wrong.** The fractions are monotone,
  evenly spaced, and exactly proportional to the multipliers 1 / 1.5 / 2 / 3; the top two rungs match
  their printed words (Hard "significant resource drain and possible casualties" at ~100%, Deadly
  "character death is a real possibility" at ~150%). What fails is that **Easy at ~50% is not "a quick
  fight that costs few resources", and Standard at ~75% is "most of the day", not "some resources".**
- **DECIDED (smallest lever = the frame; no band, HP, DR, Grit or #663 number moves).** `19:49-55`
  gains one sentence naming the pool in its own currency (HP x (Grit+1) per hero, restored on a respite,
  `13:341-347`) and each rung's measured fraction, and the four rung descriptions are restated in that
  currency. Plus one sentence drawn from the book's own `19:53` paragraph ("Four goblins (four actions
  per round) are more dangerous than one ogre with the same total HP"): **total encounter HP sets the
  fight's LENGTH, creature count sets the pool drain**, so a DA who wants a cheaper fight spends the
  same budget on fewer, tougher creatures. Re-opening #663's size rule stays last - it would re-break
  the pacing window it was chosen to fix. Work order filed. **Reversal: restore the four rung phrases
  and delete the pool sentence.**

**Verdict (subsystem 9): OK.** Conformance is the best-measured part of the book - HP calibrated to the
corpus, 82 of 84 damage triples on-row, all 49 DR values inside their ceiling - and the GM tools are
broad and internally consistent (the encounter ladder's numbers, the travel/crafting/corruption/
reputation tables, the card templates, and a starter adventure that teaches the system in layers). Two
defects, both from one missing unit: the HP rule does not say who it is counted against, which makes a
solo creature a 0.6-round fight and is the arithmetic root of the pool collision. Both are decided and
filed; neither moves a band.

**COVERAGE: 9 of 9. The sweep is complete.**

## Closing balance audit (cycle 21, 2026-09-27) - the full-book walk, and the four instruments that were the bug

**The walk, five gates.**

- **Content law gates** (`architect-content-census.py`, the nine content chapters): **0 retired band rows, 0 damage dice, 0 flat `+N` riders, 0 numeric roll modifiers.**
- **Healing axis** (`heal-row-census.py`): **0 cards on a retired row** (4 before #665). Flesh Renewal reads OFF ROW on the per-round axis and is the sanctioned recurring shape of row 171 (stated total 5/8/11 = the Adept row; the per-round figure paces it).

- **Bestiary** (`architect-bestiary-census.py`): 49 blocks, **84 of 84 attack triples on their band's row, all 49 inside their band DR ceiling (3/4/6, `20:659`)**; HP means 15.1 / 15.0 / 14.0 against the HP rule's predicted 15.0 / 15.1 / 14.0. The one informational line left is the Ancient Dragon's 4 damage lines, one of the two recorded above-cap exceptions.
- **Pacing** (`rounds-to-resolve.py`): **PASS at all three tiers** - 3.79 / 3.68 / 3.36 rounds against ruling 165's 3-4 window at the amended `19:53` encounter size.
- **Tier axis** (`tier-census.py`): 110 of 114 tier-worded cards agreed with the rank ladder on `origin/main`; all 4 disagreements were ch09 mis-titles, now **114 of 114** after PR #700.

**Four instruments were the bug, and three of them reported a false clean.** Each was repaired this cycle, each with a negative control.

1. `audit-rung-escalation.py` **harvested 0 runged cards book-wide**: its splitter matched markdown `**Adept:**` while the book has been native Typst (`*Adept:*`) since the migration, so the gate has been decorative every pass since. One regex alternation takes it **0 -> 3 runged cards**; the repaired gate flags a planted drop (exit 1) and clears the live corpus (exit 0). Coverage in the gate's own terms: 3 runged cards, **0 comparable pairs** - the corpus's only tier rungs are ch09's four Fate talents, each a single rung with no base, so the ladder law is unexercised rather than satisfied.

2. `tier-census.py` **truncated a `·`-joined requirement to its first Discipline**, so `1 Tactics · 1 Mind` counted one rank and the fourth mis-titled card (`Borrowed Eye`) stayed invisible. Fixed, with a second planted control asserting the sum.
3. `architect-bestiary-census.py` ran `git` in the invoking directory and **died with exit 128**; once running it graded every triple in a block, so it flagged a legal one-row-lower secondary (Archmage's Ember Lance) and a nested minion's stat line (the Treant's Lesser Treant) as band violations. Now grades the block's own attack lines under the primary/secondary rule: **2 false positives -> 0**, with a positive control asserting a legal secondary is not flagged.
4. Its docstring still carried the **phantom** law "creature DR = Challenge // 2, max 6"; corrected to the printed band ceiling, which is the whole law.

**Verdict: GOOD.** The spine holds on every axis the sweep can measure, and the four repairs are why the verdict is trustworthy rather than merely reassuring: a gate that reports nothing because it parsed nothing is indistinguishable from a clean book, and three of these four did exactly that.

## Re-assessment 2026-09-27 (cycle 28) - the content-law gate was a false clean, and two swept laws had a living survivor each

The five-gate walk below reported "**0 flat `+N` riders, 0 numeric roll modifiers**" over the content
chapters. **That verdict was true by accident and false as a measurement.** Both of the gate's regexes
required the number glued to its noun, so a `bonus` sitting between them matched neither:

```python
FLAT_RIDER   = r"(add|gains?|deals?|with)\s*\+([0-9]+)\s+damage(?!\s+tier)"     # 'deals +2 bonus damage' -> no match
NUM_ROLL_MOD = r"[+\u2212-]\s?[0-9]+\s*(?:on|to|against)\s+..."                # '+2 bonus on their next roll' -> no match
```

Two live defects sat in exactly that gap, and had done for the life of the gate:

- `05:340` Leader *Lead by Example*: "grant one ally who witnessed it a **+2 bonus on their next roll**"
  - the last numeric roll modifier in the book, against the Boon/Bane law, and contradicted by the
  book's own restatement of the same ability at `02:470`, which already printed "a **Boon** on their
  next roll".
- `05:568` *Leverage*: "it **deals +2 bonus damage**" - the last flat damage rider, in a table whose
  five siblings all print `+1 damage tier`.

**Both regexes widened to allow `(?:bonus\s+)?` between the number and its noun, and the control set
extended: the selftest now plants the *shape that hides* a defect, not just a convenient sample.**
Proven on the real artifact, not only on a synthetic string:

| ref | ch05 flat-riders | ch05 roll-mods |
|---|---|---|
| `57f2a29` (pre-fix) | **1** | **1** |
| `bdd96ca` (post-fix) | 0 | 0 |

Before the widening the same instrument printed `0 0` on **both** refs. The lesson generalises past this
gate: **a control set must contain the shape that hides the defect.** A gate whose only planted defect
is the obvious one can fail for the obvious reason and still be blind to the class it was written for -
which is the same failure as the post-migration harvest bug, arriving by vocabulary instead of syntax.

**Two more rules the book left implied, both landed the same cycle (PR #714).**

- `13:155` never stated whether DR comes off **before or after** a resistance/vulnerability multiplier.
  50 bestiary blocks print DR, 4 print a resistance, no worked example combines the two, and the starter
  adventure's own Drowned Guardian is both (`19:312`: HP 14, DR 1, Vulnerable (Fire)) against a party
  that will bring fire. The order is derived, not chosen: DR-then-type reaches **0** (4 fire vs DR 3
  resistant), which `06:91` ("minimum 1 damage from any hit") and `16:27` ("a hit must always be able to
  land for something") both forbid. Ruled: **type modifier first, then DR, floored at 1.**
- `07:41` now says a class sheet's `*Favored Skills*` line is guidance, not a discount. The field is
  printed on all nine class sheets and marked in the printed builds, while ch07 (the authoritative
  skills chapter) says all skills cost the same for every class and never uses the word, and ch02/ch05
  use "Favored" for a cheap **Discipline** rate.

**The five-gate walk below stands, with one correction: the content-law line now reads 0/0 for a
measured reason.** Re-run after #714: every content chapter `retired 0 dice 0 flat-riders 0 roll-mods 0`.

## Cycle 29 (2026-09-27) - walkthrough W-005: the bestiary PLAYED, 2 of 49 blocks fail

The three bestiary passes already in this file (Assessment 9's conformance census, the pacing gate, the
attributes census) all read the chapter as a TABLE. W-005 reads it as a FIGHT: for every block, at the
band its Challenge is budgeted into, can the party the encounter builder will send actually reduce its
HP, and does the block's damage still discriminate once the party's DR is applied. Instrument:
`scripts/da-walkthrough.py` (skill), 49 of 49 blocks, with a coverage guard.

**Verdict: BAD on 2 of 49, GOOD on 47.** Both failures are the same shape - a block that prints two
statements of one reduction, or an immunity whose named counter does not exist where the block is used:

1. **Wraith (C3, `20:281` + `20:285`)** prints `DR 3 (non-magical)` AND Incorporeal's half-from-non-
   magical-physical. Composed in the book's own order the mundane Adept triple reads `[1,1,2]`: 50.0% of
   all 216 rolls land for 1 damage and 50.0% for 2 (average 1.500/hit vs 9.444/hit magical, 6.30x).
   `16:25` requires the tiers to stay distinct and `20:659` caps monster DR at 4 at Adept; the
   composition reaches an effective 7.5. Fix: delete the duplicate trait, keep the DR (HP follows it).
2. **Swarm of Rats (C1/2, `20:78`)** is immune to single-target attacks and vulnerable only to area
   effects, and no area effect is reachable at rank 1 (the book's two Area cards are `09:130` Spell Storm
   - once per session, secondary targets only - and `09:382` Cyclone at 3 Melee). A level-1 Standard
   budget is twelve of them: 204 unreducible HP and 12 automatic damage a round against a 144-point pool.
   Fix: the book's own resistance idiom, `*Swarming:* half damage from slashing, piercing, and
   bludgeoning attacks.` Both landed as #715 / PR #716 (`5ef6b51`); rows 197 and 198.

**What the walkthrough found about the instrument rather than the book (the durable half).** The pacing
gate had been harvesting **48 of the 49** blocks: `rounds-to-resolve.py` anchored its heading regex on
`(Challenge N)$`, which drops `=== Vrock (Demon, Challenge 6)`, and its `CBAND Master` was `(7,8,9,10)`,
so the C12 Ancient Dragon was parsed and then left out of every Master average. Fixing both moved the
gate's verdicts to Adept `3.68 -> 3.73` and Master `3.36 -> 3.27` (still PASS) and made its two numbers
describe the whole bestiary. My own new sweep carried the same class of bug in the other direction
(48 blocks parsed, printed as a clean PASS) until its heading regex was widened; it now fails loudly
when parsed != headings. **This is the third consecutive cycle in which a gate's silence turned out to
be a coverage fact rather than a pass** - cycle 28's content-law gate was the first, the rung gate
before it the second - so the standing rule is now: after any change to a corpus, census what the tool
COLLECTS against what the file CONTAINS before believing what it prints.

**Also repaired this cycle:** the ledger's row sequence had a gap at 105, cited by
`council-runs/10-magic-system-20260912/SUMMARY.md:91` for a dismissed sub-claim. The content is not
recoverable (a pickaxe over the tracked history finds no commit carrying it) and has NOT been invented:
row 105 is now a tombstone and the sequence 1-198 is unbroken.

## Derived-constant audit (cycle 34, 2026-09-27) - an addendum to Assessment 2, the economy

**Why an addendum.** W-007 (the change-one-number pass) is an audit OF the economy rather than a new
subsystem, so it records here beside Assessment 2 rather than replacing it. Nothing in Assessment 2's
verdict changed: the row is sound at both ends of its range and the cost model still holds.

**The mechanic as printed.** Ch10's damage budget fixes one row per tier (Novice 4/6/8, Adept 5/8/11,
Master 7/10/14, `10:46`-`10:48`). Three other printed quantities are functions of that row and are
printed as if they were independent: the **DR ceiling** `3 at Novice, 4 at Adept, 6 at Master` (6 sites:
`16:27`, `20:657`, `20:663`, `21:115`, `22:365`, `22:392`) and the **monster-creation band average**
`5.67 / 7.50 / 9.59` (1 site, `20:657`), which the HP rule multiplies by three and by the number of
attackers the creature faces.

**The numbers, computed rather than quoted.**

- The band average is the row weighted by the 3d6 tier odds: `(4·56 + 6·140 + 8·20) / 216 = 5.667`;
  Adept `(5·56 + 8·140 + 11·20)/216 = 7.500`; Master `(7·56 + 10·140 + 14·20)/216 = 9.593`. Printed:
  5.67 / 7.50 / 9.59. **3 of 3 exact.** 0 stale constants book-wide.
- The ceiling is `Weak − 1` at every tier: 4−1, 5−1, 7−1 = 3 / 4 / 6. **3 of 3 exact.**
- Dependent population, parsed from `origin/main`: **155 card damage blocks**, **79 monster damage
  triples**, **49 `HP n, DR n` lines**. A one-step change to the row therefore touches **283 printed
  sites** directly plus the derived ones.
- The invariant boundary is load-bearing in both directions. Row +1 leaves every ceiling a step low
  (the ceiling would have to be 4/5/7) and moves all three averages. Row −1 **breaks invariant 3**: the
  Novice ceiling 3 would sit above `Weak − 1 = 2`, and heavy armour's DR 3 - gear, so gold-gated rather
  than level-gated - would flatten the Novice triple to 1/1/1 and switch the defence roll off.
- The ladder is internally consistent: `16:29` prices a DR grant at one rank per DR and `10:70` caps a
  Discipline at rank 3, so DR 4 is ungrantable by the book's own rule; the armour table's 1/2/3 is the
  same scale.

**Verdict: the row is GOOD; its documentation was BAD and is now GOOD.** The row delivers its promise at
both ends, discriminates across the three tiers at every DR the book can grant, and its two derived
constants were both exactly right. What failed was the **LEARNABLE** criterion: neither derivation, nor
the 3d6 odds table they rest on, appeared anywhere in the book (`git grep` **0 hits** each), so a DA
building a creature from scratch had three numbers they could not check, in a formula the book tells them
to use. Repaired on the smallest lever, documentation only, by PR #726: `16:27` names the ceiling's
derivation, `20:657` names the average's weighting and prints the odds. No number, band, ceiling or stat
block moved, no rule was added, and the page count is unchanged at 399.

**Measured and deliberately NOT changed.** (1) The Adept ceiling 4 and the Master ceiling 6 can never
bind today: the largest printed hero DR grant is +3 (heavy armour 3; the +3 wards at `11:731`, `12:241`)
and DR does not stack (`16:23`). They are derived from the band rather than chosen - move the rank cap to
4 and the Adept ceiling binds for the first time - so lowering them would be new law, and they are
recorded here so no future pass files them as dead content. (2) The `Petrified` condition's `DR +5`
(`13:209`, `21:173`, `22:109`) exceeds the Novice and Adept ceilings by design: the ceiling's scope
sentence names armor, talents and wards only, and a statue is a statue.

**Instrument.** `scripts/change-one-number.py` (new): parses `origin/main`, re-derives every constant
that follows from the row, perturbs one number at a time (band ±1, card price, a rank ladder, armour DR,
the rank cap, Grit, the attribute cap) and prints the blast radius and the invariant each one touches.
`--selftest` plants a mutated Novice row and requires the derived-constant check to fail on it, so the
gate is proven to be able to fail. One instrument bug was found and fixed in the act:
its ceiling-site regex required the word `or` and so counted 4 of the 6 printed sites, the standing
"census what the tool COLLECTS against what the file CONTAINS" rule catching it again.

## Flavour addendum (cycle 35, 2026-09-27) - the third scorecard outcome now has an instrument

**Why this belongs here.** The role's mandate names three emergent outcomes (playable, cohesive,
succinct), and two of them have had instruments for thirty cycles. Flavour - "does each mechanic's
printed flavour sell the mechanic, and does any flavour contradict its own rule" - was the one dimension
enforced by human read, so it drifted with every gate green. It is now measured, and the measurement
found two live defects rather than a clean bill.

**What is measurable, and what is not.** `scripts/flavour-pass.py` screens four classes over the card
corpus (208 cards, 503 rungs) and the whole book: rung coverage, card-level coverage, orphan references
to things the book never defines, rung durations contradicting the card's own Range field, and retired
lexicon (negation contexts exempt). It cannot say whether a clause is *good*. **Coverage is not
quality**, and no count here is a quality score: 45 of 503 rungs carry no flavour clause, and that is the
book's own rhythm rather than 45 defects.

| Measurement | Before | After | Note |
|---|---|---|---|
| Rungs carrying a flavour clause | 451 of 503 | **458 of 503** | the card-level check is the actionable one |
| Cards with no flavour on any rung | **3** | **0** | `Tough`, `Renewal`, `Thread of Ruin`; their chapters run 85 of 87 and 72 of 75, so these were deviations from convention |
| Orphan references in card rungs | **1** | **0** | `11:34` "Detection spells"; the qualifier appears once book-wide, on that line |
| Rung duration vs the card's Range field | 0 | 0 | `scene` is excluded: `19:23` defines it as a unit of story, not a clock |
| Retired lexicon in card text | 0 | 0 | mana, spell slot, damage dice, saving throw, to-hit |

**The two real defect classes, named so the next pass can grep for them.** (1) **A rung keyed to a
subsystem the book does not have** - the reader is told a mechanic is gated by a category of magic with
no entry to look up; repair by naming the printed card that already does the job. (2) **A rung
promising a rider its row does not fund** - a persistence verb (keeps, clings, lingers) in a rung that
prints no duration and no recurring damage, which invites a table argument at a fixed row; the
book-wide grep for the shape returns seven lines, six of them legal.

**Instrument discipline, since this instrument's own plants failed first.** Its first run flagged 2 of 4
plants, and both misses were mine: the coverage test counted function words as flavour, and the oracle
reader had no entry for the number word `sixty`, which the **coverage guard caught** (`exit 2`, not a
clean line) because it compares ch11's own printed total against the parse. A third bug surfaced the
same way: the guard compared the whole corpus against one chapter's claim, and now compares per chapter.
That is the standing lesson restated for this dimension: a checker's own parse is a hypothesis, and a
screen that has only ever printed green is decorative.

## Re-assessment 2026-09-27 (cycle 38) - Assessment 9 (bestiary and GM tools), re-run from a census

**Why it re-runs.** The review ranked the bestiary's silence as its top **open** weakness ("no block says
how to play it"). That is a count dressed as a judgement, so it was counted before it was repaired. New
instrument: `scripts/bestiary-role-census.py`, which parses the 49 blocks out of `origin/main` and asks one
question per block - does the block's own text decide what the creature does with its turn.

**The measure** (coverage guard green: 49 parsed, 49 `=== ` headings; vocabulary printed with the output,
because an audit is bounded by its vocabulary):

| Question | Count | Verdict |
|---|---|---|
| blocks whose own text decides the turn (Multiattack, Recharge, condition on a hit, a second attack line, casting, positioning/support, reaction) | **45 of 49** | GOOD |
| blocks with an attack line and passives only | **4**: Swarm of Rats, Guard, Zombie, Fire Elemental | OK, simple by design, each turn unambiguous |
| blocks carrying any who/when cue | **8 of 49** (4 of them only "fight next to an ally") | the gap, and it is a frame gap, not a content gap |
| blocks carrying a `Morale:` clause | **0 of 49**, against **2 of 2** in the adventure's blocks (`19:312`, `19:351`) | BAD, now reconciled: two stat-line populations, one field |
| the who/when rule itself | printed in full at `13:307` to `13:334` | GOOD, and ch20 never pointed at it |

**Verdict: OK, repaired.** The bestiary is a sound reference and a silent GM tool, and the silence is two
axes wide rather than 49 blocks wide: the fields give capability, and a DA is left to choose targets and
to remember that morale exists. The repair is the frame, not per-creature content: one paragraph after
ch20's field table naming both axes, plus `#label("sec-morale")` so the pointer has a target (`13:307` was
unlabelled). PR #734, `1309460`, 399 pages unchanged, no number moved.

**Two defects in the instrument itself, both caught by `--selftest` before any count was quoted.**
(1) `\btargets?\b` matched mechanical sentences ("target is knocked Prone", "latches onto the target")
and reported **17** priority cues where **8** exist, which is the skill's own marker law: a marker must
name a turn effect, never a clause that merely shares a word with one. (2) The condition vocabulary read a
defence line as an offence ("immune to Frightened" as a condition on a hit), so defence lines are excluded
from cue matching, and the selftest plants exactly that shape.

**What this changes.** The next pass over the bestiary should not author 49 role lines: that premise is
refuted. It should check the one field the adventure prints and the bestiary does not (`Morale:`), now the
only structural difference between the two stat-line populations, and it should judge whether a short
player-facing tactics primer belongs in ch19 or is already delivered by `19:57` to `19:59`. The census is
re-runnable (`--rev <ref>`), so the count moves if the corpus does, and the coverage guard exits 2 rather
than printing a clean line when a format change outruns the parser.
