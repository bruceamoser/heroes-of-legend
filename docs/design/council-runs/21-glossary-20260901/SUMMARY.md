# Council Run Summary — ch21 Glossary (2026-09-01)

Run: `20260901-2007` · Council: hol-rulebook · Verdict: **REJECTED 7-0** (round 1, unanimous refute, no rebuttals, no impasse, no judge) · Chain: ok (13 events) · Confidence: 0.92

## Problem
Audit ch21-glossary.qmd (201 lines) as a publishable unit. Test: every definition must match the authoritative chapter (the glossary is a summary, never a rule source), and every load-bearing term the book uses must be present.

## Members & positions (round 1)
| Role | Stance | Key findings |
|---|---|---|
| librarian | refute | Spell Weaver phantom talent; missile/thrown +Agility contradiction; PV "Adds to DR" unanchored; Fortune's Favor narrowed; completeness gaps (Rest, Recharge, Dazzled/Petrified) |
| contrarian | refute | Spell Weaver ×2 entries; missile/thrown self-contradiction; secondary precision defects |
| researcher | refute | missile/thrown wrong (ch08/ch15 flat); Fortune's Favor wrong; Spell Weaver; Surprise/Wound incomplete; completeness gaps. One claim (Attunement artifact exemption "invented") DISPROVED by direct read of ch17:377 — recorded as considered-and-kept |
| game-architect | refute | Attribute-Scaled Damage budget-breaker (missile +Agility); Spell Weaver; Fortune's Favor; Dazzled/Petrified missing; Recharge missing; "chain" vocabulary. Verified clean: budgets, costs, gates, taxonomy, HP, Background DP, Eccentric, Attunement, found-not-bought, X-conditions |
| author | refute | "chain" self-contradiction (Ability vs Spell Card); Spell Weaver orphan; en-dash prose ranges; voice otherwise holds |
| editor-in-chief | refute | rests missing; Recharge missing; Dazzled/Petrified missing; missile/thrown contradiction; Spell Weaver; chain; en-dash; structure/cross-refs hold |
| layout-expert | refute | "3-4 hours"/"9-12" hyphen vs ch19 en-dash; mixed minus glyphs; alphabetization slips. Clean: zero em-dashes, heading hierarchy, pagebreaks, Illo pattern (book-wide #36), all @sec anchors resolve |

## Disposition → implemented
One atomic PR **#388** (squash-merged, branch deleted): 25 insertions / 15 deletions in 21-glossary.qmd only. Build exit 0; new entries verified in the rendered PDF via pdftotext.

- Mechanical: Spell Weaver phantom removed (both Concentration entries, aligned to ch10:99); Attribute-Scaled Damage reworded to ch08:195/ch15:52 (missile/thrown FLAT, min-1 hedge, concrete bases); "chain" → growing-card language; Dazzled + Petrified added to Condition list AND as entries (ch13 Table 13.3); Fortune's Favor → "reroll 1, 2, or 3" (ch09); en-dash prose ranges (3–4 hours, 9–12); new entries Rest (ch19), Recharge (was undefined book-wide despite ~12 stat-block uses), Finesse (ch15); Surprise gains "acts first in the opening round" (ch13:195); Wound gains the Standard Medicine +1 heal (ch13:322); alphabetization slips (Asleep/Burning, Lift/Push).
- Design-flavored (implemented default, veto-revertible): Protection Value "Adds to DR" → "+1 to your defense roll" (ch22:303 "defensive stance bonus" + ch13 defense-roll modifier table; the book never states PV's effect). Logged decisions-pending #63.
- Considered and kept (vetoable): Attunement artifact exemption (ch17:377 confirms — researcher claim was a false positive, verification trap honored); Arcane Focus/Holy Symbol "Required for some spells" (Eccentric Spellcasting exception ch05:250).
- Open design question surfaced: Cover double-implementation (ch13:124 defense +1/+3 vs Cover section attacker −1/−3) — book-wide, tracked in #371 D/E; added decisions-pending #64. No glossary edit (glossary already matches the Cover section).

## Wall & process notes
- Pre-ingest wall lint: 8/8 findings clean (zero leaks) — waves of 3+3+1.
- No judge brief needed (reject-majority closes directly per PR #17).
- One researcher finding was a false positive (Attunement) — caught by orchestrator-side verification before any edit; no re-dispatch needed (finding recorded, claim corrected in synthesis).
