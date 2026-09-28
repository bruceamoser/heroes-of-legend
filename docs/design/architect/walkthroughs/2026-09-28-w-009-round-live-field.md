# W-009 — the round walkthrough, replayed at the LIVE field

**Date:** 2026-09-28 (architect cycle 70). **Method:** `references/architect-role.md` walkthrough 3
("four heroes plus opposition, one full round. Count the rolls before anyone acts, and how often a
player has no meaningful option"). **Corpus:** `origin/main` at `6dafb51`, read for every rule quoted.
**Instruments:** `party-round.py` (the played round, seed 20260928) and `scripts/party-dpr.py`
(the damage re-measure, any revision via `--rev`, `--selftest` passing) — every roll and every figure
below is real output, not an illustration.

## Why a second round walkthrough

W-003 (cycle 26, 2026-09-27) played the book's own example round, three creatures against four heroes,
and closed with a projection: "at the live Standard size (six creatures, `19:53`) the same round is 10
turns and about 13 action/Defence rolls". Three landings have moved both halves of that sentence since:

| landing | what it moved |
|---|---|
| **#807** (`3c6edb7`, `19:59`) | the Standard encounter is `x1.25` party level per hero: **five** Challenge 1 creatures for a party of four, not six |
| **#813** (`a42b49c`) | **HP = 10 + Fortitude + the class's Health attribute** on every hero in the book |
| **#821** (`af84315`) | **six of the nine ch02 templates carry a 2 DP attack card** where they used to swing the Basic floor |

So the round is replayed at the live field, with the printed templates as the party, and the re-measure
that #818's fix was never given is run beside it.

## The set-up, from the printed book

- **Party:** the four martial templates #821 rewrote, read from `02` at `6dafb51`: **Blade**
  (Agility +2, Brawn +1, HP 12, DR 1, *Open the Guard*), **Shadow** (Agility +2, Brawn 0, HP 11, DR 1,
  *Dual Strike*), **Protector** (Brawn +2, Agility -1, HP 15, DR 2, *Open the Guard*), **Leader**
  (Brawn +1, Reason +2, HP 11, DR 1, *Follow My Lead*). Each hero's card is the one the fix bought it,
  and each is `*Action:* Action`.
- **Opposition:** the live Standard encounter (`19:59`, `x1.25`), **five Challenge 1 creatures**:
  Dire Wolf HP 14 DR 1, Giant Spider HP 17 DR 0, Bugbear HP 14 DR 1, Ghoul HP 17 DR 0, Harpy HP 17 DR 0.
  Field total **79 HP**; every attack triple is 4/6/8 (`20`).
- **Rules used as printed:** initiative `3d6 + Agility`, players roll for the creatures too (`13:19`);
  one Action, Movement, Maneuver, one Reaction (`13:29-50`); attacks always hit and the roll reads the
  damage tier (`13:85`, `06:85`); melee attack cards **add Brawn to the row** (`08:235`, `15:115`);
  NPC attacks resolve on the player's Defense roll against Challenge (`13:109`), with the reversal
  (a Weak Defense means the creature lands Strong, `13:117`); DR subtracts and a hit lands for at
  least 1 (`13:95`).
- **Named modelling choices, stated so the transcript can be audited:** Shield Block is not played
  (conservative, and it is one attack per round for the two shield-carrying heroes); creatures attack
  the healthiest hero; heroes focus fire the lowest-HP creature (`13:85`); the Leader's *Follow My Lead*
  ally-attack rider is not counted in its damage.

## The round (seed 20260928)

**Before anyone acts: 9 initiative rolls**, one per combatant (`13:19`), all of them by players. W-003
had to roll creature initiative at +0 because the blocks printed no Agility (its GAP 1, closed since by
the Attributes pass): every block now carries the line, so the nine rolls are the book's own rule, not a
stand-in.

```text
INITIATIVE (3d6 + Agility)
  1. Ghoul        3d6(5,6,6) +2 = 19     6. Giant Spider 3d6(1,3,4) +2 = 10
  2. Bugbear      3d6(4,6,6) +1 = 17     7. Dire Wolf    3d6(1,3,5) +0 = 9
  3. Blade        3d6(3,5,6) +2 = 16     8. Harpy        3d6(1,1,5) +1 = 8
  4. Leader       3d6(2,5,6) +0 = 13     9. Protector    3d6(1,3,4) -1 = 7
  5. Shadow       3d6(1,2,6) +2 = 11
  -> the first HERO acts at slot 3; two creature turns come first

ROUND 1
  1  Ghoul        attacks Protector | Def 3d6(2,3,5) -1 -1 = 8  -> Weak, reversed to STRONG 8 - DR 2 = 6 -> 9/15
  2  Bugbear      attacks Blade     | Def 3d6(1,2,4) +2 -1 = 8  -> Weak, reversed to STRONG 8 - DR 1 = 7 -> 5/12
  3  Blade        Open the Guard at Dire Wolf | 3d6(3,5,6) +1 = 15 -> Strong 9 - DR 1 = 8 -> Wolf 6/14
  4  Leader       Follow My Lead at Dire Wolf | 3d6(2,3,5) +1 = 11 -> Standard 7 - DR 1 = 6 -> Wolf 0/14, down
  5  Shadow       Dual Strike at Bugbear     | 3d6(2,2,2) +0 = 6  -> Weak 4 - DR 1 = 3 -> Bugbear 11/14
  6  Giant Spider attacks Shadow   | Def 3d6(1,2,2) +2 -1 = 6  -> Weak, reversed to STRONG 8 - DR 1 = 7 -> 4/11
  7  Dire Wolf    down, no turn
  8  Harpy        attacks Leader   | Def 3d6(3,3,6) +0 -1 = 11 -> Standard, reversed Standard 6 - DR 1 = 5 -> 6/11
  9  Protector    Open the Guard at Bugbear | 3d6(1,1,4) +2 = 8  -> Weak 6 - DR 1 = 5 -> Bugbear 6/14

ROLLS THIS ROUND: 17 (9 initiative + 4 hero Actions + 5 creature attacks)
field 57 of 79 HP left;  party Blade 5/12, Shadow 4/11, Protector 9/15, Leader 6/11
```

Two further seeds (20260929, 777) give 18 and 18 rolls and the same shape: the field loses 21-23 HP and
the party loses 21-25 a round.

## Table friction, the walkthrough's own measurement

- **4.5 rolls per hero turn** at the live field: 1 Action roll, 1.25 Defense rolls and 2.25 initiative
  rolls amortised. **14 of the 18 rolls are not hero Actions.** W-003 measured 17 rolls for a
  seven-combatant fight; the field was widened by one creature since, so friction per round is flat in
  absolute terms and slightly lower per hero turn.
- **No hero ever had no meaningful option.** 0 of 4 turns. Each hero's Action is its card; the Maneuver
  is live every turn (Defend, Catch Breath, Move, Grapple), and the two shields hold one Reaction.
  The cost of a turn is the choice, not a shortage of choices.
- **The felt arc of the round is the reversal.** Four of the nine turns are Defense rolls, and the
  players roll them: the Ghoul's and the Spider's Weak results landed as the *heaviest* hits of the
  round. That is the design working exactly as `13:117` says it does, and it is what makes five
  creature turns feel like the party's own dice.

## The number #818's fix owed, re-measured

#818 filed the defect from a measurement (`printed templates 12.87 a round, 57% of the benchmark`) and
#821 repaired it. The repair was audited on its DP ledgers and its Derived Stats lines; **its own
headline was never re-measured.** Re-derived here from the corpus at both revisions, per hero Action at
Novice after the band's average monster DR of 0.67:

| | pre-#821 (`af84315^`) | post-#821 (`6dafb51`) |
|---|---|---|
| mean of the nine printed templates, x4 | **13.71** (61% of benchmark) | **23.84** (105%) |
| the four martial templates | **9.51** (42%) | **25.33** (112%) |
| rounds to clear the live five-creature field | **5.51** | **3.17** |

Benchmark (four heroes on a Novice damage card at +2): 22.67. Per-template, post-fix: Protector 7.67,
Blade 6.33, Leader 6.33, Shadow 5.00, Shepherd 5.99, Arcanist 5.67, Intellect 5.99, Unbalanced 5.67,
Makeva 5.00.

**VERDICT: #821 is verified.** The method differs from #818's filed figure by one choice (this re-measure
averages all nine templates; the filing averaged the four that owned a card), which is why 13.71 here
sits beside 12.87 there. Both revisions are walked by the same instrument, so the comparison is
like-for-like, and the direction and the size of the move are unambiguous: the printed teaching party
went from half the damage the encounter math is priced on to slightly more than it.

