# DesignCraft / Great Library tool trial

Issue: #1197. Tested October 15, 2026 using the official Linux x86-64
DesignCraft 0.8.0 portable release, with its visible desktop application and
documented local control API. This is a six-page tool trial, not a player-ready
book or an approved final visual design. No source rules changed.

## Visual reference

Bruce requested the Great Library application's style. Reference inspected:
http://localhost:8765/ and its local `/mnt/disk5/rpg-app/static/theme.css`.

- Forest #0e1714; gold #c9a766; ivory #f1e6ce; ink #28251c.
- Cinzel headings and EB Garamond body text.
- Dark illustrated opening; ivory reading pages; fine rules and restrained gold.
- The existing Library hero image is a local prototype reference, not a decision
  to use that image as the published HOL cover.
- The current samples leave deliberately generous space. They do not establish
  final book density, trim, margins, or typography.

## Open the trial

[PDF](artifacts/hol-library-trial.pdf) ·
[Editable DesignCraft file](artifacts/hol-library-trial.designcraft) ·
[IDML interchange](artifacts/hol-library-trial.idml)

Pages: opening, core resolution, Force/Gust Hammer excerpts, Goblin Scrapper
quick-reference excerpt, and a two-page threaded foundations story. The source
documents retain their existing status/proposal language. Creature details and
card metadata are selectively excerpted; this PDF is not a standalone rules source.

## Results

| Test | Observed result |
|---|---|
| Live desktop control | Passed through the documented localhost API; changes appear in the open document. |
| Named swatches and paragraph styles | Created and applied; body style size edited and restored. |
| Source import | Custom Markdown preprocessing needed: source line wrapping initially caused excessive paragraph breaks. Fixed in the trial importer. |
| Threaded text | One story spans two frames on separate pages. |
| Revision | Added 780 UTF-8 bytes; both frames retained the story without overset. |
| Overflow | Deliberate large addition reported 41,355 overset characters. Restoring the original removed the error. |
| Native save/reopen | Six pages retained; tested flow story text exactly equal after reopening. |
| PDF export | Six pages; selectable text; Cinzel and EB Garamond embedded with Unicode mappings. |
| Visual inspection | All six exported pages rendered with Poppler and inspected; initial overflow corrected. |
| Final preflight | Zero errors; six RGB-swatch warnings. This is a screen-oriented proof, not a press-approved file. |
| IDML | Exported and reopened in DesignCraft: six pages and zero preflight errors. Interchange with another vendor has NOT been tested. |

Raw observations: [test-results.json](test-results.json).

## Decision

DesignCraft is viable for a further publishing prototype. It has demonstrated
the basic editable-document workflow; this does not establish production readiness.

Still untested: native tables (the sample table uses aligned frames), repeating
table headers, multi-page wound tables, parent-page propagation, cross-references,
TOC/index/bookmarks, multi-chapter numbering, tagged-PDF reading order, commercial
print color/bleed requirements, large-book performance, and externally opened IDML.
A second trial should cover those before migrating the book.

The initial trial also shows why the software alone will not supply the design:
paragraph hierarchy, source normalization, frame sizes, contrast and page
composition still require deliberate choices and visual review.

## Reproduce

Start the official app with `--control 7979`. This creates a local control
connection; use it only during the test. Then run:

```sh
python3 design/layout-test/build-prototype.py
```

The script creates a NEW document and outputs to `/tmp/hol-designcraft/output`.
Override `HOL_LAYOUT_OUT` and `HOL_DESIGNCRAFT_PORT` if needed. It needs the
named fonts installed and uses the local Library hero image if present.
It reads Markdown without modifying it. Saved native/IDML artifacts include the
image; rebuilding elsewhere requires supplying that local asset.

## References

- [Official DesignCraft repository](https://github.com/storytold/designcraft)
- [Desktop control protocol](https://github.com/storytold/designcraft/blob/main/docs/control-protocol.md)
- [Official 0.8.0 release](https://github.com/storytold/designcraft/releases/tag/v0.8.0)

Workflow skills used: [create issue](../../.roo/skills/create-issue/SKILL.md)
and [create PR](../../.roo/skills/create-pr/SKILL.md).
