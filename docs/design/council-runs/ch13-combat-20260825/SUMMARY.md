# Council run: ch13 (Combat) — REJECTED 7-0

**Council:** hol-rulebook (7 voters: librarian, contrarian, researcher,
game-architect, author, editor-in-chief, layout-expert)
**Run dir:** `~/.hermes/councils/hol-rulebook/runs/20260825-2251`
**Verdict:** ch13 does not hold as written. **REJECTED** (7-0 both rounds).
The engine's terminal `rejected` state closed the run directly — no
blind-judge detour (PR #17, the first production use of that state).

## Why the engine closed as `rejected` (not via the judge)
Refute votes (7) ≥ `reject_quorum` (4, default = quorum) → `state: rejected`,
`action: recommend`. This is the mirror of `resolved` (a support-majority
clears the status quo). A unanimous reject is a *terminal conclusion*, not a
deadlock, so it closes to a recommendation (reject + disposition plan) rather
than being forced through the blind-judge mechanism that exists for genuine
impasse. The blind judge is **not** the right tool for a unanimous
conclusion — it is blind to the source and would only re-weigh arguments the
council already settled.

## Findings (14 across 2 rounds, all refute)
Round 1 (f-001..f-007) and round 2 (f-008..f-014) — every lens refuted in
both rounds. Highlights (full detail in `ledger.jsonl`):

- **Wound table is unrollable as printed** — D666 yields 56 achievable
  outcomes; rows 600-633 and 634-665 are unreachable (Crippling Blow /
  Shattered Spirit can never roll), and 222/333/555 are each double-claimed
  by two rows with no precedence rule (exhaustive enumeration, contrarian +
  researcher).
- **Worked example misnumbers NPC damage vs the bestiary** — Knight Standard
  3 (expected 9), Dark Bolt 3 (expected 4), Gust shown Prone-on-Standard
  (Prone is Strong-only); HP ledgers ripple (Kael 11→5, Lyra 10→6).
- **Three phantom cards** — Flurry, Menacing Glare, Dual Wielder appear
  nowhere in the book; Menacing Glare also gates on a skill rank (off-model).
- **Equipment DR drift** — buckler +2 here vs +1 canon; plate DR 4 here vs
  DR 6 in the armor chapter (book-level two-value split).
- **Cover implemented twice with opposite signs** (+defender vs −attacker).
- **Wound table overflows its page in the built PDF** — `style.typ` wraps
  tables `breakable: false`; the worst four outcomes (566-665) render as a
  clipped, overlapping, unreadable band (p.216). Layout-expert verified
  against the actual built PDF.
- **Render/voice hygiene** — doubled table captions ×4, "## Damage Types"
  rendering as body text, double pagebreak (orphan blank p.219), three
  callout H2s surfacing in the TOC, "but wait, Kael is only Adept" draft
  residue, both illustrations are placeholders, `Choke` references a
  suffocating state defined nowhere.

## Position map (final)
| role | r1 | r2 | conf |
|---|---|---|---|
| librarian | refute 0.78 | refute 0.85 | |
| contrarian | refute 0.90 | refute 0.82 | |
| researcher | refute 0.88 | refute 0.93 | |
| game-architect | refute 0.92 | refute 0.94 (rebutting f-003,f-004) | |
| author | refute 0.93 | refute 0.94 | |
| editor-in-chief | refute 0.86 | refute 0.90 | |
| layout-expert | refute 0.90 | refute 0.93 | |

No dissent: every member refuted in both rounds.

## Disposition plan (in `report.md`, three tiers)
- **(a) Mechanical** — re-derive wound-table ranges onto the 56 achievable
  outcomes + precedence rule; split the table (or make it breakable) so it
  renders; drop hard-coded `Table 13.x:` prefixes; unify stand-up cost and
  surprise wording; state the min-1 damage floor; demote callout H2s; fix the
  double pagebreak and the `## Damage Types` heading; excise draft residue;
  fix the art caption.
- **(b) Substantive** — rewrite the worked example to match the bestiary
  (Knight/Dark Bolt/Gust + HP ledger as one atomic edit); resolve the three
  phantom cards; reconcile equipment DR drift; de-duplicate Cover; define the
  off-hand Finesse modifier; define Choke/suffocation; cap Deep Gash bleed;
  state Bane stacking.
- **(c) Design decisions for Bruce** (flag veto-revertible) — defense-roll
  Critical/Fumble; fractional Challenge → modifier mapping; Deep Gash bleed
  at 0 HP; wound-table top-end lethality.

## Process notes
- **Pre-ingest wall lint** caught nothing in either round (members held the
  10-word rule; all verbatim text stayed in `quote_or_excerpt`).
- Two round-1 findings (game-architect, editor-in-chief) were rejected at
  ingest for an **empty `quote_or_excerpt`** — the recurring schema gotcha —
  and fixed with a single targeted member re-dispatch each, then re-ingested
  clean (the ch13 instance of the same failure the skill now documents).
- `note-round` was re-run for round 1 (5→7 findings) and round 2 (6→7) as a
  voter landed late — the superseding-digest pattern, legitimate on the
  append-only ledger.
- **Rendered-briefs vs dispatched-voters gap:** all 7 round-2 briefs rendered,
  but game-architect's dispatch fell through the 3-concurrent cap and was
  caught + dispatched separately before the round closed. Now a documented
  gotcha in the synod-council-ops skill.
- **Decorrelation:** all 7 roles on the config-default (local) model — the
  `report.md` heterogeneity budget records this. Single-model runs carry
  correlated-error risk (Q4); the charter can override per-role models if
  desired.

## Known limitations
- Single-model (local Qwen) for all roles — correlated-error risk untested
  for this run; the charter supports per-role `model:` overrides to buy
  heterogeneity.
- The `rejected` terminal state is new (PR #17); this run is its first
  production use and closed cleanly (close exit 0, verify chain ok, 23
  events).
