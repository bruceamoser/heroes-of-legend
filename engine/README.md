# Heroes of Legend — Combat Engine

An executable engine that **plays** Heroes of Legend. It resolves attacks,
reads cards, subtracts DR, rolls wounds on the D666 table, spends Grit, and
records what happened. It is not a statistical model: if the book says it,
the engine executes it or `NON_GOALS.md` says why not.

Python 3, standard library only. No wall-clock seeding, no global RNG.

## Quickstart

```sh
cd engine

# verify every cited constant against the manuscript
./hol-engine audit

# construct the party and print it, without rolling
./hol-engine explain runfiles/novice-goblins.yaml

# check a run file without running it
./hol-engine validate runfiles/novice-goblins.yaml

# run 10,000 combats, write reports/, dump characters/
./hol-engine run runfiles/novice-goblins.yaml

# re-run one combat with its full event log
./hol-engine run runfiles/novice-goblins.yaml --replay 41
```

`python3 -m hol_engine <command>` works the same way. Tests:

```sh
python3 -m unittest discover tests -v
```

## CLI

| command | what it does |
|---|---|
| `run <runfile> [--out DIR] [--iterations N] [--events all\|none\|first:N] [--replay N]` | executes the run and writes `summary.json`, `combats.jsonl`, `events.jsonl`, `report.txt`; dumps constructed characters to `characters/<run>/` |
| `audit` | re-reads every `rules/citations.yaml` entry at its `chapter:line` and fails loudly on drift |
| `validate <runfile>` | parses and constructs the run without rolling; prints every problem |
| `explain <runfile>` | prints the constructed characters, creatures, attack sequences and stubbed abilities |
| `run --replay N` | re-runs combat N from its own crc32 seed and prints the complete event log |

## Run-file schema

```yaml
run:
  name: my-run            # required; names the output directory
  seed: 20260927          # required; identical seed => identical bytes
  iterations: 10000       # required
  round_limit: 20         # optional, default 20
  events: first:100       # optional: all | none | first:N
  dice_script:            # optional: explicit dice groups, for --replay of a
    - [4, 3, 5]           # printed example; each roll consumes one group
  flags:                  # optional stubs, all default off (NON_GOALS.md)
    morale: false
    cover: false
    terrain: false

party:
  - id: P1                # required, unique
    name: Gorma
    class: Protector      # one of the nine classes
    level: 1              # 1-10; sets tier, Grit, DP budget, card gates
    ancestry: Dwarf
    culture: Mountain     # must belong to the ancestry
    attributes: {Brawn: 2, Fortitude: 1, Agility: -1, Guile: 0, Knowledge: 0, Reason: 1}
    disciplines: [Armor, Shields]   # requested starting disciplines
    skills: auto          # auto | explicit list | [] for none
    cards: auto           # auto | explicit list of modelled cards
    equipment: {armor: light|medium|heavy, shield: small|medium|large, weapon: unarmed|one-hand|two-hand|ranged, ward_dr: 0-3}
    policy: default       # named policy below
    health_attribute: ... # Odd only
    odd_disciplines: [...]         # Odd only
    ancestry_discipline: ...       # Human only (any one)
    culture_discipline: ...        # free-choice cultures
    culture_skill: ...             # which culture skill gets the +1

opposition:
  - creature: Goblin      # must name a stat block in 20-bestiary.qmd
    count: 6
    challenge_override: null  # null = printed Challenge
    policy: default

policies:
  default:
    target_selection: focus_lowest_hp   # | focus_highest_threat | random | nearest
    maneuver_priority: [defend, catch_breath]
    grit_at_zero: spend                 # | stay_down | spend_if_wounded_below_n
    grit_wound_threshold: 4             # for spend_if_wounded_below_n
    heal_policy: at_or_below_half       # | never | every_round | only_at_zero
    shield_block: true

study:                    # optional; produces reports 8.4 and 8.5
  layers: true
  healers: true
  iterations: 500
```

The engine refuses an illegal character: attributes must be the six, within
−2..+2, summing to +3 (plus the level 4/8 increases), every discipline rank
and card prerequisite is paid from the correct wallet at the class's rates,
and the ledger is dumped for inspection. `cards: auto` spends what it can and
records each purchase; explicit lists must be fully affordable or the run
fails.

## Adding a policy

A policy is a named block under `policies:` (see the schema above) referenced
by `party[].policy` and `opposition[].policy`. To add behaviour that is not a
configuration knob, subclass `Policy` in `hol_engine/policies`* and hand it to
`Combat`. The four knobs are deliberately independent:

- `target_selection` — which enemy the action attacks.
- `maneuver_priority` — the order it tries `defend` and `catch_breath`.
- `grit_at_zero` — what the hero does at 0 HP (`spend` resets to max).
- `heal_policy` — when the Action is spent on a heal card instead of an attack.

\* The shipped policy lives in `hol_engine/combat.py` as `Policy`; there is no
separate module so that `Combat` stays a single read.

## Determinism

Seeding is per combat: `combat_seed = crc32(f"{run.seed}:{combat_index}")`.
Any single combat can be replayed in isolation by index, and `--replay N`
does exactly that. `summary.json` is written with sorted keys; the
`test_same_seed_same_bytes` acceptance test re-runs a run twice and diffs
every output byte. No wall clock, no global RNG, no dict-order dependence.

## Adding a modelled card or creature

1. Add the constant to `rules/citations.yaml` with a `chapter:line` and a
   `text` fragment that the audit will look for.
2. Add the card to `hol_engine/cards.py` (`MODELED_CARDS`) and give it a
   `kind` the combat loop understands (`attack`, `heal`, `ward`, `buff`,
   `control`).
3. Run `./hol-engine audit` and add a test asserting the new card resolves.

Bestiary creatures need no per-creature code: `hol_engine/bestiary.py`
parses every `=== Name (Challenge N)` block at load time and raises with the
offending text if a block cannot be read cleanly. Multiattack lines
(`Bite + 2 Claws + Tail`, `Greataxe twice`, `May make both Claw and Bite as
one action`) are parsed into attack sequences.

## What the engine reports

`run` prints and writes the seven reports of the specification:

1. **Pacing** — rounds distribution, mean/median, P(3–4 rounds).
2. **Wound load** — wounds per hero per fight, `P(a hero reaches 4+ wounds)`.
3. **Attrition** — P(wipe), P(a hero dies), P(a hero ends a fight carrying 4+ Wounds), per class.
   The third is the wound *plateau* (4, the count at which the wound roll stops escalating),
   reported as a milestone: nothing retires a hero but the death roll (`13:455`).
4. **Layer value** — each armour/shield/ward combination against its own
   no-layer baseline (with `study.layers`).
5. **Healer delta** — healer off / one / two, reported across every policy in
   the run file (with `study.healers`).
6. **Class spread** — outcomes by class at the run's fixed level.
7. **Wound-band distribution** — which D666 rows actually fired.

## Layout

```
engine/
  hol-engine            launcher (no dependencies)
  hol_engine/           the engine
  rules/citations.yaml  every constant, with its chapter:line
  runfiles/             the four canonical runs
  characters/           constructed characters dumped for inspection
  tests/                the nine acceptance tests and regressions
  NON_GOALS.md          every unmodelled system, with a reason
  README.md             this file
```

`quarto-book/` is never modified; the manuscript is the engine's input.
