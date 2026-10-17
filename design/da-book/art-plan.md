# Art and diagram record

## Current artwork

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
