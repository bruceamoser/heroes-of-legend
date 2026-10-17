# Player’s Book — v16.1.0 PDF review

Reviewed October 17, 2026. This is the player half of the two-book starter kit,
covering levels 1–10. Publication follows review of the cleanup PR.

## Artifact and coverage

- 238 US Letter pages; 94,288,657 bytes.
- 608 included source records, all 350 abilities and 486 outcome lines.
- All 280 wound results, including their descriptions, effects and remedies.
- 73 summoned forms; 50 culture/background pairs; six complete example heroes.
- 153 current art assets; 131 unique illustration placements, including 24
  open-space placements. Functional logos and discipline symbols may repeat.
- Four printable sheets on pages 228–231.
- 2,028 PDF links with valid destinations and 961 bookmarks.

SHA-256: `25607619af03fe35aba29ba7d21cab72263e18bb05d7fa1018208adf19afca6c`.

## Checks performed

Built with Typst 0.15.1 after removing legacy sources and superseded artwork.
The source audit verifies current records, discipline prices, grants, ability
outcomes, wound cells, art availability, class-cutout transparency and page bounds.
No missing card names, outcome text, wound cells, illustrations, unresolved
placeholders or out-of-bounds words were reported. Compression preserves the
complete extracted text; source image resolution and alpha masks remain intact.

Every page was inspected in overview during the cleanup pass. The expanded
summoning introduction was reflowed into two columns with its illustration below,
removing a nearly empty continuation page. The resulting introduction and roster
were inspected enlarged, and the final export was rendered again to verify its
pagination. Catalogs, cards, tables, sheets and indexes retain the approved style.

The Player’s Book now teaches the existing approved weakness calculation,
NPC-only roll procedure, crowded-collision placement, minimum-damage wound-table
choice, summoned energy forms, controller-paid healing and six-square tether.
The shared language chapter and character language choices are retained.
Current narrative/Rules separation and catalog IDs remain intact. The erroneous
spell-only offensive-healing paragraph is removed from the potion source; the
reader edition already excluded it. No new potion attack is introduced.

## Boundaries

These are source, transcription, navigation and layout checks, not new balance
simulations or an independent editorial proofread. Creature CV and encounter
budgets remain playtest estimates. This is a digital playtest edition, not a
printer-certified PDF/X file. Full-resolution current art and font licenses are
preserved; obsolete artwork and earlier editions remain available in Git history.

See [README](README.md) for builds and [release instructions](../../release/README.md)
for the combined starter kit. Generated audit reports live under `generated/`.
