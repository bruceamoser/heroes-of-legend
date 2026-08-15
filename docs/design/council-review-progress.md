# Council Review Progress

Daily walkthrough (4pm ET cron "HOL Council Walkthrough"): one chapter per day, all five council lenses
(Game Architect · Author · Editor-in-Chief · Contrarian · Layout/Design Expert).

Rules:
- Order = the list below, top to bottom, wave 1 first, then wave 2, etc.
- Mechanical fixes go through micro-PRs the same day. Design concerns go to `decisions-pending.md` for Bruce.
- This file is TRACKED — commit updates to main after every run.

## Wave 1

| # | Chapter | Status | Findings | PRs / Issues | Notes |
|---|---------|--------|----------|--------------|-------|
| 1 | 00-front-matter | reviewed | 8 (4 fixed / 4 resolved via layout PR) | PR #263 + #264 | front matter orphaned from build; wired via index.qmd include; #264: single title page, epigraph deduped+centered, version tied to build date, cover figure numbering suppressed |
| 2 | 01-introduction | reviewed | 10 fixed (canon example, stale spell, figure captions, heading levels, spell-limit wording, author trims) + 6 swept cross-chapter | PR #265 + #271-#275 | #265: Example of Play rewritten to #256 canon (13 Standard; no Long Blades skill), Water Breathing removed (no such spell), Illo 2/3 caption-syntax dropped (figure numbering 8→6), ### callouts → ## (book convention), spell-limit wording matched ch10, redundant cross-ref trimmed. #256 stale-skill sweep closed umbrella #266: ch02 builds (#274), ch05 favored lists (#271), ch13 combat example (#272), ch22 reference table 42→20 rows (#273), whole-book one-cell leftovers ch04/ch15/ch19/ch20/ch21 (#275). NOTE for ch07's day: ch07 header says "The 18 Skills" but the table lists 20 rows — count wording needs reconciliation. |
| 3 | 01b-opening-fiction | reviewed | 1 fixed (figure alt-text / caption-syntax leftover) | PR #276 | Five lenses clean on mechanics: all discipline names canon (Armor/Protection/Wind/Energy per ch08 taxonomy; Blade class per ch05), ladder shapes legal (Roric 3 Armor, Zara 3 Wind = Master, exactly 3), roll callout follows the one-roll principle, 0 damage dice, 0 em-dashes, characters match ch01/ch16 (Kael dwarf Blade, Lyra halfling Odd, Roric dwarf Protector, Zara storm-caster). #276: dropped the `![Illo 4: ...]` figure caption-syntax that ch00/ch01 removed (figure numbering 8→6) — now `![](...)` + italic caption, matching ch01's Illustration 2/3 pattern. "fireballs were for Arcanists" (line 65) kept as in-world voice, not a rules claim. Build exit 0. |
| 4 | 02-character-creation | reviewed | 18 fixed (4 ch02 micro-PR) + 6 cross-chapter (1 micro-PR) | PR #306 + #307 | #306: stale ancestry lines (Elf=Archery, Halfling=Blades; was "X or Y" ×4), Turn Undead→Turn Unholy, Heal Wounds/Purify→Mending Touch/Sanctuary (old names exist in NO spell list), Intellect any-pick Energy→Tactics (Tactical Insight 1 Tactics), Gorma Blades→Protection rank 1 (Interpose + shield prereqs), Step 5 rank-2 deepening allowed (matches ch16 Roric), Movement row completed (dwarf/halfling 25 ft, heavy armor -5 ft), component pouch ×3, misapplied "favored" tags ×3 dropped, Arcane Shield "+1 Protection Value", "talent chains"→"Adept and Master upgrades" (ch10: no chains), Corwin pronoun, Shortbow label typo. #307 (contamination): ch04 culture table Disciplines "or"→"+" ×9 (prose+ch02+ch08 all say 2 discs), ch05 Turn Unholy ×2 + Priest kits chain shirt→leather (1 Armor unmeetable at L1) + throwing daggers, ch16 "spell attack rolls"→"spell rolls" + heavy-armor -5 ft notes. Build exit 0 both PRs. NOTE for ch07's day: ch07 header now says "The 22 Skills" — resolved row 14 says 20; recount on ch07's day. |
| 5 | 03-attributes | pending | | | |
| 6 | 04-ancestries-cultures | pending | | | |
| 7 | 05-classes | pending | | | |
| 8 | 06-core-resolution | pending | | | |
| 9 | 07-skills | pending | | | |
| 10 | 08-disciplines | pending | | | |
| 11 | 09-talents-abilities | pending | | | |
| 12 | 10-magic-system | pending | | | |
| 13 | 11-arcane-spells | pending | | | |
| 14 | 12-divine-spells | pending | | | |
| 15 | 13-combat | pending | | | |
| 16 | 14-social-conflict | pending | | | |
| 17 | 15-equipment | pending | | | |
| 18 | 16-armor-shields | pending | | | |
| 19 | 17-magic-items | pending | | | |
| 20 | 18-advancement | pending | | | |
| 21 | 19-gm-guidance | pending | | | |
| 22 | 20-bestiary | pending | | | |
| 23 | 21-glossary | pending | | | |
| 24 | 22-reference-sheets | pending | | | |
| 25 | 23-license | pending | | | |

## Wave 2

(Seeded after wave 1 completes.)
