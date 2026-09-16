# Council run - named equipment purge (issue #554)

**Run:** `20260915-1847` | **Charter:** hol-rulebook | **Closed:** yes (28 events)
**Sources:** 9 supplied - `15-equipment`, `16-armor-shields`, `08-disciplines`, `05-classes`,
`02-character-creation`, `17-magic-items`, `20-bestiary`, `21-glossary`, `22-reference-sheets`
**Findings:** 10 over 2 rounds | **Rulings:** none sealed | **Confidence:** 0.78

## Outcome

**Verdict: purge the named-equipment catalog in TWO passes rather than one.** PASS ONE relocates
before anything is deleted; PASS TWO deletes the five named tables and repairs the six items they
were silently propping up. Do not begin pass two before pass one lands: deleting first removes play
rather than clutter.

- **t-01 - ruled.** The kit model is not a complete replacement as written. Armament is a single
  select of five options and only one carries a shield, so a two-weapon build cannot be created even
  though the combat chapter defines the procedure and gates it on the Light property. Four of the
  nine class starting kits issue a second weapon.
- **t-02 - ruled.** The residue is not wholesale and not negligible. Every weapon property except
  Versatile has a consumer, but the consumer set is far smaller than raw greps suggest because of
  homonyms. Versatile is decorative and may be retired; the other six must be relocated to the kit.
- **t-03 - ruled.** Pass one lands first.

## This run was superseded in scope

Bruce Moser raised the goals review the same afternoon, re-opening the doctrine the two-pass plan
rests on. See `../equipment-goals-20260915/`, whose ruling r-001 governs. **The purge does not
proceed as written.**

## Verified defect inventory - `VERIFIED-DEFECTS.md`

Six mechanical defects (A1-A6) were re-checked against source by the orchestrator, independently of
the purge. Re-verified against `main` on 2026-09-16:

| # | Defect | Status |
|---|---|---|
| A1 | Improvised melee `1/1/2 + Brawn` called "the Basic Unarmed floor" | **NOT A DEFECT** - `1/1/2 + Brawn` is the locked unarmed/improvised value (decisions #32, PR #377). The run read the Basic-*card* floor (1/2/3) as the unarmed floor. |
| A2 | Novice Ember Lance printed `2/4/6` | already fixed |
| A3 | Shield Block worked example on Adept numbers | already fixed |
| A4 | `15:245` points at a nonexistent "Stealth column" | already fixed |
| A5 | ch22 reprints the weapon table with divergent content | already fixed |
| A6 | `08:192` asserts a Plate entry requirement of `3 Armor` | **fixed in this PR** (the Longsword clause contradicted `15:121`) |

## Superseded by

- `../equipment-goals-20260915/` - ruling r-001, the operating boundary for round 2.
