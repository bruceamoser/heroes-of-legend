# Starter-kit releases

Every starter-kit release includes **both** the Player’s Book and the Dungeon
Architect’s Guide & Bestiary. Version and edition date live in `version.json`;
both title pages read that file. Git history holds previous sources, and GitHub
Releases hold published downloads. Do not keep archived editions in the source tree.

## Build and package

Install Typst **0.15.1**, Poppler (`pdftotext`, `pdfinfo`, `pdftoppm`), and Python
requirements. Use a virtual environment with `design/player-book/requirements.txt`.
If PDF libraries use a separate runtime, set `PDF_PYTHON` to that Python executable.

```sh
python3 -m pip install -r design/player-book/requirements.txt
TYPST=/path/to/typst python3 scripts/build_starter_kit.py
```

The script runs current-source audits, assembles and builds both books, checks PDF
coverage, links and source freshness, and creates `dist/v<version>/` containing:

- `Heroes-of-Legend-Players-Book.pdf`
- `Heroes-of-Legend-DA-Guide-and-Bestiary.pdf`
- `Heroes-of-Legend-Starter-Kit-v<version>.zip` (both PDFs, README and verification files)
- `manifest.json` (version, source commit, dirty flag, page counts and PDF hashes)
- `SHA256SUMS.txt`

The script never publishes. Inspect rendered pages before release. After the source
has been reviewed and committed, run `--package-only --require-clean` to audit and
package the current builds with a clean source commit. If source hashes differ,
rebuild first. `generated/`, `output/` and `dist/` are ignored artifacts.

## Publication

Use the issue → PR → independent review → squash merge workflow. After merging,
package from the merged commit, verify checksums, then create the minor release
with both named PDFs, the ZIP, manifest and checksum list. Use the release notes
in this directory. Mark a published release latest only once all assets are present.
Do not publish a one-book starter kit or silently replace older release assets.
