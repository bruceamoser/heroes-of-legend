# Seven-step spellbooks: Invocation, Force, Wards and Channeling

Source review for book #1332 and [Workshop #310](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/310), November 16, 2026.

Bruce's final construction is seven sequential sections costing **1/2/2/3/4/4/5 DP**, gated at **1/1/1/3/3/3/7**. Sections I–IV teach two spells each; V, VI and VII each teach one. Each book therefore keeps eleven spell blocks. Their advanced spells receive three separate purchases and one continuous tail, instead of independent mastery choices attached to section IV.

This review reads the complete thirteen books and their nine prior independent folios. Spells 1–8 retain their mechanics. Advanced spells preserve their identities where retained, including stable IDs when moved between slots. Replaced slots are explicitly retired below; they must not silently change into a different learned spell in saved characters. The source importer must read each authored ID rather than derive identity from its current page.

## The advanced paths

| Book | V · 4 DP · level 3 | VI · 4 DP · level 3 | VII · 5 DP · level 7 | Review |
|---|---|---|---|---|
| Spirits | Etherealness | Create Undead | Lifegiving | A personal journey through the spirit world, a greater commanded form, then the power to restore a recently departed willing person. Resurrection retains the lifetime limit, costs and spent resources. |
| Calling | Conjure Celestial | Planar Ally | Gate — Calling | Escalates from a defined commanded profile to negotiated service and finally inviting a named willing being across planes without a prepared receiving anchor. The guest retains agency. |
| Binding | Dominate Monster | Forcecage | Imprisonment | Pressure and a breakable combat cage culminate in indefinite stasis of a willing or already restrained subject. No instant removal of an active enemy. |
| Passage | Teleport | Gate — Passage | Demiplane | Long-range travel, an open planar doorway, then a persistent personal refuge. The refuge's doorway returns to its latest entrance and does not become unrestricted travel between stored entrances. |
| Telekinesis | Wall of Force | Disintegrate | Reverse Gravity | A durable force barrier, a concentrated force attack, then area displacement and falling. Reverse Gravity now lifts 2/4/6 squares, with support, accessible climbing surfaces and flight as counterplay; ordinary falling damage applies. |
| Shaping | Passwall — Workshop | Meld Wall | True Polymorph — Objects | Temporary openings and structural masonry culminate in flexible lasting transformation. The mastery now takes 10 minutes and 6 SP, affects Bulk 12 or less, and lasts until dismissed/replaced; only one transformed object exists per caster and ordinary materials remain bounded. |
| Animation | Very High Intelligence | Animate Objects — Greater | Simulacrum | An informed object, a powerful commanded object group, then one lasting likeness. The old Greater Animate Objects ID follows it into VI. The lasting Simulacrum is explicitly inert without commands or an awake nearby controller, rather than disappearing at ordinary sleep; this exception belongs to this one spell. |
| Imbuement | Contingency | Armor IV | Imbue Spell | A stored response and lasting protection culminate in a single enchanted item that releases one known spell between the creator’s safe overnight rests. Its action, bearer’s attribute, normal requirements, shared allowance and SP-recursion exclusions are explicit. |
| Protection | Globe of Invulnerability | Mind Blank | Prismatic Wall | Group spell protection and private mental protection culminate in a substantial visible battlefield barrier. Existing actions, duration, hazard limits and SP remain intact. |
| Unraveling | Antimagic Field | Cancel True | Unessence | Suppression and a stronger interrupt lead to removal of a permanent magical property. Unessence now contributes 6/9/12 progress toward the ordinary target 12; it still consumes an hour, 5 SP and 100 coins per attempt and respects explicit artifact remedies. |
| Sanctuary | Forbiddance | Magnificent Mansion | Mighty Fortress | A sealed site and temporary shelter culminate in a permanent prepared stronghold with separately renewed wards. Materials, scheduled SP, damageable walls, ordinary supplies and one warded citadel limit remain explicit. |
| Seals | Symbol | Sequester | Gate — World Anchor | A triggered mark and protected stasis culminate in a lasting keyed planar connection. The seven-day ritual, daily SP, materials, destructible anchors, opening cost and one-pair limit remain explicit. |
| Channeling | Lord Channels | Rechanneling | Power Bridge | Cooperative payment and redirected transfer culminate in repeated, sustained SP transfer. Every transferred point leaves a real donor reserve; upkeep costs a Maneuver, no additional SP. Unwilling participants retain explicit escapes. |

## Prior independent folios

