# Council run: 12-divine-spells

- **Run:** `20260912-2322` (hol-rulebook charter, 7 voters, quorum 4, max 2 rounds)
- **Chapter:** `12-divine-spells.qmd`
- **Outcome:** all 7 findings refute; t-01 REJECTED (4 refutes); three topics contested and
  taken to the blind judge; **judge SUSTAINED all three** (confidence 0.80)
- **Disposition:** shipped as PR #496 (5 defect clusters)

## Rounds

| Round | Members | Result |
|---|---|---|
| 1 | librarian, contrarian, researcher, game-architect, author, editor-in-chief, layout-expert | 7 findings, all `refute`; prescreen clean; `check` -> continue |
| 2 | librarian, contrarian, researcher | 3 findings; prescreen clean; `check` -> **judge** (max rounds, 3 topics contested) |
| judge | blind (brief + role card only, wall clean) | **sustain** x3 |

## Judge rulings

- `damage-budget-adept-base-row` -> **sustain**. Tide of Life, Soulmend, Briar Wall held a
  two-rank (Adept-tier) prerequisite but printed base 2/4/6; ch08's budget table and ch10 bind
  that tier to 6/9/12, and both same-tier siblings and all ten of ch11's two-rank cards open at
  6/9/12. Re-rowed by the disposition.
- `glossary-term-collision` -> **sustain**. ch21 defines "Resistance" as typed-damage halving and
  ch22 repeats it, while ch12's cantrip of that name grants a Fortitude Boon. The judge established
  this is **the only word shared between the book's 81 glossary terms and its 63 spell names** - a
  unique single-lookup failure. Fixable editorially; left open by design (see below).
- `spell-card-page-integrity` -> **sustain**. Page-breaking confirmed in the rendered PDF. The
  judge **expressly declined to endorse** the round-1 sub-claim that the orphan-heading checker was
  blind, because the fix (PR #495) landed mid-run. It still sustained the topic: the page-breaking
  is independently visible in the PDF.

## Defect clusters fixed (PR #496)

1. Flat damage riders, 5 entries -> `+1 damage tier` (Holy Strike x3, Divine Judgment, Radiant Beam)
2. Adept-tier cards on the Novice row, 3 cards -> 6/9/12
3. Effect-level rung drops, 16 rungs carried forward
4. Damage row pasted as turn counts, 3 cards (Sanctuary, Turn Unholy, Banish)
5. Orphaned effect sentence on Pillar of Light

## Verification

- Effect-level audit: ch12 14 -> **0**; ch11 0; ch09 0. **0 across all 90 runged cards.**
- Flat riders 5 -> 0; row-as-turns 0; orphaned headings book-wide 15 -> 12
- Build exit 0; native-Typst exit 0; 0 doubled stops; rendered PDF checked

## Left open for Bruce

1. Duration scale for the three turn-count cards (implemented default 2/4/6 -> 3/6/9, veto to change)
2. The `Resistance` cantrip: rename it, or reserve the word for the glossary meaning
3. Divine magic's identity: the chapter opens by disclaiming attack magic while 7 Religion cards
   deal radiant damage and ch10 says divine burns the unholy

## Process note: the run could not be sealed

`seal-ruling` refused: *"rulings are binding (design law 3); non-binding ruling refused"*. Root
cause: the ruling schema requires `topic` to match `^t-[0-9]{2,}$` (per ARCHITECTURE 4.2), but the
**finding** schema accepted any string, and the members filed descriptive topic names. Every stage
up to and including the judge's ruling succeeded; only sealing was impossible.

Fixed at the source in synod PR #21: the finding schema now refuses a non-`t-NN` topic **at ingest**,
with 3 regression tests, and the `synod-council-ops` skill now states the rule in the dispatch
prompt template. This run stays unsealed - the findings, ledger chain, and judge ruling are intact
and are the substantive record.

## Council self-correction (worth preserving)

The council caught two of its own errors, unprompted:

- The **librarian** flagged that the round-1 "checker is blind" sub-claim had gone **stale** because
  PR #495 landed mid-run, and warned that corroborating it wholesale would carry a false statement
  forward.
- The **contrarian** corrected an over-quantification: "every interior boundary cuts a card" is off
  by one - the 185->186 turn is clean. It confirmed the defect while trimming the claim.
