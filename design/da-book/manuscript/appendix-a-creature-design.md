# Creating and Adapting Creatures

Begin with the creature's place in the adventure. What will the heroes notice?
What does it want? What does it do when threatened? A distinctive answer to these
questions often matters more than another attack.

Use an existing creature whose play pattern is close to what you need. Changing
its appearance, name or allegiance may be enough. If you change its mechanics,
record the new values explicitly and review its CV as an estimate. A renamed
creature should not acquire hidden abilities during the fight.

## Build the table experience first

Write a short description of the creature itself, then choose one recognizable
combat behavior. A predator separates prey; a sentinel holds a route; a spirit
makes approaching it unsettling. Select printed actions that express that behavior.
Give the heroes signs and counterplay they can discover.

Add another action only when it creates a useful choice. A bite that does exactly
what the claw does adds reading without changing a decision. A bite that holds a
target, at the cost and restrictions of grappling, can change the fight. Do not
grant every creature a complex suite merely because the book has room.

Use the normal action economy. Mark each ability Main, Maneuver, Reaction or Passive;
print its trigger, target, range, shape, outcomes, duration and limits as applicable.
A powerful breath can be a Main Action with a printed use restriction. “Procedure:
Breath” is not an action cost.

## Fill the card completely

| Part | Check before using it |
|---|---|
| Identity | Name, CV, description of appearance and nature |
| Attributes | All six, including attack attributes needed for player control |
| Body and defenses | HP, Speed/modes, footprint, physical DR, Evasion, Threat, Stability |
| Damage interactions | Weakness, resistance, immunities and healing behavior |
| Actions | Full defense outcomes, ranges, target attributes, costs and limits |
| Other capabilities | Passives, senses, communication and explicit exceptions |
| Adventure use | Signs, purpose, tactics, retreat, counterplay, habitat and loot |
| Summoning | Explicit eligibility and separate profile, or ineligible |

Armor DR is physical resistance. The list repeats that number for clarity; it does
not add another reduction. Use Boons and Banes for Evasion and Threat, not a new
target number or an unexplained signed statistic. Nonzero Stability needs an explicit
grant and remains capped at 3.

Write DA attacks in defense order. If an attack produces 2/4/6 on Weak/Standard/Strong
attacker outcomes, its ordinary defense table reads 6/4/2. Reverse the whole outcome,
including conditions and displacement, not just the damage. Store the player-facing
version for any eligible summon and check both against each other.

## Use monster abilities as construction tools

The separate monster catalog contains abilities with no DP price or player discipline
requirements. A creature has an ability only if its own entry grants it. Players
cannot buy one simply because they meet a similarly named discipline.

Copy the applicable effect into the creature's authored entry and specialize its
printed values where the template calls for that. Preserve targeting, costs,
limits and counterplay. A template is not permission to leave “see ability” in a
combat action that needs a second lookup to resolve.

An animal form or summoned category does not inherit this entire library. A summoned
profile must restrict activity to paid commands, remove independent Reactions and
state its own allowed actions. Being a spirit does not automatically grant movement
through walls; being a construct does not automatically grant every condition immunity.

## Estimate CV transparently

The current estimate uses **CV = ceiling(3 × sqrt(E × O) × U)**, minimum 1. It is a
comparison tool with explicit assumptions, not a complete model of combat.

| Input | Current seed definition |
|---|---|
| I | Expected damage of a reference hero's attack against the creature, after Evasion and physical resistance |
| E | (Creature HP + two turns of its printed regeneration) ÷ I |
| O | Expected damage of its reference attack against the reference defender, multiplied by expected targets |
| U | A recorded judgment for capabilities not directly represented above |

The reference hero has attribute +1 and physical attack outcomes **3/5/7**. Enumerate
the actual 3d6 outcomes, with extra dice for Evasion and the correct retained-three
procedure. Apply resistance and minimum damage per event. The reference defender
also uses +1, with Physical resistance 1 and other resistances 0. Threat changes
the defense distribution. Use the creature's printed target expectation and reference
attack for O; do not add its attack attribute to a player's defense probability.

The two regeneration turns are an assumption, not a prediction of fight length.
The current U rubric ranges from 1 for simple damage to 1.50–1.65 for substantial
combined utility, healing or repeated disabling pressure. Those values are judgments,
not proven prices for conditions. The full current worksheet inputs remain with
each creature in the design ledger at the end of this reference.

If a creature deals no direct damage, this formula cannot establish its contribution
by multiplying by zero. Evaluate it in the mixed encounter it supports. Area damage,
healing, repeated control and unreachable firing positions also need explicit tests.
Do not disguise their uncertainty behind a precise-looking CV.

## Test the choice the creature creates

First run the creature with ordinary companions and modest terrain against actual
characters. Record their cards, defenses, supplies and tactics. Test a stronger
terrain advantage separately. If the creature has a counter, record whether players
could discover it and whether using it was worthwhile.

Look beyond total damage. A creature can be numerically survivable and unpleasant
because it removes too many turns. Another can die quickly but create a memorable
rescue or movement puzzle. Revise the action or situation responsible instead of
raising all numbers until the fight lasts longer.

For a new summon, also test command affordability, the initial free command, tether
pressure and the cost of replacing a lost form. Check that uncommanded forms provide
no active scouting, alerts or attacks. A summoned healer charges its controller;
the form cannot receive healing. These restrictions are part of its actual play value.

After a change, recalculate the estimate and check the creature's full outcome
text. A content audit can catch missing fields or arithmetic errors. Only play
can tell you whether the creature delivers the intended experience.
