# Heroes of Legend — Combat Engine Specification

**Purpose.** Build an executable engine that *plays* Heroes of Legend, not a statistical model of it. The
previous work (`scripts/combat-sim.py`, `combat-sim-v2.py`) abstracted the game into expected values and
was wrong twice for exactly that reason: it ignored DR the first time, and it ran a healing ladder that
does not exist the second. An engine cannot make either mistake quietly, because it has to *resolve* the
attack, read the card, and apply the rule.

**The distinction that governs every decision below:** a model approximates the game; the engine plays it.
If a rule is in the book, the engine executes it. If a rule is *not* modelled, it is listed in
`NON_GOALS.md` with a reason — never silently dropped.

---

## 0. The audit rule (non-negotiable)

Every constant, table and formula the engine implements **cites its source** as `chapter:line` in a
machine-readable table (`rules/citations.yaml`). The engine ships an `--audit` mode that re-reads the
chapters and verifies each cited value still matches, failing loudly on drift.

This exists because two analyses were built on paraphrases of rules rather than the rules. A citation is
not documentation; it is a test.

---

## 1. Scope

### 1.1 Must be modelled

| system | source |
|---|---|
| Character creation: attributes, ancestry, class, disciplines, cards, equipment | `02`, `03`, `04`, `05`, `18` |
| Creature stat blocks: HP, damage, attacks/round, Challenge, DR, abilities | `20` |
| Initiative and turn order | `13:19`-`13:31` |
| Action / Maneuver / Reaction economy, one of each per turn, one Reaction per round | `13:29`-`13:41`, `13:91`, `09:15` |
| Attack resolution: 3d6 + Attribute + Skill − modifiers | `06:17`-`06:21`, `06:81`-`06:89` |
| **The Defense reversal**: defender rolls 3d6 + Defense − Challenge; a Strong defense means the attacker deals **Weak** damage | `06:99`-`06:136` (table at `06:121`), `13:116`-`13:132`, examples `06:142`, `06:152` |
| The Challenge itself: a stat block's positive Challenge rating is negated onto the roll, minion tier and Challenge 1 both impose −1, the rating caps at −6 | `06:111` |
| A Defense Roll crits and fumbles like any other roll: three 6s takes the monster's **Weak** damage, three 1s takes its **Strong** | `06:136` |
| Damage bands: Novice 4/6/8, Adept 5/8/11, Master 7/10/14; cantrips 1/3/5 | `08:213`, `10:48`, `10:82` |
| DR: armour 1/2/3, ward 1/2/3, **highest source governs, no stacking**, ceiling 3/4/6 by tier | `16:21`-`16:31`, `13:109` |
| Shield DR 1/2/3 via **Shield Block** reaction, on top of armour, **one attack per round**, total damage never below 1 | `16:93`-`16:96`, worked example `16:130` |
| Grit 2/3/4 by tier; returns only on a respite | `13:352`-`13:366` (2/3/4 at `13:354`, respite at `13:366`) |
| **A Wound on every drop to 0 HP, unconditionally** | `13:356`, `13:400` |
| `Catch Breath`: Maneuver, `ceil(maxHP/3)`, uses per combat = Grit | `13:69`, `13:94` |
| The Wound Table: D666, extra dice = wounds carried − 1 capped at 3, keep highest three, sort ascending, hundreds digit = band | `13:402`, `13:404`; tables `13:406`-`13:442` |
| The death roll with the wound-scaled Bane ladder; stabilizing resets failures | `13:370`, `13:390` |
| Healing: **half / full / full + rider**, Action, touch, single target, unlimited | law `08:238`-`08:251`; per card `12:98`, `12:116`, `12:127` |
| Concentration: one effect at a time; sustained effects cost the Maneuver | `10:110`, `10:130` |
| Cards: DP costs 2/4/8, discipline rank gates, once-per-encounter / once-per-session limits | `10:44`-`10:48`, `10:106`, `10:108`, `09:15` |
| Conditions: applied, ticked, expired | `13:195`, table at `13:228` |

### 1.2 May be stubbed (declared in `NON_GOALS.md`, switchable by config)

Cover, terrain, morale, pursuit, social conflict, crafting, XP/advancement, most non-combat skills.
Every stub must be an explicit flag defaulting to **off**, and the report must state which stubs were active.

---

## 2. Inputs — the run file

A single YAML/JSON file fully determines a run. **No hidden defaults.**

