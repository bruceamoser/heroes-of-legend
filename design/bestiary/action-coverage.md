# Creature action coverage and trope review

Issue [#1279](https://github.com/bruceamoser/heroes-of-legend/issues/1279). Review baseline: `d67e046466bdd5052360b96ed91861d607091446` (starter kit v16.3.0).
This is an authored bestiary expansion for Bruce’s review, not a published release or encounter-balance result. The pass edits 161 creature entries and 55 summon profiles (including CV/title synchronization). All 192 creatures were considered; universal Defend and Opportunity Attack are excluded from distinctive-action counts.

## Findings

| Measure | Before | Review draft |
|---|---:|---:|
| Creatures with distinctive Maneuvers | 127 | 165 |
| Creatures with distinctive Reactions | 13 | 136 |
| Distinctive Maneuver choices on creatures | 132 | 177 |
| Distinctive Reaction choices on creatures | 13 | 148 |
| Monster ability templates | 93 | 126 |
| Main Action choices on creatures | 247 | 247 |

The main gap was Reactions, particularly for pack hunters, duelists, protectors, great dragons and familiar undead. Maneuvers were more common but several movement techniques were strictly less useful than converting a Maneuver into a full movement allowance. The pass adds 33 templates (27 Reactions and six Maneuvers), reuses existing appropriate abilities and revises eight short movement techniques. It does not require every creature to fill every action category.

## How the new choices express the creature

| Style | Examples and decisions | Counterplay |
|---|---|---|
| Skirmisher | Slip the Rush lets a goblin or kobold evade a closing enemy; existing short movement now avoids one chosen visible enemy’s opportunity. | Seal escape squares, approach from several directions or hold another opportunity. |
| Duelist | Turn the Blade answers one adjacent melee attack with a Bane; no automatic riposte. | Use distance, a non-melee attack or force the Reaction before the important blow. |
| Pack hunter | Follow the Pack follows a companion’s voluntary approach, with movement but no attack. | Isolate hunters, block legal endpoints and exploit the movement’s normal opportunities. |
| Guardian | Cover a Companion obstructs a qualifying attack; Sheltering Light grants one ally temporary Physical resistance 2. | Separate protector and ward, attack from another angle or use another damage type. |
| Herd or nest defender | Shelter the Young moves a bear, mammoth, cat or stag toward a threatened ally. It grants no automatic block. | Occupy the route or draw the defender away; its occupied body is its only obstruction. |
| Dragon or many-headed beast | Tail Retort pushes a damaging adjacent attacker away; Second Head Watches extends one Basic Melee opportunity to 2 squares. | Use Stability, distance and non-provoking actions; neither grants an extra Reaction. |
| Undead | Loose skeletons fall Prone for one attack’s resistance; corpses clutch at an attacker; a vampire or wraith recoils through shadow. | Pressure skeleton movement, strike from range, light the route or spend the Reaction before moving. |
| Elemental or plant | Splintering Rime, Barbed Recoil and Heated Hide punish damaging adjacency; ice, spores and a stoked core provide setup. | Use range, matching resistance, alternative routes or wait for the patch to end. |
| Ooze | Clinging Recoil slows a damaging adjacent attacker; no body splits or equipment destruction. | Strike from range or use a second attacker after the Reaction is spent. |
| Swarm | Scatter Before the Blast interferes with one area attack without granting immunity or splitting the actor. | Area damage still ignores its dispersed-body Physical resistance; draw the one Reaction before the next sweep. |
| Leader, caster or oracle | Rally at the Blow steadies a wounded ally; Reproach the Caster adds fear; Seen It Already anticipates one visible attack. | Break hearing/sight, spread out, or use a different attack to draw the single Reaction. |

## Movement technique review

Wing Step, Wind Step, Measured Step, Driving Stride, Ride the Current, Sound the Depths and Tunnel Scamper retain their short movement but avoid opportunities from one visible enemy chosen before moving. Other enemies can still react. Stalking Step gains the same protection only when ending behind cover or concealment from that enemy. None grants Hidden. Normal terrain, occupancy and movement-mode requirements remain.

Silken Scuttle requires existing supported web. Shambling Advance is a short approach with setup against one living quarry, not a replacement sprint. Repeated setup does not stack. Main-to-movement conversion remains the better choice when distance alone matters.

## CV and action economy

HP, base damage tables, Evasion, Threat, permanent resistances and base Stability are unchanged. New action options are reflected in provisional utility estimates and the recomputed CV, including roster and encounter totals. A changed Maneuver adds 0.05 for positioning/support or 0.10 for an offensive setup; a changed Reaction adds 0.05–0.10 for conditional Stability, 0.10 for interference/movement/control or 0.15 for retaliatory injury/displacement or extended opportunity reach. For each creature use the largest changed increment in each action category, not the sum of every alternative. These judgments are visible in the creature’s terminal design notes; they are not measured equivalences.

A creature still has one Main Action, Maneuver and Reaction plus movement. A Reaction competes with its opportunity attack. It cannot react after dying or losing the required capability. Retaliation resolves after the incoming attack and does not feed another retaliation or a free-attack chain. Prevention is declared before the stated roll, damage or forced-movement step. Ordinary Boon cancellation, resistance and Stability caps remain.

There are no extra solo turns, automatic specialty opportunity attacks, blanket immunities or permanent condition penalties. Second Head Watches explicitly permits Basic Melee at reach 2 for that Reaction only. Its action must normally provoke, and cannot itself be a free attack.

## Retaliation and end-of-turn decay

Clinging Recoil applies Slowed 2; Answering Lament and Reproach the Caster apply
Frightened 2; Thunderous Answer applies Deafened 2. When triggered by an attacker
on its own turn, these decay to 1 at that turn’s end and still matter on its next
turn. A rating of 1 would normally disappear before that next turn. This is ordinary
condition decay, not a new expiry rule. Burning 1, Freezing 1 and Bleeding 1 already
resolve their damage before decaying; their retaliations retain rating 1.

## Summoned forms

All 73 player profiles remain separately authored. Reviewed Maneuvers are explicitly included where appropriate and consume the command budget. Summons gain no Reactions, opportunities, autonomous alerts, healing or extra commands. Controller-turn expiry replaces creature-turn expiry in profiles. Matching titles retain the DA creature’s updated CV for identification; that number does not measure the performance of a commanded form without its DA Reactions.

## Reviewed templates

These are reusable capabilities, not creature-specific feat lists. Every new template is assigned to at least two creatures in this pass. Clinging Recoil shares one rule across corpses, adhesive predators and oozes, while their local descriptive text retains the creature’s character. Oath Flame reuses Spell Screen rather than gaining a separate screen variant. Different triggers, required anatomy or materially different effects justify separate templates.

| Ability | Change | Creatures using it |
|---|---|---:|
| [Answering Lament](../monster-abilities/answering-lament.md) | New | 3 |
| [Bank Away](../monster-abilities/bank-away.md) | New | 6 |
| [Barbed Recoil](../monster-abilities/barbed-recoil.md) | New | 4 |
| [Bat Aside the Missile](../monster-abilities/bat-aside-the-missile.md) | New | 5 |
| [Break the Approach](../monster-abilities/break-the-approach.md) | New | 4 |
| [Clinging Recoil](../monster-abilities/clinging-recoil.md) | New | 12 |
| [Coil Against the Pull](../monster-abilities/coil-against-the-pull.md) | New | 3 |
| [Cover a Companion](../monster-abilities/cover-a-companion.md) | New | 6 |
| [Fall to Pieces](../monster-abilities/fall-to-pieces.md) | New | 5 |
| [Flicker Aside](../monster-abilities/flicker-aside.md) | New | 4 |
| [Follow the Pack](../monster-abilities/follow-the-pack.md) | New | 6 |
| [Driving Stride](../monster-abilities/grave-gallop.md) | Revised movement | 2 |
| [Guide the Light](../monster-abilities/guide-the-light.md) | New | 3 |
| [Hook the Retreat](../monster-abilities/hook-the-retreat.md) | New | 6 |
| [Lay the Rime](../monster-abilities/lay-the-rime.md) | New | 2 |
| [Lock the Frame](../monster-abilities/lock-the-frame.md) | New | 5 |
| [Measured Step](../monster-abilities/measured-step.md) | Revised movement | 3 |
| [Rally at the Blow](../monster-abilities/rally-at-the-blow.md) | New | 7 |
| [Ride the Current](../monster-abilities/read-the-current.md) | Revised movement | 5 |
| [Recoil into Shadow](../monster-abilities/recoil-into-shadow.md) | New | 4 |
| [Reproach the Caster](../monster-abilities/reproach-the-caster.md) | New | 5 |
| [Scatter Before the Blast](../monster-abilities/scatter-before-the-blast.md) | New | 2 |
| [Second Head Watches](../monster-abilities/second-head-watches.md) | New | 3 |
| [Seen It Already](../monster-abilities/seen-it-already.md) | New | 3 |
| [Shambling Advance](../monster-abilities/shambling-advance.md) | New | 3 |
| [Shelter the Young](../monster-abilities/shelter-the-young.md) | New | 6 |
| [Sheltering Light](../monster-abilities/sheltering-light.md) | New | 5 |
| [Silken Scuttle](../monster-abilities/silken-scuttle.md) | New | 2 |
| [Slip the Rush](../monster-abilities/slip-the-rush.md) | New | 7 |
| [Splintering Rime](../monster-abilities/splintering-rime.md) | New | 2 |
| [Spore Curtain](../monster-abilities/spore-curtain.md) | New | 2 |
| [Stalking Step](../monster-abilities/stalking-step.md) | Revised movement | 6 |
| [Stoke the Core](../monster-abilities/stoke-the-core.md) | New | 3 |
| [Sound the Depths](../monster-abilities/submerge.md) | Revised movement | 6 |
| [Tail Retort](../monster-abilities/tail-retort.md) | New | 8 |
| [Thunderous Answer](../monster-abilities/thunderous-answer.md) | New | 2 |
| [Tunnel Scamper](../monster-abilities/tunnel-scamper.md) | Revised movement | 2 |
| [Turn the Blade](../monster-abilities/turn-the-blade.md) | New | 4 |
| [Warning Hiss](../monster-abilities/warning-hiss.md) | New | 3 |
| [Wind Step](../monster-abilities/wind-step.md) | Revised movement | 2 |
| [Weave the Roots](../monster-abilities/root-bridge.md) | Clarify table effect | 6 |
| [Wing Step](../monster-abilities/wing-step.md) | Revised movement | 9 |

## Complete roster decisions

Counts are distinctive options, before → after. CV is also before → after. A zero is a considered choice, not a failed coverage target. No ability is granted from its creature family alone.

| Creature | Maneuvers | Reactions | CV | Review |
|---|---:|---:|---:|---|
| [Adder](creatures/adder.md) | 0 → 0 | 0 → 1 | 5 → 5 | Add Warning Hiss. |
| [Air Elemental](creatures/air-elemental.md) | 1 → 1 | 0 → 0 | 21 → 22 | Revise Wind Step. |
| [Ancestor Guardian](creatures/ancestor-guardian.md) | 0 → 1 | 0 → 1 | 16 → 18 | Add Cover a Companion, Warding Light. |
| [Ancient Mammoth](creatures/ancient-mammoth.md) | 0 → 1 | 0 → 1 | 39 → 44 | Add Shelter the Young, Plant the Weight. |
| [Animated Armor](creatures/animated-armor.md) | 0 → 0 | 1 → 2 | 17 → 18 | Add Cover a Companion. |
| [Animated Statue](creatures/animated-statue.md) | 1 → 1 | 0 → 1 | 22 → 22 | Add Lock the Frame. |
| [Ash Demon](creatures/ash-demon.md) | 1 → 1 | 0 → 1 | 29 → 33 | Add Heated Hide. |
| [Ash Revenant](creatures/ash-revenant.md) | 0 → 1 | 0 → 0 | 29 → 32 | Add Shambling Advance. |
| [Bandit Bow](creatures/bandit-bow.md) | 1 → 1 | 0 → 1 | 9 → 10 | Add Slip the Rush. Revise Stalking Step. |
| [Banshee](creatures/banshee.md) | 1 → 1 | 0 → 1 | 50 → 53 | Add Answering Lament. |
| [Barrow Guard](creatures/barrow-guard.md) | 1 → 1 | 1 → 2 | 23 → 25 | Add Cover a Companion. |
| [Basilisk](creatures/basilisk.md) | 0 → 0 | 0 → 1 | 19 → 20 | Add Warning Hiss. |
| [Battle Chaplain](creatures/battle-chaplain.md) | 0 → 1 | 0 → 0 | 13 → 13 | Add Warding Light. |
| [Black Dragon](creatures/black-dragon.md) | 1 → 1 | 0 → 1 | 75 → 84 | Add Tail Retort. Revise Sound the Depths. |
| [Black Pudding](creatures/black-pudding.md) | 1 → 1 | 0 → 1 | 23 → 25 | Add Clinging Recoil. |
| [Blood Bat Swarm](creatures/blood-bat-swarm.md) | 0 → 0 | 0 → 1 | 17 → 18 | Add Scatter Before the Blast. |
| [Vampire Courtier](creatures/blood-courtier.md) | 1 → 1 | 0 → 1 | 40 → 43 | Add Recoil into Shadow. |
| [Blue Dragon](creatures/blue-dragon.md) | 1 → 1 | 0 → 1 | 88 → 96 | Add Tail Retort. |
| [Skeleton Archer](creatures/bone-archer.md) | 0 → 1 | 0 → 1 | 6 → 7 | Add Fall to Pieces, Study the Opening. |
| [Skeleton Colossus](creatures/bone-colossus.md) | 1 → 1 | 0 → 1 | 43 → 46 | Add Fall to Pieces. |
| [Skeleton Sentry](creatures/bone-sentry.md) | 0 → 0 | 0 → 1 | 7 → 8 | Add Fall to Pieces. |
| [Briar Knight](creatures/briar-knight.md) | 1 → 1 | 1 → 2 | 19 → 21 | Add Barbed Recoil. |
| [Bridge Troll](creatures/bridge-troll.md) | 0 → 0 | 0 → 0 | 24 → 24 | Regeneration, fire counterplay and the bridge shove already define its fight; retain a straightforward brute. |
| [Bronze Dragon](creatures/bronze-dragon.md) | 1 → 1 | 0 → 1 | 80 → 90 | Add Tail Retort. Revise Ride the Current. |
| [Brown Bear](creatures/brown-bear.md) | 1 → 1 | 0 → 1 | 17 → 18 | Add Shelter the Young. |
| [Bugbear Ambusher](creatures/bugbear-ambusher.md) | 1 → 1 | 0 → 0 | 25 → 26 | Revise Measured Step. |
| [Burrowing Maw](creatures/burrowing-maw.md) | 0 → 0 | 0 → 0 | 26 → 26 | Burrowing and a maintained bite already demand positioning and shared grapple decisions. |
| [Carrion Rat Swarm](creatures/carrion-rat-swarm.md) | 0 → 0 | 0 → 1 | 11 → 12 | Add Scatter Before the Blast. |
| [Cave Bat](creatures/cave-bat.md) | 0 → 0 | 0 → 0 | 4 → 4 | A small fleeing animal; ordinary flight and opportunities suffice. |
| [Cavern Lurker](creatures/cavern-lurker.md) | 1 → 1 | 0 → 1 | 27 → 29 | Add Hook the Retreat. |
| [Centaur Scout](creatures/centaur-scout.md) | 1 → 1 | 0 → 0 | 17 → 18 | Revise Measured Step. |
| [Chain Jailer](creatures/chain-jailer.md) | 0 → 0 | 0 → 1 | 32 → 34 | Add Hook the Retreat. |
| [Chimera](creatures/chimera.md) | 1 → 1 | 0 → 1 | 55 → 61 | Add Second Head Watches. |
| [Chorus Maw](creatures/chorus-maw.md) | 1 → 1 | 0 → 0 | 37 → 37 | The area disabler already demands spreading out and a recovery turn; do not add another punishment. |
| [Cinder Imp](creatures/cinder-imp.md) | 0 → 0 | 0 → 1 | 7 → 7 | Add Slip the Rush. |
| [Cinder Strider](creatures/cinder-strider.md) | 0 → 0 | 1 → 1 | 18 → 18 | Heated Hide is already the desired close-range Reaction; preserve its lean area-striker role. |
| [Clay Golem](creatures/clay-golem.md) | 1 → 1 | 0 → 1 | 35 → 36 | Add Lock the Frame. |
| [Clay Helper](creatures/clay-helper.md) | 0 → 0 | 0 → 0 | 5 → 5 | A basic laborer and summon entry, with Force rather than combat tricks. |
| [Clockwork Scout](creatures/clockwork-scout.md) | 0 → 1 | 0 → 0 | 5 → 5 | Add Roll Away. |
| [Cloud Giant](creatures/cloud-giant.md) | 1 → 1 | 0 → 0 | 36 → 36 | Draw a Veil is already a distinctive setup; a reactive defense is not required for this negotiator. |
| [Cockatrice](creatures/cockatrice.md) | 1 → 1 | 0 → 0 | 13 → 13 | Revise Wing Step. |
| [Crypt Ghoul](creatures/crypt-ghoul.md) | 0 → 2 | 0 → 0 | 17 → 18 | Add Shambling Advance, Rattle of the Grave. |
| [Crystal Ooze](creatures/crystal-ooze.md) | 0 → 1 | 0 → 1 | 20 → 22 | Add Clinging Recoil, Shed the Grasp. |
| [Cyclops](creatures/cyclops.md) | 1 → 1 | 0 → 1 | 32 → 34 | Add Seen It Already. |
| [Dawn Emissary](creatures/dawn-emissary.md) | 0 → 1 | 0 → 1 | 31 → 34 | Add Sheltering Light, Warding Light. |
| [Death Knight](creatures/death-knight.md) | 0 → 0 | 1 → 2 | 56 → 60 | Add Turn the Blade. |
| [Deep Elf Webweaver](creatures/deep-elf-webweaver.md) | 1 → 2 | 0 → 0 | 13 → 14 | Add Silken Scuttle. |
| [Dire Wolf](creatures/dire-wolf.md) | 1 → 1 | 0 → 1 | 18 → 20 | Add Follow the Pack. |
| [Dryad](creatures/dryad.md) | 1 → 1 | 0 → 0 | 17 → 17 | Root routes and maintained holds already serve its refuge-protector scene. |
| [Earth Elemental](creatures/earth-elemental.md) | 1 → 1 | 0 → 1 | 36 → 37 | Add Lock the Frame. |
| [Emberling](creatures/emberling.md) | 0 → 1 | 0 → 0 | 8 → 8 | Add Stoke the Core. |
| [Ettin](creatures/ettin.md) | 1 → 1 | 0 → 1 | 49 → 53 | Add Second Head Watches. |
| [Faceless Envoy](creatures/faceless-envoy.md) | 1 → 1 | 0 → 0 | 22 → 22 | Disguise and a blinding escape already express its social-infiltrator role. |
| [Fire Giant](creatures/fire-giant.md) | 1 → 1 | 0 → 1 | 52 → 56 | Add Bat Aside the Missile. |
| [Flesh Golem](creatures/flesh-golem.md) | 1 → 1 | 0 → 1 | 29 → 30 | Add Lock the Frame. |
| [Frost Giant](creatures/frost-giant.md) | 1 → 1 | 0 → 1 | 41 → 44 | Add Bat Aside the Missile. |
| [Gargoyle](creatures/gargoyle.md) | 1 → 1 | 0 → 0 | 27 → 27 | Become Still and flight support its architectural ambush without an extra defense. |
| [Gate Archon](creatures/gate-archon.md) | 1 → 1 | 0 → 1 | 43 → 47 | Add Sheltering Light. |
| [Gelatinous Cube](creatures/gelatinous-cube.md) | 1 → 1 | 0 → 1 | 20 → 21 | Add Clinging Recoil. |
| [Ghast](creatures/ghast.md) | 1 → 1 | 0 → 0 | 25 → 25 | Stench and intermittent paralysis already make adjacency dangerous. |
| [Giant Boar](creatures/giant-boar.md) | 1 → 1 | 0 → 1 | 22 → 23 | Add Break the Approach. |
| [Giant Constrictor](creatures/giant-constrictor.md) | 1 → 1 | 0 → 1 | 23 → 26 | Add Coil Against the Pull. Revise Sound the Depths. |
| [Giant Eagle](creatures/giant-eagle.md) | 1 → 1 | 0 → 1 | 16 → 18 | Add Bank Away. Revise Wing Step. |
| [Giant Flytrap](creatures/giant-flytrap.md) | 1 → 1 | 0 → 1 | 22 → 23 | Add Hook the Retreat. |
| [Giant Octopus](creatures/giant-octopus.md) | 1 → 1 | 0 → 0 | 22 → 22 | Ink Cloud and shared grapple costs provide a complete escape-and-hold choice. |
| [Giant Rat](creatures/giant-rat.md) | 1 → 1 | 0 → 0 | 5 → 5 | Revise Tunnel Scamper. |
| [Giant Scorpion](creatures/giant-scorpion.md) | 1 → 1 | 0 → 0 | 22 → 22 | Brace, claws and venom provide a clear stationary threat; no bonus sting Reaction. |
| [Giant Spider](creatures/giant-spider.md) | 0 → 1 | 0 → 0 | 15 → 15 | Add Silken Scuttle. |
| [Glass Sentinel](creatures/glass-sentinel.md) | 0 → 0 | 1 → 1 | 15 → 15 | Spell Screen already counters the threat it was designed to watch. |
| [Gnoll Bonecaller](creatures/gnoll-bonecaller.md) | 1 → 1 | 0 → 1 | 16 → 18 | Add Rally at the Blow. |
| [Gnoll Tracker](creatures/gnoll-tracker.md) | 1 → 1 | 0 → 1 | 13 → 14 | Add Follow the Pack. |
| [Goblin Boss](creatures/goblin-boss.md) | 1 → 1 | 0 → 1 | 20 → 21 | Add Rally at the Blow. |
| [Goblin Firestarter](creatures/goblin-firestarter.md) | 1 → 1 | 0 → 0 | 11 → 11 | Its ranged fire and adjacent Scatter Embers create enough choices for a crew specialist. |
| [Goblin Rattlechanter](creatures/goblin-rattlechanter.md) | 1 → 1 | 0 → 1 | 13 → 13 | Add Rally at the Blow. |
| [Goblin Scrapper](creatures/goblin-scrapper.md) | 1 → 1 | 0 → 1 | 7 → 8 | Add Slip the Rush. |
| [Goblin Smoke Slinger](creatures/goblin-smoke-slinger.md) | 1 → 1 | 0 → 1 | 9 → 10 | Add Slip the Rush. |
| [Goblin Spearhand](creatures/goblin-spearhand.md) | 1 → 1 | 0 → 0 | 9 → 9 | Reach and Roll Away define the exit guard; retain opportunity competition without another trick. |
| [Gold Dragon](creatures/gold-dragon.md) | 1 → 1 | 0 → 1 | 104 → 114 | Add Tail Retort. |
| [Grave Cultist](creatures/grave-cultist.md) | 0 → 1 | 0 → 0 | 8 → 9 | Add Rattle of the Grave. |
| [Grave Wisp](creatures/grave-wisp.md) | 0 → 1 | 0 → 1 | 6 → 7 | Add Flicker Aside, Guide the Light. |
| [Great Cat](creatures/great-cat.md) | 2 → 2 | 0 → 1 | 15 → 16 | Add Shelter the Young. Revise Stalking Step. |
| [Great Stag](creatures/great-stag.md) | 1 → 1 | 0 → 1 | 13 → 15 | Add Shelter the Young. |
| [Green Dragon](creatures/green-dragon.md) | 1 → 1 | 0 → 1 | 80 → 88 | Add Tail Retort. |
| [Green Hag](creatures/green-hag.md) | 1 → 1 | 0 → 1 | 21 → 22 | Add Reproach the Caster. |
| [Griffin](creatures/griffin.md) | 0 → 1 | 0 → 1 | 26 → 28 | Add Bank Away, Wing Step. Revise Wing Step. |
| [Harbor Siren](creatures/harbor-siren.md) | 0 → 2 | 0 → 0 | 16 → 17 | Add Sound the Depths, Keep the Rhythm. Revise Sound the Depths. |
| [Harpy](creatures/harpy.md) | 1 → 1 | 0 → 1 | 19 → 21 | Add Bank Away. Revise Wing Step. |
| [Hearth Brownie](creatures/hearth-brownie.md) | 1 → 1 | 0 → 0 | 5 → 5 | Helping hands is its signature utility; a household helper needs no combat Reaction. |
| [Hedge Sorcerer](creatures/hedge-sorcerer.md) | 0 → 0 | 1 → 1 | 16 → 16 | Spell Screen already supplies a distinctive caster Reaction. |
| [Hedge Sprite](creatures/hedge-sprite.md) | 0 → 1 | 0 → 2 | 5 → 5 | Add Slip the Rush, Flicker Aside, Stalking Step. Revise Stalking Step. |
| [Hell Hound](creatures/hell-hound.md) | 1 → 1 | 0 → 1 | 22 → 24 | Add Follow the Pack. |
| [Hill Giant](creatures/hill-giant.md) | 1 → 1 | 0 → 1 | 29 → 31 | Add Bat Aside the Missile. |
| [Hill Ogre](creatures/hill-ogre.md) | 1 → 1 | 0 → 1 | 19 → 20 | Add Bat Aside the Missile. |
| [Hobgoblin Longbow](creatures/hobgoblin-longbow.md) | 1 → 1 | 0 → 0 | 16 → 17 | Revise Measured Step. |
| [Hobgoblin Marshal](creatures/hobgoblin-marshal.md) | 1 → 1 | 0 → 1 | 29 → 31 | Add Rally at the Blow. |
| [Hobgoblin Shieldguard](creatures/hobgoblin-shieldguard.md) | 0 → 0 | 1 → 2 | 20 → 22 | Add Cover a Companion. |
| [Hook-beak](creatures/hook-beak.md) | 0 → 1 | 0 → 0 | 17 → 18 | Add Stalking Step. Revise Stalking Step. |
| [Horned Devil](creatures/horned-devil.md) | 1 → 1 | 0 → 1 | 43 → 46 | Add Hook the Retreat. |
| [Hydra](creatures/hydra.md) | 1 → 1 | 0 → 1 | 54 → 59 | Add Second Head Watches. |
| [Icebound Warden](creatures/icebound-warden.md) | 0 → 1 | 0 → 1 | 19 → 23 | Add Splintering Rime, Lay the Rime. |
| [Iron Gatekeeper](creatures/iron-gatekeeper.md) | 1 → 1 | 0 → 0 | 44 → 44 | Lock the Feet already reaches Stability 3; a duplicate brace would add no choice. |
| [Kobold Emberkeeper](creatures/kobold-emberkeeper.md) | 1 → 1 | 0 → 0 | 13 → 13 | Scatter Embers and protection of a travelling brazier already supply the role. |
| [Kobold Trapkeeper](creatures/kobold-trapkeeper.md) | 1 → 1 | 0 → 0 | 7 → 7 | Prepared ground and caltrops remain the identity; no reactive trap materializes from nowhere. |
| [Kobold Tunnel Scout](creatures/kobold-tunnel-scout.md) | 1 → 1 | 0 → 1 | 9 → 10 | Add Slip the Rush. Revise Tunnel Scamper. |
| [Lantern Angel](creatures/lantern-angel.md) | 1 → 2 | 0 → 1 | 14 → 16 | Add Sheltering Light, Guide the Light. |
| [Lantern Spirit](creatures/lantern-spirit.md) | 0 → 1 | 0 → 1 | 6 → 6 | Add Flicker Aside, Guide the Light. |
| [Lizardfolk Reedguard](creatures/lizardfolk-reedguard.md) | 1 → 1 | 0 → 0 | 21 → 22 | Revise Sound the Depths. |
| [Lizardfolk Starspeaker](creatures/lizardfolk-starspeaker.md) | 1 → 1 | 0 → 1 | 15 → 17 | Add Spell Screen. Revise Ride the Current. |
| [Manticore](creatures/manticore.md) | 1 → 1 | 0 → 1 | 27 → 30 | Add Bank Away. Revise Wing Step. |
| [Many-headed Marsh Wyrm](creatures/many-headed-marsh-wyrm.md) | 0 → 0 | 0 → 1 | 55 → 62 | Add Tail Retort. |
| [Marsh Crocodile](creatures/marsh-crocodile.md) | 1 → 1 | 0 → 1 | 17 → 18 | Add Coil Against the Pull. |
| [Masked Duelist](creatures/masked-duelist.md) | 1 → 1 | 0 → 1 | 24 → 27 | Add Turn the Blade. Revise Stalking Step. |
| [Medusa](creatures/medusa.md) | 1 → 1 | 0 → 1 | 29 → 31 | Add Warning Hiss. |
| [Merfolk Tideguard](creatures/merfolk-tideguard.md) | 1 → 1 | 0 → 0 | 18 → 19 | Revise Ride the Current. |
| [Mimic Chest](creatures/mimic-chest.md) | 0 → 0 | 0 → 1 | 17 → 18 | Add Clinging Recoil. |
| [Minotaur](creatures/minotaur.md) | 1 → 1 | 0 → 1 | 26 → 27 | Add Break the Approach. |
| [Mire Ooze](creatures/mire-ooze.md) | 0 → 1 | 0 → 1 | 10 → 11 | Add Clinging Recoil, Shed the Grasp. |
| [Moon Hart](creatures/moon-hart.md) | 0 → 1 | 0 → 1 | 25 → 28 | Add Sheltering Light, Warding Light. |
| [Mourning Bell](creatures/mourning-bell.md) | 0 → 0 | 0 → 1 | 49 → 52 | Add Answering Lament. |
| [Mummy King](creatures/mummy-king.md) | 1 → 1 | 0 → 2 | 41 → 44 | Add Clinging Recoil, Rally at the Blow. |
| [Mummy](creatures/mummy.md) | 1 → 1 | 0 → 1 | 29 → 31 | Add Clinging Recoil. |
| [Night Hag](creatures/night-hag.md) | 1 → 1 | 0 → 1 | 32 → 34 | Add Reproach the Caster. |
| [Nightmare](creatures/nightmare.md) | 1 → 1 | 0 → 0 | 31 → 31 | Shadow movement and displacement already express the dangerous mount. |
| [Oath Devourer](creatures/oath-devourer.md) | 0 → 0 | 1 → 2 | 33 → 36 | Add Reproach the Caster. |
| [Oath Flame](creatures/oath-flame.md) | 0 → 0 | 0 → 1 | 26 → 28 | Add Spell Screen. |
| [Ochre Jelly](creatures/ochre-jelly.md) | 1 → 1 | 0 → 1 | 15 → 16 | Add Clinging Recoil. |
| [Ogre Glutton](creatures/ogre-glutton.md) | 1 → 1 | 0 → 0 | 27 → 27 | Stench and choosing whether to hold a victim already create a different ogre fight. |
| [Ogre Hookhand](creatures/ogre-hookhand.md) | 1 → 1 | 0 → 1 | 25 → 27 | Add Hook the Retreat. |
| [Ogre Taskmaster](creatures/ogre-taskmaster.md) | 1 → 1 | 0 → 1 | 36 → 39 | Add Rally at the Blow. |
| [Old Root Guardian](creatures/old-root-guardian.md) | 0 → 1 | 0 → 0 | 51 → 52 | Add Weave the Roots. |
| [Orc Outrider](creatures/orc-outrider.md) | 0 → 1 | 0 → 0 | 12 → 12 | Add Study the Opening. |
| [Orc Shieldbreaker](creatures/orc-shieldbreaker.md) | 1 → 1 | 0 → 0 | 21 → 21 | The hooked attack and Shoulder Through already serve the formation-breaker role. |
| [Orc Warcaller](creatures/orc-warcaller.md) | 1 → 1 | 0 → 1 | 19 → 20 | Add Rally at the Blow. |
| [Owlbear](creatures/owlbear.md) | 1 → 1 | 0 → 1 | 26 → 27 | Add Shelter the Young. |
| [Pact Broker](creatures/pact-broker.md) | 1 → 1 | 0 → 1 | 32 → 34 | Add Reproach the Caster. |
| [Pegasus](creatures/pegasus.md) | 1 → 1 | 0 → 1 | 21 → 23 | Add Bank Away. Revise Wing Step. |
| [Plague Zombie](creatures/plague-zombie.md) | 1 → 1 | 0 → 1 | 11 → 12 | Add Clinging Recoil. |
| [Poltergeist](creatures/poltergeist.md) | 1 → 1 | 0 → 0 | 18 → 18 | Rattle the Room and thrown keepsakes tell the story without reactive extra attacks. |
| [Raven](creatures/raven.md) | 0 → 0 | 0 → 0 | 4 → 4 | A curious utility scout that flees; retain ordinary flight rather than a combat trick. |
| [Red Dragon](creatures/red-dragon.md) | 3 → 3 | 0 → 1 | 95 → 104 | Add Tail Retort. |
| [Redcap](creatures/redcap.md) | 1 → 1 | 0 → 1 | 21 → 22 | Add Break the Approach. |
| [Reed Piper](creatures/reed-piper.md) | 0 → 1 | 0 → 0 | 15 → 15 | Add Keep the Rhythm. |
| [Reef Hunter](creatures/reef-hunter.md) | 0 → 1 | 0 → 0 | 17 → 17 | Add Sound the Depths. Revise Sound the Depths. |
| [Zombie Shambler](creatures/restless-corpse.md) | 0 → 1 | 0 → 1 | 8 → 9 | Add Clinging Recoil, Shambling Advance. |
| [Rill Sprite](creatures/rill-sprite.md) | 0 → 0 | 0 → 1 | 6 → 6 | Add Flicker Aside. |
| [Rime Dragon](creatures/rime-dragon.md) | 2 → 2 | 0 → 1 | 54 → 59 | Add Splintering Rime. |
| [River Serpent](creatures/river-serpent.md) | 0 → 1 | 0 → 1 | 29 → 33 | Add Coil Against the Pull, Sound the Depths. Revise Sound the Depths. |
| [Road Bandit](creatures/road-bandit.md) | 0 → 1 | 0 → 0 | 9 → 9 | Add Stalking Step. Revise Stalking Step. |
| [Roc](creatures/roc.md) | 1 → 1 | 0 → 1 | 43 → 47 | Add Bank Away. Revise Wing Step. |
| [Rust Eater](creatures/rust-eater.md) | 1 → 1 | 0 → 1 | 15 → 16 | Add Clinging Recoil. |
| [Satyr](creatures/satyr.md) | 1 → 1 | 0 → 0 | 16 → 16 | Keep the Rhythm and its distracting attack serve a musician who can be negotiated with. |
| [Sea Hag](creatures/sea-hag.md) | 1 → 1 | 0 → 1 | 21 → 23 | Add Spell Screen. Revise Ride the Current. |
| [Shadow](creatures/shadow.md) | 1 → 1 | 0 → 1 | 17 → 19 | Add Recoil into Shadow. |
| [Shambling Mound](creatures/shambling-mound.md) | 1 → 2 | 0 → 0 | 35 → 37 | Add Spore Curtain. |
| [Shield Soldier](creatures/shield-soldier.md) | 0 → 0 | 1 → 2 | 15 → 17 | Add Cover a Companion. |
| [Skeleton Champion](creatures/skeleton-champion.md) | 0 → 0 | 1 → 1 | 25 → 25 | Shield Hunker already gives the champion a relevant defense choice. |
| [Skeleton Giant](creatures/skeleton-giant.md) | 1 → 1 | 0 → 1 | 28 → 30 | Add Fall to Pieces. |
| [Skeleton Horse](creatures/skeleton-horse.md) | 1 → 1 | 0 → 1 | 15 → 16 | Add Fall to Pieces. Revise Driving Stride. |
| [Ghost — Sorrow-bound](creatures/sorrow-ghost.md) | 1 → 1 | 0 → 1 | 23 → 25 | Add Answering Lament. |
| [Sphinx](creatures/sphinx.md) | 1 → 1 | 0 → 1 | 38 → 40 | Add Seen It Already. |
| [Spore Shepherd](creatures/spore-shepherd.md) | 0 → 1 | 0 → 0 | 12 → 13 | Add Spore Curtain. |
| [Starless Oracle](creatures/starless-oracle.md) | 0 → 1 | 0 → 1 | 26 → 29 | Add Seen It Already, Study the Opening. |
| [Stone Giant](creatures/stone-giant.md) | 0 → 1 | 0 → 1 | 33 → 37 | Add Bat Aside the Missile, Plant the Weight. |
| [Stone Golem](creatures/stone-golem.md) | 1 → 1 | 0 → 0 | 45 → 45 | Innate Stability 3 already reaches the cap; a Stability Reaction would do nothing. |
| [Stone Knuckle](creatures/stone-knuckle.md) | 0 → 1 | 0 → 1 | 9 → 9 | Add Lock the Frame, Plant the Weight. |
| [Storm Column](creatures/storm-column.md) | 0 → 1 | 0 → 1 | 35 → 38 | Add Wind Step, Thunderous Answer. Revise Wind Step. |
| [Storm Giant](creatures/storm-giant.md) | 1 → 1 | 0 → 1 | 54 → 58 | Add Thunderous Answer. |
| [Succubus](creatures/succubus.md) | 1 → 1 | 0 → 0 | 26 → 26 | Borrow a Voice and fear pressure already express social manipulation; no compelled choices. |
| [Sword Angel](creatures/sword-angel.md) | 0 → 0 | 1 → 2 | 43 → 46 | Add Turn the Blade. |
| [Thorn Lurker](creatures/thorn-lurker.md) | 0 → 1 | 0 → 2 | 17 → 20 | Add Barbed Recoil, Hook the Retreat, Weave the Roots. |
| [Thorn Queen](creatures/thorn-queen.md) | 0 → 1 | 0 → 1 | 32 → 36 | Add Barbed Recoil, Weave the Roots. |
| [Thought Leech](creatures/thought-leech.md) | 1 → 1 | 0 → 0 | 20 → 20 | Borrowed voices and disabling attacks are already a complete parasite package. |
| [Lich — Tomb Sage](creatures/tomb-sage.md) | 0 → 1 | 1 → 2 | 45 → 50 | Add Reproach the Caster, Study the Opening. |
| [Trail Hound](creatures/trail-hound.md) | 1 → 1 | 0 → 0 | 5 → 5 | Scent tracking is its useful specialty; keep a level-1 tracking companion simple. |
| [Unicorn](creatures/unicorn.md) | 1 → 1 | 0 → 1 | 24 → 25 | Add Sheltering Light. |
| [Vampire Spawn](creatures/vampire-spawn.md) | 1 → 1 | 0 → 1 | 22 → 24 | Add Recoil into Shadow. |
| [Veteran Captain](creatures/veteran-captain.md) | 2 → 2 | 0 → 1 | 27 → 29 | Add Cover a Companion. |
| [Walking Furnace](creatures/walking-furnace.md) | 0 → 1 | 0 → 1 | 29 → 34 | Add Stoke the Core, Heated Hide. |
| [Walking Thorn](creatures/walking-thorn.md) | 1 → 1 | 0 → 1 | 17 → 19 | Add Barbed Recoil. |
| [Warhorse](creatures/warhorse.md) | 1 → 1 | 0 → 0 | 13 → 14 | Revise Driving Stride. |
| [Water Elemental](creatures/water-elemental.md) | 1 → 1 | 0 → 0 | 22 → 22 | Revise Ride the Current. |
| [Werebear](creatures/werebear.md) | 1 → 1 | 0 → 1 | 27 → 29 | Add Shelter the Young. |
| [Wererat](creatures/wererat.md) | 1 → 1 | 0 → 1 | 14 → 15 | Add Slip the Rush. |
| [Werewolf](creatures/werewolf.md) | 1 → 1 | 0 → 1 | 24 → 26 | Add Follow the Pack. |
| [Wight](creatures/wight.md) | 1 → 1 | 0 → 1 | 27 → 29 | Add Turn the Blade. |
| [Wild Boar](creatures/wild-boar.md) | 1 → 1 | 0 → 1 | 8 → 9 | Add Break the Approach. |
| [Winter Wolf](creatures/winter-wolf.md) | 1 → 2 | 0 → 1 | 41 → 46 | Add Follow the Pack, Lay the Rime. |
| [Wolf](creatures/wolf.md) | 1 → 1 | 0 → 1 | 8 → 9 | Add Follow the Pack. |
| [Wraith](creatures/wraith.md) | 1 → 1 | 0 → 1 | 37 → 39 | Add Recoil into Shadow. |
| [Wyvern](creatures/wyvern.md) | 1 → 1 | 0 → 1 | 27 → 31 | Add Tail Retort. Revise Wing Step. |
| [Young Ember Drake](creatures/young-ember-drake.md) | 0 → 2 | 0 → 0 | 27 → 29 | Add Stoke the Core, Wing Step. Revise Wing Step. |
| [Zombie Brute](creatures/zombie-brute.md) | 1 → 1 | 0 → 1 | 22 → 24 | Add Clinging Recoil. |

## Category coverage

| Category | Creatures | Maneuver creatures, before → after | Reaction creatures, before → after |
|---|---:|---:|---:|
| Aberration | 6 | 5 → 6 | 0 → 3 |
| Animal | 23 | 15 → 18 | 0 → 14 |
| Beast | 18 | 12 → 15 | 0 → 14 |
| Celestial | 4 | 2 → 3 | 1 → 4 |
| Construct | 10 | 5 → 7 | 2 → 6 |
| Dragon | 10 | 8 → 9 | 0 → 9 |
| Elemental | 9 | 3 → 7 | 1 → 6 |
| Fey | 13 | 8 → 13 | 1 → 8 |
| Fiend | 10 | 7 → 7 | 1 → 8 |
| Giant | 13 | 11 → 12 | 0 → 10 |
| Mortal | 35 | 28 → 32 | 3 → 20 |
| Ooze | 5 | 3 → 5 | 0 → 5 |
| Plant | 6 | 3 → 6 | 0 → 3 |
| Spirit | 6 | 2 → 4 | 0 → 5 |
| Undead | 24 | 15 → 21 | 4 → 21 |

## Verification and next table tests

The read-only survey distinguishes action choices, creature coverage and template counts. Its audit checks every roster decision, current action/CV values, attribution to monster-only templates, action types, playable details and command-profile exclusions. The summon check compares complete reviewed Maneuver rules, with controller timing and player-facing Boons, not just names. The normal bestiary audit checks defense/attacker parity and recalculates CV. The book builds must include every new monster-ability entry, index and bookmark; rendered cards still need inspection.

- Test whether a single ranged attacker can reliably draw a dragon’s Reaction before its melee ally commits, and whether Stability makes the tail response manageable.
- Test a duelist who must choose between turning a blade and punishing a provoking action. Avoid assuming a defense Reaction is free.
- Test a pack’s voluntary reaction movement with blocked endpoints and opportunities; no forced movement or free-attack chain triggers it.
- Test several adjacent retaliators against one area attack: normal condition stacking can make a cluster much more dangerous than a lone creature.
- Test a skeleton’s resistance-versus-Prone choice, including a mixed-damage attack and a second attacker before it can stand.
- Test command-only positioning with a low-tier summoned form. Its missing Reaction is intentional, not an import omission.
- Revisit provisional CV increments using real builds and encounters. This coverage pass does not certify the target wound rate or four-round duration.

```sh
python3 design/bestiary/action_coverage.py --check
python3 design/bestiary/action_coverage.py --baseline d67e046466bdd5052360b96ed91861d607091446
python3 design/bestiary/audit.py
```

## Foundry follow-through

[Foundry #175](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/175) tracks the reviewed monster-ability, creature, CV and summon-profile changes. Implement from the final approved source revision, preserve existing actors and resource state, and verify triggers and no-Reaction summon behavior. Book completion does not complete the Foundry issue.
