# Council run 20260915-2004 — 09-talents-abilities (Wave 3, chapter 1)

## Verdict

**REJECTED on all three topics.** No judge was needed (reject-majority is terminal per topic).

| Topic | Subject | Support | Refute | State |
|---|---|---|---|---|
| t-01 | conformance to the locked conventions | 0 | 5 | rejected |
| t-02 | internal consistency (the chapter's own rules vs its own 72 cards) | 0 | 7 | rejected |
| t-03 | cross-chapter canon (values restated from their owning chapter) | 0 | 5 | rejected |

Closed by librarian synthesis: `recommendation.json`, confidence 0.75, `rulings_applied: []`, 2 dissents preserved verbatim (librarian t-01, layout-expert t-02). `verify`: **chain ok, 34 events**.

## Telemetry

- 7 voters chartered (librarian, contrarian, researcher, game-architect, author, editor-in-chief, layout-expert), 7 packets rendered, **7 dispatched** (rendered = dispatched, reconciled).
- 1 round. 28 findings ingested (f-001..f-028): contrarian 4, editor-in-chief 4, game-architect 4, layout-expert 4, librarian 4, author 4, researcher 4.
- Wall rejections: **0**. All 28 findings passed the pre-ingest lint before `finding` (28/28 clean by both instruments: the sanctioned `prescreen.py` and `member-selfcheck.py`).
- Judge: not convened (no contested topics). Briefs for the judge were never rendered, which is the engine's own signal that the reject-majority held.
- Source registered: `09-talents-abilities` (md5 `63ecac8e…`, byte-identical to the chapter at `origin/main` c244e4d — verified before dispatch so that every cited line number is valid).
- Problem statement is the run's eval harness; its locked conventions were re-derived against current canon before scaffolding (the retired 2/4/6 · 6/9/12 · 9/15/21 bands are NOT law; the live rows are Novice 4/6/8, Adept 5/8/11, Master 7/10/14).

## What the council found

Headline defects, all reproduced by the orchestrator against the file before implementation:

1. **Twelve of 40 maneuver cards sat off the Novice row** — six still printed the superseded 2/4/6 band one figure per line (the renumber could not see a card that spells each value out), and six printed 5/8/11 or 7/10/14 blocks.
2. **Death Blow carried the book's only damage ceiling of 21** (`09:78`), against the Critical table's "Never above 14" (`06:168`).
3. **Parry paid a counterattack of 2**, a figure on no live row.
4. **The chapter's own opener was contradicted by its cards**: the header lesson named four fields while twelve cards carry a fifth (`Kit`); no card printed its tier though the opener makes price and gate tier-dependent; the maneuver opener understated its own non-weapon Discipline list.
5. **Cross-chapter residue** (t-03): the retired band survives as dependent restatements at `08:226`, `20:142` and `11:171-175`, plus `05-classes` glosses and ~12 off-row class-ability figures.

## Process notes (what to reuse next time)

- **The pre-ingest wrapper was needed and is now scripted.** `prescreen.py` reads only `<findings_dir>/<role>-r<round>.json`, and members write one finding per file, so `b/c/d` files were invisible to a plain invocation. `lint-all.py` stages each file alone under its canonical name and runs both the sanctioned lint and `member-selfcheck.py` per file.
- **A negative control was run on that wrapper before trusting it**: an 18-word verbatim span planted in a synthetic finding was caught and named by both instruments, exit 1. The gate has been seen to fail.
- **Self-inflicted false zeros, twice:** a hand-rolled `subprocess` grep built with a path glob (no shell expansion) returned "no hits" for the retired band that in fact appears in the book; and a POSIX-class regex for a "three-outcome block" missed the eight cards that print each figure as a bare quantity. Both were caught only because a positive control was kept in the same script. Grep with real file lists, and keep one needle you know is present.
- **A render check must normalise whitespace.** `pdftotext` wraps prose, so exact-substring matching reported three "missing" changes that were present; two of the three flags were the checker's own fault (a typographic apostrophe, and a value that had become correct), not the chapter's.
- **The chapter's own statement beat my brief.** The brief asserted 29 Talents / 39 maneuvers; a lens measured 28 / 40 and was right. The brief's convention "the retired rows are valid nowhere in the book" was also too strong: they survive as spelled-out restatements, which is exactly what `#546` exists for.
- **Fork discipline:** the t-02 fork (maneuver block vs tier) turned out to be governed by a decided ruling (#103) that predated the refactor; the council's job was to notice that the cards implement a rule the ruling retired. Checking `decisions-pending.md` for a prior ruling BEFORE framing a fork saved a round.

## Known limitations

- The run records one member's dissent as support on t-02 (layout-expert f-015) while the topic tally reads 7 refutes / 0 support; the engine counts the latest stance per member per topic, per the charter's consensus model.
- The ch09 row-count claim of "72 cards" is confirmed, but the family split is 28 Talents / 4 Basic Attacks / 40 Weapon Maneuvers, not the split the problem statement's first draft carried.
- Two Tier-2 substantive items (the spell-recast ceiling against ch10's limits, and the class-effect duplicates) were **not** implemented in the same session; they are described with per-line scope in the council recommendation and are the natural first work for the next pass on this chapter.
