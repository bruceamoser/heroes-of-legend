# Market foundations and starting-budget checks

**Issue #1166 — proposal, not a finalized economy.** The [market](../market.md)
prices 43 equipment entries and 14 services. It supplies a practical price scale,
not simulated trade balances or automatic availability. All new equipment has
narrative and a separate rules statement. Existing equipment effects are preserved;
prices are added to the individual item files.

## References actually consulted

- [D&D 2024 equipment](https://www.dndbeyond.com/sources/dnd/br-2024/equipment):
  equipment categories, starter packs, services and resale. Its separation of
  routine necessities from costly specialist equipment is useful. Its weapon
  price/damage hierarchy is unsuitable for HOL’s flavor-based ordinary weapons.
  Half-price mundane resale is adopted as a proposal; its denominations, weight
  system and spellcasting prices are not imported.
- [Pathfinder Player Core adventurer’s pack, p. 287](https://2e.aonprd.com/Equipment.aspx?ID=2700):
  a ready-made list helps a player provision quickly. HOL copies neither its price
  nor its combined Bulk: our baskets add every item’s cost and Bulk explicitly.
- Local library, **Nimble 2.0.3, Adventuring Equipment**, sections “Equipment
  Availability” and “Misc. Adventuring Equipment”; also **Equipment Rules**,
  “Swapping Equipment” and “Customizing Weapons.” Its compact ordinary list,
  settlement-sensitive availability and distinctly dearer healing informed the
  scale. Its free swapping and weapon-damage rules are not used.

Local files read from:
`/mnt/disk5/RPG-Library/Books/01-DnD-and-d20/Nimble — Arrivals/Nimble-2.0.3/Nimble-2.0.3/Nimble Markdown/Nimble Vault non-Obsidian/Items/Adventuring Equipment.md`
and the same vault’s `System/Rules/Equipment Rules.md`.
The library Markdown is the consulted source; no PDF pagination was inferred.

No source currency is converted at a fixed exchange rate. HOL prices are original
proposals constrained by its action economy, item grants and inventory dice.

## Why potions cannot simply copy another game’s price

With independent checks after use, the expected time to roll 1 on a dN is N uses.
Thus a d4 lasts 4 uses on average; a d6 descending through d4 lasts 6+4=10; a d8
lasts 8+6+4=18. None is guaranteed. A lesser d4 bottle priced at 20 averages 5 coins
per 6-HP use, before missing-HP waste or resistance. The 50/120-coin stronger
bottles cost more than proportional HP: restoration per Maneuver is valuable.
This is a chosen premium to test, not a proven optimal price.

## Six actual shopping baskets

Card grants from the six level-1 sheets are already owned. They are never bought
again in these totals. No starting coins have been assigned to those sheets.
These baskets are optional tests of 50/60/70, not changes to their inventories.

| Character | New purchases | Coins | Final Bulk / capacity | Coins left at 50 / 60 / 70 |
|---|---|---:|---:|---|
| Borin | Road essentials, rope, small necessities, lesser bottle | 51 | 11 / 13 | −1 / 9 / 19 |
| Lira | Road essentials, lesser bottle; already owns rope | 44 | 10 / 10 | 6 / 16 / 26 |
| Pip | Road essentials, small necessities, lesser bottle; already owns rope | 46 | 10 / 10 | 4 / 14 / 24 |
| Vaelis | Road essentials, rope, lesser bottle | 49 | 7 / 7 | 1 / 11 / 21 |
| Mara | Road essentials without lighting, rope, small necessities, lesser bottle | 46 | 7 / 10 | 4 / 14 / 24 |
| Oren | Road essentials, lesser bottle, ordinary material bundle | 56 | 9 / 10 | −6 / 4 / 14 |

Mara chooses her purchased Lantern in the Palm instead of mundane lighting. Her
spell is visible to enemies and does not defeat magical darkness. Oren must specify
his materials; the example buys wood/fiber for an appropriate known recipe, not
healing salts. Borin must free a hand to drink, and Lira cannot drink while using
her bow. The potion’s price never waives those action/hand costs.

At 50, Borin can omit the small-necessities bundle and Oren can postpone materials.
At 60, all six baskets fit with reserves of 4–16 coins. At 70 there is room for an
extra tool or savings, but Bulk still prevents indiscriminate packing. This supports
**50–70 as a first starting range**, with 60 a useful neutral comparison point.
It does not establish the five individual starting-coin contributions.

## Economy stress checks and unresolved limits

**Grant resale:** medium armor 40 sells for 20; heavy armor 90 sells for 45. A
training card can therefore produce coins once. Selling cannot renew the grant,
but purchasing multiple different training cards can still monetize development.
No claim that finite grants remove that incentive. Review these values before
setting class wealth offsets or offering every training card in a market campaign.

**Crafting:** one d6 healing-material supply averages ten attempts. The lesser
recipe caps each finished bottle at d4, so ten successful attempts can make ten
bottles: 200 retail, at most 100 at proposed half-price resale, against 80 material
cost, plus tools and roughly ten hours. This is a rough expectation, not a promise
that a merchant buys ten bottles. Ordinary and foraged materials can be cheaper;
full crafting profitability depends on yields, time and actual demand. No numeric
foraging yield or infinite shop demand is invented here.

**Repeated free healing:** after safe combat recovery, spell healing and lodging
cannot be priced as equivalent to scarce combat potions. This draft therefore
quotes treatment attempts, not an expensive generic HP refill service. Grit and
scar attrition remain distinct from coins.

**Special items:** 100–500 benchmarks are intentionally outside a normal starter
budget. Prices do not prove that permanent stat bonuses, resistance or damage
riders are balanced. No universal magic-item shop or automatic crafting recipe is
created. Further special-item work needs its own review.

**Baseline kit policy:** one plain worn outfit is proposed free. A pack is explicitly
Bulk 1, as are its contents; it grants no extra capacity. Water uses person-days,
not a new thirst/exhaustion subsystem. Both conventions are visible proposals,
not retrospective changes to the approved six-character sheets.

## Validation

Item prices are positive whole coins. All 43 linked item prices match the market
tables. The four standard baskets and six character baskets were recalculated,
including containers and card-granted Bulk. Catalog/link checks and whitespace
checks pass. No new combat simulation or revenue simulation was run.
