# Heroes of Legend

We are writing a fantasy TTRPG, not a software product. Bruce is the lead designer.
Read [.github/copilot-instructions.md](.github/copilot-instructions.md) for the
current source map, authoring guidance and workflow.

- Canonical rules and catalogs: `design/**/*.md`.
- Books: `design/player-book/` and `design/da-book/`; both use Typst.
- Core roll: 3d6 + one attribute, with Boons/Banes; no skill bonus.
- Starter-kit releases contain both books. Git history is the archive.
- Workflow: issue → branch → implement → PR → independent review → squash merge.
- Track every rules/content decision and change in issues on
  `bruceamoser/heroes-of-legend-foundry`; link the downstream issue from the source PR.
