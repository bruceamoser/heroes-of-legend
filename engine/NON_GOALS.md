# NON_GOALS — what the engine does not model, and why

The engine plays Heroes of Legend; it does not approximate it. Every rule it
does not execute is listed here. A stub is never silent: the run file declares
it, `summary.json` records `stubs_active`, and the printed report ends with
the list of stubs that were in force for that run.

## Declared run-file stubs (default off)

| System | Flag | Reason |
|---|---|---|
| Morale (`13:323`–`13:337`) | `run.flags.morale` | Morale is a table interaction at the table and needs a DA's judgement about odds; the engine's creatures fight to defeat unless the run turns it on. The morale *check* itself is replayable through the printed-example fixtures. |
| Cover (`13:457`–`13:476`) | `run.flags.cover` | Cover requires a battlefield. The engine has no positions. |
| Terrain and positioning | `run.flags.terrain` | All combatants are treated as in reach. Melee and ranged attacks resolve the same except for damage rows. |
| Pursuit, chases, mounted combat (`15:292`–`15:362`) | n/a | Requires a map and vehicle state. |
| Social conflict (`14`) | n/a | Separate subsystem; no overlap with combat resolution. |
| Crafting, alchemy, preparations (`15:235`–`15:256`) | n/a | Downtime, not combat. |
| XP/advancement beyond the DP tables (`18`) | n/a | `level` is an input; the DP budgets it implies are modelled. Milestones, reputation, titles and retraining are not. |
| Magic items (`17`) and ancestry gifts (`04:160`–`04:226`) | n/a | The engine executes cards, not passive item or gift text. |

## Rule abstractions (executed, but simplified)

| Abstraction | Book rule | What the engine does |
|---|---|---|
| Area effects | Range/radius (`11:189`, `20` area attacks) | Positions are not modelled, so an area card hits every living enemy. Declared because it favours area spells. |
| `nearest` target policy | Range and movement | Degenerates to a uniform random target; the policy records a note saying so. |
| Pack Tactics / Leadership | Ally adjacent (`20:44`, `20:136`) | Treated as active when two or more living creatures of that stat block are in the fight. |
| Charge (`20:96`, `20:355`) | 20+ ft straight-line move | Not applied: movement is not tracked. |
| Frightened / Charmed / Lured | Cannot approach/source-specific (`13:212`, `13:207`) | Applied as a Bane on the creature's rolls. Frightened movement restrictions need positions. |
| Hidden / Invisible | Attacks against have Bane (`13:215`, `13:217`) | Modelled as a Boon on the holder's defense and a Bane on attacks against it; targeting restrictions need positions. |
| Prone | Melee vs ranged distinction (`13:222`) | Modelled as a Bane on the target's defense. The ranged/melee split needs range bands. |
| Reach, Flyer, Darkvision, Tiny | Spatial | No effect. |
| Speech/limb wounds (`13:435`–`13:439`) | Situational | Modelled as an attack Bane for the encounter (Broken Bone, Crippling Blow) or as a Fortitude check to cast (Punctured Lung); their long-rest recovery is out of combat scope. |
| Critical and Fumble tables (`06:163`–`06:207`) | d6 effects | A critical rolls the d6 and applies Maximum Damage and the prone result; narrative results are logged. Fumbles are logged as complications; the Friendly Fire row needs positions. |
| Class signature abilities | `05` class entries | Not executed. Several ("Protection Value", `05:63`, `05:164`) reference a stat that no longer exists in the defense rules (`06:99`–`06:136`); they are left out rather than guessed. |
| Talents (`09:21`–`09:217`) | Passive/active cards | One substitution family and the roll-modifying talents are not on any shipped run's build. They are not executed. |

## Creature abilities not modelled (70 distinct, from ch20)

Each is listed with the stat blocks that print it. The engine parses and
records them, and reports them as active stubs, but does not execute them.

