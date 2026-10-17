# Using the Bestiary

Dry clicking answers the heroes' footsteps. Scraps tied to a ruined wall mark a
safe path through the debris. Coins beneath a bridge have been sorted with surprising
care. Before a creature attacks, it can already tell the players something about
the place they have entered.

The bestiary gives you creatures to portray and complete cards to run. Use the
signs, purpose and counterplay alongside the statistics. A creature is more useful
when you know why it is here and what might make it leave.

## Read from the top down

Every creature's name includes its current CV. Beneath a short description, find
its six attributes, HP, Speed, Size and Armor DR, then Evasion, Threat, Stability
and its damage defenses. The action tables come next; details provide their ranges,
targets, timing and exceptions.

| Field | Use during play |
|---|---|
| Attributes | The creature's printed values when a roll uses them. PC defense against it still uses the PC's named attribute. |
| HP | Its immediate endurance. Ordinary creatures die at 0 unless an explicit exception applies. |
| Speed | Its available movement, subject to terrain and its printed movement modes. |
| Size | Occupied footprint. Size 2 occupies 2 × 2 squares; it does not automatically grant reach or Stability. |
| Armor DR | Physical resistance, always shown even at 0. An asterisk points to additional resistance types below. |
| Evasion | Boons or Banes applied to player attacks against it. |
| Threat | Boons or Banes applied to player defenses against its attacks, unless an attack states an exception. |
| Stability | Forced movement consumed by its resistance to displacement; highest grant, maximum 3. |
| Weaknesses | Numerical damage weaknesses or explicit special vulnerabilities. Read the details. |
| Resistances | Damage types and reductions. The Physical entry repeats Armor DR; never add them together. |
| Immunities | Only the printed immunities apply. Category names grant none by themselves. |

“None” under Evasion or Threat means no modifier from that field. “1 Bane” means
one Bane through the ordinary dice procedure, not minus one to a total.

## A Goblin Scrapper at the table

The [Goblin Scrapper](../../bestiary/creatures/goblin-scrapper.md) has **CV 7,
HP 8, Speed 7, Size 1, Armor DR 0, Evasion 1 Bane, Threat None and Stability 0**.
Its Scrap knife requires **Agility defense** and deals **5/3/2 physical damage**
for Weak/Standard/Strong player defense.

A hero attacking it suffers 1 Bane from Evasion. If the goblin has used Defend,
that adds another Bane until its stated expiry. An applicable Boon cancels one;
apply the usual net cap. The goblin does not roll to dodge the attack.

When the goblin uses Scrap knife, its target rolls Agility. On Standard defense,
the attack deals 3 physical damage before resistance. A hero with Physical
resistance 2 takes 1. On Strong defense, the attack deals 2 before resistance and
still deals the minimum 1 total damage. The goblin's Agility +2 does not get added
to that player's defense roll or to the knife's damage.

On its turn, the goblin can use its Main Action for an attack and its Maneuver for
Roll Away, moving up to two squares in a straight line without provoking. Roll
Away still obeys terrain and occupied-square restrictions. Choosing it means the
goblin did not spend that same Maneuver on Defend. Its purpose is to protect a
salvage claim; a useful tool or a recognized claim may matter more to it than a fight.

## Read complete outcomes

The DA card's damage columns read **Weak defense / Standard defense / Strong
defense**. Weak is dangerous for the defending hero. Each slash separates a complete
outcome, including conditions and movement. Do not combine the riders from several
columns or apply a Strong-defense rider to every result.

A line such as “6 + Bleeding 2 / 4 + Bleeding 1 / 3” means exactly those three
alternatives. The damage type, range and target are in the action's details.
A zero-damage condition result remains a condition result; the minimum-damage
rule does not invent damage for an effect that deals none.

Healing and other nonattack actions use their own details rather than this damage
legend. A healing action's Strong result is beneficial when healing an eligible
ally. When the same ability harms a healing-harmed target, use its printed harmful
procedure and defense outcomes.

## Actions are choices

A creature has the normal Main Action, Maneuver, Reaction and movement. Several
attacks give options. A claw, bite and breath weapon do not all occur on one Main
Action unless a printed action explicitly combines them.

Read a maneuver before deciding it fits. Check range, path, endpoint, duration and
usage limits. Use the printed Reaction trigger and cost. Opportunity attacks use
Basic Melee and occur before the provoking action; the original action continues
if its actor is still capable. The specialty attack is not an opportunity substitute.

Mark expiring effects where you can see them. Defend's concise “+1 Bane” refers to
player attacks against that creature for the duration in Details. It is not a new
permanent Evasion value. A shield's hunker consumes a Reaction; defense rolls do not.

## Damage defenses in order

For each damage component, add its applicable numerical weakness, then subtract
its matching resistance. Use the highest value of a given type rather than adding
several sources; the normal cap is 3. Do not add a weakness for a damage type the
event never included. Apply minimum 1 damage to the whole damaging event after
its components have been reduced.

