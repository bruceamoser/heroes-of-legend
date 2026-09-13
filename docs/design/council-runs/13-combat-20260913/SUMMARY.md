# Council run 20260913-0025 — Chapter 13, Combat

**Verdict: chapter rejected on internal consistency (t-02); two topics sealed as binding rulings.**
**First council run to seal cleanly.**

| | |
|---|---|
| Run | `20260913-0025` |
| Voters | 7 (librarian, contrarian, researcher, game-architect, author, editor-in-chief, layout-expert) |
| Quorum | 4 · max_rounds 2 |
| Round 1 | 7 findings, all `refute` |
| Round 2 | 3 findings (librarian, contrarian, researcher) |
| Outcome | t-02 **REJECTED** (5 refutes, quorum met); t-01 and t-03 → blind judge |
| Judge | confidence 0.90, both topics **sustained** |
| Sealed | `r-001` (t-01), `r-002` (t-03) |
| Disposition | PR #501 |

## Topics

- **t-01** conformance to the locked conventions
- **t-02** internal procedure consistency
- **t-03** cross-chapter canon

## Defects found and verified

| # | Defect | Evidence | Status |
|---|---|---|---|
| 1 | Plate DR 4 in ch13 (x3) and ch20 (Knight 4, Orc Warchief 3, Death Knight 5) vs canon 6 | ch16's ladder reserves 4 for Breastplate/Half Plate | fixed |
| 2 | Half and three-quarters cover mechanically identical | ch13:424-425, ch21; tower shield nullified | **design call** |
| 3 | `Escape action` defined nowhere | 4 occurrences, 0 definitions; ch15's manacles do define one | **open** |
| 4 | `failed death save` referenced, never defined | 1 occurrence book-wide | fixed |
| 5 | Numeric roll modifiers (`+2 Defend`, `-2 Surprised`, ch22 cover `-1/-3`) | violates the Boon/Bane law | fixed |
| 6 | `Hidden` absent from both lookup surfaces | the only condition with zero coverage | fixed |
| 7 | `Blinded` disagrees: double Bane (ch13) vs reduced one tier (ch22) | ch13 is canon for conditions | fixed |
| 8 | Ambush example's morale roll | says Bane, rolls 3d6; morale admits no modifiers | fixed |
| 9 | Table 13.3's caption orphaned; near-empty page | rendered PDF | partially (pagebreak) |
| 10 | Dying is nearly non-lethal; Weak band memoryless | 55/216 no-op; death 1/161 = 0.62% | **design call** |

## The dying analysis (independently reproduced three times)

| Band | Ordered 3d6 | Effect |
|---|---|---|
| Critical (666) | 1/216 | awake at half HP — terminal |
| Strong (15+) | 19/216 | stable at 1 HP — terminal |
| Standard (9-14) | 140/216 | unconscious, stable — terminal |
| Weak (1-8) | 55/216 (25.5%) | "still dying" — **no-op, memoryless** |
| Fumble (111) | 1/216 | Death |

- P(eventual death) = (1/216) / (1/216 + 160/216) = **1/161 = 0.62%**
- Expected rolls = 216/161 = 1.34
- The D666 `666` Death row = 1/216 and fires on a **below-half-HP** trigger, so the bloodied moment out-kills the whole dying state
- **Text-dependent:** if Standard were a pause rather than an exit, death would be 1-in-21 (~4.8%) over ~10 rounds — an 8x swing resting on one sentence
- ch21 promises a "worsen" outcome the table never delivers

## Corrections made to earlier claims

- **ch21's 14-name enumeration is not a defect.** It lists the *un-levelled* condition names; each levelled condition has its own entry below. The real gap was `Hidden` alone. (Round-2 contrarian.)
- **Figure 15.1/15.2 in ch13 is not a defect.** It follows a book-wide printed-number offset (ch13→15.x, ch14→16.x). (Round-2 librarian.)
- **Plate DR was filed twice** (f-001, f-003) but is one remedy.

## Orchestrator-side work this run

- **synod PR #22**: `seal-ruling` required the judge to assert `binding: true` — a design law, not judge knowledge. Now stamped, mirroring `sealed_at`; explicit `false` still refused. Root cause of why no test caught it: `tests/_engine.py::ruling()` hard-codes `binding: True`, so the suite asserted the law on the judge's behalf and never exercised a real judge file. 131 tests OK.
- **Skill patches**: the judge file's shape is the engine's (one ruling object per topic, no wrapper); role-card paths differ by tier (core four flat, HOL customs under `roles/hol/`); verify the seal path on a toy run before dispatching seven members.

## Open for Bruce

1. **Half vs three-quarters cover** — mechanically distinct or deliberately identical? If distinct, double Bane is the option that keeps the Boon/Bane law intact. Also decides whether the planted tower shield does anything.
2. **Dying lethality** — the Weak band needs a real consequence that accumulates; it is the natural home for ch21's promised "worsen".
3. **`Escape action`** — define the escape (cost, roll, opposing side) or drop the term from the condition rows.
