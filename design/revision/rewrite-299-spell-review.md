# Spell review implementation — #299 / #303

Reviewed all 319 existing spells individually for action, target, duration, control, SP and remedies. All existing spell IDs and eleven-entry books are preserved; section prices and level gates remain I/II/III/IV at 1/2/2/3 DP with IV at level 3. New mastery spells have their own folios. Fixed terrain, lasting enchantments and directed images are distinct from active personal holds. No routine concentration saves or NPC escape rolls are added.

Moonbeam is not an existing catalog spell. Its approved fixed-duration, one-instance, Maneuver-direction pattern is implemented in Incendiary Cloud rather than inserting an unreviewed twelfth entry or replacing an existing spell. Wall of Fire and Spike Growth retain visible-zone/forced-movement value.

| Spell ID | Name | Decision |
|---|---|---|
| `spell:air:1` | Elementalism — Air | Retained: Instant; action, target, resource and remedy checked |
| `spell:air:2` | Feather Fall | Retained: Until it lands, up to 1 minute; action, target, resource and remedy checked |
| `spell:air:3` | Fog Cloud | Fixed duration; no Sustain charge |
| `spell:air:4` | Gust of Wind | Explicit Brawn player defense |
| `spell:air:5` | Levitate | Sustain retained for active personal control/suppression |
| `spell:air:6` | Lightning Bolt | Explicit Agility player defense |
| `spell:air:7` | Fly | Fixed duration; no Sustain charge |
| `spell:air:8` | Wind Wall | Fixed duration; no Sustain charge |
| `spell:air:a1` | Chain Lightning | Explicit Agility player defense |
| `spell:air:a2` | Control Weather | Retained: 8 hours; action, target, resource and remedy checked |
| `spell:air:a3` | Wind Walk | Retained: 8 hours; action, target, resource and remedy checked |
| `spell:animation:1` | Prestidigitation | Retained: 1 minute; action, target, resource and remedy checked |
| `spell:animation:2` | Unseen Servant — Workshop | Retained: 10 minutes, with commands; action, target, resource and remedy checked |
| `spell:animation:3` | Enchanted Rope — Rigging | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:animation:4` | Dancing Weapon | Retained: 1 minute, with commands; action, target, resource and remedy checked |
| `spell:animation:5` | Animate Objects | Retained: 1 minute, with commands; action, target, resource and remedy checked |
| `spell:animation:6` | Low Intelligence | Retained: 7 days; action, target, resource and remedy checked |
| `spell:animation:7` | Medium Intelligence | Retained: 7 days; action, target, resource and remedy checked |
| `spell:animation:8` | High Intelligence | Retained: 7 days; action, target, resource and remedy checked |
| `spell:animation:a1` | Very High Intelligence | Retained: 7 days; action, target, resource and remedy checked |
| `spell:animation:a2` | Simulacrum | Retained: 24 hours, with commands; action, target, resource and remedy checked |
| `spell:animation:a3` | Animate Objects — Greater | Retained: 1 minute, with commands; action, target, resource and remedy checked |
| `spell:binding:1` | Thaumaturgy | Retained: 1 minute; action, target, resource and remedy checked |
| `spell:binding:2` | Command | Explicit Reason player defense |
| `spell:binding:3` | Hold Person | Individual effect/timing revision; Explicit Reason player defense; Main Action escape: player caster Weak / player target Strong |
| `spell:binding:4` | Magic Circle | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:binding:5` | Banishment | Explicit Reason player defense |
| `spell:binding:6` | Planar Binding | Retained: One agreed service, up to 24 hours; action, target, resource and remedy checked |
| `spell:binding:7` | Geas | Retained: 7 days; action, target, resource and remedy checked |
| `spell:binding:8` | Hold Monster | Individual effect/timing revision; Explicit Reason player defense; Main Action escape: player caster Weak / player target Strong |
| `spell:binding:a1` | Dominate Monster | Explicit Reason player defense |
| `spell:binding:a2` | Forcecage | Fixed duration; no Sustain charge; Explicit Reason player defense; Fixed physical cage: attack HP/teleport remedy; not a personal hold |
| `spell:binding:a3` | Imprisonment | Retained: Until released or the crystal is broken; action, target, resource and remedy checked |
| `spell:calling:1` | Familiar | Retained: Until either ends the bond; action, target, resource and remedy checked |
| `spell:calling:2` | Find Familiar | Retained: 10 minutes, with commands; action, target, resource and remedy checked |
| `spell:calling:3` | Unseen Servant | Retained: 10 minutes, with commands; action, target, resource and remedy checked |
| `spell:calling:4` | Summon Animal | Retained: 1 minute, with commands; action, target, resource and remedy checked |
| `spell:calling:5` | Phantom Steed | Retained: 1 hour, with commands; action, target, resource and remedy checked |
| `spell:calling:6` | Conjure Animals | Retained: 1 minute, with commands; action, target, resource and remedy checked |
| `spell:calling:7` | Conjure Elemental | Retained: 1 minute, with commands; action, target, resource and remedy checked |
| `spell:calling:8` | Summon Dragon | Retained: 1 minute, with commands; action, target, resource and remedy checked |
| `spell:calling:a1` | Conjure Celestial | Retained: 1 minute, with commands; action, target, resource and remedy checked |
| `spell:calling:a2` | Planar Ally | Retained: Up to 10 minutes of conversation; action, target, resource and remedy checked |
| `spell:calling:a3` | Gate — Calling | Retained: 1 minute; action, target, resource and remedy checked |
| `spell:channeling:1` | Power Shock | Explicit Agility player defense |
| `spell:channeling:2` | Give Power | Retained: Instant; action, target, resource and remedy checked |
| `spell:channeling:3` | Draw Power | Retained: Instant; action, target, resource and remedy checked |
| `spell:channeling:4` | Siphon Power | Explicit Reason player defense |
| `spell:channeling:5` | Distant Channel | Retained: Instant; action, target, resource and remedy checked |
| `spell:channeling:6` | Channel Spell | Retained: As the transmitted spell; action, target, resource and remedy checked |
| `spell:channeling:7` | Directed Siphon | Explicit Reason player defense |
| `spell:channeling:8` | Greater Channel | Explicit Reason player defense |
| `spell:channeling:a1` | Lord Channels | Retained: As the funded spell; action, target, resource and remedy checked |
| `spell:channeling:a2` | Rechanneling | Retained: Instant; action, target, resource and remedy checked |
| `spell:channeling:a3` | Power Bridge | Explicit Reason player defense |
| `spell:decay:1` | Poison Spray | Explicit Fortitude player defense |
| `spell:decay:2` | Ray of Sickness | Explicit Fortitude player defense |
| `spell:decay:3` | Ray of Enfeeblement | Explicit Fortitude player defense |
| `spell:decay:4` | Protection from Poison | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:decay:5` | Vampiric Touch | Explicit Fortitude player defense |
| `spell:decay:6` | Bestow Curse | Fixed duration; no Sustain charge; Individual effect/timing revision; Explicit Fortitude player defense |
| `spell:decay:7` | Blight | Explicit Fortitude player defense |
| `spell:decay:8` | Contagion | Explicit Fortitude player defense |
| `spell:decay:a1` | Harm | Explicit Fortitude player defense |
| `spell:decay:a2` | Finger of Death | Explicit Fortitude player defense |
| `spell:decay:a3` | Circle of Death | Explicit Fortitude player defense |
| `spell:detection:1` | Detect Magic | Retained: Instant; action, target, resource and remedy checked |
| `spell:detection:2` | Detect Poison and Disease | Retained: Instant; action, target, resource and remedy checked |
| `spell:detection:3` | Detect Evil and Good | Retained: Until your next turn ends; action, target, resource and remedy checked |
| `spell:detection:4` | Find Traps | Retained: Instant; action, target, resource and remedy checked |
| `spell:detection:5` | See Invisibility | Fixed duration; no Sustain charge |
| `spell:detection:6` | Identify | Retained: Instant; action, target, resource and remedy checked |
| `spell:detection:7` | True Seeing | Fixed duration; no Sustain charge |
| `spell:detection:8` | Analysis | Retained: Instant; action, target, resource and remedy checked |
| `spell:detection:a1` | Detect Magic — Scaling Analysis | Retained: Instant; action, target, resource and remedy checked |
| `spell:detection:a2` | Find the Path | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:detection:a3` | Sight True | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:dreams:1` | Dreams | Retained: 1 minute; action, target, resource and remedy checked |
| `spell:dreams:2` | Sleep | Explicit Reason player defense |
| `spell:dreams:3` | Dream Message | Retained: 1 minute; action, target, resource and remedy checked |
| `spell:dreams:4` | Phantasmal Force | Sustained private illusion; explicit Reason defense, Guile hold and Reason Main Action escape; ordinary illusion examination also works |
| `spell:dreams:5` | Hypnotic Pattern | Explicit Reason player defense |
| `spell:dreams:6` | Phantasmal Killer | Explicit Reason player defense |
| `spell:dreams:7` | Dream | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:dreams:8` | Sign of Sleep | Explicit Reason player defense |
| `spell:dreams:a1` | Lord Dream | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:dreams:a2` | Weird | Explicit Reason player defense |
| `spell:dreams:a3` | Astral Projection | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:earth:1` | Enchanted Rope | Retained: 1 minute; action, target, resource and remedy checked |
| `spell:earth:2` | Loosen Earth | Retained: Instant; action, target, resource and remedy checked |
| `spell:earth:3` | Earthwall | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:earth:4` | Cracks Call | Retained: Instant; action, target, resource and remedy checked |
| `spell:earth:5` | Meld into Stone | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:earth:6` | Stone Shape | Retained: Instant; action, target, resource and remedy checked |
| `spell:earth:7` | Stoneskin | Fixed duration; no Sustain charge |
| `spell:earth:8` | Wall of Stone | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:earth:a1` | Move Earth | Retained: Instant; action, target, resource and remedy checked |
| `spell:earth:a2` | Flesh to Stone | Explicit Fortitude player defense |
| `spell:earth:a3` | Earthquake | Explicit Agility player defense |
| `spell:echoes:1` | Origins | Retained: Instant; action, target, resource and remedy checked |
| `spell:echoes:2` | Past Visions | Retained: Instant; action, target, resource and remedy checked |
| `spell:echoes:3` | Power Lore | Retained: Instant; action, target, resource and remedy checked |
| `spell:echoes:4` | Item Vision | Retained: Instant; action, target, resource and remedy checked |
| `spell:echoes:5` | Vision Guide | Retained: Instant; action, target, resource and remedy checked |
| `spell:echoes:6` | Delving | Retained: Instant; action, target, resource and remedy checked |
| `spell:echoes:7` | Vision Location | Retained: Instant; action, target, resource and remedy checked |
| `spell:echoes:8` | Past Store | Retained: Until replayed or 7 days pass; action, target, resource and remedy checked |
| `spell:echoes:a1` | Legend Lore | Retained: Instant; action, target, resource and remedy checked |
| `spell:echoes:a2` | Past Truth | Retained: Instant; action, target, resource and remedy checked |
| `spell:echoes:a3` | Vision Behind — Ages | Retained: Instant; action, target, resource and remedy checked |
| `spell:emotion:1` | Vicious Mockery | Explicit Reason player defense |
| `spell:emotion:2` | Heroism | Retained: 1 minute; action, target, resource and remedy checked |
| `spell:emotion:3` | Charm Person | Explicit Reason player defense |
| `spell:emotion:4` | Calm Emotions | Retained: Instant; action, target, resource and remedy checked |
| `spell:emotion:5` | Suggestion | Explicit Reason player defense |
| `spell:emotion:6` | Fear | Explicit Reason player defense |
| `spell:emotion:7` | Charm Monster | Explicit Reason player defense |
| `spell:emotion:8` | Confusion | Explicit Reason player defense |
| `spell:emotion:a1` | Mass Suggestion | Explicit Reason player defense |
| `spell:emotion:a2` | Dominate Person | Explicit Reason player defense |
| `spell:emotion:a3` | Antipathy/Sympathy | Explicit Reason player defense |
| `spell:farseeing:1` | Nightsight | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:farseeing:2` | Clairvoyance | Fixed duration; no Sustain charge |
| `spell:farseeing:3` | Locate Object | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:farseeing:4` | Locate Creature | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:farseeing:5` | Arcane Eye | Fixed duration; no Sustain charge |
| `spell:farseeing:6` | Scrying | Retained: 1 minute; action, target, resource and remedy checked |
| `spell:farseeing:7` | Long Ear | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:farseeing:8` | Watch II | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:farseeing:a1` | Watch True | Retained: 8 hours; action, target, resource and remedy checked |
| `spell:farseeing:a2` | Long Sense | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:farseeing:a3` | Long Sense True | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:flame:1` | Fire Bolt | Explicit Agility player defense |
| `spell:flame:2` | Boil Liquid | Retained: Instant; action, target, resource and remedy checked |
| `spell:flame:3` | Burning Hands | Explicit Agility player defense |
| `spell:flame:4` | Heat Metal | Individual effect/timing revision; Explicit Fortitude player defense |
| `spell:flame:5` | Scorching Ray | Explicit Agility player defense |
| `spell:flame:6` | Wall of Fire | Fixed duration; no Sustain charge; Explicit Agility player defense; Visible fixed hazard; normal forced-entry damage and once-per-round limit |
| `spell:flame:7` | Fireball | Explicit Agility player defense |
| `spell:flame:8` | Fire Shield | Retained: 1 minute; action, target, resource and remedy checked |
| `spell:flame:a1` | Fire Storm | Explicit Agility player defense |
| `spell:flame:a2` | Delayed Blast Fireball | Explicit Agility player defense |
| `spell:flame:a3` | Incendiary Cloud | Fixed duration; no Sustain charge; Individual effect/timing revision; Explicit Agility player defense |
| `spell:growth:1` | Druidcraft | Retained: Instant; action, target, resource and remedy checked |
| `spell:growth:2` | Entangle | Individual effect/timing revision; Explicit Agility player defense; Main Action escape: player caster Weak / player target Strong |
| `spell:growth:3` | Goodberry | Retained: 24 hours; action, target, resource and remedy checked |
| `spell:growth:4` | Speak with Plants | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:growth:5` | Spike Growth | Fixed duration; no Sustain charge; Explicit Agility player defense; Visible fixed hazard; normal forced-entry damage and once-per-round limit |
| `spell:growth:6` | Plant Growth | Retained: 24 hours; action, target, resource and remedy checked |
| `spell:growth:7` | Tree Skin | Fixed duration; no Sustain charge |
| `spell:growth:8` | Tree Stride | Retained: Instant; action, target, resource and remedy checked |
| `spell:growth:a1` | Awaken | Retained: Permanent; action, target, resource and remedy checked |
| `spell:growth:a2` | Wall of Thorns | Fixed duration; no Sustain charge; Explicit Agility player defense; Visible fixed hazard; normal forced-entry damage and once-per-round limit |
| `spell:growth:a3` | Transport via Plants | Retained: Instant; action, target, resource and remedy checked |
| `spell:imbuement:1` | Light | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:imbuement:2` | Magic Weapon | Fixed duration; no Sustain charge |
| `spell:imbuement:3` | Elemental Weapon | Fixed duration; no Sustain charge |
| `spell:imbuement:4` | Rune Mastery | Retained: 24 hours or until released; action, target, resource and remedy checked |
| `spell:imbuement:5` | Magic Mouth | Retained: 24 hours or until triggered; action, target, resource and remedy checked |
| `spell:imbuement:6` | Continual Flame | Retained: 7 days; action, target, resource and remedy checked |
| `spell:imbuement:7` | Holy Symbol | Retained: 24 hours; action, target, resource and remedy checked |
| `spell:imbuement:8` | Weapon I | Retained: 24 hours; action, target, resource and remedy checked |
| `spell:imbuement:a1` | Contingency | Retained: 24 hours or until triggered; action, target, resource and remedy checked |
| `spell:imbuement:a2` | Armor IV | Retained: 7 days; action, target, resource and remedy checked |
| `spell:imbuement:a3` | General IV | Retained: 7 days; action, target, resource and remedy checked |
| `spell:passage:1` | Landing | Retained: Until you land this turn; action, target, resource and remedy checked |
| `spell:passage:2` | Misty Step | Retained: Instant; action, target, resource and remedy checked |
| `spell:passage:3` | Blink | Retained: 1 minute or three uses; action, target, resource and remedy checked |
| `spell:passage:4` | Dimension Door | Retained: Instant; action, target, resource and remedy checked |
| `spell:passage:5` | Long Door | Retained: Instant; action, target, resource and remedy checked |
| `spell:passage:6` | Teleportation Circle | Retained: Instant; action, target, resource and remedy checked |
| `spell:passage:7` | Passwall | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:passage:8` | Plane Shift | Retained: Instant; action, target, resource and remedy checked |
| `spell:passage:a1` | Teleport | Retained: Instant; action, target, resource and remedy checked |
| `spell:passage:a2` | Gate — Passage | Retained: 1 minute; action, target, resource and remedy checked |
| `spell:passage:a3` | Etherealness — Company | Fixed duration; no Sustain charge |
| `spell:perception:1` | Minor Illusion | Retained: 1 minute; action, target, resource and remedy checked |
| `spell:perception:2` | Silent Image | Fixed duration; no Sustain charge |
| `spell:perception:3` | Disguise Self | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:perception:4` | Mirror Image | Retained: 1 minute or until three attacks resolve against you; action, target, resource and remedy checked |
| `spell:perception:5` | Invisibility | Fixed duration; no Sustain charge |
| `spell:perception:6` | Major Image | Fixed duration; no Sustain charge |
| `spell:perception:7` | Greater Invisibility | Fixed duration; no Sustain charge |
| `spell:perception:8` | Hallucinatory Terrain | Retained: 8 hours; action, target, resource and remedy checked |
| `spell:perception:a1` | Mislead | Fixed duration; no Sustain charge; Individual effect/timing revision |
| `spell:perception:a2` | Seeming | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:perception:a3` | Programmed Illusion | Retained: 24 hours or until triggered; action, target, resource and remedy checked |
| `spell:portents:1` | True Strike | Explicit Brawn against a melee weapon; Agility against a ranged weapon player defense |
| `spell:portents:2` | Guidance | Retained: Until its next roll or your next turn ends; action, target, resource and remedy checked |
| `spell:portents:3` | Augury | Retained: Instant; action, target, resource and remedy checked |
| `spell:portents:4` | Intuitions | Retained: The triggering defense; action, target, resource and remedy checked |
| `spell:portents:5` | Anticipations I | Retained: 1 minute; action, target, resource and remedy checked |
| `spell:portents:6` | Spell Anticipations | Retained: The triggering spell; action, target, resource and remedy checked |
| `spell:portents:7` | Divination | Retained: Instant; action, target, resource and remedy checked |
| `spell:portents:8` | Commune | Retained: Instant; action, target, resource and remedy checked |
| `spell:portents:a1` | Foresight | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:portents:a2` | Anticipations True | Retained: The triggering defense; action, target, resource and remedy checked |
| `spell:portents:a3` | Spell Anticipation True | Retained: The triggering spell; action, target, resource and remedy checked |
| `spell:protection:1` | Sacred Flame | Explicit Agility player defense |
| `spell:protection:2` | Shield | Individual effect/timing revision; 0 SP; held shield coverage and interval |
| `spell:protection:3` | Mage Armor | Individual effect/timing revision |
| `spell:protection:4` | Bladeturn | Retained: The triggering attack; action, target, resource and remedy checked |
| `spell:protection:5` | Protection from Evil and Good | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:protection:6` | Protection from Energy | Fixed duration; no Sustain charge |
| `spell:protection:7` | Death Ward | Retained: 1 hour or until triggered; action, target, resource and remedy checked |
| `spell:protection:8` | Warding Bond | Retained: 1 minute; action, target, resource and remedy checked |
| `spell:protection:a1` | Globe of Invulnerability | Fixed duration; no Sustain charge |
| `spell:protection:a2` | Mind Blank | Retained: 8 hours; action, target, resource and remedy checked |
| `spell:protection:a3` | Prismatic Wall | Fixed duration; no Sustain charge; Explicit Agility player defense; Visible fixed hazard; normal forced-entry damage and once-per-round limit |
| `spell:restoration:1` | Spare the Dying | Retained: Instant; action, target, resource and remedy checked |
| `spell:restoration:2` | Cure Wounds | Retained: Instant; action, target, resource and remedy checked |
| `spell:restoration:3` | Healing Word | Retained: Instant; action, target, resource and remedy checked |
| `spell:restoration:4` | Lesser Restoration | Retained: Instant; action, target, resource and remedy checked |
| `spell:restoration:5` | Prayer of Healing | Retained: Instant; action, target, resource and remedy checked |
| `spell:restoration:6` | Mass Healing Word | Retained: Instant; action, target, resource and remedy checked |
| `spell:restoration:7` | Greater Restoration | Retained: Instant; action, target, resource and remedy checked |
| `spell:restoration:8` | Mass Cure Wounds | Retained: Instant; action, target, resource and remedy checked |
| `spell:restoration:a1` | Heal | Retained: Instant; action, target, resource and remedy checked |
| `spell:restoration:a2` | Regenerate | Retained: Instant; action, target, resource and remedy checked |
| `spell:restoration:a3` | Mass Heal | Retained: Instant; action, target, resource and remedy checked |
| `spell:sanctuary:1` | Resistance | Retained: Until your next turn ends; action, target, resource and remedy checked |
| `spell:sanctuary:2` | Sanctuary | Retained: 1 minute; action, target, resource and remedy checked |
| `spell:sanctuary:3` | Quiet Ways | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:sanctuary:4` | Tiny Hut | Retained: 8 hours; action, target, resource and remedy checked |
| `spell:sanctuary:5` | Private Sanctum | Retained: 8 hours; action, target, resource and remedy checked |
| `spell:sanctuary:6` | Hallow | Retained: 24 hours; action, target, resource and remedy checked |
| `spell:sanctuary:7` | Guards and Wards | Retained: 8 hours; action, target, resource and remedy checked |
| `spell:sanctuary:8` | Antilife Shell | Fixed duration; no Sustain charge |
| `spell:sanctuary:a1` | Forbiddance | Retained: 24 hours; action, target, resource and remedy checked |
| `spell:sanctuary:a2` | Magnificent Mansion | Retained: 8 hours; action, target, resource and remedy checked |
| `spell:sanctuary:a3` | Prismatic Wall — Sanctum | Explicit Agility player defense; Visible fixed hazard; normal forced-entry damage and once-per-round limit |
| `spell:seals:1` | Mage Seal | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:seals:2` | Alarm | Retained: 8 hours; action, target, resource and remedy checked |
| `spell:seals:3` | Arcane Lock | Retained: 8 hours; action, target, resource and remedy checked |
| `spell:seals:4` | Knock | Retained: Instant; action, target, resource and remedy checked |
| `spell:seals:5` | Magic Mouth — Warning | Retained: 24 hours or until triggered; action, target, resource and remedy checked |
| `spell:seals:6` | Glyph of Warding | Explicit Agility player defense |
| `spell:seals:7` | Rune Mastery — Seal | Retained: 8 hours or until triggered; action, target, resource and remedy checked |
| `spell:seals:8` | Secret Chest | Retained: 24 hours; action, target, resource and remedy checked |
| `spell:seals:a1` | Symbol | Explicit Reason player defense |
| `spell:seals:a2` | Sequester | Retained: 7 days; action, target, resource and remedy checked |
| `spell:seals:a3` | Imprisonment — Seal | Retained: Until released or its seal breaks; action, target, resource and remedy checked |
| `spell:shaping:1` | Mending | Retained: Instant; action, target, resource and remedy checked |
| `spell:shaping:2` | Grease | Retained: 1 minute; action, target, resource and remedy checked |
| `spell:shaping:3` | Enlarge/Reduce — Objects | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:shaping:4` | Unlocking Ways | Retained: Instant; action, target, resource and remedy checked |
| `spell:shaping:5` | Heat Metal — Forge | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:shaping:6` | Stone Shape — Craft | Retained: Instant; action, target, resource and remedy checked |
| `spell:shaping:7` | Fabricate | Retained: Instant; action, target, resource and remedy checked |
| `spell:shaping:8` | Earthen Transmutations | Retained: Instant; action, target, resource and remedy checked |
| `spell:shaping:a1` | Passwall — Workshop | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:shaping:a2` | Meld Wall | Retained: Instant; action, target, resource and remedy checked |
| `spell:shaping:a3` | True Polymorph — Objects | Retained: 24 hours; action, target, resource and remedy checked |
| `spell:spirits:1` | Chill Touch | Explicit Fortitude player defense |
| `spell:spirits:2` | Gentle Repose | Retained: 24 hours; action, target, resource and remedy checked |
| `spell:spirits:3` | Speak with Dead | Retained: Up to three questions; action, target, resource and remedy checked |
| `spell:spirits:4` | Spirit Guardians | Fixed duration; no Sustain charge; Individual effect/timing revision; Explicit Reason player defense |
| `spell:spirits:5` | Lifekeeping | Retained: Until the end of your next turn; action, target, resource and remedy checked |
| `spell:spirits:6` | Animate Dead | Retained: 1 minute, with commands; action, target, resource and remedy checked |
| `spell:spirits:7` | Control Undead | Explicit Reason player defense |
| `spell:spirits:8` | Contact Other Plane | Retained: Instant; action, target, resource and remedy checked |
| `spell:spirits:a1` | Etherealness | Fixed duration; no Sustain charge |
| `spell:spirits:a2` | Create Undead | Retained: 1 minute, with commands; action, target, resource and remedy checked |
| `spell:spirits:a3` | Lifegiving | Retained: Instant; action, target, resource and remedy checked |
| `spell:telekinesis:1` | Arcane Bolt | Explicit Agility player defense |
| `spell:telekinesis:2` | Mage Hand | Retained: Until your next turn ends; action, target, resource and remedy checked |
| `spell:telekinesis:3` | Magic Missile | Explicit Agility player defense |
| `spell:telekinesis:4` | Staying | Individual effect/timing revision; Explicit Brawn player defense; Main Action escape: player caster Weak / player target Strong |
| `spell:telekinesis:5` | Levitate — Objects | Sustain retained for active personal control/suppression |
| `spell:telekinesis:6` | Shatter | Explicit Agility player defense |
| `spell:telekinesis:7` | Telekinesis | Explicit Brawn player defense |
| `spell:telekinesis:8` | Resilient Sphere | Fixed duration; no Sustain charge |
| `spell:telekinesis:a1` | Wall of Force | Fixed duration; no Sustain charge |
| `spell:telekinesis:a2` | Disintegrate | Explicit Agility player defense |
| `spell:telekinesis:a3` | Reverse Gravity | Explicit Agility player defense |
| `spell:thought:1` | Message | Retained: Instant; action, target, resource and remedy checked |
| `spell:thought:2` | Comprehend Languages | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:thought:3` | Detect Thoughts | Explicit Reason player defense |
| `spell:thought:4` | Tongues | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:thought:5` | Sending | Retained: Instant; action, target, resource and remedy checked |
| `spell:thought:6` | Telepathic Bond | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:thought:7` | Modify Memory | Retained: 10 minutes of conversation; altered memory lasts until restored; action, target, resource and remedy checked |
| `spell:thought:8` | Inner Thoughts | Explicit Reason player defense |
| `spell:thought:a1` | Mind Scan | Retained: Instant; action, target, resource and remedy checked |
| `spell:thought:a2` | Mind Probe | Explicit Reason player defense |
| `spell:thought:a3` | Thought Steal | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:transformation:1` | Hues | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:transformation:2` | Jump | Retained: Until the end of its next turn; action, target, resource and remedy checked |
| `spell:transformation:3` | Longstrider | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:transformation:4` | Alter Self | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:transformation:5` | Enlarge/Reduce — Living | Fixed duration; no Sustain charge |
| `spell:transformation:6` | Darkvision | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:transformation:7` | Polymorph | Fixed duration; no Sustain charge |
| `spell:transformation:8` | Freedom of Movement | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:transformation:a1` | Animal Shapes | Fixed duration; no Sustain charge |
| `spell:transformation:a2` | Shapechange | Fixed duration; no Sustain charge |
| `spell:transformation:a3` | True Polymorph — Living | Retained: 24 hours; action, target, resource and remedy checked |
| `spell:unraveling:1` | Detect Magic — Threads | Retained: Instant; action, target, resource and remedy checked |
| `spell:unraveling:2` | Counterspell | Retained: Instant; action, target, resource and remedy checked |
| `spell:unraveling:3` | Remove Curse | Retained: Instant; action, target, resource and remedy checked |
| `spell:unraveling:4` | Dispel Magic | Retained: Instant; action, target, resource and remedy checked |
| `spell:unraveling:5` | Cancel Essence | Retained: Instant; action, target, resource and remedy checked |
| `spell:unraveling:6` | Cancel Mentalism | Retained: Instant; action, target, resource and remedy checked |
| `spell:unraveling:7` | Cancel Channeling | Retained: Instant; action, target, resource and remedy checked |
| `spell:unraveling:8` | Dispel True | Retained: Instant; action, target, resource and remedy checked |
| `spell:unraveling:a1` | Antimagic Field | Sustain retained for active personal control/suppression |
| `spell:unraveling:a2` | Cancel True | Retained: Instant; action, target, resource and remedy checked |
| `spell:unraveling:a3` | Unessence | Retained: Instant; action, target, resource and remedy checked |
| `spell:water:1` | Ray of Frost | Retained: Instant; action, target, resource and remedy checked |
| `spell:water:2` | Create or Destroy Water | Retained: Instant; action, target, resource and remedy checked |
| `spell:water:3` | Purify Food and Drink | Retained: Instant; action, target, resource and remedy checked |
| `spell:water:4` | Water Breathing | Retained: 1 hour; action, target, resource and remedy checked |
| `spell:water:5` | Water Walk | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:water:6` | Control Water | Sustain retained for active personal control/suppression |
| `spell:water:7` | Ice Storm | Retained: Instant; hail remains until your next turn ends; action, target, resource and remedy checked |
| `spell:water:8` | Wall of Ice | Retained: 10 minutes; action, target, resource and remedy checked |
| `spell:water:a1` | Cone of Cold | Retained: Instant; action, target, resource and remedy checked |
| `spell:water:a2` | Freezing Sphere | Retained: Instant; frozen water lasts 10 minutes; action, target, resource and remedy checked |
| `spell:water:a3` | Tsunami | Retained: Instant; action, target, resource and remedy checked |