```yaml
run:
  name: "protector-vs-goblins"
  seed: 20260927            # required; identical seed => identical output. No wall-clock seeding.
  iterations: 10000         # required

party:
  - class: Protector
    level: 1                 # drives tier (Novice 1-2, Adept 3-6, Master 7+), DP, Grit
    ancestry: Dwarf
    attributes: {Brawn: 2, Fortitude: 2, Agility: 0, Guile: 0, Knowledge: 0, Reason: 0}
    disciplines: [Melee, Armor]
    cards: auto               # or an explicit list; 'auto' spends DP legally
    equipment: {armor: heavy, shield: large}
    policy: default           # named AI policy, see §5
  # ... repeated

opposition:
  - creature: Goblin          # must name a stat block in ch20
    count: 6
    challenge_override: null  # null = use the printed Challenge
    policy: default

policies:
  default:
    target_selection: focus_lowest_hp
    maneuver_priority: [defend, catch_breath]
    grit_at_zero: spend
    heal_policy: at_or_below_half
```

### 2.1 Character construction is real

`cards: auto` must spend the character's starting DP **legally** against `05`/`10` and produce a
character that a player could actually build. The engine refuses to run an illegal character — it does
not silently legalise one. Every constructed character is dumped to `characters/` for inspection.

### 2.2 Level means something

Level sets tier, tier sets Grit (2/3/4), DP budget and card access. **HP does not grow with level**
(`03:78`). `level` must be validated against the tier table and a mismatch is an error, not a warning.

The HP **formula** is changing: under #808/#809 it becomes `10 + Fortitude + the class's Health
attribute`, and `03:78` is rewritten by that work order. The engine implements the post-#809 line and
cites it, so #809 lands before the engine is built (see §14).

---

## 3. Creature construction

Read the stat block from `20-bestiary.qmd` verbatim: HP, damage band, attacks per round, Challenge, DR,
and any ability text. **Attacks per round must be honoured** — the previous model assumed one, which
turned the Master column into a floor (Cave Troll 3, Young Dragon 3, Death Knight 2, Ancient Dragon 4).

A creature whose stat block cannot be parsed cleanly is a **hard failure** with the offending text
printed, never a default.

---

## 4. The combat loop

```
initiative order
loop each round:
    for each combatant in initiative order:
        if dead or dying-unresolved: handle dying, continue
        reset Reaction if a new round
        choose an action from the policy        # Action + Maneuver, independently
        resolve it fully                        # including defense roll and DR
        resolve consequences                    # conditions, wounds, drops, death
    tick durations, expire conditions, check combat end
until: one side is defeated, or round_limit is hit
```

**Turn structure is two independent slots.** Action and Maneuver are not interchangeable and a policy must
be able to spend either, either order. Sustaining a concentration effect consumes the Maneuver.

**Simultaneity is forbidden.** Every effect resolves in order; no "both happen at once" shortcuts.

---

## 5. Policies

Policies are pluggable named strategies, not hardcoded behaviour. The engine must ship at least:

- `focus_lowest_hp`, `focus_highest_threat`, `random`, `nearest`
- `defend`, `catch_breath`, `shield_block` triggers
- `grit_at_zero`: `spend` | `stay_down` | `spend_if_wounded_below_n`
- `heal_policy`: `never` | `every_round` | `at_or_below_half` | `only_at_zero`

Policies are the *player* being simulated. Any design conclusion that depends on policy must be reported
across **at least two policies**, because "the healer is bad" and "the healer plays badly" are different
claims and the previous work could not tell them apart.

---

## 6. Resolution detail (these are the rules that have bitten twice)

**Attack.** Defender's roll is `3d6 + Defense modifiers − attacker's Challenge`. Tiers: Weak 1–8,
Standard 9–14, Strong 15+. **On defense, high is good for the defender:** a Strong defense means the
attacker deals **Weak** damage; a Weak defense means **Strong** damage. Verify this against the worked
examples in `13-combat` and fail the audit if they disagree.

**The Challenge is a printed rating, not an attack bonus.** A stat block's Challenge 3 imposes −3 on the
defense roll, a Challenge ½ minion imposes −1, and the rating caps at −6 whatever the block prints
(`06:111`). The engine reads the rating and negates it; it never invents an attack bonus for a monster.

**A Defense Roll crits and fumbles like any other roll** (`06:136`): three 6s takes the monster's Weak
damage, three 1s takes its Strong. Both outcomes are tested.

**DR.** `effective = min(max(armor_dr, ward_dr), ceiling_by_tier)`; the shield's DR is added for an attack
that used Shield Block, once per round; final damage is `max(1, damage − effective − shield)`.
**A ward on an armoured character must produce the same numbers as armour alone** — the two do not stack.
Assert this as a test.

