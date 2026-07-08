## Epic 8 — Polish & Build (#97)

**Dependency:** #96
**Est. Effort:** Medium

### Goal
Full build, PDF generation, and final review of the complete Heroes of Legend Core Rulebook.

### Build Procedure
```bash
./build.sh
# Output: starter-kit/heroes-of-legend-core-rules.pdf
```

### Review Checklist
- [ ] PDF opens correctly in standard PDF readers
- [ ] Table of contents is generated and accurate
- [ ] All chapters begin on correct pages
- [ ] Part divider pages render correctly
- [ ] All images display at correct resolution
- [ ] Tables don't overflow page margins
- [ ] Page numbers are consistent
- [ ] Headers/footers display correctly
- [ ] Font rendering is correct (no missing glyphs)
- [ ] Internal links (xref) work in PDF
- [ ] Print test: does it look good on paper?
- [ ] File size is reasonable (<50MB)
- [ ] Cover page (if separate) integrates correctly

### Tasks
- [ ] Run full build
- [ ] Review PDF page by page for visual issues
- [ ] Fix any rendering problems (table widths, image scaling, page breaks)
- [ ] Run print test
- [ ] Generate final production PDF
- [ ] Tag release version (v1.0.0-core-rules)
