## Epic 0 — Infrastructure (#4)

**Dependency:** None
**Est. Effort:** Small

### Goal
Catalog and organize the 46 images extracted from the original playtest PDF into a structured asset directory ready for use in the new rulebook.

### Success Criteria
- All 46 images are renamed from `pageNNN-imgMMM.ext` to descriptive names
- Images are organized into subdirectories by type (artwork, diagrams, icons, etc.)
- A README or catalog file maps original filenames to new names
- Duplicate images are identified and removed

### Tasks
- [ ] Review all 46 images in `assets/images/` and categorize by content
- [ ] Create subdirectories: `assets/images/artwork/`, `assets/images/icons/`, `assets/images/diagrams/`
- [ ] Rename images with descriptive filenames (e.g., `fireball-illustration.png`, `dwarf-ancestry.jpg`)
- [ ] Create `assets/images/IMAGE-CATALOG.md` mapping old→new names with descriptions
- [ ] Identify images suitable for chapter dividers or decorative elements
- [ ] Move decorative/svg-capable images to `assets/svg/` if applicable
- [ ] Identify which pages/chapters each image belongs to (cross-reference with extracted markdown)
- [ ] Mark images that need replacement (low quality, placeholder, copyright concern)

### Reference
- Extracted images: `assets/images/page*-img*.png` and `assets/images/playtest-img-*.png`
- Original page mapping: `source-doc/extracted/playtest.md` (images referenced by page number)
