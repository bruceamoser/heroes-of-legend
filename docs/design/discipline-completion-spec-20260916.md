# Discipline Completion Spec — Fate & Summon

**Status:** PROPOSED — awaiting Bruce's single veto pass.
**Authority:** ledger row **125** (Fate) and row **151** (Summon), both RULED 2026-09-16.
**Scope:** the whole of the work those two rulings create, and nothing else.

---

## 0. What is actually wrong

The book claims **"Twenty-three Disciplines"** (`08:65`) and the roster at `08:36-58` does
indeed list 23. Two of them are sold but not delivered, in opposite directions:

| Defect | Discipline | Priced? | Carded? | Net |
|---|---|---|---|---|
| **Unpriced** | **Fate** | **no** — absent from the Comprehensive Cost Table (`05:777-800`, 22 rows) and from all nine class cost tables | **0 cards** | named in the roster (`08:54`) and the ch22 catalog (`22:234`), sold by nothing |
| **Unsold** | **Summon** | **yes** — present in all nine class tables and the matrix (`05:795`) | **0 cards** | priced and catalogued, requires by no card |

Both were confirmed by parse, not by reading prose. `Summon` appears in **zero** `*Disciplines:*`
lines across `09`, `11`, `12`; `Fate` likewise. The book's 193 standalone cards price 21 of
its 23 disciplines.

**Correction to an earlier claim of mine:** I reported that Summon's cost bands were irregular
("1/2/4 for some classes and 4/8/16 for others"). That was a parser artifact — my band regex
used `\d` where it needed `\d{1,2}`, so every two-digit band (`12`, `16`) was silently dropped
and only `1/2/4` and `2/4/8` survived. The real structure is a clean four-band vocabulary used
consistently across all 22 rows:

**Home 1/2/4 · Adjacent 2/4/8 · Foreign 3/6/12 · Opposed 4/8/16**

Summon's pricing is therefore **complete and lawful**. Row 151's work is cards, not costs.

---

## 1. FATE

`08:54` defines it: *"Luck, chance, destiny, oaths kept and broken, the turning of a moment."*
Esoteric category, alongside Mind and Summon (`22:234`).

### 1.1 The cost row (nine cells)

Fate needs one row added to the Comprehensive Cost Table and one row in each of the nine class
cost tables. Proposed assignment:

| Class | Fate | Structure | Why |
|---|---|---|---|
| Protector | 4/8/16 | Opposed | steel has no truck with luck |
| Blade | 4/8/16 | Opposed | as Protector |
| Arcanist | 2/4/8 | Adjacent | Esoteric sibling — cheap, but Fate is intuition, not study |
| Shepherd | 4/8/16 | Opposed | the Shepherd's answer to fate is faith (Religion), not chance |
| Intellect | 2/4/8 | Adjacent | holds Mind at Home; Fate is its untrained half |
| Odd\* | 2/4/8 | Adjacent | forced — the Odd is flat 2/4/8 in all 23, by design |
| Leader | 3/6/12 | Foreign | command bends odds, does not gamble on them |
| Unbalanced† | 3/6/12 | Foreign | chaos is not chance |
| **Shadow** | **1/2/4** | **Home** | the thief's luck, the turning of a moment — and Shadow already holds Mind at Home |

Spread: **Home 1 · Adjacent 3 · Foreign 2 · Opposed 3.** No class is left without a route to
it, and exactly one class is built around it. (Summon reads Home 1 · Adjacent 3 · Opposed 5 —
Fate is deliberately the better-distributed of the two.)

### 1.2 Re-keying (mandated by row 125)

Row 125 directs re-keying of luck-flavoured cards **currently priced under Mind**. Exactly one
card meets that test:

- **`11:576` The Given Word** (Novice Arcane Spell) — currently `*Disciplines:* 1 Mind`,
  `*Keywords:* Oath, Damage`, Weak 4 / Standard 6 / Strong 8. Oaths are Fate's by definition
  (`08:54`: *"oaths kept and broken"*). **Re-key `1 Mind` → `1 Fate`.** No numeric change; the
  Novice ladder is already correct.

**A second target the ruling does not reach, flagged for you rather than taken.** Three Novice
talents in `09` carry reroll effects and are gated on `*Disciplines:* None`, so any hero may
buy them:

| Card | Line | Effect |
|---|---|---|
| Fortune's Favor | `09:25` | once per session, reroll one natural 1, 2, or 3 |
| Turn the Bones | `09:30` | once per scene, reroll any one die |
| Chaotic Insight | `09:148` | once per session, reroll any roll you just made |

