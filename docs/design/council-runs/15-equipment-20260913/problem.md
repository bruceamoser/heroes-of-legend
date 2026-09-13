# Council problem statement — Chapter 15, Equipment

**Source:** `15-equipment.qmd` — the `Equipment` chapter (289 lines, one Typst block).
It covers Weapons, Armor, Encumbrance, Adventuring Gear, Mounts & Vehicles, Mounted Combat,
and Vehicles.

**Question for the council:** does this chapter conform to the locked conventions, is its
internal procedure consistent, and does it agree with the canon chapters that define the same
values?

## Topics

- **t-01** conformance to the locked conventions below
- **t-02** internal procedure consistency (tables vs prose vs worked examples)
- **t-03** cross-chapter canon (values defined by another chapter)

Every finding MUST set `topic` to exactly `t-01`, `t-02`, or `t-03`.

## Locked conventions (current as of 2026-09-13 — these ARE the law this run tests against)

1. **The Boon/Bane law.** Anything that changes how likely a roll is to succeed is expressed as a
   **Boon** or a **Bane**, never as a numeric modifier on the roll. A Boon is 4d6 keeping the
   highest three; a Bane is 4d6 keeping the lowest three; Boon 2 / Potence is 5d6 keeping three.
   Boons and Banes cancel one for one. Only the SITUATIONAL layer converts; attributes, skill
   tiers and difficulty keep their numbers.
2. **Exactly three numeric roll modifiers survive in the entire book**, and a fourth is a defect:
   the Challenge example's −3, the +1 to attack used as the same-distribution proof for
   player-rolled defense, and the +3 on the skill-tier ladder. **Numbers that adjust a roll outside
   those three are violations. Numbers that adjust DAMAGE, HP, DR, duration, speed or capacity are
   not** — those are the sanctioned home for numbers.
3. **Challenge is the standard resolution for every opposed contest** (ruled 2026-09-13, shipped
   in PR #507). The acting character rolls `3d6 + Attribute + Skill − Challenge`, where Challenge is
   the target's relevant attribute modifier, negated. **The target never rolls.** This replaced the
   old "both sides roll, higher tier wins" rule, which no longer exists anywhere in the book.
4. **The weapon-as-flavour law.** Weapons are flavour and permission, not power. Damage comes from
   the attack ability card's row, never from the weapon. This chapter states it: *"The weapon never
   changes these numbers."* No weapon may be strictly better than another at the same cost, and no
   weapon may grant a damage bonus.
5. **Damage budgets are flat by tier**: Novice 2/4/6, Adept 6/9/12, Master 9/15/21. Success tiers
   are Weak 1-8, Standard 9-14, Strong 15+.
6. **Cover has exactly two tiers**: half cover is 1 Bane, full cover is 3 Bane. There is no
   three-quarters tier. "Cannot be targeted" belongs only to Invisible or a concealment effect.
7. **Skill tiers** are Novice +1, Adept +2, Master +3. **Passive Insight** is Knowledge + 7 and is
   for passive detection, not for opposing a roll.
8. **Encumbrance**: `10 + (Brawn × 5)` slots, floor 5 (ruled 2026-09-10).
9. **Zero em-dashes** anywhere in book source text. Use a comma, a colon, or a full stop.
10. **House emphasis inside body text is Typst italic (`*word*`), never markdown bold.**
11. The book's printed chapter numbering carries a **+2 offset**: this chapter is chapter 15 in
    source order and prints as **Chapter XVII (17)**. Figures in it are numbered 17.x and its table
    captions follow the same offset. This is a book-wide convention, not a defect.

## Already checked by the orchestrator and CLEARED — do NOT file these

Reproduce anything you doubt, but these were verified against the source and the built PDF; filing
them costs the run a round.

- **Encumbrance arithmetic.** `10 + Brawn×5` with a floor of 5; the Brawn +1 example is genuinely
  15 slots; the worked load (1+2+2+1+1+1+1) is genuinely 9 slots. All correct.
- **The tower shield's cover.** This chapter says it "provides half cover" while ch16 says half
  cover and adds that it can be **planted as a maneuver to grant full cover** to one ally behind
  you. These agree: ch15 states the carried state and defers prices to ch16. Not a conflict.
- **Barding (+1/+3 DR), vehicle upgrades (+10 HP, +2 DR, 50% price), healer's kit (+1 HP per use),
  shield DR (+1/+2/+3), and the carriage/chariot speed notation "20 ft (draft horse, −2)"** are all
  numbers attached to DR, HP, or speed. Those are sanctioned. Not defects.
- **The charge attack's "+1 damage tier"** moves a damage row, not a roll, and its table
  (Weak→Standard, Standard→Strong, Strong→Strong) is correct. Sanctioned.
- **Fishing tackle's "Knowledge check (Standard 9-14)"**, **caltrops' Agility check (Standard)**,
  **manacles' escape "Agility check (Strong 15+) or Brawn check (Strong 15+)"**, and the mount-death
  Agility check (Standard 9-14) are all fixed difficulties, not opposed contests. Fine.
- **`Hidden` in the smoke bomb row** is a defined condition (added to ch21 and ch22 in PR #501).
- The **game statistics** — mount and vehicle HP/Speed/Carry columns, all gold costs, the gear
  table's slot values — have not been audited for balance. That is a lead, not a cleared item.

## Orchestrator leads (verify before filing — these are SUSPECTS, not findings)

- `15-equipment.qmd:246` — *Mounted vs. Foot* grants a **−1** and a **+1** to attacks. If those are
  roll modifiers, they are a fourth and fifth surviving numeric modifier and violate convention 2.
- `15-equipment.qmd:284` — the *Chases* rule has each side **roll 1d6** and add a bonus equal to
  the Speed difference divided by 10. That is both a different die from the 3d6 core and a numeric
  roll modifier.
- `15-equipment.qmd:164` — the **Spyglass** reduces the difficulty of a Perception check **by one
  tier**. Compare ch13's Blinded condition, which was converted from a tier reduction to a double
  Bane. If that conversion was the law, this is the same shape unconverted.
- The **Longbow (50 gp)** and the **Shortbow (25 gp)** have an identical `60/120 ft` range, and the
  **Crossbow (25 gp, `20/60 ft`, `Loading`)** is shorter-ranged than the shortbow at the same price.
  Convention 4 says no weapon may be strictly worse; check whether any of these three is dominated.
- `15-equipment.qmd:75-76` — the **Thrown** property's parenthetical lists Dagger, Handaxe and
  Spear, but the weapon table marks a fourth weapon Thrown.
- The **armor table has no Slots column** while the prose states "Armor takes 2-4 slots". Can a
  reader determine any armor's slot cost?
- The **Mule's** special is "once per session, may reroll a failed check". Is a reroll part of this
  book's grammar, or should that be a Boon?

## Cross-check chapters

`06-core-resolution` (rolls, tiers, difficulty, Challenge), `07-skills`, `13-combat` (attack,
damage, conditions), `16-armor-shields` (armor and shield values — the canon HOME for DR),
`20-bestiary` (stat block conventions), `21-glossary`, `22-reference-sheets`, `02-*` and `03-*`
(coin and starting kit), `05-classes` (starting kits).

## Citation rule

Every `evidence[].source` must cite either the registered source label `15-equipment`, another
chapter's filename, or the literal `reasoning`. Quotes go in `quote_or_excerpt` only, under about
12 words. `argument` and `evidence[].claim` are wall-linted against this statement and the source:
do not quote 10 or more consecutive words there.
