# Problem: Council review of Chapter 12, Divine Spells (quarto-book/chapters/12-divine-spells.qmd)

You are the hol-rulebook council. Audit this chapter as a publishable unit of the Heroes of Legend
TTRPG rulebook and produce a disposition plan. Do NOT fix anything; file findings only.

## Scope
The registered source `12-divine-spells` (the chapter's .qmd). This chapter is the source of record
for every divine spell in the game, mirroring the arcane chapter: cantrips plus growing spell cards,
each carrying a Novice Weak/Standard/Strong block plus Adept and Master lines.

Other chapters depend on it and mirror it: ch10 (Magic System, the framework chapter that teaches
the spell model), ch11 (Arcane Spells, the sibling that shares the cantrip rule and the card
format), ch08 (the damage budget and the rank ladder), ch13 (conditions, resistance, combat),
ch05 (class abilities keyed to the same budget), ch19 (GM Guidance), ch21 (the glossary).

Cross-check against the authoritative chapters only where a claim is canon-determined: disciplines,
the rank ladder, the damage budget and the raise-cost rule ch08; core resolution, tiers, difficulty,
Boon/Bane ch06; magic framework ch10; combat, damage types, resistance and the condition table ch13;
equipment and weapons ch15; armor and DR ch16; class ability tables ch05; advancement and DP ch18;
glossary ch21; the arcane mirror ch11.

## Locked conventions the chapter must satisfy (cite the violated convention in every finding)
- **Damage budget is FLAT.** Novice 2/4/6, Adept 6/9/12, Master 9/15/21 on Weak/Standard/Strong.
  No damage dice anywhere in the book; the only sanctioned dice are 3d6 one-roll checks, 4d6 for
  Boon/Bane (keep highest or lowest three) and explicit random-effect tables (d6 criticals).
- **One-roll principle:** the casting roll IS the damage roll. Zero separate damage rolls.
- **Spell card grammar.** A card states `Disciplines`, `Action`, `Range`, `Keywords`, then Weak,
  Standard and Strong, then Adept and Master. The card's TIER equals the number of Discipline ranks
  it requires: Novice 1 rank, Adept EXACTLY 2 ranks, Master EXACTLY 3 ranks (3 different, 2+1, or
  3 same); no single Discipline may exceed rank 3. Costs are the flat 2/4/8 DP with the Level 3 and
  Level 7 gates.
- **The rung escalation law (ruled 2026-09-12).** A higher rung never loses an effect the rung
  below it promised. It must deepen, and deepening takes three sanctioned shapes: **add** (a new
  effect joins the old one), **intensify** (where the condition is scaled, the number climbs:
  Slowed 10 becomes Slowed 20, Poisoned 1 becomes Poisoned 2, Frozen 1 becomes Frozen 2), or
  **tighten** (the condition becomes a stricter one on the same ladder: Prone becomes Restrained,
  and Restrained becomes Stunned). Substituting a STRICTER condition for a milder one is a legal
  tighten, NOT a subtraction. Only a rung that falls BELOW its base's condition is a defect.
- **ZERO flat +N damage riders (book-wide law, weapons rework 2026-08-19).** No card may add a flat
  damage number. The ONLY sanctioned damage booster is the tier bump, always phrased "+1 damage
  tier" (the Overchannel convention).
- **Weapons are flavour; cards carry the damage.** No weapon contributes damage of its own.
- **Condition vocabulary** is the ch13 table. Invent no conditions, and invent no stats.
- **Zero em-dashes in book source text.**
- Card names are unique book-wide; a card that exists nowhere else is a phantom.
