# Council problem statement — Chapter 17, Magic Items

**Source:** `17-magic-items.qmd` — the `Magic Items` chapter (541 lines, one Typst block).
It covers how to read an item entry, 22 named items, attunement, and Discipline-granting items.

**Question for the council:** is this chapter publishable as it stands — does it conform to the
locked conventions, is it internally consistent (item tables vs their prose vs the damage budget),
and does every value it restates agree with the chapter that defines that value?

## Topics

- **t-01** conformance to the locked conventions below
- **t-02** internal procedure consistency (an item's table rows vs its own prose and passive lines)
- **t-03** cross-chapter canon (values or mechanics defined by another chapter)

Every finding MUST set `topic` to exactly `t-01`, `t-02`, or `t-03`.

## Locked conventions (current as of 2026-09-13 — these ARE the law this run tests against)

1. **Damage budgets are flat by tier**: Novice 2/4/6, Adept 6/9/12, Master 9/15/21, read as
   Weak/Standard/Strong. Success tiers are Weak 1-8, Standard 9-14, Strong 15+. EVERY damaging or
   healing number in the book lands on a row, or is a legal composition of a row (a rider that makes
   base + rider equal a row when it triggers, a multi-target/AoE card at the row per target, a
   heal-over-time whose per-round x rounds equals the row).
2. **"+1 damage tier" is the sanctioned damage-increase convention** (the Overchannel convention).
   Flat `+N damage` riders are DEAD everywhere in the book, magic items included.
3. **The Boon/Bane law.** Anything that changes how likely a roll is to succeed is a **Boon** or a
   **Bane**, never a numeric roll modifier. Boon = 4d6 keep highest three; Bane = 4d6 keep lowest
   three; Boons and Banes cancel one for one. Exactly THREE numeric roll modifiers survive in the
   whole book (the Challenge example's -3, the +1 used as the same-distribution proof for
   player-rolled defense, and the +3 on the skill-tier ladder). Numbers that adjust damage, HP, DR,
   duration, speed or capacity are sanctioned.
4. **Challenge is the standard resolution for every opposed contest** (ruled 2026-09-13, PR #507):
   the actor rolls `3d6 + attribute + skill - Challenge`, where Challenge is the opposition's
   relevant attribute modifier negated. **The opposition never rolls.** A fixed difficulty
   ("Agility check (Standard 9-14)") is a different, legal shape.
5. **DR comes from cards, never from gear.** Ruled 2026-09-13 (PRs #516/#517): armour grants NO DR
   for heroes. The shipped DR source is the **Iron Skin** talent, carrying **DR 2 / 5 / 8** on its
   Novice / Adept / Master rungs. **The DR invariant: three distinct damage tiers survive a flat
   subtraction only while DR is at or below the band's Weak value (Novice 2, Adept 6, Master 9).**
   Above that the tiers collapse and the defense roll stops discriminating. Corollary: **a DR value
   available at level 1 must be 2 or less.** A mount's barding and a monster's natural-armour DR are
   creature stat-block values and are not gear: they stay printed.
6. **Shields** grant Parry and Shield Block (the reaction reduces the damage tier one step).
   A shield grants no DR. Cover has exactly two tiers: half cover = 1 Bane, full cover = 3 Bane.
7. **One roll, one outcome.** An activated power resolves with a single 3d6 roll; the outcome tier IS
   the effect row. There is no separate damage roll and no second roll to confirm an effect.
8. **Conditions are a leveled vocabulary.** A condition that has a magnitude prints the magnitude
   (Burning 2, Slowed 15, Frozen 2), and `Keywords:` lines carry the bare tag only. The condition
   list and the effects table live in ch13. Resistances: resistance halves damage; vulnerability
   doubles it.
9. **Criticals**: three natural 6s is an automatic Strong result plus an effect from the Critical
   table. A fumble is three natural 1s.
10. **Zero em-dashes** anywhere in book source text. Use a comma, a colon, or a full stop.
11. **House emphasis inside body text is Typst italic (`*word*`), never markdown bold.**
12. The book's printed chapter numbering carries a **+2 offset**: this chapter is chapter 17 in
    source order and prints as **Chapter XIX (19)**. Its figures are numbered 19.x and its table
    captions follow the same offset. This is a book-wide convention, not a defect.
13. **Currency is still live in this book.** The kit system (ch15, merged 2026-09-13) is the primary
    equipment mechanism and currency removal is a LATER, unshipped phase. Do not file "this chapter
    has prices" or "this should be a kit pack" as a defect.

## Already checked by the orchestrator and CLEARED — do NOT file these

Reproduce anything you doubt, but these were verified against the source; filing them costs the run
a round.

- **The Novice-row damaging entries are correct.** Ember Burst 2/4/6, Storm Bolt 2/4/6, Frost Nova
  2/4/6, Blinding Volley 2/4/6, Elixir of Dragon's Breath 2/4/6, Potion of Healing 2/4/6.
- **The Adept-row damaging entries are correct.** Burning Retort 6/9/12, Shockwave 6/9/12, Greater
  Healing 6/9/12; Superior Healing 9/15/21 is the Master row.
- **The four "+1 damage tier" passives** (Blade of the Last Ember, Frost Brand, Thunder Maul,
  Shadow Thorn) and Sunbow's "Undead take +1 damage tier" are the sanctioned convention, not flat
  riders. Not defects.
- **Figure 19.1 / 19.2 numbering** is the book-wide +2 offset. Not a defect.
- **Attunement at three items**, and the "no Attunement" items, are internally consistent.
- **Fixed difficulties** ("Athletics check (Standard 9-14)", "Brawn check (Strong 15+)") are legal
  difficulty checks, not opposed contests.
- **The narrative items** (Deck of Many Things, Locket of the Final Word) are deliberately roll-free
  and DA-adjudicated. Design intent, not a defect.

## Orchestrator leads (verify before filing — these are SUSPECTS, not findings)

- `17-magic-items.qmd:356` — **Spellguard Shield** grants **DR 2** from an item. Check it against
  convention 5 (the DR invariant, and where hero DR is allowed to come from at all).
- `17-magic-items.qmd:380` — **Adamantine Plate** grants **DR 7** plus half-damage resistance. Check
  it against the DR invariant at the size of band a Very Rare item lands in, and against Iron Skin's
  Master rung of DR 8.
- `17-magic-items.qmd:137-139` — **Chalice of Shared Mercy** heals **2 / 2 / 2**. Does that land on
  a budget row, or does the row it should be on depend on the item's rarity band?
- `17-magic-items.qmd:308` — **Shadow Thorn** ignores "1 point of DR from non-magical armor". Armour
  has granted no DR since #516: check whether this names a mechanic that no longer exists.
- `17-magic-items.qmd:442` — **Potion of Healing** is drunk with `Roll 3d6 (no modifiers)`. Check
  that shape against convention 7 and against any precedent elsewhere in the book.
- `17-magic-items.qmd:270-271` — **Frost Nova** prints "Slowed 5" and "Frozen 2"; ch15 prints
  "Slowed 15" for caltrops. Check the magnitude convention for a leveled condition.
- `17-magic-items.qmd:341` — **Sunbow** prints "Dazzled". Verify that Dazzled is a defined condition
  in the book's condition list, and if it is defined, that this use matches its definition.
- `17-magic-items.qmd:242` — the **Locket** shifts attitude "Hostile -> Neutral" and "Neutral ->
  Allied". Verify those tier names against the social-conflict chapter's own attitude ladder.
- `17-magic-items.qmd:380` — the Adamantine Plate's "any critical hit becomes a normal hit, the
  attack deals Standard damage". Check that against the critical rule in convention 9.
- `17-magic-items.qmd:384-392` — the **Bag of Holding** is measured in **pounds** ("500 pounds",
  "15 pounds") while hero encumbrance in this book is measured in **slots**. Check which measure the
  book uses for a hero's carried gear.
- `17-magic-items.qmd:15` — "There is no power ceiling ... balance is the DA's call, not a price
  list." Stress-test that claim against the book's anti-power-creep ceiling rule and against the
  rarity guidance later in the same chapter.
- `17-magic-items.qmd:35` — **Figure 19.2's** caption carries a trailing comma, the same defect the
  ch15 pass found and fixed on Figure 17.2.
- `17-magic-items.qmd:510-512` — **Discipline Items** "can unlock Adept and Master abilities just
  like purchased Disciplines". Stress-test the attunement-swap interaction (convention 4 of the
  class economy: level gates on Adept at L3 and Master at L7).

## Cross-check chapters

`06-core-resolution` (rolls, tiers, difficulty, Challenge), `07-skills`, `09-talents-abilities`
(card format, Iron Skin, the Overchannel convention), `10-magic-system`, `13-combat` (attack,
damage, criticals, conditions, resistance, cover), `14-social-conflict` (attitude ladder),
`15-equipment` (kits, encumbrance, slots), `16-armor-shields` (DR, shields, armour), `18-advancement`
(level gates), `21-glossary`, `22-reference-sheets`.

## Citation rule

Every `evidence[].source` must cite either the registered source label `17-magic-items`, another
chapter's filename, or the literal `reasoning`. Quotes go in `quote_or_excerpt` only, under about
12 words. `argument` and `evidence[].claim` are wall-linted against this statement and the source:
do not quote 10 or more consecutive words there.
