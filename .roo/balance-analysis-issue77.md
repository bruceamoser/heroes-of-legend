# Balance Analysis: Issue #77 — DP Economy & Tier Frequency

## Executive Summary

### Problem A: DP Economy — ADOPTED
**Increase DP to 3 per level** (4 at milestone levels 1, 5, 15, 20). Total: **64 DP at level 20** (up from 41, a 56% increase).

### Problem B: Tier Frequency — ADOPTED
**Shift tier boundaries to Weak 1–8, Standard 9–14, Strong 15–18+.**

---

## Part A: DP Economy

### Current State (41 DP at Level 20)
41 DP forces min-maxing. 5 mastered skills cost 30 DP, leaving 11 for talents. Cross-class costs (2×–4×) are trap choices.

### Recommendation: 64 DP at Level 20

| Level | DP | Total DP |
|-------|-----|----------|
| 1 | 4 | 4 |
| 2 | 3 | 7 |
| 3 | 3 | 10 |
| 4 | 3 | 13 |
| 5 | 4 | 17 |
| 6–14 | 3/level | 44 |
| 15 | 4 | 48 |
| 16–19 | 3/level | 60 |
| 20 | 4 | **64** |

### Design Target Achieved
- 4–5 mastered skills (core competencies): ~24–30 DP
- 2–3 adept skills (secondary breadth): ~9–13 DP
- 8–12 talents (mix of tiers): ~16–24 DP
- 1–2 cross-class purchases: ~2–8 DP
- **Total DP needed: ~55–70 DP** ✓

---

## Part B: Tier Frequency

### Recommendation: Weak 1–8, Standard 9–14, Strong 15+

| M | Weak | Standard | Strong |
|---|------|----------|--------|
| −2 | 50.0% | 40.7% | 9.3% |
| +0 | 25.9% | 48.1% | 25.9% |
| +2 | 9.3% | 40.7% | 50.0% |
| +3 | 4.6% | 32.9% | 62.5% |
| +4 | 1.9% | 24.1% | 74.1% |
| +5 | 0.46% | 16.2% | 83.3% |
| +6 (nat 18) | 0.0% | 9.3% | 90.7% |
| +8 (nat 18 crit) | 0.0% | 0.46% | 99.5% |

All three tiers remain reachable at every modifier. At +5 (peak), Weak = 0.46% — same as Fumble probability.

---

## Discrepancies Discovered

| # | Discrepancy | Resolution |
|---|------------|------------|
| 1 | DP per level: Classes says 8 vs. Advancement says 2–3 | Fixed: now 3–4/level |
| 2 | Skill mastery cost: stated 7 DP, table shows 6 DP (1+2+3) | Confirmed: 6 DP correct |
| 3 | Missing file: docs/design/mechanics-decisions.md | Noted for future |
