# Illustrated player book revision

Completed October 16, 2026 for PR #1211, branch
`issue/1205-player-book-production`; revision issues #1212–#1217.

All 121 interior art assets are generated, saved, visually inspected and hashed.
Prompts are in `art/interior-prompts.json`. The approved cover is preserved.
Editorial introductions, four selected paths, compact cards, grouped tables,
discipline badges with overlaid ranks and four printable character sheets are
implemented in the 232-page proof.

Final export and author QA are complete. The book audit passes with 607 source
records, all 350 ability names, 486 outcome lines and 280 complete wound rows.
Every page was inspected in overview, with enlarged checks of tables, card
headers and sheets. The final summon-selection header correction was rendered
and checked separately.

`optimize_pdf.py` compresses only embedded RGB image streams, preserving source
resolution, alpha masks, text and navigation. Extracted text matches the raw PDF
exactly; all 1,538 links have valid page targets and 943 bookmarks remain.
See `generated/pdf-report.json` for the final size and hash, and `qa-report.md`
for verification details. Rebuild with `python3 design/player-book/build.py --compile`.

The player book includes 73 summoned companion profiles. The full 192-creature
DA bestiary remains a separate book, as previously agreed. Independent human
review of this revision remains pending; no merge is authorized by author QA.
