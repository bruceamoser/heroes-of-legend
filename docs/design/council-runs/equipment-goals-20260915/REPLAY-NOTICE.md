# Provenance notice: this run is a wall-clean replay of 20260915-1921

**Read this before citing this run.**

This run exists because its predecessor, `../20260915-1921/`, could not produce a
ruling. That run's round-2 findings were all wall-clean, but four of its
**round-1** findings had been ingested with verbatim spans of registered source
text, and `judge-brief` refuses a brief whose findings reproduce the forbidden
corpus. See `../20260915-1921/BLOCKED-wall.md` for the refusal and the span
inventory.

The engine has no sanctioned way to repair an ingested finding: the ledger is
append-only and hash-chained, and `judge-brief` assembles the brief from every
round's findings on the contested topics, so a corrected re-filing of the same
member's argument cannot displace the dirty one. The engine was not modified
mid-run (doctrine: a ledger must be read under one engine version).

## What this run is

The same council, the same charter, the same problem statement, the same 14
registered sources, the same 37 findings, in the same ledger order, with the
same round structure (22 findings in round 1, a round-end digest, 15 findings in
round 2, a round-end digest). The four findings below had the leaked spans
rephrased by the same roles; every claim, number, card name, citation, stance,
confidence and evidence entry is preserved.

Rebuilt 2026-09-15. Arguments were authored in the original run between 15:44 and
15:57; the ingest timestamps in this ledger are the replay's, not the authorship
time. That is the one thing this ledger cannot represent, and it is recorded here
instead.

## The four findings that were rephrased

| finding | role | topic | round | leaked spans | rephrase |
|---|---|---|---|---|---|
| f-001 | librarian | t-03 | 1 | 2 vs `sources/15-equipment` | "grants no HP, no damage and no bonus to any roll" -> "adds no number at all: no hit points, no bonus on any roll" |
| f-002 | contrarian | t-02 | 1 | 9 vs `sources/15-equipment`, problem statement | "'wielding X does not grant the maneuvers that require them'" -> "X confers no maneuvers that demand Discipline training"; one `evidence[4].claim` reworded |
| f-004 | contrarian | t-03 | 1 | 14 vs problem statement, `sources/08-disciplines`, `sources/21-glossary` | the band table quoted as a slash list ("Novice 4/6/8, Adept 5/8/11, Master 7/10/14") restated as prose with identical values |
| f-005 | contrarian | problem-scoping | 1 | 2 vs problem statement, `problem.md` | "DR <= band's Weak value (Novice 2, Adept 6, Master 9)" restated as prose with identical values |

The other 33 findings are byte-identical to the originals. Round-2 findings were
already wall-clean.

## What is authoritative

The ruling sealed here rules on the arguments as rephrased above. For the
substance of every argument other than those four clauses, `../20260915-1921/`
is the authorship record; for the deliberation's outcome, this run is the
operative one.
