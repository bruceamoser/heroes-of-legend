# Shared Maneuvers: useful choices beside the Main Action

**Issue #1157 — proposals for Bruce’s review.** The agreed direction is a focused
expansion of shared Maneuvers. Ordinary movement, conversion rules and class
signatures are unchanged. No variable-cost cards are added.

The existing 23 shared Maneuvers include forms, movement and condition care, but
leave fewer choices for an archer preparing a shot, a duelist creating an opening,
or an explorer helping someone across an obstacle. These ten additions address
those situations. They are original HOL proposals based on the fresh catalog and
agreed goals; no new external source or legacy card was used.

## What each addition is for

| Card | Level and requirements | Decision it creates | Comparison and boundary |
|---|---|---|---|
| [Take the Measure](../cards/take-the-measure.md) | 1; Marksmanship 1 | Hold position for a better shot or spend the Maneuver defending/repositioning | One self-attack Boon, not universal ranged damage or a free attack; any displacement spoils it. |
| [Sell the Feint](../cards/sell-the-feint.md) | 1; Arms 1 and Subterfuge 1 | Commit the Maneuver to an adjacent duel | No control over the enemy’s actions. Unlike Blade passives, it costs a Maneuver every time. |
| [Lantern in the Palm](../cards/lantern-in-the-palm.md) | 1; Radiance 1 | Bring light for everyone, including pursuers | Ordinary equipment can still illuminate. No detection, damage or magical-darkness override. |
| [Arrive under Guard](../cards/arrive-under-guard.md) | 3; Guard 2 and Athletics 1 | Reach an ally and cover its next defense | Protector’s Close the Gap moves safely and grants continuing self-defense; this approach provokes and protects one ally’s next roll. |
| [Haul Them Home](../cards/haul-them-home.md) | 3; Athletics 2 and Guard 1 | Rescue a prepared companion over an edge | Requires a secured rope, footing and supportable load. Does not replace Grapple release or ordinary rope use. |
| [Ice across the Break](../cards/ice-across-the-break.md) | 3; Frost 2 and Wilderness 1 | Create a short crossing the party—and enemies—can use | A fixed, temporary bridge, not flight, ice armor or a damage zone. Unlike Running Vault it helps others but needs supports. |
| [Draw the Current](../cards/draw-the-current.md) | 3; Storm 2 and Scholarship 1 | Spend setup to add a small shove to a damaging spell | Arcanist’s Deliberate Spark needs no Maneuver on Standard/Strong; this costs one and also works on Weak. Neither adds direct damage. |
| [A Word Apart](../cards/a-word-apart.md) | 3; Influence 2 and Subterfuge 1 | Pass advice privately during a negotiation | Compared with A Verse for Courage, adds ordinary-hearing privacy and scene-long readiness, but requires adjacency and a specific social task. |
| [The Wind Makes Room](../cards/the-wind-makes-room.md) | 7; Storm 3 and Guard 1 | Reposition several companions through bad ground | More recipients and terrain handling than Chorus Advances. Grants no attacks; Leader’s Coordinated Rush remains a different, offensive command. |
| [Cast through the Reflection](../cards/cast-through-the-reflection.md) | 7; Scholarship 3 and Mind 1 | Spend setup to cast from a useful angle | Arcanist’s Bent Trajectory does this at an adjacent origin without setup. This reaches farther but costs a Maneuver and grants no range increase. |

There are three Novice, five Adept and two Master additions. Eight require mixed
disciplines; both Master cards require rank 3 in their primary discipline. They
require no earlier abilities. This expands choice without placing every new option
in a single-rank starting menu.

## Table handling

All ten resolve without an extra setup roll. The attack or social task still makes
its normal roll if needed. The new cards do not introduce a new resource, a movement
subsystem, a second Reaction or a damage modifier. Prepared benefits expire on the
printed anchor and repeated preparation cannot multiply the same benefit.

**Archer example:** Take the Measure spends a Maneuver; the next ranged attack
against that target gains one Boon. Moving to another square first loses the benefit.
The archer could instead have used universal Defend or Disengage.

**Caster example:** Draw the Current spends a Maneuver, then a Main Action spell
resolves normally. Even on Weak, one damaged target can be pushed one square. The
caster has sacrificed its usual opportunity to reposition or defend with that Maneuver.

**Crossing example:** Ice across the Break joins two banks separated by three empty
squares. It supplies no movement; each traveler uses normal movement to cross. An
enemy can follow. Unsupported or uneven endpoints make this card unsuitable.

## Review limits

The two attack-setup options may become routine default choices for some builds.
Test whether foregoing defense and movement remains meaningful. Small pushes can
be very valuable near hazards; that is intended, but collision outcomes still use
the common rules. Bridge expiry over a dangerous drop uses the adventure’s normal
falling adjudication; this card does not define falling damage.

These are additions for review, not a claim of measured encounter balance. No new
simulation or VTT implementation was performed. Earlier catalog manifests and
surveys remain dated snapshots, not checksums for this expanded catalog.

## Updated counts

| Action type | Shared | Signatures | Universal | Total |
|---|---:|---:|---:|---:|
| Main Action | 159 | 20 | 6 | 185 |
| Maneuver | 33 | 22 | 5 | 60 |
| Reaction | 27 | 16 | 2 | 45 |
| Passive | 14 | 23 | 0 | 37 |
| Movement | 0 | 0 | 2 | 2 |
| Variable / conversion | 0 | 0 | 3 | 3 |
| **Total** | **233** | **81** | **18** | **332** |

## Validation

The catalog audit and whitespace check pass. Fresh counts confirm 332 cards,
including 33 shared Maneuvers and fourteen shared passives. The previous
`survey_1143.py` intentionally asserts coverage against its older classification
ledger and fails that count assertion after expansion; it was not rewritten or
reported as passing. A new eligibility/balance survey remains future work.
