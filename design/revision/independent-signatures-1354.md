# Independent class signatures — #1354

Source issue: [book #1354](https://github.com/bruceamoser/heroes-of-legend/issues/1354). Implementation: [Foundry #330](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/330).

## User decision

Each class signature is an individual ability. Choose one without DP at each of levels 1, 3 and 7 from that milestone's class choices. Earlier signatures are not prerequisites, automatic grants or replaced versions. A brief additional benefit conditioned on another separately learned signature is allowed. Do not repeat the other ability's rules inside the card.

This supersedes the foundation bundling, conditional component copies and highest-choice-per-line presentation in rewrite #299. The underlying ability identities and milestone schedule remain unchanged.

## Source and implementation

All ninety cards carry only their own complete procedure. Seventeen higher-level procedures needed independent activation, targets, costs or effects, rather than simply deleting the repeated foundation. These are Reading the Weave, Press On, Return Stroke, Twofold Making, Predict the Motion, Masterwork Bond, Shatter the Guard, Pact's Claim, Restoring Hands, Rebuking Light, Sheltering Hands, Hamstring, Shape of the Wild, Great Shape, Pain Feeds the Fire, Deathless Rage and Through Bramble. Their revisions reuse the existing procedure's numbers and requirements where needed; they grant no separate earlier ability.

Open the Circle, Careful Transfer and Twitch Reflexes also require explicit wording around references to earlier choices. Optional interactions identify the separately learned signature by name.

The machine-readable signature index uses schema 2 with one rulesMarkdown body for each signature. IDs and level gates are unchanged. Importers must grant only selected IDs, retain every selected signature, and never expand an earlier foundation or collapse selections by a thematic line. Both books use the same source cards. Workshop and native packs must import the reviewed source revision before publication.

## Verification

Source audit checks ninety unique choices, three per class per milestone, matching card/index text, independent class prerequisites and absence of bundled headings or grant metadata. Both books must build and pass their existing audits. Inspect the rendered Protector cards and representative formerly dependent signatures before merge. The native engine must test independent cross-theme selections and retained earlier choices, followed by its catalog and runtime checks.

## Completed source review

All ninety signature/card pairs passed the independent-choice audit. Standard source, bestiary, artwork, repository and 272 worked-example checks passed. Both Typst books rebuilt: Player’s Book 278 pages and DA Guide 310 pages. Both PDF audits and per-entry transcription checks passed. Rendered Player pages 33, 43 and 46 were inspected for complete rules, legibility and intact two-column cards; the final Protector and Intellect pages were rechecked after the last changes.

The author review retained optional higher-choice interactions for Twitch Reflexes with Return Stroke and Shatter the Guard with Predict the Motion, alongside the healing, binding, transformation and rage interactions. Binding rituals explicitly retain their 1 SP cost. This verifies source consistency and presentation, not playtest balance. Native implementation and runtime acceptance remain separate in Foundry #330.
