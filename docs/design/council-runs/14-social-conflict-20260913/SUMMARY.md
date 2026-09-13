# Council run 20260913-0203 — Chapter 14, Social Conflict

**Verdict: do not publish as it stands.** Two topics REJECTED outright, one carried to a blind
judge and sustained. Recommendation confidence 0.78.

| | |
|---|---|
| Run | `20260913-0203` |
| Voters | 7 (librarian, contrarian, researcher, game-architect, author, editor-in-chief, layout-expert) |
| Quorum | 4 · max_rounds 2 |
| Round 1 | 7 findings, all `refute` |
| Round 2 | 3 findings (librarian, contrarian, researcher) |
| Outcome | t-02 **REJECTED** (4 refutes); t-03 **REJECTED** (4 refutes); t-01 contested → blind judge |
| Judge | sustained t-01; sealed as **r-001** |
| Sealed | `r-001` — **second consecutive clean seal** |
| Disposition | PR #504 (page-flow, ruling r-001) |
| Run trail | `docs/design/council-runs/14-social-conflict-20260913/` |

## Topics

- **t-01** conformance to the locked conventions
- **t-02** internal procedure consistency
- **t-03** cross-chapter canon

## The three substantive defects

### 1. Who scores points? (t-02)

The round structure says the party's **face** makes one roll from Persuasion, Deception,
Intimidation or Performance. The worked example's deciding round is rolled by **Lyra** (not the
face) using **Insight** (not in that list), and it is scored as a **point** although the chapter's
own assist rules say allied contributions feed the face a **Boon**. Line 140 confirms the intent is
broader than the enumeration ("The Blade might read the room with Insight").

**Measured cost of the ambiguity:**

| Model | Result |
|---|---|
| Face only | 1.2824 successes/round → **2.5835 rounds** to 3 (exact Markov solve, MC-confirmed) |
| Four contributors scoring | reach 3 in **one round ~99.5%** of the time |

So allowing multiple scorers does not tilt the race, it cancels it. The ambiguity is the
difference between a three-round negotiation and a one-round formality.

### 2. The attitude ladder vs the success table (t-02)

Both tables key off the same tiers and return **opposite verdicts for the same roll**, with nothing
scoping either:

| Roll | Attitude table | Success table |
|---|---|---|
| Weak vs a Friendly NPC | "sufficient for minor favors" — success | "Your argument falters" — the NPC scores |
| Standard vs a Hostile NPC | "Standard fails, they dig in harder" — failure | "You score a point" — success |

Line 84 sides with the success table, so the attitude table is contradicted inside the chapter.
**The chapter's own worked example walks through both collision points** — round 1 leaves the warden
Friendly, round 2 is run against a Hostile lieutenant.

Related, verified by the orchestrator (not filed by any lens): the success table has **no row for a
lost exchange**. It scores by the party's own tier, so a party can bank a point on an exchange the
NPC won.

### 3. Passive Insight tiered as a contested value (t-03)

ch14 converts a static passive Insight score into a **tier** and compares tiers. Passive Insight is
Knowledge + 7, so it spans **5-9 only** — always Weak or Standard, never Strong — meaning **no NPC can
ever post a Strong opposition**.

| | |
|---|---|
| Face (+3) beats a passive 9 | **196/216 = 90.74%** |
| …with a Boon | **35/36 = 97.22%** |
| NPC takes the exchange | **20/216 = 9.26%** (Weak band 10/216 + the exact-9 tie band 10/216) |

**Round-2 narrowing:** the contrarian showed the passivity charge overreaches — a static score
opposing a roll is book-sanctioned (ch06:71 names "Stealth versus passive Insight" and ch13 runs it).
The genuinely unreplicated move is **tiering** it. ch13:529 compares a total against the number
("19 beats 7 easily"); ch13:230 grades the roller's own tier. Fixing ch14 means adopting one of those,
not abandoning the mechanic.

### Smaller confirmed items

- **The `Critical` row is unreachable.** Line 56 routes three natural 6s to an automatic **Strong**
  result, which the same table scores as 2 successes, so "Win the conflict immediately" has no
  trigger. ch22:28 pairs Critical with **"Automatic Strong + special outcome"**, so line 56 is also
  out of step with canon. 1/216 either way.
- **The social vocabulary is defined nowhere.** ch21 has zero entries for Attitude, its four names,
  Social Conflict, the Face, or Stakes; ch22 has no attitude or social-conflict section at all.
- **ch17:242 restates the ladder as a two-step jump** (Neutral → Allied, skipping Friendly) against
  ch14's explicit one-step rule.
- **Bane and Potence are absent from the chapter entirely** — zero occurrences, while ch06:59-65
  defines Potence (Boon 2 = 5d6 keep 3) and both callouts grant "a Boon" with no stacking guidance.
  An omission, not a contradiction.

## t-01 and the sealed ruling r-001

The "Failing Forward" sidebar was stranded alone on a printed page ~74% blank, caused by a
hand-authored page break immediately after it that blocked reflow; the note missed fitting the
previous page by roughly one line. The same pattern repeated after the worked example's Outcome
paragraph. The layout lens measured callout box extents from 200 dpi pixel analysis and dropped two
false candidates (one pdftotext extraction artifact, one vision claim disproved by pixel analysis).

**The judge sustained it**, reasoning that recurrence elsewhere in the book does not make it house
style: *a convention yields intended, predictable output, whereas this blank page is an arbitrary
break meeting a near miss.* Conditions: repair confined to page flow; verified on a rebuilt PDF;
other chapters' instances recorded but not a dependency; the relocate-the-note alternative accepted
if the breaks prove load-bearing.

**Fixed in PR #504** (main `5dfbc98`): both breaks removed. Book **366 → 365 pages**; the stranded
page now **99.6% full**; no new orphaned headings; build 0, native-Typst 0, 0 em-dashes.

## Council self-corrections worth keeping

- **The contrarian refuted part of two round-1 findings** and was right: f-001/f-003 were one defect
  filed twice, and f-003's NPC-scoring rate was wrong (4.63% understated the tie band; the true
  figure is 9.26%). The researcher then independently reproduced the correction in round 2, solving
  the race by exact Markov chain.
- **The researcher corrected its own round-1 figure** of its own accord.
- **The librarian declined to assert the lost-exchange row** during synthesis because no finding file
  in the ledger made that claim — it was orchestrator-verified, and it said so rather than laundering
  it into the council's voice.
- The author filed the defect the researcher spotted but deliberately left unclaimed (one finding per
  member), and the game-architect added the assist-rules angle that made it decisive.

## Open for Bruce (design calls)

1. **Who scores?** Face-only, or do allies score too?
2. **Attitude ladder vs success table** — which governs which stage of play?
3. **Passive opposition** — compare the total to the number (ch13:529), or grade the roller
   (ch13:230)?
