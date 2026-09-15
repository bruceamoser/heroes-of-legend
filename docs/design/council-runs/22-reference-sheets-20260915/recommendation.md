# Recommendation — hol-rulebook

**Verdict:** FINAL DISPOSITION PLAN — chapter 22 Quick Reference Sheets (quarto-book/chapters/22-reference-sheets.qmd). Implement MECHANICAL and SUBSTANTIVE as written; every RESERVED item is verified but unreached by any finding or ruling and needs the principal's scope/owner decision before anyone edits it. All line numbers are current HEAD numbers.

MECHANICAL (ruling-settled and surgical: implement exactly, no judgment)
M1. 22-reference-sheets.qmd:194 — delete the Parry row's trailing shield clause "(shield enables Parry and gives DR, never a roll bonus)" so the Key Use cell ends "...requires one in hand". Binding under r-001 C2 (clause deleted outright on this sheet); no other chapter-22 row is reopened on this topic (r-001 C3).
M2. 20-bestiary.qmd:116 — dispose of the Guard's "*Shield:* +1 DR." line in ONE of the two shapes r-001 C2 allows: either fold the +1 into the Guard's authored DR total on 20-bestiary.qmd:112 (DR 1 -> DR 2), or delete the value together with the whole line. Stripping only the number and leaving the line is barred. Confirm by whole-book search that no carrier survives beyond the two re-derived sites (22:194 and 20-bestiary.qmd:116) — r-001 C3 permits only that confirmation.
M3. 22-reference-sheets.qmd:118 — delete the standalone #pagebreak() that follows the Conditions figure (figure closes at :116). Measured cause: the 23-row table ends under one line of slack on folio 364, so the authored break lands a page late and leaves folio 365 empty (fill 364 = 99.2%, 365 = -4.6% with 4 words, 366 = 91.0%; 365 is mid-chapter, so no opener or last-page exemption). Record the corrected baseline (387 pages; chapter span folios 359-379) and accept only on a clean rebuild showing 386 pages with folio 365 content-filled and the chapter's surviving rows intact (r-002 C2, C3).
M4. 22-reference-sheets.qmd:93 — Asleep X row, BOTH cells: Effect "Unaware" -> "Unaware for X minutes"; Ends "X minutes or damage" -> "Wakes on damage". Mirror 13-combat.qmd:192 and the glossary; the owners are correct and are not edited. [t-02 defect from f-004; t-02 was rejected, so the defect still stands.]
M5. 22-reference-sheets.qmd:107 — Marked row, EFFECT CELL ONLY: open the cell with the defining tie to a single marking creature (mirror 13-combat.qmd:206 and the glossary entry), keeping the three consequences in the sheet's shorter phrasing. The Ends cell ("Source, marker downed, or amends") is faithful and must not change. [t-02 defect from f-008.]
ATOMICITY (binding): M3, M4 and M5 land in ONE commit. The Conditions table has under one line of slack, so either wording repair moves the page break that produces the blank folio; split them and the defect returns. Rebuild and re-measure folios 364-366 after that single commit.

