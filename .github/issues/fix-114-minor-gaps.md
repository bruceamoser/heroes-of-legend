## Minor Fix #14 — Fix Remaining Small Gaps

**Status:** Nice to fix  
**Affects:** Chapters 06, 13, 18

### Remaining Minor Gaps

#### 1. Add Design Philosophy Justifications
Throughout the book, add brief "Designer's Note" asides explaining *why*:
- Why 3d6 instead of d20 (bell curve makes skill matter more than luck)
- Why attacks always hit (missing feels bad, double-rolling slows combat)
- Why flat damage instead of dice (pacing, tactical predictability)
- Why no spell slots (cinematic magic, always-active casters)
- Why Disciplines instead of class levels for ability gating (training narrative, visible progression)

Add these as NOTE admonitions in the relevant chapters.

#### 2. Initiative Spread
Current: d6 + Agility (-2 to +2) = range of -1 to 8. Very narrow — ties common.

Option: Change to 2d6 + Agility. Range: 0 to 14. Still bell-curved. Fewer ties.

Or: Keep d6 + Agility but allow skill bonuses. If you have Combat Awareness (talent), add your skill tier.

**Ask Bruce** which approach he prefers before implementing.

#### 3. Define Shield Block Reaction
Chapter 13 mentions "Reaction: shield block" but never defines it.

Add to Chapter 16 (Armor & Shields):
```
*Shield Block (Reaction):* When you are hit by an attack, you may use 
your reaction to interpose your shield. Reduce the damage tier by one 
step (Strong→Standard, Standard→Weak, Weak→1 damage). You must be 
wielding a shield and aware of the attack.
```

#### 4. DP Refund/Respec Rules
Add to Chapter 18 (Advancement):
```
*Retraining:* At each level, you may exchange one skill rank or talent 
purchase for another of equal or lower DP cost. The DA may require 
narrative justification (finding a trainer, time spent practicing).
```

### Implementation
1. Add design philosophy notes to chapters 06, 08, 10, 13
2. Ask Bruce about initiative spread fix
3. Define shield block in chapter 16
4. Add retraining rules to chapter 18
5. Rebuild and verify
