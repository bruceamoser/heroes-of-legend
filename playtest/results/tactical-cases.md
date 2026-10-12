# Tactical interaction review

Updated for v0.2. These are scripted rule walkthroughs and exact calculations, not Monte Carlo
encounter results. They isolate the additional features requested for later tests.

## 1. Casting under melee pressure

A healer has Main + Maneuver + movement and is adjacent to one enemy with a Reaction.
Casting now provokes Basic Melee. Damage-only variant: resolve damage, then heal if
still able. Strong-interrupt variant: a Strong opportunity outcome consumes the
casting action without its effect. Both variants require an actual available
Reaction; an enemy that already blocked with a shield cannot also interrupt.

Alternative: spend Maneuver on Disengage, move out of reach, then cast. That preserves
the Main but sacrifices Defend or another Maneuver. This is why the all-contact
simulation is a stress case rather than a complete judgment on interruption.
Constrained corridors, sufficient movement, reachable patient, and occupied squares
must be tested on a board before choosing the default.

**Finding:** movement and access supplement the agreed healing HP cost. Blanket interruption has a higher risk of shutting down
casters than opportunity damage alone. No Counterspell card is included yet.

## 2. Worst-case player AoE

One player affects three eligible enemies: open, partial cover, heavy cover. Use
three net Banes before any opposing Boons; all get the same outcome. Each then applies
its own resistance. A player cannot silently omit the heavy-cover target unless the
card's targeting/exclusion permission allows it.

**Finding:** a poorly placed enemy can suppress damage to exposed enemies. This is
an accepted speed-over-realism choice. Cards need explicit inclusion/exclusion text;
otherwise an optional-target interpretation becomes a major unpriced advantage.
Creature AoE still gives each player their own defense roll.

## 3. Grapple contribution tracking

A grappler applies Grappled 1. Both retain two action categories; target cannot move.
A second applies 1: target now Grappled 2, but each grappler remains at their own 1.
A third applies 1: target is Restrained 3 and cannot self-Force. Each grappler still
retains two categories. Releasing one contributor immediately reduces target to 2.

Two independent neutral Brawn-0 grapple rolls restrain with probability about 93.3%
if the target has no intervening escape opportunity. Alternating turns can provide
that opportunity; the probability is not a complete combat capture rate.

Attacks against each creature gain Boons equal to its own Grappled rating.

**Finding:** loss of the grapplers' action categories is not symmetrical with the
stacked target's loss. Cheap bodies remain a concern. No automatic escape at rating
3 is proposed; that would contradict the agreed rule.

## 4. Dazed plus Grappled

Grappled 1 and Dazed 1 leave two categories, not one. Grappled 2 and Dazed 1 leave
one category. Grappled sets movement to zero independently. Reaching rating 3 blocks
immediately, even if action choices were made earlier in the turn.

**Finding:** explicitly use the greater restriction in both the sheet and VTT; do
not add ratings across condition names. A persistent Dazed 3 loop needs real counters
and should not appear casually on a repeatable low-tier card.

## 5. Free attacks

Expose Enemies grants two adjacent allies Basic Melee on Strong. Each resolves its
own attack; each must satisfy reach and weapon requirements. Neither free attack
triggers another free attack. They do not use Reactions, so a shielded ally may make
one. Opportunity attacks instead spend Reaction and only use Basic Melee.

**Finding:** basic damage is an input to many other cards. Increasing basic Strong
from 4 to 5 also strengthens these grants. Price the granting card against the actual
number of available allies; no target-count-free damage budget is sufficient.

## 6. Summon commands and bodies

With three summons, a controller can command one with Main and another with Maneuver.
The third cannot act or move. However, it still occupies a square and may obstruct
movement. Casting Summon Companion instead of commanding creates a fresh 6-HP body
and grants its immediate Main command; existing bodies remain for their duration.