| Former spell identity | Disposition |
|---|---|
| `spell-mastery:the-invisible-shieldbearer` | Retired. The final familiarity pass keeps Wall of Force in V; it does not rename the bespoke shield-and-rescue effect after Arcane Hand, whose established interposing effect supplies cover rather than this sequence. |
| `spell-mastery:step-between-heartbeats` | Retired. Its teleport-and-weapon-attack sequence is genuinely distinct, not silently represented by Teleport or another retained spell. The revised Passage path prioritizes travel and the permanent refuge; a future spellblade branch may revisit this concept. |
| `spell-mastery:sanctuary-of-steel` | Retired. Its armored group combat shelter is distinct from the retained long-term Sanctuary workings. Do not claim that Mighty Fortress or Globe of Invulnerability grants its reduction/immunities. |
| `spell-mastery:colossus-of-the-forge` | Retired. The final familiarity pass chooses HARP’s established Imbue Spell concept for Imbuement VII, rather than retaining a bespoke battle-transformation hybrid. Its damage and protective shell are not inherited by Imbue Spell. |
| `spell-mastery:the-road-for-the-lost` | Retired. Passage keeps Long Door, Teleportation Circle, Teleport and Gate — Passage for group travel. The old twelve-person selective one-way crossing is not granted by those retained spells unless their own text permits it. |
| `spell-mastery:simulacrum` | Retained as Animation VII, consolidating the two former likeness spells. Explicit commanded activity, one likeness, 0 SP/Grit, no healing/casting/learned abilities and destruction at 0 HP prevent a second character or resource engine. Dormancy gives its lasting duration an actual use. |
| `spell-mastery:demiplane` | Retained as Passage VII, preserving its fixed size, twelve-creature capacity, ordinary necessities and single refuge. |
| `spell-mastery:gate-world-anchor` | Retained as Seals VII. Its keyholder explicitly pays opening SP from their own reserve. |
| `spell-mastery:guards-and-wards-living-citadel` | Retained as Sanctuary VII under the clearer established spell name Mighty Fortress, with ordinary structural durability and separately renewed wards. The stable ID preserves its existing identity; ordinary Guards and Wards still wards rooms in section IV. |

## Replaced spell slots and surviving identities

| Old spell ID | Result |
|---|---|
| `spell:passage:a3` · Etherealness — Company | Retired in favor of Demiplane. Personal Etherealness remains in Spirits; it does not inherit the group target. |
| `spell:telekinesis:a1` · Wall of Force | Retained with its existing identity and effect as section V after the familiarity pass. |
| `spell:animation:a2` · ordinary Simulacrum | Retired in favor of the single level-7 Simulacrum. Its cheaper temporary likeness is not a separate learned spell. |
| `spell:animation:a3` · Animate Objects — Greater | Retained unchanged in effect and stable ID, moved to page A2 / section VI. |
| `spell:imbuement:a3` · General IV | Retired in favor of `spell:imbuement:imbue-spell`, adapted from HARP. The former at-will cantrip item is not silently exchanged for the new daily-spell item. |
| `spell:sanctuary:a3` · Prismatic Wall — Sanctum | Retired in favor of Mighty Fortress. Protection retains its own Prismatic Wall; its targets and duration remain distinct. |
| `spell:seals:a3` · Imprisonment — Seal | Retired in favor of World Anchor. Binding retains Imprisonment in a crystal; its original rules apply rather than the old fixed chamber's terms. |

## Familiar source concepts

Bruce’s later direction requires recognizable established spells, adjusted to HoL rather than invented replacements. The final pass restores Wall of Force and replaces the custom Colossus proposal with **Imbue Spell**. HARP *College of Magics*, second edition, printed pages 94 and 109–110, describes Imbue Spell as creating an item capable of a known spell’s daily release, with a baseline power capacity of 5. HoL uses its own 8-hour ritual, 8 SP, 200-coin preparation, one active item, one release between the creator’s safe overnight rests and current action/reserve procedures; it does not import HARP’s extended crafting equations or scaling menu.

The user’s local *Spell Law* also confirms General IV in Enchanting Ways (PDF page 89), but that spell’s numeric item bonuses do not match the revised HoL direction as well as HARP’s spell-bearing item. The discarded custom shield rescue was checked against the official [Arcane Hand description](https://www.dndbeyond.com/spells/2002-arcane-hand): changing its name alone would not preserve that spell’s familiar interposing behavior.

**Mighty Fortress** is an established 5e spell, confirmed in the official [D&D Beyond conjuration list](https://www.dndbeyond.com/spells/school/conjuration). The retained HoL fortification procedure is an adaptation, not a reproduction of that text. Its earlier Guards and Wards title misleadingly described construction: the official [Guards and Wards](https://www.dndbeyond.com/spells/2618968-guards-and-wards) instead protects an existing site. The new title fixes that mismatch while keeping the existing HoL spell’s stable identity.

## Validation and limits

The scoped structural check verifies thirteen books, 143 unique spell blocks, matching table/block names and SP, the section distribution 2/2/2/2/1/1/1, explicit spell fields and usable reaction triggers/ritual times. The same check confirms original spells 1–8 remain unchanged and surviving identities are unique. Shared importer, endpoint references, migration, both PDF builds and browser tests are integration work tracked in #310. These checks establish coherent authoring and construction, not playtested equivalence between combat, travel and settlement magic.
