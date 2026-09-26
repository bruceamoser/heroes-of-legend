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
| Playable | walkthrough transcripts on file | **0** | **UNMEASURED.** No one has ever played this book on paper and written down what happened. This is the largest blind spot in the project and the architect's first weeks exist to close it. |
| Cohesive | Disciplines advertised but not purchasable | **1** (Fate: in the ch08 roster, the ch21 glossary and the ch22 reference sheet; zero cost rows) | defect, ruled 2026-09-16, unbuilt (row 125) |
| Cohesive | Disciplines priced but consumed by no card | **1** (Summon: nine class cost tables, zero card requirements) | defect, ruled 2026-09-16, unbuilt (row 151) |
| Cohesive | card containers indexed (card chapters + ch05 class tables) | 196 cards + 90 class abilities | baseline for the corpus count question |
| Cohesive | cards whose printed tier contradicts their printed requirement | **3 of 196** (ch09 3, ch11 0, ch12 0) | new instrument, cycle 1: parse each card's requirement against the tier word in its own heading. Defect recorded as ledger row 160; ch09's three are titles that outlived the row-150 gating wave. |
| Succinct | dead content: printed places per unusable element | **3 each** (Fate and Summon are each printed in roster + glossary + reference sheet) | 6 printed slots selling two things nothing can use |
| Succinct | words | 81,416 (`wc -w`, 25 chapter files at `eb8b5e0`) | no target set — a target is Bruce's call |

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
