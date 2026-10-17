# Art and diagram record

The table below records the original editorial ideas. The completed review proof
uses the approved visual library, new creature portraits and five vector diagrams; it does not claim
that every proposed illustration below was commissioned. Each placed asset is used
once in this book. Match the forest, gold and parchment palette; use clear
silhouettes and transparent backgrounds for cutout figures and objects. A diagram
should explain a rule without relying on a decorative illustration.

| Section | Subject | Treatment and purpose |
|---|---|---|
| Opening | A lantern beyond a broken gate in rain | Wide atmosphere image; leave readable quiet space for the title. |
| Running the game | Hands, three dice and a marked card | Small transparent still life; avoid repeated full-body portraits. |
| Adventure construction | An unfolded route map, wax seals and a worn bell clapper | Transparent object group supporting investigation. |
| Bell at the Crossing | Ferry shelter, causeway, toll yard, loft and service path | Original labeled location diagram; separate tactical inset for yard and signal room. |
| Places and people | A working riverside settlement | Broad landscape with several recognizable destinations. |
| Encounter preparation | A bridge with approaches, cover and an escape route | Diagram, not merely a scenic bridge; show why position matters. |
| Hazards | Spear catch, furnace shutter and sluice controls | Distinct labeled mechanical sketches, one per relevant entry. |
| Treasure | Recipe roll, mixing kit and an ordinary coin purse | Transparent objects; distinguish supplies from training. |
| Campaigns | A repaired chair beside a retiring hero's old equipment | Quiet scene supporting lasting consequences. |
| Creature-card guide | Annotated Goblin Scrapper layout | Diagram labeling defense outcomes, Evasion/Threat and resistance. |
| Stability example | Three numbered positions on a square grid | Diagram showing movement remaining, collision damage and new Stability deduction. |
| Summoned forms | A Moon Hart dissolving at the edge of a six-square diagram | Use visual distinction for energy form without implying incorporeality. |
| Bestiary families | Selected lairs, tracks, silhouettes and creature cutouts | Unique subjects chosen after pagination; no repeated family filler image. |

Check that every diagram agrees with printed distances and timing. Final art must
not obscure card headers, attribute labels, table rows or cross-references. Page
padding and column balance take priority over inserting another portrait.


## October 17 review proof

`generated/pdf-manifest.json` lists every placed interior asset and its SHA-256.
`generated/layout-metadata.json` records the actual page of each placement.
The completed art plan contains **206 distinct interior illustrations/diagrams**:
192 creature portraits, nine chapter illustrations and five diagrams. The approved
cover crest and ruins are each used once on the cover, outside this count.

Every creature now has a dedicated portrait, mapped by stable creature ID in
[the shared art manifest](../bestiary/art/manifest.json). Seventy-three are existing
Player's Book creature cutouts; 119 are new transparent illustrations made with
the built-in image generation tool. Chapter illustrations reuse nine existing
objects, landscapes and scenes. The book renderer and future VTT share the same
portrait references, with image hashes and dimensions recorded. See the
[art catalog](../bestiary/art/README.md) and [prompt set](../bestiary/art/prompts.json).
No creature receives a prop image as a substitute, and no interior image is repeated.

Five original SVG diagrams are rebuilt by `draw_diagrams.py`:

- `crossing-routes.svg`: the adventure’s connected locations, not a scale map.
- `toll-yard.svg`: the 12-by-10-square yard, cart, cover and suggested opponents.
- `signal-room.svg`: the 8-by-8-square room, sentries, threshold and outside alcove.
- `stability-sequence.svg`: the approved push-5 collision example, with damage before
  the new participant’s Stability deduction.
- `summon-tether.svg`: nearest occupied squares at distance 6; a distance beyond 6
  immediately ends the form.

Map positions illustrate the approved adventure and remain suggestions. The diagrams
introduce no additional turn, surprise, terrain or creature rules. They were checked
against the adventure text, Stability ruling and ordinary summon-distance rule.
