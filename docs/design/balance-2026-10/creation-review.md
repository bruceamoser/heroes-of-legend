# Character creation and advancement review

The 10 DP at level 0 plus 10 DP at level 1 budget supports a broad starting character in the illustrative ledgers. The greatest pressure comes from prerequisite access, inventory, and the number of choices, rather than an inability to afford enough cards. These are affordability checks using placeholder cards, not certified characters from a finished catalog.

Full purchases, prerequisites, grants, and running balances are in [characters.json](outputs/characters.json). The test catalog and validation are in [creation.py](creation.py). Attribute order is Brawn, Fortitude, Agility, Guile, Knowledge, Reason.

## Ten creation routes

| Concept | Attributes | Distinct Disciplines | Learned cards including signature | Capacity | Illustrative carried bulk | Encumbrance |
|---|---|---:|---:|---:|---:|---:|
| Protector with broad utility | 2 / 2 / 0 / −1 / 0 / 0 | 4 | 13 | 16 | 8 | 0 |
| Fragile Arcanist | −2 / −1 / 2 / 1 / 2 / 1 | 4 | 13 | 4 | 5 | 1 |
| Shepherd healer | 0 / 1 / 1 / −1 / 0 / 2 | 5 | 12 | 10 | 6 | 0 |
| Shadow specialist | 0 / 0 / 2 / 2 / −1 / 0 | 4 | 13 | 10 | 8 | 0 |
| Odd generalist | 1 / 0 / 1 / 0 / 1 / 0 | 5 | 12 | 13 | 6 | 0 |
| Protector buying opposed healing | 2 / 1 / 0 / −1 / 0 / 1 | 5 | 11 | 16 | 7 | 0 |
| Protector with a healing background | 2 / 1 / 0 / −1 / 0 / 1 | 4 | 13 | 16 | 7 | 0 |
| Summoner with utility | −1 / 0 / 1 / 0 / 2 / 1 | 4 | 13 | 7 | 5 | 0 |
| Duplicate-package stress test | 0 / 0 / 0 / 1 / 2 / 0 | 3 | 13 | 10 | 7 | 0 |
| Low-Brawn ranger | −2 / 0 / 2 / 1 / 1 / 1 | 4 | 13 | 4 | 8 | 4 |

Every route also has the 11 universal cards and two selected ancestry traits. Equipment cards are separate physical items. Four supply slots—food, light, rope, potion—are assumed acquisitions for the inventory test, **not an automatic starting package**. None has an approved price or guaranteed starting grant. Creature battle simulations do not import these characters or their placeholder cards.

All ten attribute arrays sum to +3; all stay within −2 to +2. Each purchase meets its fixture prerequisites at the moment of purchase. No level-0 Discipline is bought, no creation DP carries into the next stage, no ability is bought twice, and all stage balances reconcile to zero. Exhaustive enumeration finds 1,246 labeled legal attribute arrays; this is choice-space size, not evidence of 1,246 distinct play styles.

## Worked creation ledgers

### Protector with broad utility

Culture grants Armor 1 and Medium Armor Training; background grants Lore 1 and Forage Forest. Five no-Discipline utility cards spend the level-0 ten DP. The class grants Blades 1, Protection 1, and its signature. Melee Technique, Shield Training, Craft Mundane, Derive Mundane Recipe, and Identify Potions cost two DP each at level 1.

The result has one primary attack, defensive equipment, five general utility specialties, foraging, crafting, derivation, and identification. This is well rounded without extra creation DP. The practical problem is that the crafter still needs a recipe and time to use it; those permissions are not supplied merely by buying the crafting card.

### Protector buying an unfamiliar discipline

The comparison Protector starts with Armor and Blades, then receives Protection and Unarmed from class. At level 1, buying opposed Life 1 costs four DP and Healing Spell costs two. Shield Training and Grapple spend the remaining four. All ten level-1 DP are used for four purchases, including the discipline.

The healing-background route receives Life 1 and the healing card before class costs apply. It reaches 13 learned cards rather than 11 in the comparison, but has a different Discipline set. This is **not a controlled proof of a two-card background imbalance**; it demonstrates how an expensive off-class capability can be selected through a free origin package. Across all rank-1 grants, class cost differences make package value unequal by design.

### Duplicate package

Both origin choices grant Lore 1 and Forage Forest. Their duplicate Discipline and card award two extra DP at level 0; six purchases spend twelve DP. Class grants Lore and Armor; the duplicate Lore awards one level-1 DP. Buying a Home rank-1 Discipline for one DP and five cards for ten uses all eleven.

The character ends with 13 learned cards but only three distinct Disciplines. The duplicate ability does not grant another copy of its equipment. The compensation prevents waste without a free selection from the entire catalog. It does not make the redundant training worth its full class purchase price; that is a deliberate trade-off to explain to players.

### Low-Brawn ranger

Ranged weapon, ammunition, armor, tools, food, light, rope, and a potion occupy eight slots. Brawn −2 gives capacity four. With an **assumed** ancestry Speed of six and Agility +2, Speed becomes four. The character can discard or delegate supplies, but those are real choices before collecting treasure.

