# Nonmagical discipline revision

Source issue: https://github.com/bruceamoser/heroes-of-legend/issues/1310
Foundry: https://github.com/bruceamoser/heroes-of-legend-foundry/issues/271

This is the authored first-pass review packet for the approved nonmagical layout.
It contains 11 disciplines, 44 paths and 176 learning entries. It is not yet wired
into the released Player's Book or DA book. Existing cards remain intact until their
origin/class grants, references and replacement mappings are migrated together.
Do not combine the old rank/card acquisition rules with this packet's learning rules.

The approved Arms sample from PR #1309 supplies its 16 entries. Other entries are
newly authored for review, informed by the existing discipline descriptions and
useful catalog ideas (armor resistance, interception, rope travel, recipe work,
field treatment, tracking and social influence). Four Lanterns Deep supplies the
four-path sequential structure, not the mechanics or automatic endpoint wiring.

## Authoring and build

Each discipline Markdown file is the editable source. A path has four entries;
I/II/III retain the base technique name and the final entry has its own name.
The renderer preserves the body text and derives stable graph IDs from the
current discipline/path slug plus step number. Once adopted by downstream systems,
renames must retain these IDs explicitly rather than regenerating different IDs.

Run from repository root:

```sh
python3 design/player-book/nonmagical/build.py
python3 design/player-book/nonmagical/audit.py
```

Output: `output/pdf/nonmagical-disciplines.pdf`. Generated JSON is ignored.
The first two pages explain acquisition, universal resolution, practical/social
objectives and the previously agreed recovery limits. Pages 3–13 are the eleven
disciplines in Arms, Armor, Guard, Marksmanship, Athletics, Subterfuge, Wilderness,
Medicine, Craft, Scholarship, Influence order.

## Design choices in this first pass

- One DP for discipline access; paths cost 1/2/2/3, with only the final step gated
  to character level 3. These follow the approved sample, replacing class-priced
  discipline ranks within this revision. Full creation budgets are not changed here.
- Improvements are automatic and cumulative, without per-hit option menus.
  Values described as replacements are totals, not additional increments.
- Minimum attack damage remains 1 after every reduction. No NPC resistance rolls.
- Armor progresses through light/medium/heavy in one path; other paths add bracing,
  defensive reactions and armored mobility. Early heavy-armor access is a visible
  consequence of the agreed first-three-step availability, for Bruce's review.
- Utility paths improve time, progress, capacity or scope. Feasible mundane actions
  are not locked behind training. Known recipes still require ingredients and tools.
- Medicine uses the health revision's one recipient first-aid attempt between safe
  overnight rests. Emergency Treatment accelerates that same attempt. Condition
  care neither restores HP nor consumes the attempt. No hit-dice pool is introduced.
- Influence uses concrete, attainable concessions and DA-set progress objectives.
  Reference targets 3/6/9/12 and a worked example are included. Repeated arguments
  do not generate extra rolls; ordinary credible contributions still work.

## Integration still to do

1. Review these new ability choices and interactions with Bruce; printed numbers
   are first-playtest rules, not claims of tested balance.
2. Map old card IDs and all ancestry/culture/background/class grants to the new
   paths, preserving reference redirects or explicit replacement records. Do not
   silently reinterpret an old card with the same evocative title as the new rule.
3. Review the level-7 combined abilities now authored in `combined.md`, including
   their exact endpoint connections. Two/three/four-discipline combinations all
   require level 7. No generic investment or inferred adjacency qualifies an entry.
4. Integrate the approved source into both book builds and retire superseded
   rank/card prose in one coherent migration, together with approved health changes.
5. Implement Foundry only against the reviewed source commit.

## Verification

Typst 0.15.1 produced 13 letter-size pages. All 13 rendered pages were visually
reviewed, including final typography and the corrected Medicine/Armor entries.
The audit verifies all 176 complete effects against PDF text, one page per
discipline, unique graph IDs, exact previous-step prerequisites, 1/2/2/3 DP costs,
level-3 endpoints, printable text bounds and no zero damage floor.
No released-book builder or canonical live card was changed, so the existing
full-book builds were not rerun for this isolated packet.

## Book-style correction

The packet now imports the actual Player's Book `template.typ` and uses its setup,
catalog-card and discipline-mark components. This replaces the standalone pastel
blocks with the established forest headers, gold borders/dividers, parchment card
interiors, discipline silhouettes, typography, margins and running headers/footers.
No ability Markdown changed. All 176 full effects still match the rendered PDF.
Decorative art is omitted on these dense reference pages rather than adding overflow
pages; the book's existing functional discipline symbols appear in every path header.
The shared template is consumed unchanged, so the other books do not need rebuilding.
All thirteen pages were rendered and visually compared with the existing book.

Column-flow correction: both procedure prose and discipline paths now use the
Player's Book's existing `reading-columns` compositor. Paths read down the left
column before continuing down the right, with independent vertical placement and
intact path cards. Removed the row-aligned two-by-two grid. Rebuilt all 13 pages,
visually reviewed column order and spacing, and passed the complete packet audit.


## Level-7 combined disciplines

Source issue: https://github.com/bruceamoser/heroes-of-legend/issues/1312

`combined.md` adds 30 new abilities: 15 two-discipline (3 DP), nine three-discipline
(4 DP), and six four-discipline (5 DP). Every ability requires level 7 and every
listed endpoint, with distinct disciplines counted rather than merely distinct
spell lists. Nine entries combine magical and nonmagical training, three at each
breadth. Magical abilities spend explicitly printed SP per use; DP is learning only.

`magical-endpoints.md` records the eight required spell-list endpoints directly
from the existing local Magic Forge catalog (November 12, 2026). Their existing
IDs such as `air:3` are preserved; the `:3` is the prototype's zero-based final
node, not a different gate. The reference includes pages 7–8 and the three advanced
spells learned with each endpoint. This is a prerequisite reference, not a second
complete spell catalog. Names and unlocks should be sourced from the eventual
canonical magic catalog when integrating both systems.

The 24-page packet retains the base discipline pages, adds a linked combined-ability
index on page 14, abilities on pages 15–21, a reverse endpoint directory on pages
22–23, and magical endpoint references on page 24. Exact discipline, branch/list,
endpoint name and linked page appear on every combined card. Reverse connections
are generated from the same required-ID lists; there is no independently edited
connection table that can drift. Not every base endpoint has a combined ability in
this first set; absent connections do not imply prerequisites or grants.

Validation checks all 176 base and 30 combined effect texts in the PDF, distinct
discipline counts, all-of endpoint requirements, gates and costs, generated reverse
connections, magical page references, navigation presence and printable text bounds.
All added pages were rendered and visually reviewed in the actual book template.
The first-aid allowance, minimum-one damage and available-Reaction constraints are
retained. Large-scale effects and new SP costs are first-playtest design choices;
structural validation is not encounter-balance evidence.
