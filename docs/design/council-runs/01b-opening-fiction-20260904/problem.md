# HOL Council — ch01b Opening Fiction ("The Last Ember")

Chapter under review: ch01b (quarto-book/chapters/01b-opening-fiction.qmd), "The Last Ember", 123 lines. The book's opening fiction: a short story in which the party (Kael the dwarf Blade, Lyra the halfling Odd, Roric the Protector, Zara the storm-speaker) breaks a warding glyph in a sealed temple and kills a many-legged guardian. It is the first fiction the reader meets after the front matter, and the canon reference for the party's identities and play styles (ch01's Example of Play points readers here: "You'll meet Kael and Lyra in the opening story").

Task: audit the chapter as a publishable unit and produce a disposition plan. Each member audits through their own lens (see role card) and files ONE finding:
  stance support = the chapter holds on this lens as written
  stance refute  = the chapter must change; name the fix and its scope
Findings cite [01b-opening-fiction.qmd:line]. Mechanics findings state the broken value and the expected value.

Cross-chapter canon anchors (use the AUTHORITATIVE chapters as reference, not this chapter):
- discipline taxonomy = ch08 (08-disciplines.qmd): 19 named Disciplines in 4 categories. Relevant names: Armor (one Discipline, Defense category, "heavy armor proficiency, damage soaking"), Wind (Nature category), Energy (Arcane category), Knowledge (Arcane category), Protection (Defense category). There is no "Armor Disciplines" plural taxonomy beyond the single Armor Discipline; ranks within one Discipline max at 3 (the Master ladder).
- class starting bundles = ch08 table (~lines 73-80): Protector = 1 any Weapon + 1 Armor; Arcanist = 1 Fire + 1 Energy; Shepherd = 1 Protection + 1 Animal; Leader = 1 Tactics + 1 Protection; Unbalanced = 1 Fire + 1 Water (or Earth/Wind); Blade = Blades (1) + Stealth (1).
- party canon = ch02 (templates/walkthroughs), ch13-combat.qmd (initiative example lines ~348-432: Kael (Blade) 13, Lyra (Odd) 16, Roric (Protector) 7, Knight of the Iron Circle Challenge 3; Kael's longsword + buckler, Roric's warhammer and Brawn +2), ch05-classes.qmd (class flavor and favored skills), ch01-introduction.qmd (Example of Play: Kael dwarf Blade with longsword, Brawn +1; Lyra halfling Odd, Agility +2, Stealth Adept +2; party stated as veteran adventurers several levels in).
- known open question (decisions-pending #73, for context only, do not re-litigate): the Blade class flavor (ch05: shadow-assassin, light blades) vs Kael's vanguard portrayal in this chapter and his longsword (a Heavy Weapon). That tension is already logged for Bruce; audit this chapter's text on its own merits.

Book conventions every lens applies: zero em-dashes in the book (restructure sentences instead of find-replace); no stale or retired vocabulary (the role label is DA, never GM); placeholder content (TBD, "final art TBD") is ACCEPTABLE in a draft build and is NOT a defect to fix now (flag only if a placeholder is wrong or inconsistent); the one-roll principle (the hit roll IS the damage roll; no separate damage dice); flat damage budgets (Novice 2/4/6, Adept 6/9/12, Master 9/15/21); success tiers Weak 1-8 / Standard 9-14 / Strong 15-18+; Adept gates at level 3, Master at level 7; card costs flat 2/4/8 DP.

Specific areas worth checking (findings are yours to file or dismiss):
- line 19: "Armor Disciplines, three of them" — Roric is described as having three Armor Disciplines. Check this phrasing against the ch08 taxonomy (Armor is one Discipline; three ranks in one Discipline is the Master shape, but the wording "three of them" reads like three separate Disciplines named Armor).
- line 21 and line 47: Zara "had three Wind Disciplines" / "Three Wind Disciplines didn't just summon a breeze" — check the same plural-discipline phrasing against the taxonomy (Wind is one Discipline).
- line 27: the inline roll narration "3d6: 5, 4, 6, 15 plus Brawn plus skill, Strong" — check the arithmetic (5+4+6 = 15; 15 + Brawn + skill is at least 15, so Strong is consistent with the tier table; the narration gives no explicit modifiers, so it is a summary, not a worked example — flag only if it misstates a tier or contradicts a canon number).
- lines 1-5: the heading "# The Last Ember {#sec-chapter-opening-fiction}" AND a typst block "#label(\"sec-chapter-opening-fiction\")" define the same anchor twice. Check whether the duplicate label definition is a defect (redundant, or a render warning).
- the anchor sec-chapter-opening-fiction: no other chapter cross-references it (grep the book). An orphaned forward-looking anchor is not itself a defect, but note if it is dead weight or if a chapter that should link here (e.g. ch01's "You'll meet Kael and Lyra in the opening story") does not.
- em-dashes: count and locate every em-dash in the chapter; the zero law applies to fiction prose as well as rules prose.
- Kael's longsword (lines 27, 45, 61, 87): a Heavy Weapon in the hands of the Blade; the ch01/ch05 tension is already logged (#73) — audit only what is broken in THIS chapter's own text.
- Zara's class: the fiction shows her as the party's storm-speaker (Wind + Energy) but never names her class; check whether any authoritative chapter (ch02, ch13) names her, and whether the fiction's portrayal contradicts it (Unbalanced's starting bundle includes Wind as an option).

Disposition tiers (the librarian synthesizes these in the recommendation):
  TIER 1 mechanical — chapter-local, zero mechanics change, no content judgment (heading/label, wording, em-dashes, table rows, stale refs, page flow).
  TIER 2 substantive — rewrites or multi-sentence fixes that change content but not rules (a line rephrased to match canon, a paragraph restructured).
  TIER 3 design decisions — anything that touches rules, canon identities, or book-wide convention; route to decisions-pending for Bruce, with a recommended default.
