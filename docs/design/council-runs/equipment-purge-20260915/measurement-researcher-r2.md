# Round-2 destination-plan measurement (researcher lens, f-010)

Run from `/home/bmoser/.hermes/councils/hol-rulebook/runs/20260915-1847/sources`.
`P` = `\b(Finesse|Versatile|Reach|Thrown|Light|Loading|Two-Handed)\b`
`W` = `\b(Battleaxe|Shortsword|Longsword|Dagger|dagger|daggers|Spear|Shortbow|Longbow|Crossbow|Greatsword|Handaxe|Greataxe|Mace|Warhammer|Maul|Halberd|Throwing Dagger|throwing daggers)\b`
`C` = `\b(Shortsword|Shortbow|Spear|Dagger|Longsword|Longbow|Greataxe|Greatsword|Battleaxe|Handaxe|Mace|Warhammer|Maul|Halberd|Crossbow|Shield)\b`

## Item 1 — the seven weapon properties

| content | file | sites | mentions | command |
|---|---|---|---|---|
| chapter property definitions | 15-equipment | 7 bullets | 8 | `grep -A9 '^\*Properties:\*' 15-equipment \| grep -c '^- \*'` |
| glossary property definitions (independent wording) | 21-glossary | 7 headwords | 10 | `grep -cE 'weapon propert' 21-glossary` |
| main weapon table, property cells | 15-equipment | 10 of 17 rows | 19 | `grep -A20 'table.header(\[Weapon\]' 15-equipment \| grep -oE "$P" \| wc -l` |
| rows carrying >=1 property | 15-equipment | 10 | — | `grep -A20 'table.header(\[Weapon\]' 15-equipment \| grep -cE '^ +\[[A-Za-z ]+\],[^]]*\], \[[A-Z]'` |
| reprint weapon table, property cells | 22-reference-sheets | 10 rows | 19 | `grep -A25 'table.header(\[Weapon\]' 22-reference-sheets \| grep -oE "$P" \| wc -l` |
| prose rule naming Finesse | 08-disciplines | 2 lines | 2 | `grep -cE '\bFinesse\b' 08-disciplines` |
| prose rule naming Finesse | 15-equipment | 1 line (:200) | 1 | `grep -nE '\bFinesse\b' 15-equipment` |
| gear row invoking thrown | 15-equipment | 1 row (:310) | 1 | `grep -nE '\bThrown\b' 15-equipment` |

**Item 1 total: 38 sites / 60 mentions / 4 files.**

## Item 2 — weapon lists in loadouts

| content | file | lines | weapon tokens | command |
|---|---|---|---|---|
| class starting kits | 05-classes | 9 | 12 (+2 shield, +6 armor) | `grep -c 'Starting Kit' 05-classes` ; `grep -h 'Starting Kit' 05-classes \| grep -oE "$W" \| wc -l` |
| exemplar + step-8 equipment lists | 02-character-creation | 9 | 12 (+2 shield) | `grep -cE '^\*Equipment:\*|^\*Step 8, Equipment:\*' 02-character-creation` ; `grep -hE '^\*Equipment:\*|^\*Step 8, Equipment:\*' 02-character-creation \| grep -oE "$W" \| wc -l` |

**Item 2 total: 18 lines / 24 weapon tokens.**

## Item 3 — named items referenced downstream

| content | file | lines | command |
|---|---|---|---|
| attack lines named for a catalog weapon | 20-bestiary | 15 | `grep -cE '^\*(Shortsword\|Shortbow\|Spear\|Dagger\|Longsword\|Longbow\|Greataxe\|Greatsword\|Battleaxe\|Handaxe\|Mace\|Warhammer\|Maul\|Halberd\|Crossbow)[^*]*:\*' 20-bestiary` |
| Multiattack lines naming a catalog weapon | 20-bestiary | 2 | `grep -cE '^\*Multiattack:\*.*(Shortsword\|...\|Crossbow)' 20-bestiary` |
| any line naming a catalog weapon/shield | 20-bestiary | 18 | `grep -cE "$C" 20-bestiary` |
| item Type fields typed on a catalog weapon/shield | 17-magic-items | 6 | `grep -cE '^\*Rarity:\*.*\*Type:\* (Longsword\|Warhammer\|Dagger\|Longbow\|Shortsword\|Greatsword\|Shortbow\|Spear\|Greataxe\|Battleaxe\|Handaxe\|Mace\|Maul\|Halberd\|Crossbow\|Shield)\b' 17-magic-items` |
| body lines naming the dagger (Shadow Thorn) | 17-magic-items | 6 | `grep -cE '\bdagger\b' 17-magic-items` |
| named-item headword lines | 21-glossary | 10 (6 of them the property headwords) | `grep -cE "$C\|Buckler\|Padded\|Studded Leather\|Chain Shirt\|Breastplate\|Half Plate\|Chain Mail\|Plate" 21-glossary` |
| weapon/shield lines | 22-reference-sheets | 22 | `grep -cE "$C" 22-reference-sheets` |
| armor rows | 22-reference-sheets | 8 | `grep -cE '^  \[(Padded\|Leather\|Studded Leather\|Chain Shirt\|Breastplate\|Half Plate\|Chain Mail\|Plate)\],' 22-reference-sheets` |

Union of distinct lines across all three items: **119**.

## Noise floor — property tokens that are NOT the property

Naive case-sensitive token census of `$P` over the nine sources: **88**.
Non-property: 28 (7 Human-ancestry `Versatile` in 02-character-creation; 6 armor-class `Light` in
16-armor-shields; 5 armor-class `Light` in 15-equipment; 3 monster-attack-range `Reach` + 1
`Light Sensitivity` in 20-bestiary; 2 armor-class `Light` + 1 trait `Versatile` in 21-glossary;
3 armor-class `Light` in 22-reference-sheets).
True property tokens: **60** — a raw grep over-counts by 32%.

## Verdict

- Properties: **larger** than round 1 implied — 38 lines vs the 14-line shape a "seven properties,
  two copies" reading gives (2.7x). The surplus is the two table property columns (38 mentions over
  20 rows in 2 files), which a per-definition budget does not see.
- Class kits: **smaller** — 12 weapon tokens per file, not 43 item entries (31 of the 43 are armor,
  tools, robes, focuses or packs).
- Downstream: **larger** at the margins — bestiary 15 -> 17 (2 Multiattack rules), magic items
  5 -> 6 Type fields plus 6 body lines in Shadow Thorn, glossary 7 property headwords that are also
  named-item lines.