## The note the melee law forces

A melee attack card adds Brawn **on top of** a row printed at the full band value (`08:235`, `15:115`).
So the Protector's *Open the Guard* is 6/8/10 at Brawn +2, and the Blade's is 5/7/9 at Brawn +1. The
Novice band average of 5.66, which `20:659` prices every creature's HP against, is a **Brawn 0** figure.
Consequences, measured rather than argued:

- a Brawn-heavy party clears the field in **2.99** rounds where the band-average party takes 3.17, so the
  printed party now sits at the window's floor rather than under it;
- nothing here is off-budget: the band governs the **printed row**, and the melee add is a separate
  printed law with its own chapter home. Recorded as a note, not a defect. A future change to either
  sentence moves every martial card in the book, which is why they are cited together.

## GAP 1 — a player cannot tell a flat card from a melee one, and the taxonomy says they can

The round's own reading step found this. The Blade's *Open the Guard* prints `4/6/8` and adds Brawn; the
Arcanist's *Ember Lance* prints `4/6/8` and adds nothing. The two cards are identical on the page, and
the sentence that tells a player how to read the difference is false:

- `08:229` reads "Every damaging card **states its expression in its damage line** as either *Flat* or
  *Attribute-Scaled*."
- **Measured: 0 of the 161 cards** carrying a Weak/Standard/Strong block state either term. **3** state an
  inline attribute expression (the three Basic cards, `09:230/239/266`: "1 + Brawn damage"). **158** state
  neither. "Attribute-Scaled" appears in the whole corpus only at `08:233` (the sentence defining it) and
  `21:47`/`21:49` (the glossary mirrors).
