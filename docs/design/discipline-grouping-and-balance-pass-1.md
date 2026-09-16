# Discipline Grouping Pass + First Balance Pass

Date: 2026-09-15. Author: Winston. Status: **draft for Bruce's review** — not landed; the mechanics
below go through issue → branch → PR like anything else.

---

## Part 1 — The grouping pass

### 1.1 The idea

A card requirement does not have to name one Discipline. Because the 24 Disciplines are already
organised into 9 categories, a card can name a **group** and cover many Disciplines at once. One
card then serves every member of that group, which is cheaper to author and richer to build in.

The book already uses group requirements in exactly one place — class grants (`1 any Weapon`,
`Any Elemental (1) + 1 opposing Elemental (1)`, `2 any (different types)`) and one card
(*Weapon Focus*, `1 chosen weapon Discipline`). **No manoeuvre and no spell uses a group
requirement.** That is the untapped seam.

### 1.2 Proposed requirement grammar

Six forms, two families.

**Category groups** (a card names one of the nine categories):

| Form | Means |
|---|---|
| `1 any Weapon` | rank 1 in any one of Blades, Axes, Polearms, Archery, Heavy Weapon, Unarmed |
| `1 any Melee Weapon` | rank 1 in Blades, Axes, Polearms, Heavy Weapon or Unarmed |
| `1 any Projectile Weapon` | rank 1 in Archery (the only projectile Discipline today; the group exists so it can grow) |
| `1 any Elemental` | rank 1 in Fire, Earth, Wind or Water |
| `1 any Primal` | rank 1 in Animal or Plants |
| `N any <Category>` | N ranks spread within that category — 2 in one member, or 1 in each of two |
| `N any <Category> (different)` | N ranks in N *different* members |

**Costing rule (needed to make it playable):** when a card requires a group, the player **nominates
the Discipline that satisfies it** and pays that Discipline's rank cost from their class table if
they do not already hold the rank. So a `2 any Melee Weapon` card costs a Blade 2 ranks of Blades
and an Axe-holder 2 ranks of Axes — same card, each pays their own table.

### 1.3 The broadening sweep — 9 manoeuvres

Judged on card text, not on category. A card broadens when its effect is about *fighting*, and stays
specific when the weapon **is** the card.

**Broaden to `1 any Melee Weapon`** (rank 1):
- **Pinpoint Strike** — `+1 damage tier, Piercing N`. Nothing blade-specific.
- **Dual Strike** — two attacks at 1/2/3 each. Any pair of one-hand weapons.
- **Open the Guard** — damage plus the target cannot take Reactions. Generic.

**Broaden to `2 any Melee Weapon`** (rank 2):
- **Power Strike** — `+1 damage tier on your next weapon attack`. Generic.
- **Parry** — `+DR against one attack`, counterattack on Strong. Any weapon can parry.
- **Disarm** — the target drops the weapon. Generic.
- **Trip** — target is Prone. Not reach-specific.
- **Charge** — move up to Speed and attack at `+1 tier`. Generic.
- **Breakthrough** — move through an enemy's space. Generic.

**Deliberately NOT broadened** (the weapon is the card):
- Blades keeps **Cyclone** (spinning blade work), **Riposte** (fencing counter), **Hamstring Cut**,
  **Through the Blind Spot**.
- Axes keeps **Cleave** and **Executioner's Cut** — it owns only two cards, and both are its identity.
- Archery keeps **Throw**, **Dead Reckoning**, **Pinning Shot**, **Single Out**, **Sunshot**.
- Unarmed keeps **Heel Hook**, **Chokehold**, **Taken Alive**.
- Heavy Weapon keeps **Crushing Blow**, **Battering Hurl**, **Groundbreaker**.
- Polearms keeps **Brace**, **Long Spear Rebuke**, **Harvest the Fear**.
- Shield/manoeuvre cards keyed to Armor/Protection/Tactics/Sleight are untouched.

**Effect on the Weapon category** (this is the point of the exercise):

| Discipline | now | after | why |
|---|---|---|---|
| Blades | 20 | 14 | loses 6 generic techniques |
| Axes | 2 | **11** | gains the 9 shared manoeuvres |
| Polearms | 5 | 13 | gains 9, loses Trip |
| Heavy Weapon | 7 | 14 | gains 9, loses Charge/Breakthrough |
| Unarmed | 5 | 14 | gains 9 |
| Archery | 7 | 7 | untouched |

