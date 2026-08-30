# Heroes of Legend — Mechanics Design Review

*Designer's hat. Read of record: all mechanics chapters (02, 03, 05–10, 13–16, 18), glossary, spell chapters, bestiary samples. August 11, 2026.*

---

## 1. What the Game Actually Is

A **bounded-accuracy, tiered-success, always-forward engine**. 3d6 keeps results tight; the Weak/Standard/Strong bands turn every roll into "success with a price" rather than pass/fail; attacks never whiff; players roll everything; armor reduces damage instead of preventing hits. The result is fast, participatory, cinematic play with real math discipline underneath. The Discipline system is a genuinely novel prerequisite economy. The prose voice is strong and consistent.

**The core loop is sound and should not be disturbed.** The issues below are consistency breaks and unresolved design forks, not engine rot.

## 2. The Engine — Probability Reality Check

3d6 + Attribute (−2…+2) + Skill (+1…+3) + Difficulty (+4…−6), bands: **Weak 1–8 / Standard 9–14 / Strong 15–18+**.

| Total mod | Weak | Standard | Strong | Notes |
|---|---|---|---|---|
| +0 | 25.9% | 64.8% | 9.3% | Default |
| +2 | 11.6% | 62.5% | 25.9% | Adept skill + attr |
| +4 | 1.9% | 48.1% | 50.0% | Trivial diffs trivialize |
| −4 | 79.2% | 20.4% | 0% | Very hard ≈ always Weak |
| −6 | 90.7% | 9.3% | 0% | Near-impossible ≈ ritual Weak |

What this means:
- **Weak is the workhorse band** — ~26% of all neutral rolls are "success with a catch." That's the fail-forward engine. Good.
- **Skill > luck is real**: +2 shifts Strong from 9% to 26%. The book's design note is honest.
- **Difficulty is a tier-collapse dial**: −4/−6 almost guarantee Weak, which is fine *because Weak is still success* — but see Gap #1 below (totals ≤ 0 are unbanded).
- **Crit/Fumble at 1/216** each: ~1 dramatic moment per ~2 sessions at 100 rolls/session. Rare enough to be mythic; good.
- **Bounded accuracy holds**: max reliable roll ≈ 18+2+3 = 23; the bands never break.

**Verdict: the engine is tight. Keep it.**

## 3. Combat Math

- L1 HP ≈ 9–12 (10 + Brawn). Weapon damage 1–8 (Strong tiers). **2–4 hits to drop a hero at L1** — fights are fast and lethal, then DR slows attrition.
- Plate (DR 6) vs Longsword Strong 5 → 0 damage: heavy armor can fully negate single hits, but **volume of Weak hits grinds through** — the "death by a thousand cuts" math checks out (5 goblins at Weak 2 vs DR 6 = 4 damage/round net).
- **Shield Block (tier-down reaction) is the best tactical toy in the book** — cheap, readable, creates real choices (Block vs Riposte — the worked example teaches this beautifully).
- Defense-reversal (high defense roll = low incoming damage) is mathematically equivalent to NPC attack rolls and keeps dice in player hands. Elegant.
- Morale + surrender + non-lethal rules keep fights from overstaying. The 8-minute worked combat is the best teaching section in the book.

## 4. The Discipline System — the Signature

**The good:** prerequisites-not-rolls is a clean, memorable innovation. Permanent mastery, no bookkeeping. Weapon prereqs that *combine* types (Longsword = Blade + Heavy Weapon) make fighting styles real. Attunement items granting temporary Disciplines is a lovely treasure hook. Master-tier "no single type above 3" forces breadth.

**The tension:**
1. **14 vs 20 disciplines.** Chapter 08 documents 14 (no Plants, Life, Religion, Mind, Summon). Classes (ch05) and Glossary use 20. Every divine/support spell path depends on the missing six. This is the single biggest documentation gap — ch08 must be completed.
2. **General-substitution asymmetry**: 1:1 at Novice, *forbidden* at Adept, 2:1 at Master. So the Adept gate is the *hardest* and Master is *easier* than Adept to shortcut. That inverts the natural difficulty curve ("the deeper you go, the cheaper the shortcut"). Design intent is stated ("Adept demands commitment") but the Master 2:1 rule fights it — a player can bypass Adept discipline breadth with Generals. Recommend: 2:1 only at Novice→Adept, or remove Master substitution.

## 5. Magic Pacing — Almost Perfect

Always-fires + per-encounter (Adept) + per-session (Master) + concentration is a **better caster economy than spell slots** for this system's goals. Cantrips free. Spell chains are recognizable and teachable. Fireball (6/9/12, 20-ft) vs Greatsword (3/5/8) — the Adept AoE nova is real but the per-encounter brake makes it a moment, not a rotation. Good.

**The fork: level gates vs discipline gates.** Ch02/05/glossary: "Adept unlocks at Level 3, Master at Level 7" and "At Level 1 you are a Novice — you cannot buy Adept or Master." Ch08/10: "A dedicated caster can reach Adept spells at creation and Master by level 6, or even level 3." These cannot both be true. The Odd signature even says "level requirements still apply" — evidence the level gate is intended. **This is the single most important decision to make** — it determines the entire power curve (creation-Fireball vs Fireball-at-3 changes every encounter budget in the bestiary).

## 6. Progression Economy

