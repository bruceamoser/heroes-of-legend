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
| Cohesive | Disciplines advertised but not purchasable | **1** (Fate: in the ch08 roster, the ch21 glossary and the ch22 reference sheet; zero cost rows) | defect, ruled 2026-09-16, unbuilt (row 125, work order #655) |
| Cohesive | Disciplines priced but consumed by no card | **1** (Summon: nine class cost tables, zero card requirements) | defect, ruled 2026-09-16, unbuilt (row 151) |
| Cohesive | printed builds that are legal under the loadout cost model | **2 of 9** (Lirael, Corwin) | new instrument, cycle 2: price every printed build's gear ranks against its grants. 26 DP unfunded across 7 builds; ledger row 161; needs one word from Bruce |
| Cohesive | printed builds whose DP ledger is closed under the skill rules | **0 of 9** (all nine buy the skill their own culture grants +1 in) | new instrument, cycle 2: 18 DP of spend that is either additive or dead; ledger row 162 |
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
| 3 | 2026-09-26 | 1 transcript (flat, unchanged) | 2 (flat: #655 unbuilt; +3 new instruments) | 81,416 / 6 | Direction changed mid-day (#659): the build pass is ordered by assessing the game from the foundation up, so this cycle INSPECTED the open PR #660 (Assessment 1, every row re-derived and **correct**; my own first checker was the bug) and advanced the sweep to **Assessment 2, the economy** (coverage 2 of 9). It measured Assessment 1's priority 1 and **reversed it**: Grit plus tier-appropriate armour DR hold time-to-kill flat at **5.8 / 5.9 / 5.8 hits** across the career, so static HP is not the book's biggest structural bet. The economy itself is **OK with LEARNABLE failing**: a Novice card's true price is **2-6 DP**, not the 2 DP creation and the reference sheet advertise, which is the measured root cause of the 44 DP of unfunded spend above. Three new measurements: Shepherd overspends its pool by 1 DP (9 vs 8), four classes misname an Opposed 4/8/16 charge as "Foreign" (3/6/12), and damage per DP falls 3.00 -> 2.00 -> 1.29 across the tiers, unstated. |
