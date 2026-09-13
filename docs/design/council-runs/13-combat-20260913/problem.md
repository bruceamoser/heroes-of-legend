# Problem: Council review of Chapter 13, Combat (quarto-book/chapters/13-combat.qmd)

You are the hol-rulebook council. Audit this chapter as a publishable unit of the Heroes of Legend
TTRPG rulebook and produce a disposition plan. Do NOT fix anything; file findings only.

## Topics (use these exact ids in your finding's `topic` field)

The finding schema only accepts a topic id of the form `t-NN` (or the literal `problem-scoping`).
Pick the one your finding belongs to:

- **t-01** — Conformance. Does the chapter obey the locked conventions listed below? Cite the
  convention you believe is violated.
- **t-02** — Internal procedure consistency. Initiative, the combat round, maneuvers, making an
  attack, who rolls, defense, damage types, effects, conditions, surprise, grappling, two-weapon
  fighting, non-lethal attacks, morale, dying and death, wounds, cover, and the worked example. Does
  the chapter contradict itself, leave a procedure incomplete, or state a rule twice in two ways?
- **t-03** — Cross-chapter canon. Where this chapter and another chapter state the same rule
  differently, one of them is wrong. Known suspects from the earlier pass: plate DR (ch16 says 6;
  bestiary stat blocks use 4 and 3) and Cover (defense modifiers +1/+3 versus attacker modifiers
  -1/-3). Verify these and look for others.

## Scope

The registered source `13-combat`. This chapter is the source of record for the combat procedure and
for the condition table that the rest of the book relies on.

Chapters that depend on it or mirror it: ch06 (core resolution, tiers, Boon/Bane), ch08 (damage
budget, rank ladder), ch09 (talents and maneuvers), ch10 (magic framework), ch11 and ch12 (spell
cards that reference conditions and damage types), ch15 (equipment, weapons), ch16 (armor, DR),
ch19 (GM guidance), ch20 (bestiary stat blocks), ch21 (glossary).

## Already fixed in the earlier pass. Do not re-report these.

A previous council run rejected this chapter and its findings were implemented via PR #370 and
PR #372. Already repaired, and therefore NOT defects to file: the double pagebreak before the
midpoint art; the literal `## Damage Types` text that was rendering as prose; the wound table
re-derived onto the 56 achievable D666 outcomes with a precedence rule for named triples; the worked
example reconciled to the bestiary (Knight 3 to 9, Dark Bolt 3 to 4, Gust Prone-on-Standard to a
10 ft push) with its HP ledger re-derived; three phantom cards (Flurry, Menacing Glare, Dual Wielder)
replaced with canon defaults; off-hand Finesse adds Agility; minimum 1 damage as a stated rule;
surprise unified to "first roll"; Prone stand-up unified to Maneuver.

If you believe one of those repairs was itself wrong or incomplete, say so explicitly and give the
evidence; do not simply restate the original finding.

## Locked conventions the chapter must satisfy

- **Damage budget is FLAT.** Novice 2/4/6, Adept 6/9/12, Master 9/15/21 on Weak/Standard/Strong.
  No damage dice anywhere in the book; the only sanctioned dice are 3d6 one-roll checks, 4d6 for
  Boon/Bane (keep highest or lowest three) and explicit random-effect tables such as the d6
  critical table and the D666 wound table.
- **One-roll principle.** The attack roll IS the damage roll. There are no separate damage rolls,
  and effects resolve by tier without a second roll.
- **Conditions are levelled.** A condition with a scale carries its number (Slowed 10, Poisoned 2,
  Burning 3). Invent no conditions and no stats; the condition table in this chapter is canon.
- **Resistance and Vulnerability.** Resistance halves damage of a specific type, round down;
  Vulnerability doubles it.
- **The rung escalation law (ruled 2026-09-12).** A higher rung never loses an effect the rung below
  it promised. Deepening takes three sanctioned shapes: **add** (a new effect joins the old one),
  **intensify** (a scaled condition's number climbs), or **tighten** (the condition becomes a
  stricter one on the same ladder, such as Prone to Restrained to Stunned). A stricter condition
  substituting for a milder one is a legal tighten, not a subtraction.
- **ZERO flat +N damage riders (book-wide law, weapons rework 2026-08-19).** No card or stat block
  may add a flat damage number. The only sanctioned damage booster is the tier bump, phrased
  "+1 damage tier".
- **Weapons are flavour; cards carry the damage.** No weapon contributes damage of its own.
- **Zero em-dashes in book source text.**
- **Card and stat block names are unique book-wide.** A name that exists nowhere else is a phantom.

## Output

One finding each, on the topic above where your lens has the most to say. Findings are decision
inputs, not essays. Where you assert a defect, give the evidence that makes it checkable.