- DP: 64 total by L20, Background 8+KN+FO, Class 8. Skills 1/2/3×multiplier, Abilities 1/2/4 flat. Tight economy forces focus — and the book says so, repeatedly. Good.
- **HP formula conflict**: Derived table + glossary + ch03 say **10 + Brawn** (+Brawn/level). The Makeva worked example computes "10 + Fortitude 0 + Knowledge 0", and ch03 prose says both "Fortitude sets your Health Points" *and* "Knowledge helps determine your starting Health Points." Three sources, two formulas. The KN+FO version pairs elegantly with Background DP (8+KN+FO) and makes the "background" stats matter; the Brawn version keeps tank stats in one basket. Pick one, fix the text, and the worked example.
- **Casting attribute conflict**: ch10 (magic) says "3d6 + **Knowledge** + skill"; ch13 worked example casts Gust/Spark with **Reason**; ch03 says Reason is "the engine behind spellcasting"; ch05 keys Arcanist to **Knowledge** but Shepherd/Leader to **Reason**. Four statements, two attributes. Cleanest resolution: arcane → Knowledge, divine → Reason (matches class keying), and say so explicitly in ch10.
- Level-gate numbers also appear in the advancement table's "Class feature upgrade / Capstone" rows while the comment block says classes have no feature upgrades — the table vs the design note disagree. Cleanup needed.

## 7. Gaps — Undefined Mechanics Referenced but Never Ruled

1. **Totals below 1**: at −4/−6 difficulty, rolls can total 0 or less. The tier bands start at 1. What happens? (Recommend: total ≤ 0 = Weak with a complication, or treat as automatic fumble-lite.)
2. **Opposed rolls**: grapple, shove, pin, disguise contests, social (ch19) all say "opposed" — the book never defines how to compare two rolls (compare totals? tiers? margin?). The grapple example (14 vs 7 = "Strong") implies margin but never states it. Needs one explicit paragraph.
3. **Advantage/disadvantage vs Boon/Bane**: glossary defines Boon (extra d6, keep high 3) and Bane (keep low 3); the main text uses "advantage/disadvantage" 20+ times without definition. Pick one vocabulary and define it in ch06, not just the glossary.
4. **"Bonus Action"** appears in the crit table ("Moment of Glory") and the crossbow Loading property — the action economy (Action/Move/Maneuver/Reaction/Free) has no Bonus Action. Should be "Maneuver" or "extra Action."
5. **"Evasion"** used as a stat in the Arcanist's Arcane Shield signature — never defined (Acrobatics Master has an Evasion *maneuver*; the signature seems to mean defense rolls).
6. **Wounds**: dying table says "Take 1 wound" — wound track never defined. (Bestiary/gm chapters don't cover it either.)
7. **DA rolls**: morale checks and the ch16 shield example have the DA rolling dice, directly contradicting "The DA never touches the dice... It is the rules." Either carve out morale as DA-rolled or make it player-facing ("threat roll").

## 8. Consistency & Copyedit List (mechanical, not prose)

| # | Item | Where |
|---|---|---|
| 1 | Plate DR: 3 vs 4 vs 6 | ch06 example / Knight stat / equipment table |
| 2 | Longsword prereq: "2 Blades" vs "1 Blade + 1 Heavy Weapon"; Greataxe "2 Axes" vs "1 Axe + 2 Heavy" | ch08 prereq table vs ch15 weapons |
| 3 | Shortbow 2/4/7 & dagger 1/3/5 in Makeva example vs 2/3/4 & 1/2/3 in equipment | ch02 example vs ch15 (pre-flat-damage leftovers) |
| 4 | Giant Spider still rolls 1d4/1d6/1d8 — violates "no damage dice" | bestiary |
| 5 | Ghost skills: Perception, Lore, Animal Handling, Navigation, Craft, Performance, Thievery — referenced, never in the skill list | ch02 cultures, ch05 favored lists, ch15 gear/mounts |
| 6 | Discipline table empty cells render as ", " | ch07 skill cards |
| 7 | Skill table shows "X1/X2/X3" but maneuver rows leave cost cells blank | ch07 |
| 8 | "six core classes" comment vs eight classes | ch05 opener rationale |
| 9 | 00-front-matter credits [TBD] (Playtesters, Layout, Cover, Editing) | front matter |
| 10 | TODO(#96): Arcane Quick Reference may overflow at 9pt | ch11 |

## 9. What I'd Change If It Were Mine (priority order)

1. **Resolve the level-gate vs discipline-gate fork** — my recommendation: keep the L3/L7 level gates (they protect the early game and make the bestiary honest), and let the Discipline system govern *which* Adept/Master things you can buy when the gate opens. The ch08/10 "Adept at creation" text becomes aspirational language about progression speed, not a rule.
2. **Complete the Discipline taxonomy to 20** and fix the General-substitution Master rule.
3. **Pick the HP formula** (I lean 10 + Brawn for table simplicity, but KN+FO makes the background stats sing — either is defensible) and enforce it everywhere, including the worked example.
4. **Pick the casting attribute** (arcane Knowledge, divine Reason) and make ch10 say so.
5. **Write the three missing micro-rules**: opposed rolls, totals ≤ 0, advantage/disadvantage (adopt boon/bane vocabulary).
6. **Kill the ghost skills**: either add Perception/Lore/Animal Handling/etc. to the skill list or rewrite references.
7. **Let the DA roll morale** (one explicit exception) or make it player-facing.
8. Sweep the copyedit list (§8) — all mechanical, no design risk.

## 10. Bottom Line

This is a **good game with a confident spine**: bounded 3d6, tiered success, always-hit, players-roll-all, Discipline prerequisites, per-encounter magic pacing. The mechanics cohere. What it needs before public eyes is **one consistency pass from the designer**: four unresolved forks (gates, HP, casting attribute, discipline taxonomy) and a handful of undefined micro-rules. None of them require redesign — they require decisions, and then a sweep.

*— W. (designer's hat, for the record)*
