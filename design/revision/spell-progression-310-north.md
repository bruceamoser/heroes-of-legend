# Seven-step spellbook review: Elements, Life, Mentalism and Divination

Source delivery: book #1332; decisions and downstream Workshop work: [Foundry #310](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/310). Bruce approved the martial construction and clarified that each 4/4/5-DP advanced purchase teaches one spell. This is a content-and-progression revision, not a claim of completed combat balance testing.

Each book retains eleven spell blocks. Sections I–IV teach the existing pairs of spells; V, VI and VII teach A1, A2 and A3 individually. Gates are 1/1/1/3/3/3/7, costs 1/2/2/3/4/4/5. The first eight spells in these sixteen books are unchanged. All spell identities remain stable except the four explicit A3 replacements below, which retain the incoming spell's authored identity instead of reusing an unrelated outgoing ID.

## Advanced paths

| Book | V · 4 DP, level 3 | VI · 4 DP, level 3 | VII · 5 DP, level 7 | Content review |
|---|---|---|---|---|
| Air | Chain Lightning | Control Weather | Storm of Vengeance | Selective burst, extensive weather utility, then a three-round battlefield storm whose repeated strikes each cost a Main Action. |
| Flame | Fire Storm | Delayed Blast Fireball | Meteor Swarm | Shaped immediate attack, prepared/delayed attack, then three distinct impact areas with one damage event per creature. |
| Water | Cone of Cold | Freezing Sphere | Tsunami | Cone and ranged burst lead to a wave with damage, pushing and a Strong-result knockdown. Mastery is 6 SP, 5/8/11 damage and Push 2/3/4, with Agility defense stated. |
| Earth | Move Earth | Flesh to Stone | Earthquake | Excavation and gradual petrification lead to broad ground disruption and structural progress. Mastery is 6 SP, 5/8/11 damage and 3/5/7 collapse progress; falling and subsequent hazards retain their own rules. |
| Restoration | Heal | Regenerate | True Resurrection | Substantial immediate healing, physical restoration, then one person's return to life. Group healing remains in the book's earlier spells. |
| Transformation | Animal Shapes | Shapechange | True Polymorph — Living | Group forms and adaptable personal form lead to a 24-hour voluntary transformation. Mastery is 6 SP, includes Large forms, and uses normal Speed for its one movement adaptation. It retains the recipient's HP, attributes and mind. |
| Growth | Awaken | Wall of Thorns | Transport via Plants | Independent awakened life and controlled terrain lead to long-distance company travel. Wall of Thorns incorporates named safe passage; mastery is 6 SP and reaches a personally touched living tree within 100 km, respecting teleportation barriers. |
| Decay | Harm | Finger of Death | Circle of Death | Single-target withering leads to an indiscriminate area attack. Mastery is 6 SP, 5/8/11 life damage and Poisoned 1, using ordinary damage and dying rules. |
| Thought | Mind Scan | Mind Probe | Thought Steal | Consensual inquiry and intrusive immediate reading lead to a day of borrowed remembered experience. Mastery uses a one-hour ritual, 6 SP, one agreed topic, one language and 1 Boon on Knowledge rolls drawing on that experience. It preserves actual errors/gaps and grants no learned abilities or SP. |
| Emotion | Mass Suggestion | Dominate Person | Antipathy/Sympathy | Group persuasion and a bounded command lead to a lasting emotional site. Mastery is 6 SP, a 6-square radius and 24 hours. Dread is 2/3/4 and ends on leaving; welcome aids attainable agreements. One working remains active. |
| Perception | Mislead | Seeming | Programmed Illusion | A directed double and group disguises lead to a reusable prepared illusion. Mastery uses a one-hour ritual, 6 SP, a 6-by-6-square scene, five-minute recorded performance and seven-day duration; it waits ten minutes between triggers. Interaction and examination still reveal it. One working remains active. |
| Dreams | Lord Dream | Weird | Astral Projection | A shared plan and group waking terrors lead to spirit exploration. Lord Dream incorporates one truthful plan warning without inheriting Oracle's Dream's reroll. Mastery is 6 SP, eight hours and 10 km, limited to observation/speech and subject to spirit-travel barriers. |
| Detection | Detect Magic — Scaling Analysis | Find the Path | Sight True | Magical analysis and route guidance lead to prolonged revealing sight. Mastery is 6 SP and one hour, includes outlines of magic through limited ordinary cover, and respects explicit divination wards and physical attack paths. |
| Farseeing | Watch True | Long Sense | Long Sense True | An observation network and distant place-view lead to a company sensory link. Mastery is 6 SP, eight hours and up to three consenting companions on the same plane. Each observation costs a Main Action and occupies the observer's own sight/hearing. |
| Echoes | Legend Lore | Past Truth | Vision Behind — Ages | Historical account, direct scene and a thousand-year inquiry form a complete utility progression. Existing costs, limits and effects are retained. |
| Portents | Foresight | Anticipations True | Foresight — Shared Vigil | Personal preparation and immediate reroll lead to group warning and a shared once-per-round defense reroll. Ordinary initiative applies when the warning precedes an ambush. |

