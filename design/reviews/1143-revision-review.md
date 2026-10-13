# Adventure catalog revision review

October 13, 2026. Implements the direction from issues #1143, #1144 and #1145.
Specific ability text and numeric assignments remain proposals for Bruce’s review.
No book layout or combat simulation is included.

## What changed

The catalog now has **322 rule cards**: 18 universal, 223 shared and 81 signatures.
Eighteen new shared cards add seven passives and eleven active utility choices.
Existing high-tier disguise, wilderness guidance, public persuasion and reconstruction
cards now describe a more substantial achievement and what happens on completion.

Every one of the **455 card records** has narrative followed by a Rules section:
322 rule cards, 20 traits, four ancestry entries, 50 origins, nine classes, eighteen
disciplines, 22 items and ten recipes. Path and index pages remain navigation rather
than cards. The short narrative is an imagined experience; adjudication belongs in Rules.
The audit checks separation, not literary quality or proof of unambiguous play.

## Coverage after revision

Same editorial rubric as [the baseline survey](1141-passive-utility-and-access.md).
The [current ledger](1143-card-survey.csv) records every shared card’s classification.

| Shared cards | Novice | Adept | Master | Total |
|---|---:|---:|---:|---:|
| Noncombat-first | 33 | 16 | 10 | 59 |
| Explicit dual-use | 13 | 13 | 13 | 39 |
| Combat, recovery or limited utility | 47 | 40 | 38 | 125 |
| Total | 93 | 69 | 61 | 223 |
| Passive action, overlapping above | 8 | 4 | 2 | 14 |

Noncombat-first plus dual-use rises from 77/205 (38%) to 98/223 (44%). The more
important change is the experience: a climber can establish a party route, a master
guide can bring companions through a completed crossing, an infiltrator can maintain
an identity across routine encounters, and a distant magical conversation is a real
new possibility. These percentages are not design quotas or measured usefulness.

## Requirements after revision

| Shared tier | No discipline | Single discipline | Mixed disciplines |
|---|---:|---:|---:|
| Novice | 7 | 84 | 2 |
| Adept | 0 | 54 | 15 |
| Master | 1 | 49 | 11 |

Both Novice hybrids require two rank-1 disciplines. Adept includes 2+1 and a modest
1+1 object-moving technique. Master includes 3+1 and 2+2 combinations. All **49**
single-discipline Master cards still require rank 3. No ability chains or class
locks were added, and signatures retain class/level-only requirements.

Twenty existing requirements changed; eight of the eighteen new abilities have
mixed requirements. Every origin pair still supplies its card’s requirements.
Mixed fields are indexed under both disciplines rather than only the first one.

## Starting access remains broad

The same 472,320 grant combinations were counted. This remains a grant-only view,
excluding origin cards already owned and excluding either stage’s DP purchases.

| Class | Baseline unowned eligible choices | Revised choices |
|---|---:|---:|
| Arcanist | 9–33 | 9–34 |
| Blade | 12–31 | 12–35 |
| Intellect | 15–33 | 15–35 |
| Leader | 12–32 | 12–35 |
| Odd | 8–33 | 8–35 |
| Protector | 10–32 | 10–34 |
| Shadow | 12–31 | 12–35 |
| Shepherd | 12–33 | 12–35 |
| Unbalanced | 11–31 | 11–34 |

Adding desirable early utility slightly expands the list even while two early
techniques now require combinations. **Bruce reviewed the maximum of 35 and judged
it a useful number of choices.** Broad starting access is therefore accepted for
this draft, not a number to reduce. Evaluate whether those choices are distinct and
worth their cost; the count alone is not evidence of excessive power. No DP prices changed.

The revised Arcanist example buys Wilderness 1 before Call a Burrower and drops two
other planned cards to pay for it. Spellblade advice now explicitly needs Flame and
Arms. The nature brawler already owns the newly required Athletics 1; the grove
keeper already owns the newly required Wilderness 1. Three additional acquisition
examples are in [Heroes between battles](../adventure-development.md).

## Precision changes worth reviewing

- Borrow the Shadow and Carry to Safety now specify movement distance and endpoints.
- Veiled Crossing explicitly moves the user and can bring one adjacent ally at the
  ally’s Reaction cost, with genuine concealment still required.
- Hold the Passage states who receives its Boon and when it ends.
- Through the Spearpoints uses a Boon to applicable opportunity defenses instead
  of extra reduction after resistance. This is a mechanical proposal, not merely editing.
- Icebound Path no longer calls for a roll with three identical results.
- Potion equipment references the full giver/receiver procedure. Book of Quiet Doors
  identifies its ten-minute activation and prevents banking repeated study benefits.
- Ambiguous duration boilerplate was replaced with timing, event or persistent-result
  language. Narrative cannot supply extra powers or override that rule text.
- Weak results on several ordinary expertise cards now explicitly provide useful
  information alongside progress. They still do not promise automatic success.

## Verification and limits

Run `python3 design/audit.py` for links, fields, narrative/Rules separation, discipline
names, prices, origin grants and path ordering. Run `python3 design/reviews/survey_1143.py`
for current classifications, tier/gate counts and access witnesses. The old
`survey_1141.py` now reads its historical Git source `9b5eb4c`; its output matches the
original survey rather than failing against a deliberately changed catalog. Keep
that commit available to reproduce the historical check.

The coverage ledger is manually classified; body edits require rereading it.
Metadata validation cannot decide whether prose is evocative or a card is worth its DP.
The existing open questions about Hidden/perception, summon resolution, opportunities
and collision geometry remain explicit. The revision does not certify balance,
complete every imaginable fantasy, or settle those foundations implicitly.
