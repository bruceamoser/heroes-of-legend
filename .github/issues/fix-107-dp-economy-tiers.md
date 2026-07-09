## Major Fix #7 — Fix DP Economy & Tier Frequency

**Status:** Should fix before publication  
**Affects:** Chapters 07, 09, 18

### Two Related Balance Problems

#### Problem A: DP Economy Too Tight
Total DP at level 20: 41. To master one skill: 7 DP. To master 5 skills: 35 DP. That leaves 6 DP for talents — maybe 1-2 talents at Adept tier. A level 20 character with 5 Master skills and 1 talent feels narrow for endgame.

Cross-class costs (2-4× DP) make off-role skills trap choices. A Protector wanting Novice Stealth pays 3 DP (vs Odd's 1 DP). At that price, cross-class skills are effectively locked out.

**Research needed:** Ask Bruce:
- Is 41 total DP the right number? Should it be 50? 60?
- Should talents have a separate pool from skills?
- Should cross-class costs be flatter (2× max instead of 4×)?

#### Problem B: Strong Tier Too Frequent
At +2 modifier (achievable at level 1 with maxed Brawn, no skill), Strong hits occur 50% of the time. At +4 (Brawn +2, Adept skill +2), Strong occurs 74.1% of the time. Weak results become impossible at +4.

This flattens the tension between tiers. If Strong is the default outcome, the system loses its drama.

**Options to explore:**
1. **Shift tier boundaries:** Weak 1-8, Standard 9-14, Strong 15-18+ (makes Strong harder to reach)
2. **Cap modifiers:** Maximum +3 total modifier (attribute + skill combined)
3. **Reduce attribute range:** -1 to +1 instead of -2 to +2
4. **Increase tier thresholds with level:** At level 1, tiers are as-is. At level 10, shift by +2.
5. **Make difficulty more impactful:** Standard difficulty applies -1 to the roll by default

**Research needed:** Run probability tables for each option and present to Bruce.

### Implementation Steps
1. Present DP economy options to Bruce with math
2. Present tier boundary options to Bruce with probability tables
3. Get decisions
4. Update chapter 07 (skill DP cost table)
5. Update chapter 09 (talent DP costs)
6. Update chapter 18 (advancement DP table)
7. Update chapter 06 (tier boundaries if changed)
8. Rebuild and verify

### Probability Reference
Run these calculations for Bruce:

```
Current tiers (1-6, 7-12, 13-18+):
  +0: W 9.3% | S 64.8% | St 25.9%
  +2: W 1.9% | S 48.1% | St 50.0%  ← Strong half the time
  +4: W 0.0% | S 25.9% | St 74.1%  ← Weak impossible

Option 1: W 1-8, S 9-14, St 15-18+
  +0: W 25.9% | S 48.1% | St 25.9%
  +2: W 9.3%  | S 48.1% | St 42.6%
  +4: W 1.9%  | S 37.0% | St 61.1%

Option 2: Cap at +3
  +3: W 0.5%  | S 37.0% | St 62.5%  ← Still high but Weak reappears

Option 3: Range -1 to +1
  +2: W 1.9%  | S 48.1% | St 50.0%  ← Same as current +2 but max attainable is lower
```