**Wounds.** Reaching 0 HP costs a Wound **whatever happens next** — a later heal does not undo it, and
spending Grit does not cause it. The Wound Table roll happens at the moment of the drop.

**Death's Door** is a wound-table result, not a wound. It must not be removable by healing.

---

## 7. Telemetry

Record per combat, per participant, per round. Not aggregates — events.

```jsonl
{"combat": 41, "round": 3, "actor": "P1", "action": "attack", "target": "G2",
 "roll": [4,5,6], "total": 15, "defense_roll": [3,3,3], "defense_total": 9,
 "damage_tier": "standard", "raw_damage": 6, "armor_dr": 3, "shield_dr": 0,
 "final_damage": 3, "target_hp_before": 11, "target_hp_after": 8}
```

Per combat, a summary row: outcome, rounds, and per hero — drops, wounds taken, **wound-table results
including the D666 value and the row name**, Grit spent, damage dealt and taken, heals cast, conditions
applied, whether they died, and at what round.

Wound-table results must be recorded **with the row name**, because the design question is not only *how
many* wounds but *which* ones — a band distribution is a design output.

---

## 8. Reports

The engine prints (and writes JSON for) at minimum:

1. **Pacing** — rounds to resolve, distribution, per tier and encounter size. *Tests the 3–4 round law.*
2. **Wound load** — wounds per hero per fight, distribution `P(0W…5W)`, and **`P(a hero reaches 4+ wounds)`**
   against the permanent ceiling.
3. **Attrition** — P(wipe), P(a hero dies), P(a hero ends a fight carrying 4+ Wounds). Reported per class and per build. **Amended 2026-09-28:** the third metric read P(a hero retires) until Bruce ruled the wound arc uncapped (`13:455`, `7fbd34f`); with no cap the same predicate measures the *plateau* milestone, never a career end.
4. **Layer value** — the marginal effect of light armour, heavy armour, shield, ward, and each combination,
   as a delta against that build's own no-layer baseline.
5. **Healer delta** — on/off and one-vs-two, **reported across every policy**, never a single number.
6. **Class spread** — outcomes per class at fixed level and encounter, so a class can be compared to a class.
7. **Wound-band distribution** — which rows actually fire, per tier, as a percentage of all wound rolls.

---

## 9. Determinism

Identical input file + seed ⇒ byte-identical output. Seeding is per-combat from `crc32(seed, combat_index)`
so any single combat can be replayed in isolation by index. No wall-clock, no global RNG, no dict-order
dependence. `--replay N` must re-run combat N and print its full event log.

---

## 10. CLI

```
hol-engine run <runfile.yaml>            # execute the run, write reports
hol-engine run <runfile.yaml> --replay 41
hol-engine audit                         # verify every citation in rules/citations.yaml
hol-engine validate <runfile.yaml>       # check the input without running
hol-engine explain <runfile.yaml>        # print the constructed characters and creatures
```

---

## 11. Acceptance criteria — the engine is not done until all of these pass

1. **Reproduces the printed worked examples.** There are exactly **four** machine-checkable examples and they
   are named here so none is invented: `06:142` (goblin, Challenge −1) and `06:152` (Knight, Challenge −3)
   are the two Defense Roll examples, and `13:487` (A Full Combat Round) and `13:569` (The Ambush) are the
   two combat examples. The `06` pair is written out here as fixed fixtures: dice `4,3,5` on `3d6 + 1` is
   13, a Standard defense, so the goblin's Standard 6 less Kael's DR 1 is 5 damage; dice `2,3,2` on
   `3d6 − 1` is 6, a Weak defense, so the Knight's Strong 11 less DR 1 is 10 damage. Reading ch13's two
   sections for their own figures is part of the work; they are printed and are not to be estimated.
   Because the engine rolls its own dice, this criterion is only reachable through a **scripted-roll mode**:
   the run file or a test fixture must be able to inject an explicit dice sequence so a printed example
   replays exactly. Acceptance is one test per example, asserting the printed totals, tiers and damage. An
   engine that cannot replay the book's own examples is not an engine of the book.
2. **`--audit` passes** — every cited constant matches its chapter line.
3. **Ward-on-armour is a no-op** (equal to armour alone) — asserted in the test suite.
4. **Shield DR never takes damage below 1.**
5. **Every drop to 0 produces exactly one Wound**, including drops followed by a heal in the same round.
6. **A Wound is never removed by any effect**, asserted against every healing, condition-ending and
   wound-table effect in the corpus.
7. **Determinism** — same seed twice, byte-identical.
8. **A Master-tier printed multiattack creature runs without error** and its extra attacks appear in the
   telemetry.