Switching Brawn from −2 to −1 raises capacity by three slots. When encumbered, that can recover three squares of Speed; a point of Agility grants only one. This does not mean Brawn is globally better—Agility affects rolls—but carrying capacity creates a sharp movement incentive at the low end. Test the actual starter cards before adjusting the multiplier or adding a floor.

## Advancement pressure

| Level | New DP | Cumulative purchased DP including creation | Maximum Novice cards from that award alone |
|---|---:|---:|---:|
| 1 | 10, following 10 at level 0 | 20 | 5 |
| 2 | 10 | 30 | 5 |
| 3 | 11 | 41 | 5 |
| 4 | 12 | 53 | 6 |
| 5 | 13 | 66 | 6 |
| 6 | 14 | 80 | 7 |
| 7 | 15 | 95 | 7 |
| 8 | 16 | 111 | 8 |
| 9 | 17 | 128 | 8 |
| 10 | 18 | 146 | 9 |

The level-2–10 awards total 126 DP. Once prerequisites are established, the award can buy more than the hoped-for two to four things per level. Buying only Novice cards would add 63 cards over those levels. Buying mostly Master cards gives far fewer purchases. Card breadth and catalog size will decide whether this is liberating or overwhelming; do not reduce awards solely from this upper bound.

Sequential rank prices continue to matter:

| Price category | Rank 1 from nothing plus Novice card | Rank 3 from nothing plus Master card | Rank 3 from an owned rank 1 plus Master card |
|---|---:|---:|---:|
| Home | 3 | 15 | 14 |
| Adjacent, including Odd | 4 | 22 | 20 |
| Foreign | 5 | 29 | 26 |
| Opposed | 6 | 36 | 32 |

A level-7 Home specialist can buy rank 2, rank 3, and one Master card from their new 15 DP if rank 1 was already owned. The equivalent opposed path costs 32 and requires saved DP. That supports class identity without making shared cards exclusive. Shared prerequisites serve many future cards, however, so their marginal cost declines sharply after the initial investment.

These price examples pair a Novice card with a rank-1 requirement and a Master card with a rank-3 requirement. They do not establish a universal correspondence between card tier and Discipline rank; actual cards state their own requirements.

## Problems to address before publishing creation

1. **The revised catalog is the main blocker.** Validity depends on actual origin pairs, class choices, rank requirements, signature options, equipment grants, and ancestry traits. The old catalogs cannot be reused without review.
2. **Starting HP contributions remain unspecified.** We cannot verify the durable dwarf Protector versus frail halfling Arcanist spread from a reference total of 20. Set a few sample contributions before declaring either build balanced.
3. **Starting Speed bases remain unspecified.** Inventory penalties are calculable, but final movement is not. The six-square base in these examples is only a fixture.
4. **Weak Brawn can dominate starter inventory decisions.** Audit every low-capacity origin/class path against the equipment its granted cards place in inventory. Equipment should not silently appear with zero bulk or an exempt backpack.
5. **Creation grants need complete physical-item text.** Ordinary attack cards define relevant weapon properties; the weapon's equipment card is flavor except explicit special additions. Clarify how several compatible attack cards share one weapon without counting it twice, especially if their printed bulk differs.
6. **Training can grant equipment later as well as at creation.** DP-to-equipment-to-coins conversion is finite for one-copy abilities but still possible across many training cards. Set grant scope and DA resale expectations before using equipment value as a balance lever.
7. **Cards that require recipes need a useful entry route.** A starting crafter with no recipe, no applicable item to derive, and no materials has bought deferred potential. Explicitly decide whether a crafting card grants a starter recipe or whether an origin/adventure supplies it. No such grant is assumed here.
8. **Knowledge has accumulated many specialties.** Crafting, foraging, and several likely identification routes compete against Reason/Guile whose catalog coverage is less settled. Audit actual card attributes before calling the six attributes equally attractive.
9. **Character creation involves many selections.** Two traits, two origin pairs, class, two class Disciplines, signature, and up to ten purchases precede equipment choices. Optional suggested shopping lists can shorten entry without restricting choice; they were already allowed in the spec.
10. **The starter hand may contain 24 rule cards before equipment.** Separate an ordinary-turn reference from occasional utility cards in the physical/digital presentation. This is a layout recommendation, not a limit on learned cards.
11. **Stage expiry needs visible accounting.** A step-by-step sheet should show level-0 spend, duplicate compensation, expiry, then level-1 pricing. The scripts caught no negative balance in these ten routes, but a player can otherwise confuse a class grant with permission to buy a Discipline at level 0.

## Recommended creation playtest

Build actual draft cards for three of these routes: Protector, low-Brawn ranger, and healer/crafter. Give a new reader the origin choices, price sheet, and universal reference. Record completion time, questions, unused DP, unusable grants, and equipment they must discard. Do not publish those draft cards as canonical until Bruce reviews the numbers and requirements.
