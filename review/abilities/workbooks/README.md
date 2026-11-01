# Heroes of Legend — Excel review set

Generated 2026-10-26 from the read-only `heroes-of-legend` reference repository. No source markdown was modified.

Start at `../START_HERE.md`; the control set and SOP are in `../`.

## Files

| File | Content | Review rows |
|---|---|---|
| `00_Index_and_Review_Findings.xlsx` | Index, findings, flagged cards, coverage, method | 32 findings / 95 flags |
| `10_Ancestry_Dwarf.xlsx` | Dwarf ancestry | 5 traits / 10 pairs |
| `11_Ancestry_Elf.xlsx` | Elf ancestry | 5 traits / 10 pairs |
| `12_Ancestry_Halfling.xlsx` | Halfling ancestry | 5 traits / 10 pairs |
| `13_Ancestry_Human.xlsx` | Human ancestry | 5 traits / 10 pairs |
| `20_Class_Arcanist.xlsx` | Arcanist class signatures | 9 signatures |
| `21_Class_Blade.xlsx` | Blade class signatures | 9 signatures |
| `22_Class_Intellect.xlsx` | Intellect class signatures | 9 signatures |
| `23_Class_Leader.xlsx` | Leader class signatures | 9 signatures |
| `24_Class_Odd.xlsx` | Odd class signatures | 9 signatures |
| `25_Class_Protector.xlsx` | Protector class signatures | 9 signatures |
| `26_Class_Shadow.xlsx` | Shadow class signatures | 9 signatures |
| `27_Class_Shepherd.xlsx` | Shepherd class signatures | 9 signatures |
| `28_Class_Unbalanced.xlsx` | Unbalanced class signatures | 9 signatures |
| `29_Class_Warden.xlsx` | Warden class signatures | 9 signatures |
| `30_Universal_Abilities.xlsx` | Universal shared abilities | 18 rows |
| `31_Novice_Abilities.xlsx` | Novice (level 1) shared abilities | 133 rows |
| `32_Adept_Abilities.xlsx` | Adept (level 3) shared abilities | 91 rows |
| `33_Master_Abilities.xlsx` | Master (level 7) shared abilities | 87 rows |

## Control set

The process, tracker, ledger, templates and release checklist live in `review/abilities/`:

- `review/abilities/README.md` — index of the control set
- `review/abilities/ABILITIES_REVIEW_SOP.md` — the revised batch-build SOP
- `review/abilities/AREA_TRACKER.md` — 18 areas, issues, branches and status
- `review/abilities/CHANGE_LEDGER.csv` — authoritative change record
- `review/abilities/CHANGE_LEDGER_SCHEMA.md` — column rules and validation checks
- `review/abilities/BASELINE.md` — starting SHAs, versions, source pin and rollback point
- `review/abilities/RELEASE_CHECKLIST.md` — the one-time final build/release gate
- `review/abilities/DECISION_LOG.md` — decisions already made and why
- `review/abilities/OPEN_QUESTIONS.md` — open blockers
- `review/abilities/WORKBOOK_MANIFEST.csv` — what each workbook contains
- `review/abilities/templates/` — epic, area issue, release PR and Foundry PR bodies

## How to use

1. Open the index workbook and read **Findings**. Use **Flagged Cards** as the working triage list.
2. Use the ancestry and class workbooks for character-facing review. Each choice has a design read and a suggested change.
3. Use the tier workbooks for catalog review. **Review Queue** isolates flagged rows; **Requirements** and **Families** expose the structural questions.
4. Every data sheet has a **Decision** dropdown (Keep / Revise / Cut / Unsure) and a blank **Your notes** column.
5. Use **Stable ID** to link a row to a field-level change on the workbook's **Change Log** sheet, then merge it into `review/abilities/CHANGE_LEDGER.csv` before the area PR.

## Highest-value findings

