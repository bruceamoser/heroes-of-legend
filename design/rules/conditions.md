# Conditions

Agreed condition rules, consolidated after the wound-table review (issue #1125).
Use these timing and sensory rules throughout the current catalog.

## Ratings, decay, and persistence

At the end of the affected character's turn, resolve a temporary numbered
condition's effect, then reduce its rating by 1. At 0 it ends. A condition gained
during that turn also decreases at that turn's end. Numbered instances add where
meaningful; binary states do not. Normal Boon/Bane cancellation and caps apply.

The number can describe severity as well as duration (Dazed, Burning), or duration
only (Blinded, Paralyzed). A higher duration-only rating does not strengthen the
condition. Dazed 3 or greater grants no action categories.

An asterisk means **no automatic decay**: Blinded 1* is blindness that persists
until its specified remedy. It does not mean every such injury is incurable.
A wound states whether treatment, replacement, or another remedy removes it.
Maintained Grappled does not decay. Binary conditions and lasting wound penalties
use their own removal rules.

Spend a **Main Action** to reduce an appropriate condition on yourself or an
adjacent creature by 1 without a roll: staunch Bleeding, extinguish Burning, or warm
someone suffering Freezing with a plausible method. This is not a universal cure
for every condition. Specialist abilities can remove more or use a cheaper action.
A star prevents automatic decay, not a removal method explicitly allowed by its
source. Mixed temporary and starred contributions still need a specific tracking
ruling; do not assume the star makes later temporary contributions permanent.

Example: untreated Bleeding 3 deals 3 damage, decreases to 2, then deals 2 and 1
on subsequent turns before ending. A Main Action reducing it before the first tick
changes that sequence to 2, then 1. Burning and Freezing apply matching resistance
to each tick, with the normal minimum 1 damage for a damaging event.

| Condition | Effect | Removal / persistence |
|---|---|---|
| Burning X | Fire X damage at end of turn; matching resistance applies | Resolve damage, then decay; appropriate Main reduces 1 |
| Freezing X | Cold X damage at end of turn; matching resistance applies | Resolve damage, then decay; appropriate Main reduces 1 |
| Bleeding X | X damage at end of turn, bypasses resistance | Resolve damage, then decay; appropriate Main reduces 1 |
| Poisoned X | X Banes to action/defense/death rolls, not inventory dice; no damage | Decay unless explicitly maintained or persistent |
| Frightened X | X Banes while its source is perceptible; no forced choices or movement | Decay unless explicitly maintained or persistent; source must be identified |
| Blinded X | Cannot see; no direct sight-required targeting | Duration only; decay; Blinded 1* requires its specified remedy |
| Deafened X | Cannot hear; cannot respond to hearing-only triggers | Duration only; decay; Deafened 1* requires its specified remedy |
| Slowed X | Speed −X, minimum 0 | Decay unless explicitly persistent |
| Dazed X | At 1/2/3+, choose 2/1/0 of Main, Maneuver, Reaction; movement remains | Choose at turn start; no retroactive change to spent actions; decay 1 at turn end |
| Grappled X | Movement 0; at 1/2/3+, choose 2/1/0 of Main, Maneuver, Reaction | Maintained; no decay. Force reduces 1/2/3 when a Main remains; rating 3 requires help |
| Prone | Crawl; standing costs 2 movement | Stand or source effect; occupied prone square traversable at cost 2 |
| Asleep X | Unaware, no actions/movement | Default numbered decay; adjacent Main wake effort reduces 1; damage ends it; source can specify persistence |
| Paralyzed X | Aware, no actions or movement at any positive rating | Duration only; decay; no gradual return of options before 0 |
| Unconscious | Unaware, prone, no actions/movement | Source; ordinary healing wakes only HP-caused unconsciousness |
| Petrified | Inert solid, unaware, no actions/movement | Source defines protection and cure |
| Hidden | Universal hidden state, not observer-specific | Ends on attack/open revelation; DA judges concealed movement |
| Invisible | Cannot be seen; not automatically unlocated | Source; attacking ends Hidden, not automatically Invisible |

Asleep, Paralyzed, Unconscious, and Petrified apply three defense Banes; overlapping
helpless states apply that penalty once. Dazed adds no defense Banes.
Attacks against a Grappled creature gain one Boon per level of its Grappled rating,
including attacks against grapplers, using normal Boon/Bane rules.
When Dazed and Grappled coexist, use the greater action restriction, not their sum.

Grappling restricts the grappler by their own contribution as well as the target.
Multiple grapplers' contributions add on the target. Each can freely release even
at rating 3, ending their contribution. Once helpless capture is established and
combat is over, resolve the scene through ordinary narration.

Example: Paralyzed 3 prevents actions and movement, falls to 2 at turn end, then
to 1, then clears. Dazed 3 instead gradually returns action options as it decays.
Blinded 2 is full blindness for two decay steps, not stronger blindness than 1.

**Provisional prone combat rider for tests:** none beyond movement until approved.
Do not import automatic melee Boons or ranged Banes from another game's prone rule.

See [wounds](wounds.md) for lasting effects and [foundations](foundations.md) for movement.

## Action-category timing — latest agreement

Dazed and Grappled determine retained action categories at the start of the affected
creature’s turn. Changes during the turn do not undo spent actions or recalculate
that turn’s category selection. Temporary Dazed decays at turn end; maintained
Grappled does not decay. Grappled’s movement restriction still applies while the
hold exists. Paralyzed, Asleep and Unconscious retain their immediate restrictions;
they are not action-category selection effects.

**Mixed-source tracking:** record temporary and starred contributions
separately. Add effective severity where the condition uses severity; decay only
the temporary part. For duration-only conditions, either positive contribution
keeps the condition active, without multiplying its effect. Generic temporary
reduction removes temporary rating only; permanent treatment follows its source.
