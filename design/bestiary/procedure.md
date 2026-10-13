# Using a creature card

**Approved foundations:** players roll; attacks always produce their outcome;
resistance is applied afterward; ordinary creatures die at 0 HP. A creature receives
one Main Action, Maneuver, Reaction and movement on its turn. Main converts to
Maneuver, Maneuver to movement. No extra turns or legendary actions are assumed.

**Working proposals below** fill bestiary-specific gaps for this draft. They are
reviewable decisions, not claims of previous approval.

## One roll, with the right actor

- A hero attacks: roll the hero’s printed attack attribute. Apply the target’s
  Evasion Banes and circumstances. Read the hero’s attack outcomes directly.
- A monster attacks a hero: the player rolls the defense attribute named by the
  monster attack, with Threat Banes and circumstances. Strong defense receives
  Weak attack; Standard receives Standard; Weak receives Strong.
- A player-controlled creature attacks: its controller rolls its printed attack
  attribute, using the same attacker procedure. Its Threat becomes that many Boons
  on this attack roll, rather than a second defense roll.
- An NPC attacks a player-controlled creature: its controller rolls the attribute
  named by the incoming attack, using the creature’s six printed values. Its Evasion
  becomes that many defense Boons; the NPC’s Threat supplies defense Banes.
- Player-controlled attacker against another player-controlled target: attacker
  rolls only; target Evasion supplies Banes. Never roll twice for the same attack.

A skeleton archer attacks Borin with an Agility defense. Borin’s Strong defense
receives its Weak damage, then his physical resistance reduces it. If Vaelis commands
that skeleton instead, Vaelis rolls the skeleton’s Agility for its attack; Vaelis’s
own Agility does not enter the calculation.

**NPC against NPC without a player controller:** resolve unimportant outcomes by
fiction. For consequential combat, ask a player to roll the attacking NPC’s printed
attack attribute, using attacker-side Boons/Banes (its Threat as Boons, target
Evasion as Banes). The DA retains both NPCs’ decisions. This is a proposed dice
procedure, not permission for an uncommanded summon to act. Hostile healing likewise
uses a player rolling the healer’s attribute, with exactly the same outcome chances
and life cost as player healing; never substitute an automatic Standard result.

## Areas and reach

Individual targets must be visible unless the entry explicitly permits a precise
alternative sense. Requiring a target to hear a song does not reveal a Hidden
target. Printed sound-based sight or ground-vibration senses may locate targets
within their stated range and limits, using ordinary perception resolution.

All distances are squares; count diagonals as 1. Measure range between nearest
occupied squares, with a clear path. An area affects a large creature once if any
of its squares are included. Printed area attacks include allies unless they say
otherwise. Monster AoE against heroes gives each player a defense roll. A controlled
creature’s AoE uses one attack roll with the worst applicable target modifiers.

A **burst radius 1** is the nine-square block around its center. A **line 6** is six
consecutive squares in one of the eight grid directions. A **fan 3** is three rows
of width 1, 3 and 5, extending from the creature in one cardinal direction; use one of the four cardinal directions for this draft. No square behind full obstruction
is affected. Creatures with larger footprints choose one edge square as the origin.

Large bodies must fit the entire route and endpoint; no rotating or squeezing a
2×2 footprint through a one-square doorway. Printed flight costs 1 movement per
square including vertical movement; ending airborne is allowed. Prone, paralysis
or unconsciousness removes flight and causes a fall unless a trait says otherwise.
Printed swimming/climbing ignores the ordinary cost 2 for that mode. Burrowing
works only in soil or sand, leaves no passable tunnel unless stated, and requires
emerging to attack; earth is full obstruction. These mode definitions are proposals.

## Forced movement and large bodies

Subtract the initial target’s Stability once from push, pull or throw distance,
minimum 0. Do not add another movement-reduction bonus; use the highest. Move the
whole footprint without turning. Every translated step costs the highest terrain
cost under any newly entered square. A positive remainder can pay the final step
as already agreed. Collided movable creatures join the moving group; do not subtract
their Stability again. Resolve each new creature collision once, not once per square.
If any part of the group would enter a solid obstruction or an immovable body, stop
the whole group and apply the agreed hard-collision damage. Only the original target
bounces back one square, if its whole footprint can fit. Groups never overlap at rest.