9. **A run with `iterations: 10000`, 4 heroes vs 6 creatures completes in under 60 seconds.**

---

## 12. Deliverables

Everything below lives under **`engine/`** at the repository root. Nothing is written outside that
directory: `quarto-book/` and the repository's own `README.md` are not touched.

| file | contents |
|---|---|
| `engine/hol_engine/` | the engine, in **Python 3, standard library only** (every other instrument in this repository is Python, and a dependency-free engine runs anywhere the book builds) |
| `engine/rules/citations.yaml` | every constant with its `chapter:line` |
| `engine/runfiles/` | at least the four canonical runs: Novice, Adept, Master, and a mixed party |
| `engine/NON_GOALS.md` | every unmodelled system, with a reason |
| `engine/tests/` | the acceptance criteria above, as tests |
| `engine/README.md` | the CLI, the run-file schema, and how to add a policy (**not** the repository's root `README.md`, which is the book's) |

---

## 13. What this is for

The engine exists to answer design questions **before they reach a table**:

- Does an even fight resolve in 3–4 rounds at every tier, or not?
- How many permanent wounds does one Standard fight cost a hero, and does the ceiling of 4 hold a campaign?
- Is a healer worth a party slot, and does the answer change with the policy?
- What is each defensive layer actually worth, and is light armour dead content?
- Do the classes differ from each other, or only in flavour?

Each of those currently has a contested answer. The engine's job is to make them settled.

---

## 14. Corrections and pinned build decisions (architect, cycle 62, 2026-09-27)

The specification above was checked line by line against the manuscript at `3447063` before it was released
to an agent. **The rules it states are correct; several of its line citations were not.** A citation is a
constant the engine implements, so a wrong one either fails `--audit` on the first run or has the agent move
a value to match a line that says something else. Each was re-derived from the file and corrected above.

| where | was | is | why |
|---|---|---|---|
| §1.1 initiative | `13` | `13:19`-`13:31` | the section head is `== Initiative: Who Goes First` |
| §1.1 economy | `13`, `09` | `13:29`-`13:41`, `13:91`, `09:15` | the round table and the one-Reaction sentence; `09:15` is the card field vocabulary |
| §1.1 attack roll | `06` | `06:17`-`06:21`, `06:81`-`06:89` | The Core Roll, and the line that makes the attack roll's tier the damage tier |
| §1.1 reversal | `06` section, `13` | `06:99`-`06:136`, `13:116`-`13:132` | the section is `=== Reading the Defense Result` at `06:113` |
| §1.1 Grit | `13:343`, `13:355` | `13:354`, `13:366` | `13:343` is a morale-table row; `13:355` is blank |
| §1.1 wound trigger | `13:345` | `13:356`, `13:400` | blank at the cited line |
| §1.1 Wound Table | `13:391`, `13:393` | `13:402`, `13:404`; tables `13:406`-`13:442` | both cited lines are blank |
| §1.1 death roll | `13:359` | `13:370`, `13:390` | blank at the cited line |
| §1.1 healing | `12:93`, `12:111`, `12:116` | law `08:238`-`08:251`; cards `12:98`, `12:116`, `12:127` | the healing law is the *Healing Thresholds* section (half / full / full + rider), not a card rung |
| §1.1 conditions | `13:184` | `13:195`, table at `13:228` | the section head and Table 13.3 |
| §1.1 cards | `10:44`, `09` | `10:44`-`10:48`, `10:106`, `10:108`, `09:15` | costs, then the per-encounter and per-session limits |
| §11 item 1 | "all five examples in `13-combat`" | four named examples | ch13 contains **two** `== Worked Example` sections; three more would have been invented |

Three things the spec left undecided are now decided. Each is veto-revertible with one word.

1. **Language and dependencies.** "The repo's language of record" names nothing: this repository is a Quarto
   book whose only executable artifacts are Python instruments. Pinned: **Python 3, standard library only**.
2. **Where it lives.** §12's paths are relative to a new **`engine/`** directory at the repository root, and
   the engine's README is `engine/README.md`. Written bare, the spec's `README.md` would have overwritten the
   book's own repository README.
3. **How acceptance 1 is reachable.** A stochastic engine cannot reproduce a printed example by re-rolling; it
   needs the printed dice. Pinned: a scripted-roll mode, with the two `06` examples written out as fixtures.

**Sequencing.** The engine encodes the HP formula, and `03:78` is being rewritten by #809. Building the engine
first would bake the current formula into `rules/citations.yaml` and into every constructed character, so the
order is **#809, then #807, then this**.
