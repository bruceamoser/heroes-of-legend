# Verified defect inventory — run 20260915-1847

Every item below was re-checked by the orchestrator against the source, not accepted from a lens's
self-report. Commands are re-runnable from `quarto-book/chapters`.

## A. Confirmed mechanical defects (exist independently of the purge)

| # | Defect | Evidence | Severity |
|---|---|---|---|
| A1 | Improvised melee printed as `1/1/2 + Brawn` and called "the Basic Unarmed floor" (3 sites) | `15:202`, `15:287`, `15:309`; the floor is `1/2/3` per `08:234` and `21:47` | mechanical |
| A2 | Novice Ember Lance given as `2/4/6` | `08:226`; the live Novice row is `4/6/8`, printed ten lines above at `08:214-216` | mechanical |
| A3 | Shield Block worked example runs on Adept numbers | `16:102`, `16:106` price Standard→Weak as 8→5; the Novice row is 6→4. Correct line: 6 → 4 → (4−3)=1, round total 9, Roric at 4 HP not 3 | mechanical |
| A4 | `15:245` points at a "Stealth column" that does not exist | `15:245` vs `16:37`, whose header is `[Armor], [Class], [DR], [Slots], [Notes]` | dangling ref |
| A5 | ch22 reprints the weapon table with divergent content | `22:373-393` prints "Melee" in Range where `15` leaves the cell blank | duplicate truth |
| A6 | `08:192` asserts a Plate entry requirement of `3 Armor` | no armour table carries a Discipline column (`15:231`, `16:37`); no card requires Armor 3 | dangling rule |

## B. The catalogue's shape (measured)

| Measure | Value | Command |
|---|---|---|
| Named-table rows | 77 (17 weapons, 8 armour, 37 gear, 7 mounts, 8 vehicles) | `15` line ranges 172-188, 232-239, 275-311, 339-345, 403-410 |
| Named-item lines across the 9 files | 400 | `grep -icE "$W" *` per file |
| Name occurrences | 644 | `grep -iohE "$W" * \| wc -l` |
| Named tables' share of ch15 | 126/433 lines (29.1%), 10,369/32,084 bytes (32.3%) | layout-expert, source-level |
| Real starting-kit lines | 9, at `05:59,104,156,201,246,293,340,411,464` | `grep -rn "Starting Kit" 05-classes` |

Researcher's instrument `_researcher-r1-verify.sh` reproduces all of these; it was re-run and matched.

## C. Weapon properties — the load-bearing residue

All seven have consumers. Raw greps over-count badly on homonyms, so the counts below are the
genuine property sites after removing armour-class *Light*, the Human ancestry trait *Versatile*,
and monster *Light Sensitivity*.

| Property | Genuine consumers | The decisive one |
|---|---|---|
| Finesse | `15:200`, `15:214`, `08`, `13:292` example | swaps Agility for Brawn on melee attack and damage |
| Light | `13:290`, `15:217`, `21:133` | the off-hand weapon **must** have it for two-weapon fighting |
| Loading | `15:218`, `21:135` | costs a **Maneuver** to reload |
| Thrown | `15:216`, `15:310`, `09` improvised | gives a 20/60 ft range |
| Reach | `15:215`, `21:129`, `20` stat blocks | extends to 10 ft |
| Two-Handed | `15:219`, `21:137` | both hands, 2 slots |
| **Versatile** | `15:213`, `21:127` | **decorative** — a choice with no numeric consequence (Longsword only) |

Homonym correction, measured: raw `\bLight\b` returns 30 book-wide hits of which **3** are the
property; raw `\bVersatile\b` returns 16 of which **3** are the property (7 are the Human trait).

## D. Orchestrator verification outcomes

- **Reproduced:** the researcher's counts (re-ran its script — exact match).
- **Rejected:** a quoted starting-kit line in `researcher-r1` does not exist. See `PROCESS-NOTES.md`.
- **Rejected, scope error:** "Lyra is invented" — she is real, 41 mentions across 7 chapters.
- **Rejected, scope error:** "the Light property has no consumer" — its consumer is
  `13-combat:270-292`, outside the nine-file source set.
- **Corrected against the orchestrator's own work:** the first book-wide property grep returned
  inflated counts; the homonym correction above supersedes it.