Example: push 4 against a 2×2 ogre with Stability 1 starts with 3 movement. Its next
translated step touches difficult terrain, costing 2; the remaining 1 permits one
last step into difficult terrain. A wall instead ends the push with remaining
movement + 1 collision damage to every member. Apply physical resistance normally.

Falling uses the existing proposed 3 × floor(squares / 2) physical damage. Landing
at a legal adjacent square rather than overlapping someone is a DA placement ruling;
a fall does not create an additional free attack or automatically grant a grapple.

## Ordinary actions and senses

All entries may use Force (Main, Brawn, 1/2/3 progress or displacement), Defend
(Maneuver, defense rolls gain 1 Boon until the start of its next turn), and anatomically possible
interactions. Force cannot substitute for buying a specialist grapple ability.
Defend becomes 1 Bane on player attacks against an NPC until its next turn.
Repeating Defend does not stack; Shield Block is a separate source.

Working search/hide outcomes: searching costs Main. Reason Weak reveals a useful
sign or narrows the location, Standard locates the concealed target, Strong also
gives 1 Boon on the searcher’s next action against it before turn end. Hiding costs
Main and needs real concealment: Agility Weak reaches concealment but is still
located, Standard becomes Hidden, Strong also moves 1 square within that concealment.
Attacking or exposing oneself ends Hidden. For NPC stealth against a searching hero,
only the hero’s Reason roll is made; Evasion is not a perception penalty. When an NPC
searches for a hidden hero, only that hero’s Agility roll is made: Weak exposes them,
Standard remains Hidden, Strong also permits that one-square reposition. No free
search on every turn. Obvious clues need no roll.

A sense may remove a particular obstacle, never invent a target behind a wall.
Dark sight sees in unlit spaces within its listed range. Keen scent supplies 1 Bane
to a hero hiding from that scent and 1 Boon to commanded scent tracking, when relevant.
Sound-based sight fails while Deafened and cannot penetrate full obstruction.

## Shared limits

Conditions use [their ordinary rules](../rules/conditions.md), including end-turn
decay. Grapples burden the holder too. No monster ignores that burden just because
it has tentacles. The action-category restrictions of Dazed/Grappled are chosen at
turn start; paralysis and unconsciousness stop activity immediately.

Opportunity attacks spend Reaction and use only the printed **Basic melee**, with
no specialty rider. The provoking action starts, the opportunity interrupts, and
the action continues if the actor remains capable. Each creature has one Reaction.

**Weakness proposal:** for each positive printed damage component, subtract the
highest matching resistance and add the highest matching Weakness value. Floor
that component at 0; then apply the existing minimum 1 to the whole damaging event.
Matching weaknesses do not stack. A creature with cold Weakness 1 and no cold
resistance takes 4 from a 3-cold attack; cold resistance 2 would reduce that to 2.
A zero-damage action does not become damaging because of weakness. This supplies
a simple working meaning for the field; it is a new proposal for review.

HP healing costs 1/3/7 life upfront by ability tier, bypasses resistance and must
leave its caster above 0. Life resistance also reduces healing, minimum 1 while HP
is missing. Undead entries explicitly say healing harms them instead. Neither a
category nor a descriptive metal grants unprinted damage immunity.

## Supplies and recovery

A real creature using a bow, sling or thrown ammunition begins with an inventory
d6 unless its entry prints another supply. Ask a player to roll the inventory die
after each use; on 1 it steps down normally. A natural attack or returning magical
projectile does not consume ammunition unless stated. Equipment recovered after
combat retains its remaining die, not a new full bundle.

Living creatures and spirits follow the ordinary safe-breath HP recovery where
applicable. Repair-only constructs need one uninterrupted hour in a suitable
workshop with repair tools and one use of compatible ordinary materials to return
to full HP. Check that material inventory die afterward. This is a proposed repair
procedure, never revival of a construct destroyed at 0, and never free supply from
a summoned body. A scene-duration summon normally vanishes before such repairs.

Carrying limits concern objects, not rider seats. This catalog does not introduce
mounted action-sharing or allow two creatures to end in the same square. Permanent
pets, mounts and independent companion advancement remain outside these summon rules.