## Former combined magical spells

Twenty concepts now have one spellbook prerequisite, section IV, and a separate 4-DP level-7 mastery purchase. Casting SP is preserved from each source. This price applies only to these individual mastery spells, not existing spellbook sections or the seven-step training curve. Weapon/shield focus permission preserves the mixed martial/magical workings without requiring impossible extra hands. No free spells or revised gates are applied to the original 319 entries.

| Mastery | Book | SP |
|---|---|---:|
| Stormsteel Arc | air | 3 |
| The Invisible Shieldbearer | telekinesis | 2 |
| Borrowed Dawn | restoration | 4 |
| Starfall Volley | flame | 4 |
| Step Between Heartbeats | passage | 4 |
| Sanctuary of Steel | sanctuary | 4 |
| Colossus of the Forge | imbuement | 6 |
| The Road for the Lost | passage | 6 |
| Dawn on the Battlefield | restoration | 6 |
| Meteor Swarm | flame | 6 |
| Wall of Thorns — Living Fortress | growth | 5 |
| True Resurrection | restoration | 8 |
| Simulacrum | animation | 8 |
| Demiplane | passage | 6 |
| Foresight — Shared Vigil | portents | 5 |
| Storm of Vengeance | air | 7 |
| Mass Lifegiving | restoration | 10 |
| Foresight — Oracle’s Dream | dreams | 6 |
| Gate — World Anchor | seals | 10 |
| Guards and Wards — Living Citadel | sanctuary | 10 |