SUBSTANTIVE (ruling-settled content: implement, no question asked)
S1. 22-reference-sheets.qmd:147-158 — Dying subsection: restore the Grit gate the sheet omits. Add the tier values (2 Novice / 3 Adept / 4 Master), the spend procedure (spend one point: HP resets to maximum and you roll on the Wound Table) and the return condition (a respite, a full night's rest), mirroring 13-combat.qmd:339-349. The sheet currently prints the 0-HP roll as the whole procedure. Required by r-002 C1.
S2. 22-reference-sheets.qmd:249 — Derived Stats line: add Grit alongside HP, Initiative, Speed and Carry Slots, mirroring the owning derived-stat line in 02-character-creation.qmd. Required by r-002 C1 ("together with the dropped derived-stat line").
S3-S6 (the retired damage-band text that the rejected t-02 leaves standing; the sheet's own budget block at 22:311-322 prints the live rows and must NOT be touched):
 S3. 08-disciplines.qmd:222 — the "How to Read the Budget" callout teaches Ember Lance as 2/4/6; raise it to the live Novice row its own table prints at :210-212 (4/6/8).
 S4. 11-arcane-spells.qmd:171-175 — the Ember Lance card prints 2/4/6; raise Weak/Standard/Strong to 4/6/8 (Novice card, 1 Fire; 08-disciplines.qmd:177 and :241 price it as Novice).
 S5. 20-bestiary.qmd:144 — Archmage stat block "*Ember Lance:* 2/4/6 (at will)." -> 4/6/8.
 S6. 13-combat.qmd:510 — worked example "Ember Lance Standard damage: 4 fire" -> 6 fire, with the same sentence's arithmetic restated ("4 damage straight through" -> 6).
 Verification for S3-S6: grep the four files for the retired triples 2/4/6, 6/9/12 and 9/15/21 and confirm none survives in a damage context.

RESERVED (verified, nothing adjudicated: principal decides scope and owner)
R1. 22-reference-sheets.qmd:280-291 — the DP Cost table prices seven purchases and has no FREE row for cantrips, though cantrips cost nothing and carry no Discipline requirement (10-magic-system.qmd:71-77; decisions-pending #109). ORCHESTRATOR-VERIFIED. Recommended: insert "[Cantrip (no Discipline requirement)], [Free]" after :290; the problem statement framed the omission as possibly a scope choice, so the principal accepts or declines.
R2. Brimstone Burst's tier: 11-arcane-spells.qmd:180-184 and 20-bestiary.qmd:146 print it on the live Novice row 4/6/8 while 08-disciplines.qmd:243 buys it as an Adept card (Adept row 5/8/11). ORCHESTRATOR-VERIFIED and the stated subject of the still-open #546. Decide the card's tier, then its values.
R3. Rank-2 divergence between the spell chapters: 11-arcane-spells.qmd:180-184 and :189-193 print 4/6/8 while 12-divine-spells.qmd:105-109, :114-118 and :137-141 print 6/9/12; the live Adept row is 5/8/11 (08-disciplines.qmd:211). ORCHESTRATOR-VERIFIED. Decide the repair target chapter before editing either.
R4. Book-wide retired-band population: roughly 25 owner-side sites survive because the sweep rewrote only compact slash strings, leaving per-tier Weak/Standard/Strong blocks at their pre-renumber numbers. NONE are in chapter 22. ORCHESTRATOR-VERIFIED; same class as #546. Decide whether to charter a sweep or fold it into #546.
R5. Action-resource vocabulary: 22-reference-sheets.qmd:59 names the per-turn resource "Movement" (matching 13-combat.qmd:39) while the derived-stat line at :249 prints "Speed" with no unit and no definition of its own. ORCHESTRATOR-VERIFIED. Decide whether the derived stat reads "Speed (ft)" or the resource row carries the unit; one token either way.
R6. 22-reference-sheets.qmd:470 — the asterisk key is unanchored: the rows it decodes (:406 backpack, :426 pouch, :430 sack) print on folio 377 while the note prints on 379. ORCHESTRATOR-VERIFIED. Decide whether the container-exemption note moves adjacent to those rows or the asterisks are dropped.
R7. Truncated example cells: 22-reference-sheets.qmd:335 (example column :332-335) prints one option where the owner prints two ("1 Ancient Dragon (C12) or 1 Lich (C10) + minions", 20-bestiary.qmd:654); the same truncation is flagged at :155 in the Dying table (owner 13-combat.qmd:361 — verify the owner before touching it). ORCHESTRATOR-VERIFIED. Decide whether the sheet carries the owner's alternatives or points at the owner.
R8. Knight/hero DR inconsistencies outside chapter 22: 06-core-resolution.qmd:91 prints a plate knight at DR 6 while :154 gives heavy steel as DR 5; 13-combat.qmd:472 gives the Knight's plate DR 4 against :498 and :520's DR 3; Kael's DR is 3 at 13-combat.qmd:482 but 1 at :502. ORCHESTRATOR-VERIFIED. Decide the correct knight DR and restate the worked examples, or file per chapter.
R9. 13-combat.qmd:389 reuses the name *Marked* for a Wound-table result with no mechanical effect, colliding with the Marked condition at 13-combat.qmd:206. ORCHESTRATOR-VERIFIED. Decide rename (preferred) or an explicit mechanical link.
R10. 15-equipment.qmd uses British "armour" in 18 places against 13 uses of "armor" in the same file, plus one in 16-armor-shields.qmd. ORCHESTRATOR-VERIFIED. Decide the house spelling and sweep, or defer.
R11. quarto-book/_extensions/heroes-of-legend/style.typ:295 still claims tables are wrapped unbreakably, contradicting the live code at :326-327 (the unbreakable wrapper was removed under #467/#84/#98). ORCHESTRATOR-VERIFIED. Comment-only, no render effect, but it misleads the next layout fix; decide correct-and-keep or delete.

**Confidence:** 0.88

## Per-topic outcomes

- t-01: ruled
- t-02: rejected
- t-03: ruled

## Resolved (per the librarian)
- t-01: Contested, ruled r-001. The Parry row's shield-reduction claim is established and the repair must not be scoped as a single-site deletion: the clause is deleted at 22:194 (M1), the site list is re-derived by whole-book search and the count restated at two carriers (22:194 and 20-bestiary.qmd:116), and the bestiary value is folded into the Guard's authored DR total or removed with its line, never blind-deleted (M2). No other chapter-22 row is reopened on this topic; only a no-third-carrier confirmation is permitted (r-001 C3).
- t-02: Rejected by a reject-majority of four refutes (f-002, f-004, f-006, f-008) against the threshold of four — terminal, with no ruling and none possible. The rejection is the council agreeing the chapter fails mirror fidelity, so the defects still stand and are carried into the plan, not dropped: the Asleep X cells at 22:93 (M4, from f-004), the Marked effect cell at 22:107 (M5, from f-008, Ends cell faithful), and the retired damage-band text f-006 found in 08-disciplines.qmd:222, 11-arcane-spells.qmd:171-175, 20-bestiary.qmd:144 and 13-combat.qmd:510 (S3-S6), with the sheet's own budget block at 22:311-322 confirmed correct and untouched.
- t-03: Contested, ruled r-002. Both defects stand and are dispatched: the omitted resource's tier values, spend procedure and dropped derived-stat line are restored at 22:147-158 and 22:249 (S1, S2), and the content-free folio 365 is removed by the one-line deletion of the standalone break at 22:118 (M3), with the corrected baseline recorded as 387 pages and chapter span folios 359-379 and acceptance conditional on a clean rebuild showing 386 pages, folio 365 content-filled, and the chapter's surviving rows intact. M3 lands in the same commit as M4 and M5.

## Dissenting views

- researcher on t-01: A scan of all 25 chapter files returns this one row as the sole carrier of the withdrawn idea, so the outlier is 194, not the owners.
- layout-expert on t-03: delete the redundant :118 break (388 pages becomes 387, Effects fills 365) ... A clean rebuild of the file at HEAD places the chapter on folios 360-379 and leaves folio 365 with no body text

## Rulings applied

- r-001 (t-01): The council must treat the Parry-row shield-reduction claim as established and must not scope the repair as a single-site deletion: the clause comes out of this sheet's Parry row outright, and any site list inherited from a mirror-scoped search must be re-derived and the repair defined per site before edits are scoped.
- r-002 (t-03): The council must treat both chapter-22 defects as established: the omitted resource values the sheet itself charges against must be restored to the sheet, and the content-free folio must be removed, with the corrected bookkeeping governing the record in place of the round-one figures.
