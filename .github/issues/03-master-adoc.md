## Epic 0 — Infrastructure (#3)

**Dependency:** #1
**Est. Effort:** Small

### Goal
Create the master `docs/heroes-of-legend.adoc` document that assembles all chapter files into a single book via `include::` directives.

### Success Criteria
- Master document compiles without errors via `asciidoctor-pdf`
- All 23 chapter includes are present (even as stubs)
- Document metadata (title, author, doctype, toc settings) is correct
- Part dividers separate the book into logical sections

### Document Structure
```
= Heroes of Legend (Core Rules)
Bruce A. Moser
:doctype: book
:toc: left
:toclevels: 2
:sectnums:
:pdf-theme: heroes-of-legend
:pdf-themesdir: {docdir}/themes
:imagesdir: {docdir}/../assets

// Front Matter
include::chapters/00-front-matter.adoc[]

// Part I — Introduction
include::chapters/01-introduction.adoc[leveloffset=+1]
include::chapters/01b-opening-fiction.adoc[leveloffset=+1]

// Part II — Character Creation
include::chapters/02-character-creation.adoc[leveloffset=+1]
include::chapters/03-attributes.adoc[leveloffset=+1]
include::chapters/04-ancestries-cultures.adoc[leveloffset=+1]
include::chapters/05-classes.adoc[leveloffset=+1]

// Part III — Core Mechanics
include::chapters/06-core-resolution.adoc[leveloffset=+1]
include::chapters/07-skills.adoc[leveloffset=+1]
include::chapters/08-dice-types.adoc[leveloffset=+1]
include::chapters/09-talents-abilities.adoc[leveloffset=+1]

// Part IV — Magic
include::chapters/10-magic-system.adoc[leveloffset=+1]
include::chapters/11-arcane-spells.adoc[leveloffset=+1]
include::chapters/12-divine-spells.adoc[leveloffset=+1]

// Part V — Combat & Equipment
include::chapters/13-combat.adoc[leveloffset=+1]
include::chapters/14-social-conflict.adoc[leveloffset=+1]
include::chapters/15-equipment.adoc[leveloffset=+1]
include::chapters/16-armor-shields.adoc[leveloffset=+1]
include::chapters/17-magic-items.adoc[leveloffset=+1]

// Part VI — World & GM
include::chapters/18-advancement.adoc[leveloffset=+1]
include::chapters/19-gm-guidance.adoc[leveloffset=+1]
include::chapters/20-bestiary.adoc[leveloffset=+1]

// Appendices
include::chapters/21-glossary.adoc[leveloffset=+1]
include::chapters/22-reference-sheets.adoc[leveloffset=+1]
include::chapters/23-license.adoc[leveloffset=+1]
```

### Tasks
- [ ] Create `docs/heroes-of-legend.adoc` with the above structure
- [ ] Set correct document metadata (author: Bruce A. Moser)
- [ ] Add part divider pages (images or sidebar blocks) between major sections
- [ ] Create minimal stub files for each chapter (single paragraph placeholder)
- [ ] Verify build succeeds: `asciidoctor-pdf docs/heroes-of-legend.adoc`

### Reference
- Neon Relic master document: `../neon-relic/docs/neon-relic.adoc`
