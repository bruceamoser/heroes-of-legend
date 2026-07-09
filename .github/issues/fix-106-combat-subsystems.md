## Major Fix #6 — Add Combat Subsystems (Surprise, Grappling, Two-Weapon, Non-Lethal, Morale)

**Status:** Should fix before publication  
**Affects:** Chapter 13 (Combat)

### Problem
The combat chapter is missing essential subsystems that every fantasy TTRPG needs:

1. **No surprise/ambush rules** — In an always-hit system, how does getting the drop on someone work?
2. **No grappling rules** — The Grappled condition exists but no rules for initiating or using it
3. **No two-weapon fighting** — Can a Blade dual-wield? How?
4. **No non-lethal damage** — Can you knock someone out instead of killing?
5. **No morale/flee rules** — When do NPCs run away?

### Implementation

#### 1. Surprise & Ambush
Add a section to Chapter 13:

```
== Surprise
When one side catches the other unaware, the ambushing side gains
*initiative advantage*: they act first in the first round, regardless
of initiative rolls. 

Additionally, surprised targets suffer a -2 penalty to their 3d6 
roll on the first round (they're reacting, not acting).

To determine surprise, the ambushing side rolls Stealth (or relevant 
skill) opposed by the target's passive Insight (Knowledge score + 7). 
On Standard or Strong success, surprise is achieved.
```

#### 2. Grappling
Add a section to Chapter 13:

```
== Grappling
To initiate a grapple, make a Brawn (Athletics) roll opposed by the 
target's Brawn (Athletics) or Agility (Acrobatics). 

*Weak:* You grab hold but don't control. Target is Grappled but can 
still act normally.
*Standard:* Firm hold. Target is Grappled and Restrained.
*Strong:* Complete control. Target is Grappled, Restrained, and you 
may move them at half speed.

While grappling, you may use your action to:
- *Pin:* Force another opposed roll. Strong result adds Incapacitated.
- *Throw:* End the grapple. Target is knocked Prone in an adjacent 
space and takes Weak unarmed damage.
- *Choke:* Target begins suffocating (can hold breath for Fortitude 
+ 2 rounds).
```

#### 3. Two-Weapon Fighting
Add to Chapter 13:

```
== Two-Weapon Fighting
When wielding a weapon in each hand, you may attack with both as a 
single Standard Action. 

The off-hand weapon always deals damage one tier lower (Strong→Standard, 
Standard→Weak, Weak→1 damage). 

*Requirements:* The off-hand weapon must have the Light property (Dagger, 
Shortsword, Handaxe) unless you have the Dual Wielder talent.
```

#### 4. Non-Lethal Damage
Add to Chapter 13:

```
== Non-Lethal Attacks
When you reduce a creature to 0 HP with a melee attack, you may 
declare the blow non-lethal. The creature falls Unconscious but 
stable at 0 HP instead of dying. 

Ranged attacks and spells cannot be made non-lethal unless the 
spell specifically allows it.
```

#### 5. Morale
Add to Chapter 13 (and reference in Chapter 19 — GM Guidance):

```
== Morale
NPCs and monsters don't fight to the death by default. When a 
creature faces overwhelming odds, the DA may call for a Morale Check.

The creature rolls 3d6 (no modifiers):
- *Strong (13+):* Stands firm. Gains +1 on next attack.
- *Standard (7-12):* Wavers but stays. Disadvantage on next attack.
- *Weak (1-6):* Flees or surrenders.

A creature automatically checks morale when:
- Reduced below half HP for the first time
- Its leader is defeated
- Half its group has fallen
- The party demonstrates overwhelming force (DA discretion)
```

### Success Criteria
- Each subsystem has clear rules text with W/S/S outcomes where applicable
- Each subsystem has at least one example
- All subsystems cross-reference to relevant conditions in chapter 13
- Builds without errors
