# Council Run 20260831-2121 — ch20 (Bestiary)

**Council:** hol-rulebook · **Chapter:** `quarto-book/chapters/20-bestiary.qmd` (322 lines)
**Verdict:** REJECTED 7-0 (refute 7 / support 0, round 1, no rulings, no judge)
**Disposition:** ONE atomic ch20 PR — mechanical micro-fix set + 3 implemented defaults + 5 considered-and-kept.

## Findings (7 voters, all refute)
- **game-architect** (f-001): save-vocab "Agility save" (264); "speed halved" → Slowed X (176); flat damage riders incl. Barbed Devil "6/9/12 + 2 fire" (194); encounter example sums off-budget (288-291); Shield +1 DR vs ch16; Fire Elemental "Vulnerable: Water" flagged (dismissed by librarian as bespoke trait).
- **researcher** (f-002): Lich 1d10 (132); Bugbear Natural Stealth mis-keyed to Guile (ch07 keys Stealth → Agility); doppelganger Deception key OK; flat +1 check bonuses; Paralyzed/Stunned 1-round durations flagged (dismissed — source durations).
- **contrarian** (f-003): dangling Bandit "Pack Tactics." (84); flat +1 vs Boon/Bane internal contradiction; DR formula vs printed natural-armor values; quick template "1-12" can't make C½ minions.
- **author** (f-004): Creating Monsters self-contradiction (1-3 vs 1-2 attacks; 1-2 vs 1 ability; DR formula twice); Additional Monsters italic taglines (voice drift); variant ability wordings (Relentless/Pack Tactics/Multiattack); Zombie "Slow" vs Slowed condition homonym; art-tracker captions.
- **editor-in-chief** (f-005): Recharge referenced 13× but never defined (ch19 writes "Recharge 5-6" divergently); heading-hierarchy split (10 ### vs ~39 run-ins; Beasts section mixes both).
- **layout-expert** (f-006): built-PDF verification — paragraph-wall stat blocks render as un-scannable 4-6-line wraps; dash split (hyphen "1-3" vs en-dash "C1–2") in Creating Monsters; pagebreaks strand sparse pages (intro alone, Dire Boar alone, Oozes/Shapechangers alone).
- **librarian** (f-007): synthesis — confirms ~15 mechanical items, 3 false positives dismissed with reasons, small design set with defaults; nothing demands a multi-file pass.

## Wall
- 0 rejections (all 7 findings pre-screen clean; prescreen.py linted every finding before ingest).

## Disposition summary
- **Mechanical (17 items):** save→check; Slowed 10; Barbed Devil rider stripped; encounter examples re-totalled (6 Wolves / Knight+6 Guards / Young Dragon+6 Cultists); Recharge defined + ch19 reconciled; ALL stat blocks promoted to headed line-per-ability form (39 run-ins → ###); Creating Monsters reconciled; template C½ gap; 1d4+1; "as an action"; taglines stripped; Stealth→Agility key; art captions stripped; "roll Fortitude"→check + Slow→Shambling; Dire Wolf Pack Tactics full text; en-dash ranges; pagebreak reflow.
- **Implemented defaults (veto-revertible):** flat +1 bonuses → Boon (Pack Tactics/Leadership/Marshal Undead/Natural Stealth/Deceptive); DR hedge added ("adjust to taste, max 6"); Shadow Stalker "Vulnerable: Light" → "Light Sensitivity".
- **Considered-and-kept (vetoable):** swarm 1 auto-damage + contact 2s (floor/row values); Fire Elemental "Vulnerable: Water"; Pixie Confusion Touch; Archmage at-will secondaries; Paralyzed/Stunned 1-round durations.

## Process notes
- Subagents wrote findings to varied paths (findings/ vs briefs/round-01/) — orchestrator reconciled before ingest; ids f-000 placeholders restamped by the engine.
- Promotion direction (vs demotion) resolved on layout-expert's built-PDF evidence.
