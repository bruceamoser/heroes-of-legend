## Epic 0 — Infrastructure (#1)

**Dependency:** None (prerequisite for all other work)
**Est. Effort:** Small

### Goal
Set up the heroes-of-legend repository to mirror the proven build structure from Neon Relic, enabling AsciiDoc chapter files to be assembled and built to PDF.

### Success Criteria
- `./build.sh` runs without errors and produces `starter-kit/heroes-of-legend-core-rules.pdf`
- Master document includes all 23 chapter stubs via `include::` directives

### Tasks
- [ ] Create `docs/chapters/` directory with placeholder `.adoc` stubs for all 23 planned chapters
- [ ] Create `docs/heroes-of-legend.adoc` master document with `include::` directives
- [ ] Create `build.sh` (Linux/macOS) adapted from neon-relic's build script
- [ ] Create `build.ps1` (Windows) counterpart
- [ ] Create `docs/themes/` directory structure
- [ ] Create `assets/svg/` for decorative elements
- [ ] Create `starter-kit/` as build output target (gitignored)

### Reference
- Neon Relic build scripts: `../neon-relic/build.sh`, `../neon-relic/build.ps1`
- Neon Relic master document: `../neon-relic/docs/neon-relic.adoc`
