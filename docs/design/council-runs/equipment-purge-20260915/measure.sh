#!/usr/bin/env bash
# Round-2 destination-plan measurement. Run from the sources dir.
set -u
P='\b(Finesse|Versatile|Reach|Thrown|Light|Loading|Two-Handed)\b'
W='\b(Battleaxe|Shortsword|Longsword|Dagger|dagger|daggers|Spear|Shortbow|Longbow|Crossbow|Greatsword|Handaxe|Greataxe|Mace|Warhammer|Maul|Halberd|Throwing Dagger|throwing daggers)\b'
C='\b(Shortsword|Shortbow|Spear|Dagger|Longsword|Longbow|Greataxe|Greatsword|Battleaxe|Handaxe|Mace|Warhammer|Maul|Halberd|Crossbow|Shield)\b'

echo "[1] 15-equipment property bullet definitions:  $(grep -A9 '^\*Properties:\*' 15-equipment | grep -c '^- \*')"
echo "[2] 21-glossary property headword definitions: $(grep -cE 'weapon propert' 21-glossary)"
echo "[3] 15-equipment property tokens in weapon table: $(grep -A20 'table.header(\[Weapon\]' 15-equipment | grep -oE "$P" | wc -l)"
echo "[4] 15-equipment weapon rows carrying a property: $(grep -A20 'table.header(\[Weapon\]' 15-equipment | grep -cE '^ +\[[A-Za-z ]+\],[^]]*\], \[[A-Z]')"
echo "[5] 15-equipment weapon table rows total: $(grep -A20 'table.header(\[Weapon\]' 15-equipment | grep -cE '^ +\[[A-Za-z ]+\], \[')"
echo "[6] 22-reference-sheets property tokens in weapon table: $(grep -A25 'table.header(\[Weapon\]' 22-reference-sheets | grep -oE "$P" | wc -l)"
echo "[7] 22-reference-sheets rows carrying a property: $(grep -A25 'table.header(\[Weapon\]' 22-reference-sheets | grep -cE '^ +\[[A-Za-z ]+\], \[[^]]+\], \[[A-Z]')"
echo "[8] 15-equipment prose site naming the Finesse property: $(grep -nE '\bFinesse\b' 15-equipment | grep -vcE '^- \*|\[[A-Z]') lines (see :200)"
echo "[9] 08-disciplines prose sites naming the Finesse property: $(grep -cE '\bFinesse\b' 08-disciplines)"
echo "[10] 05-classes Starting Kit lines: $(grep -c 'Starting Kit' 05-classes)"
echo "[11] 05-classes weapon tokens on those lines: $(grep -h 'Starting Kit' 05-classes | grep -oE "$W" | wc -l)"
echo "[12] 05-classes weapon+shield tokens on those lines: $(grep -h 'Starting Kit' 05-classes | grep -oE "$W|\b[Ss]hield\b" | wc -l)"
echo "[13] 05-classes named ARMOR tokens on those lines: $(grep -h 'Starting Kit' 05-classes | grep -oE "\b(leather armor|chain mail)\b" | wc -l)"
echo "[14] 02-character-creation Equipment lines: $(grep -cE '^\*Equipment:\*|^\*Step 8, Equipment:\*' 02-character-creation)"
echo "[15] 02-character-creation weapon tokens on those lines: $(grep -hE '^\*Equipment:\*|^\*Step 8, Equipment:\*' 02-character-creation | grep -oE "$W" | wc -l)"
echo "[16] 02-character-creation weapon+shield tokens on those lines: $(grep -hE '^\*Equipment:\*|^\*Step 8, Equipment:\*' 02-character-creation | grep -oE "$W|\b[Ss]hield\b" | wc -l)"
echo "[17] 20-bestiary attack lines named for a catalog weapon: $(grep -cE '^\*[A-Za-z ]+:\*.*' 20-bestiary >/dev/null; grep -cE '^\*(Shortsword|Shortbow|Spear|Dagger|Longsword|Longbow|Greataxe|Greatsword|Battleaxe|Handaxe|Mace|Warhammer|Maul|Halberd|Crossbow)[^*]*:\*' 20-bestiary)"
echo "[18] 20-bestiary Multiattack lines naming a catalog weapon: $(grep -cE '^\*Multiattack:\*.*(Shortsword|Shortbow|Spear|Dagger|Longsword|Longbow|Greataxe|Greatsword|Battleaxe|Handaxe|Mace|Warhammer|Maul|Halberd|Crossbow)' 20-bestiary)"
echo "[19] 20-bestiary lines naming a catalog weapon/shield (any position): $(grep -cE "$C" 20-bestiary)"
echo "[20] 17-magic-items Type fields typed on a catalog weapon/shield: $(grep -cE '^\*Rarity:\*.*\*Type:\* (Longsword|Warhammer|Dagger|Longbow|Shortsword|Greatsword|Shortbow|Spear|Greataxe|Battleaxe|Handaxe|Mace|Maul|Halberd|Crossbow|Shield)\b' 17-magic-items)"
echo "[21] 17-magic-items body lines naming the dagger (Shadow Thorn): $(grep -cE '\bdagger\b' 17-magic-items)"
echo "[22] 21-glossary named-item headword lines: $(grep -cE "$C|Buckler|Padded|Studded Leather|Chain Shirt|Breastplate|Half Plate|Chain Mail|Plate" 21-glossary)"
echo "[23] 22-reference-sheets weapon+shield named-item lines: $(grep -cE "$C" 22-reference-sheets)"
echo "[24] 22-reference-sheets armor-table rows (named armor): $(grep -cE '^  \[(Padded|Leather|Studded Leather|Chain Shirt|Breastplate|Half Plate|Chain Mail|Plate)\],' 22-reference-sheets)"
echo "[25] 15-equipment armor-table rows (named armor): $(grep -cE '^    \[\*(Padded|Leather|Studded Leather|Chain Shirt|Breastplate|Half Plate|Chain Mail|Plate)\*\],' 15-equipment)"
echo "[26] 16-armor-shields armor-table rows (named armor): $(grep -cE '^  \[(Padded|Leather|Studded Leather|Chain Shirt|Breastplate|Half Plate|Chain Mail|Plate)\],' 16-armor-shields)"
echo "[27] 16-armor-shields named shields stated in prose: $(grep -cE '^\*(Buckler|Shield|Tower Shield):\*' 16-armor-shields)"
echo "--- property token census (case-sensitive) ---"
for f in 02-character-creation 05-classes 08-disciplines 15-equipment 16-armor-shields 17-magic-items 20-bestiary 21-glossary 22-reference-sheets; do printf "%-22s %s\n" "$f" "$(grep -oE "$P" "$f" | wc -l)"; done
echo "--- trap census: same tokens that are NOT the weapon property ---"
echo "[T1] 02-character-creation Versatile tokens (all Human ancestry trait): $(grep -cE '\bVersatile\b' 02-character-creation)"
echo "[T2] 16-armor-shields Light tokens (all armor weight class): $(grep -cE '\bLight\b' 16-armor-shields)"
echo "[T3] 20-bestiary Reach tokens (all monster attack range): $(grep -cE '\bReach\b' 20-bestiary)"
echo "[T4] 15-equipment Light tokens that are the armor weight class: $(grep -cE '\bLight\b' 15-equipment | tr -d ' ') of $(grep -oE '\bLight\b' 15-equipment | wc -l); armor-class lines = $(grep -nE '\bLight (armour|armor)|\[Light\]' 15-equipment | wc -l)"
echo "[T5] 17-magic-items lowercase reach tokens (verb, not the property): $(grep -ciE '\breach\b' 17-magic-items)"