Specific adaptations: Starfall Volley now uses a prior Main Action studying the target instead of an unavailable Recall the Record prerequisite; both large heals explicitly apply Life resistance; both Simulacrum versions share one likeness; Storm of Vengeance persists for three rounds and uses a Main Action for each later strike, rather than conflating attacks with Sustain. Living Fortress cutting damage can reach zero after resistance. World Anchor and Living Citadel keep their explicit multi-day costs and material requirements; those are ritual schedules, not Sustain.

Additional precision: Freedom of Movement reduces loose Grappled 1/2, not physical Grappled 3; Lord Channels delegates only the transmitted spell’s actual maintenance. Directed fixed spells retain their stated action to move or act. Shield no longer adds a second damage reduction on top of its shield-equivalent Boon.

Review distinctions: Command, Dominate Person/Monster and Control Undead resolve a choice or immediate consequence, rather than seizing a creature’s later turns; they keep that player-agency procedure and need no persistent-hold escape field. Sleep and Hypnotic Pattern use their normal temporary-condition remedies. Flesh to Stone is a timed bodily transformation with named restoration remedies, not a maintained personal grip. Forcecage and Resilient Sphere are destructible barriers with their own HP or willing-exit procedures, not physical Grappled 3. These were not converted to the generic hold procedure.