> **Example: mixed damage.** An event deals 4 Physical and 1 Fire. Fire Weakness 2
> changes the Fire component to 3. Physical resistance 2 and Fire resistance 1
> leave 2 Physical plus 2 Fire, for 4 total. Armor DR and Physical resistance are
> the same value, not two reductions.

A special vulnerability follows its own wording. Fire stops the Bridge Troll's
Knit Flesh for the stated interval; it does not automatically add Fire damage.
The troll recovers HP only while above 0 and cannot regenerate from death.

## Forced movement and Stability

All actors start at Stability 0 unless an explicit trait, ability or item says
otherwise. On creature cards, Heavy Frame identifies a permanent grant. A large
footprint by itself grants none. Use the highest applicable source, maximum 3.

Deduct the initial target's Stability once before forced movement. Terrain then
consumes movement by square: normal 1, difficult 2. Any positive remaining budget
can enter the last square and stop even if its cost exceeds that budget.

When the moving creature or group strikes another movable creature, resolve
collision damage from the movement remaining at contact. Apply applicable damage
resistance, then deduct the new member's Stability. Continue as one group if movement
remains. Never charge the same member's Stability twice during that movement.

> **Example: a collision chain.** Push 5 meets Stability 1, leaving 4. The target
> crosses one normal square, leaving 3, then collides with a Stability-2 creature.
> Both receive 3 collision damage before applicable resistance. Deduct the new
> member's Stability 2, leaving 1 for further group movement.

A hard obstruction stops the group and adds 1 to the remaining-budget collision
damage. Every member takes the applicable damage. Finish in separate legal spaces;
if everyone cannot fit, stop at the last position where they can. You choose the
arrangement without granting extra forward movement or passage through walls.
The original mover bounces one square opposite afterward where possible.

Stability does not resist Prone, grapples, conditions or damage. If Stability
prevents a push, the attack's other effects still occur.

## Play purpose, not omniscience

A creature acts on what it can perceive and know. Use its senses as printed;
ordinary hearing does not become precise location through any wall. Give players
visible signs when a capability should be recognizable: a troll's closing wounds,
a wolf's circling pack, or a sentinel that stops at a boundary.

The tactics line suggests useful choices. Adapt them to the scene without changing
the card. A hungry animal might protect food, while one defending young risks more.
A guard can retreat, surrender or negotiate while still alive. At 0 HP, an ordinary
creature does not automatically receive a chance for last-minute stabilization.

Knowledge of a familiar fantasy trope can suggest an experiment, but only this
creature's printed rules determine its effect. If a player tries something that
would plainly fail here, offer information their hero could reasonably perceive
before they spend an action on a mistaken assumption.

## Summoned forms

Summons are energy shaped to resemble and act like creatures. They cannot receive
healing and disappear at 0 HP without a body or permanent loot. They are still
tangible: they occupy squares, block movement and can be damaged, pushed or grappled
unless their own card states an exception.

Use the separate player profile for an eligible summon. Its attack outcomes run
Weak to Strong **attack**, and its modifiers already express the player's perspective.
Do not reverse the DA card mentally or import its independent Reactions. A creature
is eligible only where the profile explicitly lists the relevant category and tier.

| Controller spends | One summon receives |
|---|---|
| Main Action | Main Action and Maneuver |
| Maneuver | Maneuver and movement |
| Summoning card's immediate free Main command | Main Action and Maneuver; this counts as that summon's command for the turn |

A summon receives at most one command on its controller's turn. The controller
may spend Main and Maneuver on different summons. Normal downward conversion
applies; a Main-command package does not also include free movement. Convert its
Maneuver to movement if it must approach before attacking.

No command means no activity: no following, watching, alerting, helping or continued
attack. Existing conditions and durations still resolve on the controller's turn.
Commands cannot be saved for an enemy turn. Summons have no independent Reactions,
opportunity attacks or summon chains.

Keep the nearest occupied squares of controller and summon within six squares,
using ordinary grid distance. Exactly six is valid; beyond six it immediately
disappears. Movement of either participant, including forced movement, can break
the tether. It also disappears if the controller becomes unconscious or dies.

> **Example: the Moon Hart.** A commanded summoned hart uses Battle Mending. Its
> controller pays 3 HP before resolution, bypassing resistance and remaining above
> 0. The hart does not also pay. Roll the hart's Reason and heal 5/10/15, reduced
> by the eligible recipient's Life resistance, minimum 1 where HP is missing. The
> hart itself cannot be healed. An ordinary unsummoned hart pays its own healing cost.

## Find the next creature

The following chapter groups creatures into alphabetical families, keeping variants
together. Each individual is also indexed by name, CV, habitat and role. These
categories help you find candidates; they do not add abilities, summon eligibility,
resistance or moral alignment.

The monster ability appendix supports preparation and adaptation. The creature
card remains complete enough to run without chasing that appendix during a turn.
Design worksheets follow the play references, where they cannot crowd the defenses
and actions you need in combat.