**Finding:** diminishing commanded actions does not imply diminishing board value.
Repeated summoning adds cover or blockage even without extra attacks. Summoning before
combat can preload bodies within the 6-square controller tether. The prototype's duration, placement, fragility, and allowed
board occupancy need testing. Do not silently impose a summon-count cap; unlimited
summons are an agreed design choice.

## 7. Straight-line forced movement

Push 1 enters one difficult square and stops. Push 2 does the same. Push 3 enters
that square and one normal square. This deliberately favors the mover when a square
cost exceeds the positive remaining budget.

When a moving group hits a wall with 2 push remaining, each member receives a physical
3 damage event before its own resistance. With resistances 0 and 2 they lose 3 and 1
HP. The initial mover's final bounce is opposite, only if free; it does not add damage.

**Finding:** an obstruction can make a push more damaging than open travel. Multi-
creature footprints and bends remain unresolved geometry, so only straight-line
examples are claimed checked. The working rule retains that gap explicitly.

## 8. Burning versus direct damage

Burning Hands deals 3/3/5 fire and applies Burning 0/1/2. Against fire resistance 2,
immediate damage is 1/1/3 and the first tick for either rating is 1. After that tick the rating decreases by 1. Repeated applications stack with the
remaining rating, not the original rating. An appropriate Main Action reduces it
by 1 before the tick; it no longer automatically clears the whole condition.

**Finding:** conditions alter timing and actions, not only expected damage. A Main
spent extinguishing competes with an attack or heal. Our Burning pressure test does
not make the party extinguish midfight, so it is an upper-bound for that policy.

## 9. Potions and shields

A character drinks their own potion with Maneuver and may still attack with Main.
Giving it to an upright ally costs that ally's Reaction; an ally who already used
Shield Block cannot receive it until their Reaction refreshes. At 0 HP no recipient
Reaction is needed. Inventory decline is checked after the fixed heal, never before.

**Finding:** potion access is more than a small healer substitute: it preserves Main
Actions. Supplies must be explicit in encounter preparation and campaign economics.
No infinite bottle refill or unpriced routine restock is assumed.

## 10. Repeated healing on both sides

NPC healers use the same fixed healing outcomes and 1/3/7 HP casting costs as players. Living
NPCs can be healed; those at 0 are dead. Focused damage can remove a creature before
its ally heals it, while players have Dying/Grit opportunities.

**Finding:** symmetric healing text does not make both sides identical—the agreed
0-HP rules differ. This difference should remain visible when comparing outcomes.
NPC support rolls are a provisional implementation detail, not resolved canon.

## 11. Creation DP and minimums

Physical +2/+2/+2 forces mental sum −3 and gives 7 DP at each creation stage. Such a
character qualifies for Blade and Unbalanced but may fail classes needing a mental
attribute at 0. Mental +2/+2/+2 forces physical sum −3 and gives 16 DP each stage;
Intellect and Shepherd are accessible but some physical classes may not be.

**Finding:** this creates a substantial 18-DP difference across creation, not a small
flavor bonus. It is accepted and worth testing with real choices. More learned cards
mostly expand options because actions remain limited; free/passive benefits can
change that, so they need a stricter budget than redundant attacks.

## 12. Advanced signature prototypes

Each class has three choices at each signature milestone. Higher-tier prototypes
now include class-specific effects: Protector resistance while Defending, Blade
follow-up attacks, Arcanist area exclusions, Shepherd condition relief, Intellect
crafting progress, Leader coordinated attacks, Unbalanced collision pressure,
Shadow rapid lock work and concealment, and Odd attribute substitution.

**Finding:** these effects cannot be priced as an ordinary damage increase. Area
exclusion changes the agreed worst-target AoE roll; coordinated attacks multiply
basic-attack value; movement changes access to healing and weaker targets. Core
level-3/7 simulations deliberately disable signatures, so they do not certify these
prototypes. No named lower card is a signature purchase prerequisite; lock-working
signatures provide their own procedure and tools rather than creating card chains.
