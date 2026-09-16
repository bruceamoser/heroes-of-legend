# HOL council — round 1, WAVE 3: LIBRARIAN

You are the **LIBRARIAN** lens of the `hol-rulebook` Synod council: the FRAMING and WEIGHING seat.
Read your role card first: `/home/bmoser/repos/synod/references/roles/librarian.md`

## Files (absolute paths)

- **Your round-1 packet**: `/home/bmoser/.hermes/councils/hol-rulebook/runs/20260916-2002/briefs/round-01/librarian.json`
  (problem statement, registered source, the three topics, the 14 locked conventions, the orchestrator's
  cleared list and worked leads).
- **The source under review**: `/home/bmoser/.hermes/councils/hol-rulebook/runs/20260916-2002/sources/11-arcane-spells`
  Chapter 11 exactly as it stands on `origin/main`. Every line number you cite is 1-based into THIS file.
- **Problem statement**: `/home/bmoser/.hermes/councils/hol-rulebook/runs/20260916-2002/problem.md`

**Reading any OTHER chapter**: the checkout at `/home/bmoser/repos/heroes-of-legend` is parked on a stale
branch. Always read the live book:
`cd /home/bmoser/repos/heroes-of-legend && git show origin/main:quarto-book/chapters/<file>.qmd`

## Topics (use these exact ids)

- `t-01` conformance to the locked conventions (budget rows, ranks-equal-grant, gates, style law)
- `t-02` internal consistency (the chapter's own promises against its own 68 cards)
- `t-03` cross-chapter canon (values, rows, terms or mechanics this chapter restates)

## Deliverable — one finding per file

Write **2 to 4 files** at `/tmp/hol-council/11-arcane-spells/findings/r1/librarian-r1-<id>.json`
(ids `f-901`, `f-902`, ...). Each file holds exactly ONE finding OBJECT (never an array).

Exact keys: `id`, `round` (=1), `role` (="librarian"), `topic` (t-01/t-02/t-03), `stance`
("refute"/"support"), `argument`, `evidence`, `confidence`, `rebutting` (use `[]`).
Each `evidence` item: exactly `source`, `claim`, `quote_or_excerpt` (non-empty). `source` is
`11-arcane-spells`, another chapter's filename, or `reasoning`. Every claim carries a line reference.

## WALL DISCIPLINE

The blind judge sees only your paraphrased `argument` and every `evidence[].claim`. **No span of 10 or
more consecutive words may be shared with the problem statement or the chapter text.** Verbatim is
allowed only inside `quote_or_excerpt` (<= ~12 words).

## WHAT THE SIX OTHER LENSES FILED IN ROUND 1 (24 findings, all in the ledger)

Do NOT restate any of these. Your value is (a) ruling on the leads below, (b) the disposition class of
each defect, (c) anything the six missed.

**Card names / cross-chapter canon (t-03)**
- `f-001` the Protection trio reuses the three ward names the divine chapter already prints, with the
  same DR steps and upkeep; the primal branch of the same ladder was renamed when it was written.
- `f-022` (support) ch11's plant section heading agrees with the Discipline table; ch12's heading is the
  divergent side.
- `f-020` (support) eight cross-chapter restatements of this file's figures all still agree.
- `f-015` Arcane Mark's permanent-until-dispelled duration stands on a dispel procedure the book lacks.
- `f-017` three cards push a casting duration into the Action slot, a compound value the field's owner
  does not admit.
- `f-016` (support) the nine-section inventory and the one-card Plants block are required by the
  owning chapters, not defects.
- `f-003` eleven tags appear only in this chapter's headers; four occur exactly once book-wide.
- `f-008` claims the ward section's never-additive DR language contradicts the chapter that owns DR.

**Internal consistency (t-02)**
- `f-002` four cards name a leveled condition in the header and never apply it (Frozen appears only in
  those headers).
- `f-004` the opener over-promises what the outcome blocks do.
- `f-007` unlimited at-will cantrips with no cap on how many effects may be live.
- `f-011` Tilt's first outcome prints no figure where its siblings print 8 and 11.
- `f-013` two header templates run side by side with no rule saying which applies.
- `f-014` the section headings lose a card (21 cards under one heading; Mind-keyed cards filed under
  other sections).
- `f-018` two duration ladders do not rise monotonically (one returns to its weakest value at its top
  rung; another changes time unit from scenes to hours with no bridge).
- `f-019` two cards print a single total covering three targets; the total mostly will not divide and
  the chapter's one division rule covers a two-way split only.
- `f-023` the nine headings do not partition 68 cards to a usable granularity.
- `f-024` two header fields disagree with themselves (range-slot capitalisation; another field).

**Locked-convention conformance (t-01)**
- `f-005` Ember Lance's Standard secondary figure is not half its primary, against the chapter's own
  rounding sentence; the Strong secondary is consistent.
- `f-006` + `f-010` (ONE defect, filed twice) Ward of Iron's Strong line states one damage figure twice
  in a single clause, so it is unreadable whether it applies once or twice.
- `f-009` Turn the Air is Adept but its only damage figure is 1.
- `f-012` (support) the ward ladder's ranks-equal-grant relation and its ceiling compliance are legal.
- `f-021` the chapter's only plate sits inside a card run, against the house pattern for every sibling
  plate in the book.

## ORCHESTRATOR-VERIFIED — carry these as settled, do not re-derive

1. **`f-008` is REFUTED.** The chapter that owns DR states in its own body that sources do not add, that
   the highest single source governs, and that armor, talents and wards do not add together
   (`16-armor-shields.qmd:23`), and its worked example uses the middle ward of this very ladder by name
   and takes the larger single number (`16-armor-shields.qmd:33`). This chapter's Protection preamble
   states the same rule. `f-012` reached the same conclusion independently. The residual question lives
   in `16-armor-shields.qmd:29` (temporary grants that DO add) versus its ward sentence, not here.
2. **`f-003`'s headline over-reaches.** A book-wide census of every `Keywords:` field (196 fields, 68
   distinct tags) shows chapter-private tags are the book's practice, not a ch11 defect: ch12 carries 14
   private tags and ch09 about 20. The defensible residue is narrower: tags that occur exactly once
   book-wide, `Utility` naming a category rather than a mechanic, `Ward` colliding with the DR meaning
   the same section defines, and inconsistent pair order.
