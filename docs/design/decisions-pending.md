# Design Concerns & Decisions Pending (Bruce)

Living log maintained by the daily council walkthrough. Items here are things **Bruce must rule on** —
design-flavored questions the council cannot resolve autonomously. The daily 4pm report surfaces the open list.

How it works:
- The walkthrough appends new rows (chapter, source lens, crisp question).
- Bruce answers in chat; Winston marks the row **resolved** with the ruling and files any pipeline work it implies.
- Never silently close a row. Never decide a design question in this file without Bruce's answer.

| # | Chapter | Concern / Question | Source | Status | Bruce's ruling |
|---|---------|--------------------|--------|--------|----------------|
| 1 | 05-classes | Ability pool fills (~10 cards per class) — queued content wave, seeds exist from #183 | Queue (pre-existing) | queued | Ruling 2026-08-14: queue now — dispatch as next content wave |
| 2 | all | Final balance audit (full-book budget walk) | Queue (pre-existing) | queued | Ruling 2026-08-14: fold into walkthrough days — audit each chapter on its day |
| 3 | 07-skills | #260 weapon-skill families | Issue #260 | resolved | Ruling 2026-08-14: dispatch sweep as written (remap to Disciplines; 8 DP preserved) |
| 4 | 02-character-creation | Dwarf build templates: armor/weapon inconsistency | Council (flagged) | resolved | Ruling 2026-08-14: template takes Axes from ancestry; culture table stands (accept 2-disc start) |
| 5 | 09-talents-abilities | Corwin's Exploit Chaos — energy keying | Council (flagged) | implemented default 2026-08-14 | Ruling 2026-08-14: keyed to Mind, but follow-up check showed Mind AND Energy are unavailable at L0 (Unbalanced starts Fire+Water; Energy is Arcane). Corwin's template buys it at creation, so it must be usable at L0. Implemented default: No prereq (matches Improvised Solution convention) — veto to revert. |
| 6 | 11-arcane-spells | Rider gaps on 2-discipline cards (5 utility cards left Adept/Master open) | EIC pass | shipped 2026-08-14 | Ruling: fill completely. PR #292: Phantasmal Image, Fade, Mind Crown, Eldritch Sight, Pillar of Light got full Adept/Master riders. |
| 7 | 04-ancestries-cultures | Ancestry "any one weapon" fix — Decision 3 | Council | resolved | Ruling 2026-08-14: fixed per-ancestry weapon Discipline — Elf=Archery, Dwarf=Axes, Halfling=Blades |
| 8 | 10-magic-system | Card inventory completeness: 48 spell inventory vs roster | Design review | resolved | Ruling 2026-08-14: 48 is the locked scope; tranche 2 proceeds against it |
| 9 | 00-front-matter | Opening flow: decorative #titlepage() lands at p10 (after the auto title block, TOC, and Chapter I opener); the epigraph tagline also appears twice (p9 opener + p10 titlepage). Suppress the auto title block and move the ornate title page to p1 (template work), or accept current placement? | Layout | resolved | Fixed 2026-08-13 (council layout PR): single auto title page at p1, duplicate ornate page removed |
| 10 | 00-front-matter | `.centered` div class is dead (pandoc drops the class), so the front matter block and epigraph render left-aligned. Add a working centering mechanism (typst align block or a styled class), or accept left-aligned? | Layout | resolved | Fixed 2026-08-13 (council layout PR): dead class usage removed; epigraph centered via raw typst align |
| 11 | 00-front-matter | Version marker: book still prints "Version 0.1.0 (Draft)" after the cards/final-economy era. Tie versioning to draft-release dates (draft-2026-08-13), bump semantically, or freeze at 0.1.0 until first public release? | EIC | resolved | Fixed 2026-08-13 (council layout PR): version tied to build date via {{< meta date >}} |
| 12 | 00-front-matter | Cover art renders as auto-numbered "Figure 1.1" with a duplicated caption ("Figure 1.1: Illustration 1: Cover Art" + the italic caption line). Suppress figure numbering for front matter art? | Layout | resolved | Fixed 2026-08-13 (council layout PR): cover is plain image, no caption syntax -> no figure numbering |
| 13 | 15-equipment | Mount-control rules keyed to Animal Handling, which #256 removed from the skill roster | Council (Architect) | reverted 2026-08-14 | Bruce vetoed Athletics keying: mount control reverts to Survival/Nature. Revert PR #275 re-key; keep livestock roundup (Survival/Nature) and disguise-seeing (Reason/Insight) as shipped. |
| 14 | 07-skills | ch07 header claims "The 18 Skills" but the skill table lists 20 rows | Council (EIC, flagged for ch07's day) | resolved | Ruling 2026-08-14: header updates to "The 20 Skills"; roster stands |

Last updated: 2026-08-14