- **F02 (High)** — Eight shared cards have no discipline requirement beyond the six stated 1-DP exceptions: seven 2-DP Novice skill cards and One More Dawn (Master, 8 DP). _Suggested:_ Decide whether a 'General' category exists. If yes, state its price, cap and tier rules in card-conventions. If not, assign discipline requirements or reprice the seven Novice cards; handle One More Dawn separately (F03).
- **F03 (High)** — Master tier, 8 DP, no requirement, once-ever +1 Grit that never replenishes spent Grit. _Suggested:_ Either move it to Novice at 2 DP as a once-ever grit purchase, or keep it at Master and add a second, capstone-scale benefit plus a discipline requirement.
- **F04 (High)** — Repeatable +1 maximum HP, one purchase allowed at each level, no upper cap and no discipline requirement. _Suggested:_ Cap it (for example three purchases), make it a one-time +2 HP, or turn it into a training track with an explicit maximum. Remove the 'missed purchases cannot be banked' clause if the intent is simply gradual toughness.
- **F05 (High)** — Master tier, 8 DP, Armor 3, Reaction solely to 'remain standing' when an effect would knock you prone. _Suggested:_ Move it to Adept (4 DP) or broaden it: remain standing and gain Stability 1, or reduce forced movement by 1. If kept, state why it is worth a Master slot.
- **F06 (High)** — Requires 'Craft 1; known compatible crafting card', a card prerequisite. _Suggested:_ Remove the 'known compatible crafting card' clause (Craft 1 is enough), or explicitly approve and document this as the one chain exception.
- **F07 (High)** — Near-duplicate cards: both are Craft 1, 2 DP, Main Action, Knowledge, grant tools and two ordinary recipes, use the same recipe list and produce the same 1/2/3 progress outcomes. The substantive difference is salvage substitution and a Strong rider on Make Something Useful. _Suggested:_ Merge into one card, or split the niches cleanly: Make Something Useful = field improvisation with salvage; Trail Workshop = portable workshop with better setup/reuse but no salvage. Cut the redundant text either way.
- **F01 (Medium)** — Player-facing cards still contain review-stage language: 'Proposal: target 12', 'Proposal: target 6' and 'Proposed NPC defense attribute: ...' on 16 cards. _Suggested:_ Replace with definite wording: 'Typical target 12', 'Target 6 (DA judgement)' and 'NPC defense attribute: Agility'. If the number is genuinely advisory, label it 'Typical' rather than 'Proposal'.
- **F08 (Medium)** — The summon catalog is a 6 creature-type x 3 tier matrix of near-identical 232-word cards. Several titles were changed to 'Summon X — Tier' while IDs and filenames retain the old evocative names (call-a-burrower, the-ancestors-stand, the-walking-toolbox, etc.). _Suggested:_ Use one shared summon procedure plus six type records (or a single matrix card with type and tier columns), then keep only the type-specific lines. Align title, ID and filename, or document stable IDs with a 'formerly called' note.
- **F09 (Medium)** — The six treatment cards are near-identical, but Treat Soft Tissue is Type Skill instead of Recovery, uses 'Self or one willing patient' instead of 'One wound listing X', and is 97 words versus 145-146 for the others. _Suggested:_ Standardize the template: Type Recovery, target 'One wound listing Soft Tissue', same time/once-per-day/outcome wording. Consider one 'Treat Wound' card with a wound-type choice.
- **F10 (Medium)** — Forage Woodland is Type Skill instead of Skill / Utility and is 108 words versus 139-141 for the other three. _Suggested:_ Standardize Type and template. Consider one 'Forage' card that works in any viable terrain, with a Bane or reduced yield in poor terrain, instead of four terrain-specific purchases.
- **F11 (Medium)** — Halfling is HP +1 and Speed 5. Bigger on the Inside now raises HP, but no Halfling trait raises Speed, and the ancestry still has the lowest base HP/Speed. _Suggested:_ Keep the +1 HP on Bigger on the Inside. Consider a Speed trait or a small always-on movement benefit if Halfling still feels slow. If the gap is intentional, state the luck/stealth compensation in the ancestry text.
- **F13 (Medium)** — Once per day, before any attribute roll, gain 1 Boon. This is the broadest ancestry trait in the game. _Suggested:_ Monitor at the table. If it dominates, make it once per scene, require a roll with a meaningful consequence, or limit it to non-attack rolls. Keep it if Halfling needs the power (see F11).
- **F14 (Medium)** — Three universal cards use action labels outside the five standard labels: 'Main Action or Maneuver', 'Action conversion' and 'Varies'. _Suggested:_ Add a secondary 'Action detail' field for compound costs, or define the labels in the conventions. Convert an Action reads like a rules procedure, not an ability; consider moving it to the combat chapter.
- **F15 (Medium)** — The four basic attacks have Tier Universal but Type Attack; the other fourteen universal cards have Type Universal. _Suggested:_ Make Type functional (Attack, Defense, Movement, Utility) for all cards and let Tier/availability carry 'Universal'; or add a Universal tag to the four attacks and document the distinction.
- **F16 (Medium)** — Three Master cards require only two rank-2 disciplines (Mind 2 + Guard 2; Mind 2 + Storm 2; Storm 2 + Athletics 2). _Suggested:_ Confirm the intent. If these are meant to be broad Master options, add a policy note. If not, raise one requirement to rank 3. A Voice across the Valley is also noncombat utility; consider Adept if it is not meant to be a Master capstone.
- **F17 (Medium)** — Five shared cards carry Type Skill / Attack but make no attack roll; they only set up or improve a later attack. _Suggested:_ Add a Setup tag for attack-support cards, or document that Attack includes 'sets up an attack'. Apply the same rule to signature Tags so the taxonomy is predictable.
- **F18 (Medium)** — Ten signature abilities are clear power spikes: a level-1 intercept, Aid for two allies, repeatable free attacks, a round of untargetability, party-wide movement, an 8-hour watch buff, and 2-Boon reactions. _Suggested:_ Playtest these first. Consider once-per-round limits, adjacency requirements, shorter durations, or 1 Boon instead of 2 where the spike is largest. Keep the fantasy; tighten the repeatability.
- **F19 (Medium)** — Several Master or Adept signature choices are simple riders or narrow utility: a 2-square push, a 2-square push plus move, an anti-grapple maneuver, a lockpicking card and a trail-concealment card. _Suggested:_ For each, either add a second clause that broadens the moment (condition, ally benefit, alternate use) or accept it as a deliberate specialist pick and say so in the class guidance.

## Scope and caveats

- Static review, not a playtest. Balance comments are editorial and provisional; approval of content is not proof of balance. A structural audit is not balance evidence, and CV/encounter budgets remain estimates.
- These workbooks are review artifacts, not a rules source. The design markdown remains authoritative. No source file was modified.
- Covers 419 cards, 20 ancestry traits, 10 classes and 18 disciplines.
- Shared-tier workbooks exclude the 90 class signatures; signatures are reviewed in the class workbooks.
- Link integrity, DP/tier agreement, required fields and requirement parsing were checked automatically; see the Method sheet in the index.

## Integrity snapshot

- **Class signature links: PASS** — 90/90 linked; 0 title/class/tier problems; 0 unlinked signatures.
- **Ancestry trait links: PASS** — 20/20 linked; 0 missing.
- **Tier / DP agreement: PASS** — All cards use 1/2/4/8 DP; six Novice cards use the stated 1-DP exception.
- **Required fields: PASS** — Action, attribute, target, duration, limits, requirements and type present on all 419 cards; Tags present on all 90 signatures.
- **Title / ID drift: PASS** — No non-summon title/ID drift. The 11 summon cards are documented separately in F08.
