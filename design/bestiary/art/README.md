# Creature illustration catalog

Every creature has one dedicated transparent portrait. The DA book and future VTT
should resolve artwork through [manifest.json](manifest.json), keyed by the stable
creature ID from the authored Markdown. Do not infer a filename from the creature's
display name: names can change without changing identity.

Paths are relative to the repository root. `source` identifies the creature card;
`illustration` identifies its portrait. The manifest records pixel dimensions,
transparency and SHA-256 so an export can verify which revision it contains.
Keep these paths stable when revising an image, and update its recorded hash.

The catalog contains 192 portraits: 73 existing Player's Book creature cutouts
and 119 newly generated bestiary illustrations. Existing art stays at its original
path; it is not copied into a second library. New assets live in `creatures/`.
The book places each portrait once, beside its creature. Summoned profiles link
back to that creature rather than repeating the image.

New art uses the built-in image generation tool, with transparent backgrounds,
crisp ink contours and restrained forest, brass and earth colors. The exact new
generation prompts are in [prompts.json](prompts.json), keyed by creature ID.
Existing images retain their original Player's Book provenance; descriptions in
the prompt file for those IDs are prospective replacement briefs, not claims
about how those older images were generated.

These are illustrations suitable for VTT portraits. A future VTT export may make
cropped tokens or add rings, but should retain the creature ID and original
illustration reference. This catalog does not introduce a VTT data format or
claim that a token importer is already implemented.

Run `python3 design/bestiary/art/audit.py` from the repository root (Pillow required).
The audit checks creature coverage, unique image files and hashes, dimensions,
transparency and new-art prompt references. Rendered book pages still need visual
review; a valid image file alone does not prove a good crop or illustration.