Axes goes from the thinnest column in the book to a full one **without authoring a single card** —
because one card now covers many weapons. That is precisely the effect Bruce described.

### 1.4 The same trick for elements and nature

No existing elemental card is element-agnostic, so this is a **new pattern** rather than a re-key.

The four elements already have mechanical identities — Fire imposes *Burning*, Water *Slowed*,
Wind *Prone/Push*, Earth *Prone/Restrained*. So a card can require `1 any Elemental`, have the
player choose the element when they buy it, and take that element's condition on its rows. One card,
four flavours, and **Water stops being a 3-card column**.

Same construction for Primal: `1 any Primal`, choose Animal or Plants.

This is the cheapest lever in the whole review: authoring an element-agnostic card adds to all four
elemental columns at once.

### 1.5 Defects found while making the calls

1. **Power Strike and Crushing Blow are the same card.** Both print `+1 damage tier on your next
   weapon attack` with the same three rows, one at `2 Blades` and one at `2 Heavy Weapon`. Under the
   broaden this collapses naturally; flagging it so it is a decision, not an accident.
2. **`08:222` contradicts `08:210`.** The damage-budget table prints **Novice 4/6/8, Adept 5/8/11,
   Master 7/10/14**, but the callout directly beneath it explains "a Novice Ember Lance deals 2
   damage on a Weak result, 4 on Standard, 6 on Strong". **Resolved by issue #546:** the table is
   live and the retired rows (2/4/6, 6/9/12, 9/15/21) "are valid nowhere" — the callout, Ember Lance
   and the other spelled-out cards are the residue #546 tracks. Every card drafted below therefore
   uses the live table.
3. **Three pipeline-skill files were carrying the retired bands as if live** — `templates/dispatch-prompt.md`
   (the rules handed to every implementer), `references/council-review-loop.md` (the Game Architect's
   grading row), and `references/closing-balance-audit.md` (a pre-rebase eval snapshot whose every
   compliant/fail verdict was computed against the old rows). An implementer following the dispatch
   prompt would have authored on retired bands and been marked wrong for it. All three corrected,
   with the audit file banner-marked as historical.

---

## Part 2 — First balance pass (cards)

Damage rows below use the live ch08 spine (Novice 4/6/8, Adept 5/8/11, Master 7/10/14).

### 2.1 Summon — 5 cards

Summon is priced in all nine class cost tables and has zero consumers. Treatment is deliberately
**light**: calling and binding conjured creatures resolved as ordinary card effects, with no
companion subsystem and no stat blocks.

**Beast Call** — Arcane Spell · `1 Summon` · Action · Range 30 ft · Keywords: Summon
- *Weak:* A natural animal of the DA's choosing arrives within a round and performs one simple task you name.
- *Standard:* You choose the animal, and it performs tasks for you for the rest of the scene.
- *Strong:* As Standard, and it fights for you: one attack on your turn each round for **4** damage.

**Conjured Servitor** — Arcane Spell · `1 Summon` · Action · Range 10 ft · Keywords: Summon, Utility
- *Weak:* An unseen servant performs one minor task: carry, open, fetch, hold, or knock.
- *Standard:* The servant serves for the scene, and can perform any task a pair of hands could.
- *Strong:* Two servants serve for the scene, and each can exert the force of a strong adult.

**Binding Word** — Arcane Spell · `1 Summon` · Action · Range 60 ft · Keywords: Summon, Control
- *Weak:* The target is Slowed 5 until the end of its next turn.
- *Standard:* The target is Restrained until it Escapes.
- *Strong:* The target is Restrained until it Escapes, and its Escapes are at Bane.

**Summon the Pack** — Arcane Spell · `2 Summon` · Adept · Action · Range 30 ft · Keywords: Summon, Damage
- *Weak:* Two beasts arrive and maul one target for **5** damage.
- *Standard:* **8** damage, and the target is at Bane on its next attack.
- *Strong:* **11** damage, and the target is Prone.

**Sovereign Command** — Arcane Spell · `3 Summon` · Master · Action · Range 60 ft · Keywords: Summon, Binding
- *Weak:* One creature you can see obeys a single command that does not obviously harm it.
- *Standard:* It obeys you for the scene, provided the command does not clearly doom it.
- *Strong:* One creature is bound to your service for the scene, or three creatures obey one shared command.

**Summon after this pass:** 3 rank-1, 1 rank-2, 1 rank-3 — rank-2 floor met, capstone present.

### 2.2 Fate — 0 authored, 2 proposed