The V/VI entries otherwise retain their original mechanics. High-level utility receives scope, duration or a stronger mode of information rather than an unrelated combat package. The increased SP figures above are printed casting costs, separate from the approved DP costs.

## Explicit identity replacements

| Outgoing spell identity | Outgoing spell | Incoming identity at A3 / VII | Incoming spell |
|---|---|---|---|
| `spell:air:a3` | Wind Walk | `spell-mastery:storm-of-vengeance` | Storm of Vengeance |
| `spell:flame:a3` | Incendiary Cloud | `spell-mastery:meteor-swarm` | Meteor Swarm |
| `spell:restoration:a3` | Mass Heal | `spell-mastery:true-resurrection` | True Resurrection |
| `spell:portents:a3` | Spell Anticipation True | `spell-mastery:foresight-shared-vigil` | Foresight — Shared Vigil |

The four outgoing spells are retired from the current catalog, not renamed or silently converted. Wind Walk's group mist travel, Incendiary Cloud's moving hazard, Mass Heal's divided group healing, and Spell Anticipation True's group spell-defense Reaction are not claimed to survive unchanged. Their histories remain in Git. Existing purchases and favorites require the root migration's explicit relearning treatment rather than automatic substitution.

## Former independent mastery folios

| Former folio identity | Disposition |
|---|---|
| `spell-mastery:stormsteel-arc` | Retired as a separate weapon-dependent spell. Chain Lightning supplies a chosen multitarget lightning attack, but its Knowledge roll is not represented as the same Brawn-based weapon technique. |
| `spell-mastery:storm-of-vengeance` | Retained unchanged in identity as Air VII. Wording states normal Stability/collision handling for its existing push. |
| `spell-mastery:starfall-volley` | Retired as a separate weapon/ammunition-dependent fire technique. Fire Storm and Meteor Swarm preserve powerful fire attacks, not its exact Agility weapon attack or Burning rider. |
| `spell-mastery:meteor-swarm` | Retained unchanged in identity and principal mechanics as Flame VII. |
| `spell-mastery:borrowed-dawn` | Consolidated by retaining Heal V: both provided 8/12/16 healing and bleeding relief. Heal keeps its own Reason, 5 SP, range and additional poison treatment. No automatic ID conversion. |
| `spell-mastery:dawn-on-the-battlefield` | Retired. Mass Cure Wounds IV remains the group-healing spell, but does not inherit the stronger six-target healing or fear reduction. |
| `spell-mastery:true-resurrection` | Retained unchanged in identity as Restoration VII, with the one-lifetime-return limit shared with Lifegiving. |
| `spell-mastery:mass-lifegiving` | Retired. Resurrection is a single-person mastery; this folio's multi-person return is not hidden as an alternate mode. |
| `spell-mastery:wall-of-thorns-living-fortress` | Named safe passage and cover incorporated into Wall of Thorns VI. It keeps the existing rolled crossing damage, 8-HP sections and one-minute duration instead of adding a second blocking/cutting procedure. |
| `spell-mastery:foresight-oracles-dream` | One truthful plan warning incorporated into Lord Dream V. The earlier spell's one-use Boon remains; the independent full-roll reroll and separate spirit invitation are retired. |
| `spell-mastery:foresight-shared-vigil` | Retained unchanged in identity and principal mechanics as Portents VII. |

## Validation

A focused source check confirms all sixteen books have eleven matching table/block entries, section grants 2/2/2/2/1/1/1, unique identities, complete casting fields, and the expected four incoming mastery IDs. Each book's first eight spell blocks compares byte-for-byte with the pre-rewrite source. Source-level checks establish consistency; the root delivery runs whole-catalog audits, both PDF builds/visual review and Workshop progression/import tests.