These are the *actual* luck cards in the book, and they are ungated — which is why Fate has
nothing even though its flavour has three cards. Two observations worth your ruling:

1. **They are near-duplicates of one another.** Three Novice talents, 2 DP each, three
   overlapping reroll effects. That redundancy is a defect on its own terms, independent of Fate.
2. **Gating any of them to Fate is the cheapest way to give the discipline presence** — but it
   removes a reroll from every non-Fate hero. That is a real power change, not a bookkeeping one,
   so it is your call and not mine.

### 1.3 New Fate cards

Six new cards, in the card shape (`08:134`), priced by the flat card rate (Novice 2 DP / Adept
4 DP / Master 8 DP; gates L1 / L3 / L7).

**Novice — requires `1 Fate`**

1. **Weighted Coin** (Novice Talent) — `*Action:* Reaction · *Range:* Self · *Keywords:* Reroll`
   *Once per scene, after a roll is made but before its outcome is known, shift the result by 1
   in either direction.*
2. **Oathsworn** (Novice Talent) — `*Action:* Passive · *Range:* Self · *Keywords:* Oath`
   *Speak an oath aloud naming one task. While you pursue it you gain +1 to all rolls. Abandon
   the task and you lose 2 maximum HP until you atone. Only one oath at a time.*

**Adept — requires `2 Fate`**

3. **Cast the Bones** (Adept Ability) — `*Action:* Action · *Range:* Self · *Keywords:* Divination`
   *Once per session, ask three questions about one course of action you are considering. The DA
   answers each truthfully and in one sentence.*
4. **Turn of the Wheel** (Adept Ability) — `*Action:* Reaction · *Range:* 30 ft · *Keywords:* Reroll`
   *Once per scene, force a creature within 30 ft to reroll a roll it has just succeeded on, using
   fresh dice.*
5. **Thread of Ruin** (Adept Arcane Spell) — `*Action:* Action · *Range:* 60 ft · *Keywords:* Damage`
   *Weak 5 / Standard 8 / Strong 11* — on the Adept ladder. *An enemy's fortune curdles; a Resolve
   save negates.*

**Master — requires `3 Fate`**

6. **Moment of Turning** (Master Talent) — `*Action:* Reaction · *Range:* Self · *Keywords:* Reroll`
   *Once per session, after a roll fails, treat it as a natural maximum instead.*

**Fate after this work: 7 cards** — 1 re-key + 6 new. Rank coverage **1 ×3 · 2 ×3 · 3 ×1**,
which meets your standing standard (*"they should all have a rank 2"*).

---

## 2. SUMMON

Catalogue text at `08:53`: *"Calling, binding, conjuring creatures."*
**Pricing is already complete** — no cost-table work exists. This is a cards-only module.

The bestiary gives the vocabulary: 49 creatures, Challenge ½ to 12, across 14 categories.

All six cards land in `ch11` (Arcane), in the Weak/Standard/Strong spell shape.

**Novice — requires `1 Summon`**

1. **Call the Least** (Novice Arcane Spell) — `*Action:* Action · *Range:* 30 ft · *Keywords:* Summon`
   *Weak:* one Challenge ½ creature (Wolf, Goblin, Skeleton, Pixie). *Standard:* Challenge 1 or
   lower (Dire Wolf, Ghoul, Harpy). *Strong:* Challenge 2 or lower (Bear, Owlbear, Ogre).
   *It acts on your turn, obeys your spoken commands, and vanishes at the end of the scene or when
   reduced to 0 HP.*
2. **Bind the Weak** (Novice Arcane Spell) — `*Action:* Action · *Range:* Touch · *Keywords:* Binding`
   *Weak:* bind one defeated or willing Challenge ½ creature to one task. *Standard:* Challenge 1.
   *Strong:* Challenge 2. *The binding ends when the task is done or the creature is harmed by you.*

**Adept — requires `2 Summon`**

3. **Call the Mighty** (Adept Arcane Spell) — `*Action:* Action · *Range:* 60 ft · *Keywords:* Summon`
   *Weak:* Challenge 3 (Basilisk, Minotaur, Wraith, Knight). *Standard:* Challenge 4 (Fire
   Elemental, Cave Troll). *Strong:* Challenge 5 (Chimera, Hill Giant, Treant).
   *Lasts 3 turns; once per scene.*
4. **Spirit Ally** (Adept Arcane Spell) — `*Action:* Action · *Range:* Self · *Keywords:* Summon`
   *A Challenge 2 or lower spirit stays beside you for the scene. It cannot be commanded to leave
   your side and it shares your initiative.*

