# Problem: Council review of Chapter 11, Arcane Spells (quarto-book/chapters/11-arcane-spells.qmd)

You are the hol-rulebook council. Audit this chapter as a publishable unit of the Heroes of Legend
TTRPG rulebook and produce a disposition plan. Do NOT fix anything; file findings only.

## Scope
The registered source `11-arcane-spells` (the chapter's .qmd). This chapter is the source of record
for every arcane spell in the game: 10 cantrips (11:31-119) and 30 spells, each a single growing
card carrying a Novice Weak/Standard/Strong block plus Adept and Master lines (11:123-517). It has
40 `===` cards, 2 section headings, no tables and no callout blocks at all, and only two outbound
cross-references (11:19 to the damage budget, 11:21 back to the magic-system chapter).

Other chapters depend on it and mirror it: ch10 (Magic System, the framework chapter that teaches
the spell model and prints Ember Lance and Brimstone Burst in its own table), ch12 (Divine Spells,
the sibling that shares the cantrip rule and the card format), ch19 (GM Guidance, which prints
Brimstone Burst as the worked card-format example), ch20 (Bestiary, which lists NPC spell damage),
ch05 (class abilities keyed to the same budget), ch08 (the budget and ladder), ch13 (conditions,
resistance, combat).

Cross-check against the authoritative chapters only where a claim is canon-determined: disciplines,
the rank ladder, the damage budget and the raise-cost rule ch08; core resolution, tiers, difficulty,
Boon/Bane ch06; magic framework ch10; combat, damage types, resistance and the condition table ch13;
equipment and weapons ch15; armor and DR ch16; class ability tables ch05; advancement and DP ch18;
glossary ch21; the divine mirror ch12.

## Locked conventions the chapter must satisfy (cite the violated convention in every finding)
- **Damage budget is FLAT.** Novice 2/4/6, Adept 6/9/12, Master 9/15/21 on Weak/Standard/Strong.
  No damage dice anywhere in the book; the only sanctioned dice are 3d6 one-roll checks, 4d6 for
  Boon/Bane (keep highest or lowest three) and explicit random-effect tables (d6 criticals).
- **One-roll principle:** the casting roll IS the damage roll. Zero separate damage rolls.
- **Spell card grammar.** A card states `Disciplines`, `Action`, `Range`, `Keywords`, then Weak,
  Standard and Strong, then Adept and Master. The card's TIER equals the number of Discipline ranks
  it requires: Novice 1 rank, Adept EXACTLY 2 ranks, Master EXACTLY 3 ranks (3 different, 2+1, or
  3 same); no single Discipline may exceed rank 3. Costs are the flat 2/4/8 DP with the Level 3 and
  Level 7 gates. An Adept line must be a strict superset of the card's Novice effects and a Master
  line a strict superset of the Adept line: a higher tier may add, never subtract or replace.
- **ZERO flat +N damage riders (book-wide law, weapons rework 2026-08-19).** No card may add a flat
  damage number. The ONLY sanctioned damage booster is the tier bump, always phrased "+1 damage
  tier" (the Overchannel convention). A card whose base hit also deals damage cannot stack a
  recurring damage rider on an off-table sum: base hit plus rider must land on a budget row, or the
  rider must gate on the WEAK result so base plus rider equals a row (a Novice Weak 2 plus a 2 rider
  = 4 is on the row; the same rider gated on Strong is not). Recurring damage over a stated duration
  must total a row (per-round x rounds), and everything a card prints about one effect must sum to
  its row.
- **Compliant patterns NOT to re-flag.** Multi-projectile or multi-layer cards divide the row
  (Magic Missile three darts at 2 each; a wall's layers); per-target damage equals the row for an
  area chain (Chain Lightning); per-round damage equals the row for a persistent zone (Blizzard);
  and an on-row conditional rider (a Fireball's 9 plus 3 at the centre = 12) is fine.
- **ZERO numeric roll modifiers (Boon/Bane law).** A situational bonus or penalty to a ROLL is Boon
  or Bane, never +N or -N. Numbers are for damage, HP, DR, DP, ranges and durations, plus three
  named exceptions: attributes and skill tiers (Novice +1, Adept +2, Master +3), the DA's difficulty
  dial, and a Challenge penalty. Boons and Banes cancel one for one; the potence ladder is
  Boon/Bane 1 = 4d6 keep three, 2 = 5d6, 3 = 6d6, capped at three.
- **Leveled condition vocabulary.** Conditions use the leveled form the ch13 condition table defines
  (Burning 3, Frozen 2, Slowed 5, Asleep 2, Dazed 1) or the binary name exactly (Prone, Frightened,
  Restrained, Blinded, Hidden). Bespoke paraphrases ("take 2 ongoing fire damage", "is Slowed for
  1 round" with no level, "frozen in place") are defects. `Keywords:` lines stay plain tags; the
  card TEXT carries the level. "Slowed 5 for 1 round" IS compliant.
- **Damage types and resistance.** Damage is typed, and resistance or vulnerability halves or
  doubles it (ch13). A card that prints a resistance interaction must match that math.
- **Cross-references:** every `@sec-*` / `@tbl-*` link must resolve to a real label, and no typed
  period or comma may follow a cross-reference (the engine renders its own trailing stop, so
  `@sec-x,` prints a doubled stop and `@sec-x, then` prints "Chapter 10., then").
- **Zero em-dashes in book text (style law, book-wide).**
- **Typst conventions:** exactly one `{=typst}` fence per file with the `# H1` line above it;
  callout bodies in the NAMED `body: [...]` form; every `#table(` carrying `outlined: false`;
  `#label("sec-...")` on the line after its heading.
- **Phantom cards.** Any card this chapter names must exist under that name wherever it is
  referenced, and any card it references must exist in the book. A name colliding with a different
  card in another chapter is a defect. Cross-chapter mirrors of a card this chapter owns must print
  the same numbers (ch10's table, ch19's worked example, ch20's list).

## Findings format (one finding per member this round)
Each finding must be decision-oriented: name the broken value with [11-arcane-spells:LINE], the
expected or correct value, the violated convention, and the minimal fix. Cite the cross-chapter canon
line where the expected value is canon-determined. Recompute every number you check: a card's damage
line, its tier, its Discipline count, its cost and its superset chain must all agree with each other
and with the chapters that mirror them. A finding that cannot state the broken value and the expected
value is not a finding. Do NOT invent defects to look thorough; a chapter with few real problems is
a good outcome.
