# HOL foundations for authoring

These summarize the approved system. Bruce resolves discrepancies; current
cards and rules are the source, not earlier editions.

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

At combat start, the DA decides whether either side has pulled off an ambush.
An ambushing side starts without an initiative roll. Otherwise, one player rolls
unmodified 3d6. On 12 or more, the players start. On 11 or less, the opposition
starts. The starting side opens every round.

Alternate sides from the first turn of combat. Each side chooses its next
character, and the side with turns remaining finishes them when the other runs
out. A round lasts 6 seconds and ends after everyone has had a turn. Each
character has Main, Maneuver, Reaction and movement. Main converts to Maneuver,
and Maneuver converts to movement. Conversion goes in that direction only.

Player attacks use one attacker roll, even against a player. NPC attacks use the
player’s defense roll. Strong defense receives Weak attack effects, Standard
receives Standard, Weak receives Strong. The defense itself spends no Reaction.
Players roll their controlled creatures’ printed attack and defense attributes.
For NPC-only actions, either a player or the DA assuming the player role rolls.
For an NPC-versus-NPC attack, roll the defender’s printed defense attribute and
read the attacker’s defense-outcome table. For consequential NPC healing or other
tasks, roll the acting NPC’s printed attribute and outcomes. Apply the ordinary
modifiers and use one roll; handling the dice does not transfer control of the NPC.
Off-screen events may be resolved by DA judgment without simulating combat.

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

## Cover

The DA judges whether an obstruction protects the target from the attack. Partial
cover gives the attacker 1 Bane. Heavy cover leaves a narrow attack path and
gives the attacker 3 Banes. If the defender rolls, apply the same number as Boons
on that defense roll. Apply cover once to the roll being made, using the usual
Boon and Bane rules.

An attack needs a usable path. A barrier that blocks the path prevents the attack.
An attack that requires sight needs a visible target or an explicit alternative
that permits targeting. Follow the attack's printed targeting rules.

## Movement

Entering a normal square costs 1 movement and entering a difficult square costs 2.
While Prone, crawl for 2 movement per normal square or 3 per difficult square.
Use the same costs for straight and diagonal steps. Standing costs 2 movement.
You may cross an occupied square if its occupant is Prone. Pay the higher of 2
movement or your usual cost to enter it, and finish in a free square. Crawling is
voluntary movement and can provoke when you leave an
enemy’s melee reach. Forced movement consumes the entered terrain’s cost. Any
positive remaining budget can enter the final square and stop even if that cost
exceeds the budget.

Push X moves the target up to X squares directly away from the source. Pull X
moves it up to X squares directly toward the source. Slide X moves it up to X
squares in any direction, including vertically. The effect’s user chooses the
path for a Slide and can stop any of these movements early. A Push or Pull
changes elevation only if its effect allows it. Follow any restrictions in the
effect. Collision damage requires an actual impact.

Collisions gather movable creatures and intact movable objects into a group that
moves as one creature on the original remaining allowance. Each new impact deals
physical damage equal to the movement remaining at contact to every member of the
group and whatever it strikes. Creatures and objects with HP each apply their own
resistance, with a minimum of 1 damage. The DA judges the impact on objects without
HP. Remove any movable object that breaks, including one reduced to 0 HP. Then
deduct a newly struck creature’s Stability once for that movement. Continued
contact between group members deals no further damage.

A fixed barrier stops the group even if it breaks. Add 1 to the damage dealt to
each group member and the barrier before resistance. After placement, only the
original mover bounces one square opposite the impact. If that square is blocked,
the mover stays in place without another collision or damage.

**Group placement — approved October 16, 2026:** move the group along the forced
movement path and finish in separate legal spaces. If everyone cannot fit, stop
at the last position where they can. The DA determines the exact arrangement;
placement cannot pass through walls or grant extra forward movement.

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

A mixed permanent/temporary bookkeeping rule is recorded in the full condition reference.
Do not let a new temporary effect become permanent merely because another is starred.

## Summons, exploration and recovery

**Summoned forms — approved October 16, 2026:** summons are shaped from energies
to resemble and act like their creatures, not actual physical creatures brought
into the scene. They cannot be healed and disappear at 0 HP, leaving no body.
Ordinary unsummoned creatures retain their own healing rules.

Summoned forms remain tangible: they occupy squares, block movement, take damage
and can be pushed or grappled normally unless their card says otherwise. Their
energy composition grants no automatic incorporeality or damage/control immunity.

Summons require commands; see the [summoning reference](summoning.md). Without a
command they do nothing, including following, lookout and alerts. Old orders grant
no continued activity; existing conditions and durations still resolve. No free independent
turns, inherent Reactions or summon chains. No count cap. Beyond 6 squares from the
controller they disappear, including forced movement of either participant.
Measure between the nearest occupied squares of controller and summon, using
ordinary grid distance; this applies to every footprint. Exactly 6 squares is
within the tether; beyond 6 causes immediate disappearance.

**Summoned healing:** the controller pays the healing
ability’s printed SP cost instead of the summon, once, before resolution. The
controller must have sufficient SP. Use the summon’s
printed attribute and outcomes. Ordinary unsummoned healers pay their own cost.

Ordinary travel has no routine roll and no exhaustion track. Group checks occur
outside combat only: each participant adds 1/2/3 to a declared target. State binary
or cumulative before rolling. Make crafting and treatment rolls individually.

Safe overnight rest restores HP and SP; first aid uses one recipient allowance between rests. Scars are descriptive; Grit is gained once at levels 1/3/7 and never refreshes. At 0 HP heroes enter Dying; further damage causes an immediate Fortitude death roll. Weak adds a failure, Strong adds a success and Standard changes neither tally. Three failures kill unless Grit or an ability intervenes. Three successes stabilize at 0 HP. See [recovery](recovery.md) for the complete procedure.

[Latest perception, timing and movement decisions](session-resolution.md) supersede
earlier timing notes. [Full conditions](conditions.md), [scars](wounds.md), and
[encounter calibration](encounters.md) complete the current working references.