**Master — requires `3 Summon`**

5. **Call the Great** (Master Arcane Spell) — `*Action:* Action · *Range:* 60 ft · *Keywords:* Summon`
   *Weak:* Challenge 6 (Young Dragon, Archmage, Vrock). *Standard:* Challenge 7 (Stone Giant).
   *Strong:* Challenge 8 (Death Knight). *Lasts the scene; once per session.*

   > **Deliberately capped at 8.** The ceiling is your call, not mine — the bestiary runs to
   > Challenge 12 (Ancient Dragon) and Challenge 10 (Lich). Summoning either would put a Master
   > caster above every martial character in the book at the same tier. I have set the cap where
   > the card is strong but not dominant, and flagged it rather than deciding it.

6. **Dismiss the Bound** (Master Arcane Spell) — `*Action:* Reaction · *Range:* 60 ft · *Keywords:* Banish`
   *Return one summoned or extraplanar creature to where it came from. A creature of Challenge 6 or
   lower gets no save; above that, a Resolve save negates.*

   > Summoning needs an off-switch. Without one, the discipline that adds creatures to the board
   > is also the discipline with no answer to creatures on the board.

**Summon after this work: 6 cards.** Rank coverage **1 ×2 · 2 ×2 · 3 ×2** — better coverage than
most disciplines in the book.

---

## 3. Files touched

| File | Change |
|---|---|
| `05-classes.qmd` | Fate row ×9 class cost tables (`05:65,109,160,204,248,294,340,410,462`) + Fate row in the Comprehensive Cost Table (`05:777-800`) |
| `09-talents-abilities.qmd` | 10 new cards (6 Fate, 4 of the Summon set if placed here) |
| `11-arcane-spells.qmd` | 6 Summon spells; `The Given Word` re-keyed `1 Mind`→`1 Fate` (`11:577`) |
| `22-reference-sheets.qmd` | verify the Fate catalog row; DP tables unchanged |
| `21`/`08` | count claim already reads 23 and is now true — **no edit** |

---

## 4. The veto pile

Everything below is implemented as an **implemented default** unless you rule otherwise. Each is
one line of your time.

| # | Decision | My default |
|---|---|---|
| F1 | Fate's Home class | **Shadow** (Arcanist/Intellect/Odd Adjacent, Leader/Unbalanced Foreign, Protector/Blade/Shepherd Opposed) |
| F2 | Gate the three ungated reroll talents to Fate? | **No** — flag only; keep them open to all heroes |
| S1 | Master summon ceiling | **Challenge 8**, not 10/12 |
| S2 | Re-key `The Given Word` Mind→Fate | **Yes** (this one is mandated by row 125) |

---

## 5. Issues to file

Per `AGENTS.md` — *"No issue = no work. Bite-sized issues."* Two modules, and they must
**serialize**, because both write the same nine class cost tables and the same ch22 reference
sheet; parallel agents will conflict on those files.

1. **Fate module** — §1.1 + §1.2 + §1.3
2. **Summon module** — §2

Both land before the row-2 balance sweep, which remains the closing act of the build pass.

---

## 6. Appendix — the #649 blocker, and how it resolved

Recorded because the resolution differed from what this appendix first proposed.

**The blocker.** #649 told the agent to move Wall Shield off the card system, but `16:25` then read
that a shield item grants no number on its own, that shield DR comes from a card, and that Wall
Shield and Ward of Faith were the only two printed sources. Three statements the ruling contradicted
at once. Separately, `16:92` Shield Block reduced the damage *tier* rather than DR, so "Shield Block
becomes the Reaction that applies shield DR" silently assumed one of two very different shields.

**Resolution — 2026-09-16, PR #650, merged to `main` as `5f5c6f2`:**

- Shield Block now **applies the shield's DR**, replacing the tier reduction entirely.
- Shield DR is set by **size class: small 1 / medium 2 / large 3**. Historical shield names are
  flavor, not statistics. This supersedes the item ladder this appendix first proposed.
- Shield DR never enters the DR total, so the printed 3/4/6 ceiling is untouched and no number
  changed.
- Ward of Faith was reworked: it improves a shield the target already wields.
- The Shields maneuver ladder landed at **6 cards** — Interpose was kept, and Cover Ally was deleted
  as its duplicate.
- Ledger row **157** carries the ruling.

Nothing here is open. The first-draft defaults (D1-D4) are superseded by the above and are not
preserved as options.
