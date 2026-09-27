# Architect scorecard — the three outcomes, measured

**One row per cycle, always.** A flat line is information. An empty cell is a confession:
measure it next cycle or say why it cannot be measured.

## The three outcomes

| Outcome | The question | Instrument | Owner |
|---|---|---|---|
| **Playable** | Can a new player build a hero and resolve a scene from the book alone? | walkthrough transcripts (`architect/walkthroughs/`) | architect |
| **Cohesive** | Is it one system — one canon home per concept, every requirement satisfiable, every listed thing priced and reachable? | canon index reconciliation | architect |
| **Succinct** | Does every printed thing earn its space? | printed cost per mechanic; duplication; dead content | architect |

## Baseline at cycle 0 (2026-09-26)

Scale: **25 chapters, 81,414 words, 157 ledger rows.** Style law holds: **0 em-dashes**
in book text across all 25 chapters.

| Outcome | Measurement | Value | Verdict |
|---|---|---|---|
| Playable | walkthrough transcripts on file | **1** (`w-001-first-session.md`, cycle 2) | **MEASURED.** Scenes resolve end to end from printed text with no invention; hero *creation* does not, in two places: Step 8 never charges the loadout's Discipline ranks, and a culture's +1 skill bonus has no stated interaction with a purchased rank. 4 defects found (2 fixed same day, 2 awaiting one word each). |
| Playable | scene resolution defects per walkthrough | **2 in 1 transcript** (Challenge 1/2 had no printed penalty; a round summary contradicted its own round) | both fixed same day, verified in the PDF |
| **Playable** | **even-fight length against Bruce's 3-4 round law** (row 165) | **1.26 / 1.05 / 0.96 rounds** at Novice / Adept / Master, measured on the book's own Standard encounter (`19:53`, about two creatures) | **BAD, and the failure is uniform rather than a collapse.** New instrument cycle 4 (`scripts/rounds-to-resolve.py`, skill), **re-derived and corrected cycle 5**: the first version paired a Master party with the bestiary's global average HP and measured the book's Deadly encounter while calling it even. Root cause is a premise mismatch between `20:659`'s solo-duel HP rule and `19:53`'s two-creature Standard. Lever 2 chosen as a veto-revertible default in cycle 6 (no stat block, band or hero number moves) and filed as **#663**; the repair is a per-hero budget with the field size stated in the text. |
| Playable | is an even fight dangerous? (the other direction) | **a party is dropped after 12.7 / 12.9 / 12.7 rounds, flat** (Grit pools x hero DR) | **the earlier "mutual rout in 1.8 rounds" claim is WITHDRAWN.** It omitted Grit and armour DR. An even fight is too *short*, not too lethal: it never reaches the staying-power mechanic it is supposed to spend. |
| Cohesive | Disciplines advertised but not purchasable | **1** (Fate: in the ch08 roster, the ch21 glossary and the ch22 reference sheet; zero cost rows) | defect, ruled 2026-09-16, unbuilt (row 125, work order #655) |
| Cohesive | Disciplines priced but consumed by no card | **1** (Summon: nine class cost tables, zero card requirements) | defect, ruled 2026-09-16, unbuilt (row 151) |
| Cohesive | printed builds that are legal under the loadout cost model | **2 of 9** (Lirael, Corwin) | new instrument, cycle 2: price every printed build's gear ranks against its grants. 26 DP unfunded across 7 builds; ledger row 161; needs one word from Bruce |
| Cohesive | printed builds whose DP ledger is closed under the skill rules | **0 of 9** (all nine buy the skill their own culture grants +1 in) | new instrument, cycle 2: 18 DP of spend that is either additive or dead; ledger row 162 |
| Cohesive | the price of a card, as stated | **stated 2 ways: 2 DP (flat) vs 2-6 DP (true)** | new instrument, cycle 3: `02:204` + ch22 print the flat cost; `08:178` says the flat cost is part of it. This one gap is the mechanism behind 44 DP of unfunded spend. Filed as #661 |
| Cohesive | classes that can fund their printed loadout and a card | **8 of 9** (the Shepherd needs 9 DP of an 8 DP pool) | new instrument, cycle 3 (`scripts/class-loadout-economy.py`, which pays every rank above the grant). Row 166; needs one word |
| Cohesive | structures whose printed label matches their printed price | **5 of 9** (four classes call a 4/8/16 charge "at your Foreign rate"; Foreign is 3/6/12) | new instrument, cycle 3. Filed as #661 |
| Cohesive | card containers indexed (card chapters + ch05 class tables) | 196 cards + 90 class abilities | baseline for the corpus count question |
| Cohesive | cards whose printed tier contradicts their printed requirement | **3 of 196** (ch09 3, ch11 0, ch12 0) | new instrument, cycle 1: parse each card's requirement against the tier word in its own heading. Ledger row 160. |
| Succinct | dead content: printed places per unusable element | **3 each** (Fate and Summon are each printed in roster + glossary + reference sheet) | 6 printed slots selling two things nothing can use |
| Succinct | words | 81,416 (`wc -w`, 25 chapter files at `eb8b5e0`) | no target set - a target is Bruce's call |

## The corpus-count question (settle it, do not inherit it)

Three counts are in circulation and they disagree: **283 cards** (ledger, measured
2026-09-16), **109-entry library** (skill), **286 containers** (spike parse: 196 cards + 90
class abilities). They may each be right for a different corpus. `references/card-census-method.md`
defines the corpus; the store must print **which** corpus each number came from, or the
numbers will keep disagreeing in good faith.

## Trend

| Cycle | Date | Playable | Cohesive (dead disciplines) | Succinct (words / dead slots) | Note |
|---|---|---|---|---|---|
| 0 | 2026-09-26 | unmeasured (0 transcripts) | 2 | 81,414 / 6 | bootstrap: loop, contract and baselines exist |
| 1 | 2026-09-26 | unmeasured (0 transcripts) | 2 | 81,416 / 6 | Cohesive is flat and that is the honest read: the Fate work order is FILED (#655), not merged, so nothing has moved yet. What moved is the queue: bootstrap merged (#654), rows 125/151 re-verified, row 159 added for the module's unruled defaults, and a new instrument found 3 cards whose title contradicts their tier (row 160). Playable was skipped this cycle for the ruled-but-unbuilt row; it is cycle 2's first act. |
| 2 | 2026-09-26 | **1 transcript** (W-001); creation does not close, scenes do | 2 (flat: #655 still unbuilt) | 81,416 / 6 | Playable is measured at last, and the measurement landed on the layer the 2026-09-16 armament collapse rewrote: **7 of 9 printed builds are unfunded by 2-6 DP (26 DP) and all 9 buy the skill their culture grants +1 in (18 DP)**. Two defects were single-outcome and fixed the same day; the two that remain need one word each from Bruce (rows 161, 162) and hit the same nine builds, so they are one pass, not two. Cohesive stays flat by the dead-discipline count and is honestly worse by the two new instruments. |
| 3 | 2026-09-26 | 1 transcript (flat); **the economy's defects are now counted, not suspected** | 2 (flat: #655 still unbuilt; three fresh instruments) | 81,416 / 6 | The direction changed: **#659** ordered the work by assessing the game from the foundation up, so the THINK priority is the sweep and it outranks the queue. Assessment 1 was INSPECTED (all six probability rows re-derived and correct, my own checker being the faulty one) and its priority 1 was **reversed**: Grit plus tier DR hold time-to-fall flat at 5.8 / 5.9 / 5.8 hits, so static HP is not the book's big bet. Assessment 2 (the economy) landed at coverage 2 of 9 and found the single root cause under rows 161/162: the price of a card is stated two ways (2 DP flat vs 2-6 DP true). Rows 165/166/167 added; #661 filed; nothing dispatched. |
| 4 | 2026-09-26 | 1 transcript; **the pacing law is ruled and gated for the first time** | 2 (flat) | 81,416 / 6 | Bruce ruled row 165: an even fight lasts 3-4 rounds at every tier. Cycle 4 wrote the gate, measured 2.22 / 1.57 / 1.18 rounds, and reported an even fight as a mutual rout. Closed #660, opened **#662** carrying the assessment and the row. Nothing merged, so `main` did not move. |
| 5 | 2026-09-26 | 1 transcript; **the pacing measurement was corrected, and the correction made the defect sharper and cheaper** | 2 (flat) | 81,416 / 6 | INSPECTED #662 and repaired it in place: four defects (citations to rows that existed nowhere, a dropped cycle of plan/scorecard state, two sections named "Assessment 2", and a gate measuring the wrong encounter with the wrong pool). Re-derived the pacing from the corpus: 4v4 is 2.52 / 2.10 / 1.92 (uniform 1.31x, not 1.88x); **the book's own Standard encounter (two creatures) resolves in 1.26 / 1.05 / 0.96 rounds**; a party is dropped after 12.7 / 12.9 / 12.7 rounds flat, so the "mutual rout" is withdrawn - the fight is too short, not too lethal, and it never spends the Grit it is supposed to spend. Root cause named: `20:659` is a solo-duel calibration and `19:53` builds two-creature fights. Lever 2 (one creature per hero) lands 3.78 / 3.15 / 2.88 rounds and moves no stat block, band or hero number. Gate rebuilt with a positive and a negative control; still exits 1. |
| 6 | 2026-09-26 | 1 transcript (flat); **the pacing repair is specified, not just measured** | 2 (flat) | 81,416 / 6 | INSPECTED and **MERGED #662** (the law and the corrected measurement now sit on `main` at `340fd11`), after correcting the PR body so the durable record does not open with the retracted mutual-rout figures. The cycle then went to the lever, because the law is Bruce's and the choice is the architect's: the encounter's challenge-point budget cannot set a fight's length (creature HP is flat at 15.0-15.1 by band while Challenge runs 1/2 to 12, so HP per challenge point falls 15.78 / 3.74 / 1.80, and the printed budget's HP yield is a coincidental ~30 at every tier, about one round), while the creature count can, and ch20 already fits it (six creatures need 14.0 / 16.4 / 18.2 HP per monster against 15.1 / 14.8 / 15.0 printed, so **no stat block changes**). **#663 filed**: per-hero budget, one and a half creatures per hero, seven at Adept and Master. Cohesive is unchanged by design this cycle. |
