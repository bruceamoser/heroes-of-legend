## Epic 8 — Polish & Build (#96)

**Dependency:** All chapters #15-#95
**Est. Effort:** Large

### Goal
Cross-reference validation — ensure every `xref:` link in every chapter points to a valid target.

### Validation Rules
- Every `xref:chapters/XX-chapter-name.adoc#anchor[text]` must resolve
- Every internal anchor `[[anchor-name]]` referenced by an xref must exist
- No dangling references to chapters that were renamed or removed
- All chapter-to-chapter references use correct filenames and anchors

### Tools
- `asciidoctor` will warn on broken xrefs during build
- Manual review of each chapter's xref list

### Tasks
- [ ] Build the full PDF and capture all xref warnings
- [ ] Fix every broken cross-reference
- [ ] Verify all chapter references in master adoc match actual filenames
- [ ] Verify all `<<anchor>>` internal references resolve
- [ ] Verify all image paths resolve
- [ ] Rebuild and confirm zero xref warnings
