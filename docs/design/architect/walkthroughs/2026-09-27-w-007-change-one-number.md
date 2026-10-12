# W-007 — the change-one-number pass (2026-09-27, cycle 34)

**Walkthrough 5 of `references/architect-role.md`:** perturb a budget row, a tier or a rank cost, and
report the blast radius. It is the designer's form of an audit: it asks not "is this legal?" but
"what is this number holding up, and what breaks if it moves?"

**Instrument:** `scripts/change-one-number.py` (new, in the skill). It parses `origin/main`, re-derives
every constant that is supposed to follow from the damage-budget row, and reports, per perturbation,
the printed sites that move, the derived values before and after, and which invariant breaks.
`--selftest` plants a mutated Novice row and requires the derived-constant check to fail (**it does**).

## What the corpus is, as parsed

| Population | Count |
|---|---|
| Card headings (ch09/11/12) | 208 |
| Card outcome blocks printing a Weak/Standard/Strong damage triple | **155** |
| Monster stat-block headings (ch20) | 49 |
| Monster damage triples | **79** |
| Monster `HP n, DR n` lines | **49** |
| Sites printing the DR ceiling | **6** (`16:27`, `20:657`, `20:663`, `21:115`, `22:365`, `22:392`) |
| Sites printing the band average | **1** (`20:657`) |
| Rank ladders parsed from ch05 | (1,2,4) (2,4,8) (3,6,12) (4,8,16) |
| Level-1 pool sentence | 12 DP |

## Part A — are the printed derived constants current?

**Yes: 0 stale.** The three band averages match the live row exactly, and the three ceilings sit
exactly on the invariant boundary:

| Tier | Row | Printed average | Re-derived | Printed ceiling | Weak − 1 |
|---|---|---|---|---|---|
| Novice | 4/6/8 | 5.67 | **5.67** | 3 | **3** |
| Adept | 5/8/11 | 7.50 | **7.50** | 4 | **4** |
| Master | 7/10/14 | 9.59 | **9.59** | 6 | **6** |

The average is the tier's three values weighted by the 3d6 odds: (4·56 + 6·140 + 8·20)/216 = 5.667.
**Neither the odds (56/216, 140/216, 20/216) nor the fact that the ceiling is Weak − 1 appears
anywhere in the book** (`git grep` = 0 hits each). So both numbers are correct and neither is
checkable by a reader.

## Part B — the blast radius, one number at a time

| # | Perturbation | Printed sites that move | Derived consequence | Verdict |
|---|---|---|---|---|
| P1 | Band row **+1** (4/6/8 → 5/7/9) | 155 card blocks, 79 monster triples, 49 HP lines, **6** ceiling sites, **1** average site, 2 cantrip sites | all 3 averages go stale (5.67→6.67, 7.50→8.50, 9.59→10.59); all 3 ceilings one step too low; hits-to-fall at HP 11 falls 2.4/2.0/1.7 → 1.9/1.7/1.4 | **COUPLED** — 6 derived sites must move with the row and nothing says so |
| P2 | Band row **−1** (4/6/8 → 3/5/7) | same populations | Novice ceiling 3 > Weak − 1 = 2, so heavy armour (DR 3, gear, therefore gold-gated and not level-gated) collapses the Novice triple to **1/1/1** | **INVARIANT 3 BREAKS** — the ceiling is pinned by the row, not chosen |
| P3 | Card flat price 2/4/8 → 3/5/9 | 3 flat-price sentences, 18 printed build ledgers | a Novice card costs [2,3,4,5,6] today and [3,4,5,6,7] after, against a 12 DP pool | COUPLED — 18 ledgers re-close, several at negative slack |
| P4 | Foreign rank ladder 3/6/12 → 3/6/14 | 131 rank-ladder entries in the nine class tables | the four ladders stop being a clean doubling chain | COUPLED, and it destroys the one pattern the tables share |
| P5 | Heavy armour DR 3 → 4 | 3 armour sites, 1 DR-size rule | `16:29` requires a DR grant to cost ranks equal to the DR; `10:70` caps a Discipline at rank 3 (and `05:763` prices only ranks 1-3), so **DR 4 is ungrantable by the book's own rule** | **INVARIANT 4 BREAKS** — no live defect, the ladder is self-consistent as printed |
| P6 | Max Discipline rank 3 → 4 | the Master tier definition, every 3-rank requirement, the tier grammar | DR 4 becomes grantable, and the **Adept ceiling 4 becomes reachable for the first time** | the tier grammar and the DR ladder move together, silently |
| P7 | Grit 2/3/4 → 1/2/3 | 2 Grit sites | pool HP × (Grit+1) falls 33/25/20%, so the ledger's measured 73/80/73% share of the pool becomes **110/107/91%** | **INVARIANT 7 BREAKS** at Novice and Adept; Grit is load-bearing |
| P8 | Attribute cap ±2 → ±3 | 7 attribute-cap sites | max modifier +5 → +6; at +6 ordinary failure is 0.0% (P(Weak) 0.46% → 0.00%) and the dial's own −6 justification ("a Master specialist reaches mod +5") lapses | the cap and the dial are coupled through one sentence |

## Findings

**CN-1 (LANDED, PR #726 / `92d990e`) — two derived constants printed as independent facts.**
The DR ceiling and the monster-creation band average both follow from the live damage row, and
neither derivation is stated. The row has already been retuned once, which is exactly when a silent
drift happens: P1 moves 6 derived sites and P2 breaks invariant 3 at the printed ceiling. Repair is
documentation only, on the smallest lever (frame/guidance, no new rule, no number moves):
`16:27` now says the ceiling is each tier's Weak value minus one and moves with the band; `20:657`
now says the average is the tier's three values weighted by the 3d6 odds, which also prints the odds
table the book never carried. Verified in the render; words 84,287 → 84,329 (+42); pages 399 → 399.

**CN-2 (REPORTED, deliberately not changed) — the ceiling above Novice can never bind.**
The largest printed hero DR grant anywhere is **+3** (heavy armour 3, the +3 wards at `11:731` and
`12:241`), and DR does not stack (`16:23`), so the Adept ceiling 4 and the Master ceiling 6 are
unreachable: the ceiling is a Novice-only rule in practice. That is a guardrail against a future or
handmade source, and the values are derived from the band rather than chosen (P6 shows the Adept
ceiling binds the moment the rank cap moves to 4). Lowering 4/6 to the reachable 3 would be new law
and would remove the guard, so nothing moves.

**CN-3 (REPORTED, no change owed) — the condition `Petrified` grants DR +5**, which exceeds the
Novice (3) and Adept (4) ceilings. The ceiling's scope sentence names "armor, talents, and wards",
so a condition is already outside it, and the state itself is incapacitating and immune to
non-magical damage. Read and dismissed as intentional; recorded so the next pass does not re-file it.

## What this pass establishes

The damage row is the book's most load-bearing number: **283 printed sites** ride on it directly
(155 card blocks, 79 monster triples, 49 HP lines), and **6 more encode values derived from it**
without saying so. Everything else the pass perturbed is either coupled to it (P5/P6 through the
rank cap and the ceiling) or load-bearing on its own account (P3/P7/P8). No live defect survives the
pass: the two numbers were correct, and the only thing missing was the arithmetic that makes them
checkable.