Fate needs **no authored card to clear the standard**: the cluster already exists and is merely
unkeyed. Re-keying only:
- *Fortune's Favor*, *Turn the Bones*, *Chaotic Insight*, *Dangerous Gambit* (ch09, currently
  `Disciplines: None`) → `1 Fate`
- *The Given Word* (`11:592`, the oath card) → `1 Fate + 1 Mind`
- The Odd's abilities → `1 Fate` (Lucky Guess, Wrong Number), `2 Fate` (Plot Twist, Serendipity),
  `3 Fate` (Everything At Once)

That yields 5 rank-1, 2 rank-2, 1 rank-3. Two further cards are proposed only to give Fate a
*caster* presence alongside Mind:

**Read the Thread** — Arcane Spell · `1 Fate` · Action · Range: Self · Keywords: Fate, Utility
- *Weak:* You learn whether one named course of action brings danger within the hour.
- *Standard:* You learn which of two courses is safer, and one thing that must happen on either path.
- *Strong:* You learn the safest course and the price of the other.

**Turn of the Wheel** — Arcane Spell · `2 Fate` · Adept · Reaction · Range 30 ft · Keywords: Fate
- *Weak:* One creature must reroll a roll it just made and keep the new result.
- *Standard:* You choose which of the two results stands, for any creature you can see.
- *Strong:* You may turn one die of a just-made roll to any face you name.

**Fate after this pass:** 6 rank-1, 3 rank-2, 1 rank-3.

---

## Part 3 — Breakdown by Discipline (current tree)

Counts are card entries; a card requiring two Disciplines counts in both.

| Category | Discipline | r1 | r2 | r3 | total | composition |
|---|---|---|---|---|---|---|
| Elemental | Fire | 8 | 2 | 0 | 10 | 6 ability, 4 arcane |
| Elemental | Earth | 2 | 5 | 0 | 7 | 5 arcane, 2 divine |
| Elemental | Wind | 2 | 4 | 1 | 7 | 5 arcane, 2 divine |
| Elemental | Water | 1 | 2 | 0 | 3 | 3 arcane |
| Weapon | Blades | 11 | 8 | 1 | 20 | 10 ability, 10 manoeuvre |
| Weapon | Axes | 0 | 2 | 0 | 2 | 2 manoeuvre |
| Weapon | Polearms | 2 | 2 | 1 | 5 | 4 manoeuvre, 1 ability |
| Weapon | Archery | 4 | 2 | 1 | 7 | 5 manoeuvre, 2 ability |
| Weapon | Heavy Weapon | 1 | 5 | 1 | 7 | 6 manoeuvre, 1 ability |
| Weapon | Unarmed | 3 | 1 | 1 | 5 | 3 manoeuvre, 2 ability |
| Defense | Protection | 16 | 10 | 0 | 26 | 17 ability, 4 divine, 3 talent, 2 manoeuvre |
| Defense | Armor | 6 | 3 | 0 | 9 | 6 ability, 2 manoeuvre, 1 talent |
| Primal | Animal | 3 | 1 | 0 | 4 | 3 ability, 1 divine |
| Primal | Plants | 4 | 5 | 0 | 9 | 5 divine, 3 ability, 1 arcane |
| Arcane | Energy | 22 | 12 | 3 | 37 | 19 arcane, 18 ability |
| Divine | Life | 4 | 7 | 0 | 11 | 8 divine, 3 ability |
| Divine | Religion | 7 | 5 | 3 | 15 | 12 divine, 3 ability |
| Esoteric | Mind | 16 | 5 | 2 | 23 | 13 arcane, 10 ability |
| Esoteric | Summon | 0 | 0 | 0 | 0 | — |
| Esoteric | Fate | 0 | 0 | 0 | 0 | — |
| Subterfuge | Stealth | 8 | 2 | 0 | 10 | 10 ability |
| Subterfuge | Sleight | 9 | 0 | 0 | 9 | 7 ability, 1 talent, 1 manoeuvre |
| Knowledge | Lore | 5 | 2 | 0 | 7 | 6 ability, 1 talent |
| Knowledge | Tactics | 12 | 6 | 0 | 18 | 11 ability, 5 manoeuvre, 2 talent |

**Reading it:** rank-2 floor is violated by Summon, Fate and Sleight only. Rank 3 is absent for 15
Disciplines, but under Bruce's standard that is only a defect where rank-1 breadth is also thin —
which is Axes, Water, Animal and the two dead Esoteric columns, nothing else.