- `19:564`, the book's own card template, has no expression field either: its outcome row reads "Damage
  uses the budget table (`@sec-damage-budget`)" and nothing more.
- The taxonomy names **two** families; the corpus uses **three**: flat (row as printed, `08:231`),
  attribute-scaled (floor + attribute, printed inline, `08:233`), and **melee (row + Brawn)**, which
  exists only as a trailing clause in the middle of the Attribute-Scaled definition and again at
  `15:115`.

Consequence at the table, and it is #818's own defect class arriving from the reading side: a table that
believes the sentence cannot tell the Blade's `4/6/8` from the Arcanist's `4/6/8`, so it either drops
Brawn off every martial card (the party falls back toward the 42% column above) or adds a spell's
attribute to a flat row.

**Repair, smallest first.** Option A, **landed this cycle**: correct `08:229` to state the convention the
book actually has, naming the three families and saying plainly that the family is set by what the card
is rather than by a label on it. One sentence, ch08 only, **no new rule** (every clause restates
`08:231`, `08:233` and `08:235`), no printed number moves. Veto to revert with one word.
Option B, not taken: print the expression on 158 cards and add the field to `19:564`'s template. Heavier,
touches five chapters, and it forks a design question (is the expression a printed field or a category?).

**Secondary observation, recorded not repaired:** `08:225` uses "flat" in its everyday sense ("These are
flat numbers. No dice.") two paragraphs above `08:229`'s defined term *Flat* (row as listed, no attribute).
The two senses happen to agree, so nothing is wrong, but the word is doing two jobs in one callout and is
worth watching before it drifts.

## What this round changed in the record

- **#821 verified** by re-measurement, with both revisions walked by one instrument.
- **Ledger row 242** created: the expression taxonomy, with the repair and its reversal path.
- **Micro-PR:** the `08:229` correction, plus this transcript, the ledger row, the scorecard row and the
  plan entry. Build gate run on the branch.
- **No change owed** to `19:59`'s field size, to `20:659`'s pricing rule, or to the HP formula: the live
  field clears inside the 3-4 round window on the printed party, which is what all three were for.
