# HOL foundations for authoring

These summarize the agreed conversation decisions. New per-card numbers remain
proposals. Bruce resolves any discrepancy; do not repair it from an old card.

## Resolution

Roll only for uncertainty with consequences. Correct fictional action may reveal a
clue without a roll. The DA asks for Brawn, Fortitude, Agility, Guile, Knowledge or
Reason; the player takes an action which may call for that roll. Force is an action,
not another attribute or a separate skill-roll category.

Roll 3d6 plus one attribute. Weak is 8 or below: progress, not automatic success.
Standard is 9–14. Strong is 15 or above. Three natural retained sixes give Strong
plus a benefit; three retained ones give Weak plus a complication.

Boons and Banes cancel. Use at most three net extra dice, retaining the best or
worst three. Difficulty comes through Banes, never another target number on the
same roll. A cumulative task’s progress target is a different thing: 1/2/3 progress
per Weak/Standard/Strong result.

## Turns and attacks

At combat start, one unmodified 3d6: 12+ gives players the first turn, otherwise
the opposing side starts. Alternate sides; each side chooses its next character.
The same side starts every round. Each character has Main, Maneuver, Reaction and
movement. Main converts to Maneuver, Maneuver to movement; never upward.

Player attacks use one attacker roll, even against a player. NPC attacks use the
player’s defense roll. Strong defense receives Weak attack effects, Standard
receives Standard, Weak receives Strong. The defense itself spends no Reaction.
Players roll their controlled creatures’ printed attack and defense attributes.
NPC-versus-NPC without a player controller still needs a DA procedure.

Damage is fixed by the card. Apply the highest resistance of each matching type,
cap 3; do not sum matching armor. Minimum 1 damage applies to the whole damaging
event, not each component. Physical is one type. Different resistances coexist.
Conditions and displacement may matter more than a larger damage number.

**Numerical weakness — approved October 16, 2026:** Weakness X increases the
matching damage component by X before resistance. Apply each weakness once per
damaging event. Use the highest applicable weakness of each type, not the sum of
multiple sources, with a normal cap of 3. A damaging effect must include that
type; weakness does not add an absent damage type.

**Example:** Fire Weakness 2 changes 3 fire damage to 5 before resistance.
An event dealing 4 physical and 1 fire instead becomes 4 physical and 3 fire;
an event dealing only 4 physical is unchanged. Apply matching resistances next.

Special vulnerabilities, such as fire stopping regeneration, use their printed
procedure. They do not imply numerical weakness or extra damage unless stated.

## Movement

Normal squares cost 1, difficult 2. Diagonal movement costs 1. Standing costs 2
movement. Cannot cross an occupied square unless its occupant is prone; then cost
2 and never end there. Forced movement consumes the entered terrain’s cost; any
positive remaining budget can enter the final square and stop even if that cost
exceeds the budget.

Forced collisions gather movable occupants into one moving group. All take the
collision damage using movement remaining at contact, before deducting the newly
struck creature’s Stability. If movement remains, the group continues together.
A hard obstruction stops the group and adds 1 to remaining-budget collision damage. The original
mover bounces one square opposite afterward if possible.

**Group placement — approved October 16, 2026:** move the group along the forced
movement path and finish in separate legal spaces. If everyone cannot fit, stop
at the last position where they can. The DA determines the exact arrangement;
placement cannot pass through walls or grant extra forward movement. The original
mover’s backward bounce still applies where possible.

All actors have [Stability](stability.md): default 0, explicit grants only, maximum
3, highest source. It consumes forced movement once per newly struck creature,
including through a collision chain; no protection against Prone or conditions.

## Conditions

Resolve a temporary numbered condition at turn end, then reduce by 1. Burning and
Freezing deal their rating in matching elemental damage; Bleeding bypasses
resistance. Poisoned applies its rating in Banes, not damage. Frightened supplies
Banes while the stated source is perceptible. Slowed reduces Speed.

Dazed 1/2/3 leaves two/one/no categories among Main, Maneuver and Reaction; choose
at turn start. Movement remains. Paralyzed stops actions and movement at any
positive rating; its number is duration. Blinded and Deafened numbers are duration,
not severity. An asterisk prevents automatic decay; a persistent binary sense loss
needs only rating 1*. Removal follows the source.

Grappled prevents movement and reduces action choices like Dazed; it is maintained,
not decaying. The grappler suffers their own contribution too. Force can reduce
Grappled while Main is retained; rating 3 needs help. Attacks gain Boons equal to
the actual target’s Grappled rating. Greater restriction applies when combined with
Dazed, not their sum. Prone is binary. Hidden is universal, not observer-by-observer.

A mixed permanent/temporary bookkeeping proposal is recorded in the full condition reference.
Do not let a new temporary effect become permanent merely because another is starred.

## Summons, exploration and recovery

Summons require commands; see the [summoning reference](summoning.md). Without a
command they do nothing, including following, lookout and alerts. Old orders grant
no continued activity; existing conditions and durations still resolve. No free independent
turns, inherent Reactions or summon chains. No count cap. Beyond 6 squares from the
controller they disappear, including forced movement of either participant.
Measure between the nearest occupied squares of controller and summon, using
ordinary grid distance; this applies to every footprint. Exactly 6 squares is
within the tether; beyond 6 causes immediate disappearance.

**Summoned healing — approved October 16, 2026:** the controller pays the healing
ability’s printed HP cost instead of the summon, once, before resolution. Payment
bypasses resistance and must leave the controller above 0 HP. Use the summon’s
printed attribute and outcomes. Ordinary unsummoned healers pay their own cost.

Ordinary travel has no routine roll and no exhaustion track. Group checks occur
outside combat only: each participant adds 1/2/3 to a declared target. State binary
or cumulative before rolling. No group crafting, recipe derivation or wound treatment.

After a safe breath, restore full HP. Grit expenditure and wounds persist. Player
characters enter Dying at 0; creatures normally die there. Attacks are lethal unless
an explicit ability permits a different outcome; grapple/restraint can capture.

[Recovery boundary](recovery.md) records what is preserved and what still needs a
complete standalone reference before this draft is used without the agreed spec.

[Latest perception, timing and movement decisions](session-resolution.md) supersede
earlier timing notes. [Full conditions](conditions.md), [wounds](wounds.md), and
[encounter calibration](encounters.md) complete the current working references.