Aggressive (Orc); Ambusher (Doppelganger); Animate Trees (Treant); Barbed Hide
(Barbed Devil); Blink (Phase Beast); Brute (Bugbear); Charge (Dire Boar,
Minotaur); Charm (Dryad); Commanding Presence (Orc Warchief); Confusion Touch
(Pixie); Counterspell (Archmage); Coven Magic (Green Hag); Cowardly (Goblin);
Create Specter (Wraith); Darkvision (Goblin, Goblin Shaman); Deceptive
(Doppelganger); Engulf (Gelatinous Cube); Fanatical (Cultist); Flyer (Harpy);
Freeze (Water Elemental); Frightful Presence (Young Dragon); Goblin Cunning
(Goblin Shaman); Hex (Goblin Shaman); Hulking Brute (Ogre); Illusory
Appearance (Green Hag); Invisible (Pixie); Iron Discipline (Hobgoblin);
Labyrinthine Recall (Minotaur); Legendary Resistance (Ancient Dragon); Light
Sensitivity (Shadow Stalker); Luring Song (Harpy); Magic Resistance (Vrock,
Barbed Devil); Magical Ward (Archmage); Marshal Undead (Death Knight); Merge
with Shadow (Shadow Stalker); Mind Reading (Doppelganger); Mindless Fury (Cave
Troll); Natural Stealth (Bugbear); Nimble Escape (Goblin); Paralyzing Touch
(Ghoul); Petrifying Gaze (Basilisk); Phasing (Phase Beast); Phylactery (Lich);
Pixie Dust (Pixie); Rend (Cave Troll); Rooted Grasp (Treant); Rusting Antennae
(Rust Monster); Scent Metal (Rust Monster); Shadow Leap (Shadow Stalker);
Shapechange (Doppelganger); Shield Block (Knight); Slow-Witted (Hill Giant,
Ogre); Soulbind (Death Knight); Spellcasting (Lich); Spores (Vrock); Stone
Camouflage (Stone Giant); Stunning Screech (Vrock); Surprise Attack (Bugbear);
Swarming (Swarm of Rats); Three Heads (Chimera); Touch (Fire Elemental);
Transparent (Gelatinous Cube); Tree Stride (Dryad); Treebound (Dryad); Undead
Nature (Skeleton); Unholy Resilience (Death Knight); Unstable (Phase Beast);
War Cry (Orc Warchief); Web (Giant Spider); Whelm (Water Elemental).

Modelled creature abilities, for contrast: Multiattack (all sequences, e.g.
Ancient Dragon's four attacks), Pack Tactics, Leadership, Martial Advantage,
Blood Frenzy, Knockdown, Relentless, Regeneration, Shambling (Zombie acts
last), recharge attacks (roll 5–6 at the start of the turn, `20:28`).

Damage types, resistances and vulnerabilities (`13:156`–`13:166`; e.g. Skeleton
"Vulnerable: Bludgeoning", Treant "Vulnerable: Fire") are **not** modelled:
the engine applies the printed DR and flat damage. This is declared here
rather than silently dropped; a run against a Skeleton will overestimate it.

## The printed Wound Table has gaps

`13:406`–`13:446` prints the bands 111, 112–126, 133–166, 222, 223–235,
236–266, 333, 334–344, 345–366, 444–446, 455–466, 555, 556, 566 and 666.
D666 rolls between the bands (for example 411 or 500) match no printed row.
The engine records those as `Unnamed (gap in the printed table)` with no
effect instead of inventing a row; the wound-band report surfaces the gap so
the manuscript can close it.

## Healing and concentration

Healing is executed as the *Healing Thresholds* law (`08:238`–`08:251`):
half / full / full + rider, Action, unlimited for Novice cards. The ward
ladder (Bark Skin / Stone Skin / Iron Skin, `12:218`–`12:301`) is executed as
a Maneuver-cast concentration effect. Rituals (`10:134`) are out of combat
scope. Damage-type interactions with concentration, rests and respites, and
out-of-combat recovery are not modelled.

## Encounter sampling

Each iteration is an independent encounter that starts with full HP, full
Grit and all once-per-encounter uses available, as if the party had taken a
respite (`13:366`). A run therefore measures per-fight attrition, not a
campaign's resource drain across fights. "Once per session" (`10:108`) is
treated as once per combat, because one combat is one sample session.

## Dice and telemetry

- Recurring healing over rounds is executed for its total when a recurring
  card is in the catalog (none of the shipped run files buy one).
- Random target selection is uniform over living enemies. No wall clock is
  ever consulted; all randomness is seeded from `crc32(seed, combat_index)`.
- Full per-event telemetry is written for a sample (`run.events`, default
  `first:100`); every combat's summary row is always written. `--replay N`
  prints the complete event log for combat N.
