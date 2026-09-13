# Council run - chapter 15, Equipment

**Run:** `20260913-0253` | **Charter:** hol-rulebook | **Closed:** yes | **Chain:** ok (21 events)
**Source:** `15-equipment.qmd` (289 lines, prints as Chapter XVII)
**Findings:** 10 over 2 rounds | **Rulings:** 2 sealed | **Confidence:** 0.85

## Outcome

- **t-01 (conformance) - REJECTED by quorum** (4 refutes).
- **t-02 (internal consistency) - ruled r-001.** The failure-to-teach proposition is **rejected**: the
  Discipline column carries 13 distinct values across 17 rows, a demonstration is in print, and the
  refutation of the proposed remedy went unanswered. A worked example is explicitly **barred** as a
  repair. t-02 closes only on the undefined second range band. Weapon domination is **carried
  separately as a repricing matter**, not dissolved by the ruling.
- **t-03 (cross-chapter canon) - ruled r-002.** Five non-conforming rules are all **defects**, fixed
  additively: the chase rebuilt on the core roll with the speed gap as Boon/Bane; the catalog and
  properties registered in the lookup surfaces; the carry-slot floor placed in the character-creation
  table (not ch15); the Tent restated; armor slot costs made resolvable.

## Why the split matters

Rejecting the pedagogy claim could have taken the domination defect down with it. The judge
separated them: the chapter does teach its lesson, **and** four of its weapon rows are still traps.

## Shipped

| PR | Change |
|---|---|
| **#508** | Repricing (4 pairs -> 0), chase rebuilt, armor Slots column, Two-Handed property, Thrown list completed, Mounted -> Bane/Boon, Spyglass -> Boon, Tent restated, p235 + p228 page-flow, caption comma |
| **#509** | The two-band range notation defined (r-001's single required close) |

Measured: p235 **~7% -> 95.3%** full; p228 **~49% -> 73.5%**; **365 -> 364 pages**; build 0;
native-Typst 0; 0 em-dashes; orphans unchanged at 2; table fidelity OK.

## Released notes

- The **Chases** callout was the only player-facing non-3d6 resolution in the book. Every other d6
  is a DA-facing oracle (random encounters, monster recharge) or a table count.
- The **Mule's reroll** was cleared, not filed: reroll grammar is canon (ch04/ch09/ch18).
- **ch02** is the carry-slot outlier, not ch15 - ch03 and ch15 both carry the floor of 5.
- **Figure 17.2's** trailing comma was the only one of 40 captions in the book to have one. The
  editor-in-chief declined to file it, asserting it matched a book-wide pattern; a direct count
  disproved that.

## Design calls still open (need Bruce)

- **A.** Container cap - backpack/sack/pouch grant unbounded exempt storage.
- **B.** Four-cell minimum vs six-cell variant for the repricing.
- **C.** Unaudited balance leads - Cart vs Chariot, Volatile Reagents vs the 1 sp oil flask, mount spread.

## Not yet applied

The ch21/ch22 **registration pass** (69 catalogued entries, 6 weapon properties) - r-002's item 2,
still outstanding as a separate additive pass.