3. **Cleared:** every printed damage triple in the chapter sits on its tier's band (0 off-row). That
   measures the triples that exist, not whether each card carries one.

## Anti-anchoring

Your deliverable is an INDEPENDENT audit plus the framing rulings above. A filing that only comments on
items already in the ledger is wasted. Two specific questions are yours to answer:
(a) **is the topic split the right frame** for this chapter, or does the real defect live outside the
three topics; and (b) **what disposition class does each defect belong in** (MECHANICAL / SUBSTANTIVE /
DESIGN), and which defects are chapter-local versus multi-file.

## Self-audit BEFORE you reply

For each file: re-parse it (one object, exact key set, non-empty `quote_or_excerpt`), run
```
python3 /home/bmoser/.hermes/skills/autonomous-ai-agents/synod-council-ops/scripts/member-selfcheck.py \
  /tmp/hol-council/11-arcane-spells/findings/r1/librarian-r1-<id>.json \
  /home/bmoser/.hermes/councils/hol-rulebook/runs/20260916-2002/sources/11-arcane-spells \
  /home/bmoser/.hermes/councils/hol-rulebook/runs/20260916-2002/problem.md
```
and run your own 10-gram overlap check of `argument` + every `evidence[].claim`. Zero overlap required.

## DONE line

File count and paths; one line per finding (`f-NNN [topic] headline — 11-arcane-spells:LINE`); the
selfcheck and overlap results; the disposition class you assign; and **every observation you did NOT
file**, with the reason. You cannot ask questions. Work autonomously.
