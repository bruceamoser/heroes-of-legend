# Design Concerns & Decisions Pending (Bruce)

Living log maintained by the daily council walkthrough. Items here are things **Bruce must rule on** —
design-flavored questions the council cannot resolve autonomously. The daily 4pm report surfaces the open list.

How it works:
- The walkthrough appends new rows (chapter, source lens, crisp question).
- Bruce answers in chat; Winston marks the row **resolved** with the ruling and files any pipeline work it implies.
- Never silently close a row. Never decide a design question in this file without Bruce's answer.

| # | Chapter | Concern / Question | Source | Status | Bruce's ruling |
|---|---------|--------------------|--------|--------|----------------|
| 1 | 05-classes | Ability pool fills (~10 cards per class) — queued content wave, seeds exist from #183 | Queue (pre-existing) | open | |
| 2 | all | Final balance audit (full-book budget walk) — queued after ability fills | Queue (pre-existing) | open | |
| 3 | 07-skills | #260 weapon-skill families — open issue, needs Bruce's scope call | Issue #260 | open | |
| 4 | 02-character-creation | Dwarf build templates: armor/weapon inconsistency flagged in template walkthroughs | Council (flagged) | open | |
| 5 | 09-talents-abilities | Corwin's Exploit Chaos — energy keying needs confirmation | Council (flagged) | open | |
| 6 | 11-arcane-spells | Rider gaps on 2-discipline cards (5 utility cards left Adept/Master open) | EIC pass | open | |
| 7 | 04-ancestries-cultures | Ancestry "any one weapon" fix — Decision 3 pending approval | Council | open | |
| 8 | 10-magic-system | Card inventory completeness: 48 spell inventory vs roster — confirm scope before tranche 2 | Design review | open | |
| 9 | 00-front-matter | Opening flow: decorative #titlepage() lands at p10 (after the auto title block, TOC, and Chapter I opener); the epigraph tagline also appears twice (p9 opener + p10 titlepage). Suppress the auto title block and move the ornate title page to p1 (template work), or accept current placement? | Layout | resolved | Fixed 2026-08-13 (council layout PR): single auto title page at p1, duplicate ornate page removed |
| 10 | 00-front-matter | `.centered` div class is dead — pandoc drops the class, so the front matter block and epigraph render left-aligned. Add a working centering mechanism (typst align block or a styled class), or accept left-aligned? | Layout | resolved | Fixed 2026-08-13 (council layout PR): dead class usage removed; epigraph centered via raw typst align |
| 11 | 00-front-matter | Version marker: book still prints "Version 0.1.0 (Draft)" after the cards/final-economy era. Tie versioning to draft-release dates (draft-2026-08-13), bump semantically, or freeze at 0.1.0 until first public release? | EIC | resolved | Fixed 2026-08-13 (council layout PR): version tied to build date via {{< meta date >}} |
| 12 | 00-front-matter | Cover art renders as auto-numbered "Figure 1.1" with a duplicated caption ("Figure 1.1: Illustration 1: Cover Art" + the italic caption line). Suppress figure numbering for front matter art? | Layout | resolved | Fixed 2026-08-13 (council layout PR): cover is plain image, no caption syntax -> no figure numbering |

Last updated: 2026-08-13
