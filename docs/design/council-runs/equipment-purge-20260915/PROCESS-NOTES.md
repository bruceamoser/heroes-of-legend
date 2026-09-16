# Round-1 integrity violation — orchestration record

**Finding:** `f-005` (`researcher-r1.json`, stance `support`, topic `t-03`)
**Violation:** fabricated quotation presented as verbatim.

The finding's second evidence item declares two sources and prints, in a single
`quote_or_excerpt`:

> `*Starting Kit:* Battleaxe, chain mail, shield, smith's tools.`
> `*Starting Kit:* Longbow, leather armor, shield, quiver of 20 arrows.`

The first line is real (`05-classes:59`). The second **does not exist anywhere in the book.**

## Orchestrator verification (not the lens's self-report)

```
grep -rn "quiver of 20 arrows" quarto-book/chapters/*.qmd   ->  no match
grep -rn "Starting Kit" quarto-book/chapters/*.qmd          ->  9 lines: 05:59,104,156,201,246,293,340,411,464
```

The nine real starting-kit lines, verbatim:

| Line | Kit |
|---|---|
| `05:59` | Battleaxe, chain mail, shield, smith's tools |
| `05:104` | Shortsword, dagger, leather armor, thieves' tools |
| `05:156` | Arcane focus, dagger, scholar's robes, focus pouch, spellbook |
| `05:201` | Shortsword, holy symbol, leather armor, healer's kit |
| `05:246` | Shortsword, spellbook, scholar's robes, focus pouch, ink & pen |
| `05:293` | **Shortbow**, dagger, leather armor, thieves' tools, 20 arrows |
| `05:340` | Longsword, spear, leather armor, shield |
| `05:411` | Spear, focus pouch, scholar's robes, six vials of volatile reagents |
| `05:464` | Two daggers, 6 throwing daggers, leather armor, thieves' tools, disguise kit, 50 ft silk rope, grappling hook, smoke bomb |

The invented line is a splice: the ranged class's real line (`05:293`) carries a **shortbow and
no shield**; the shield and the `Longbow` come from the smith's and leader's lines. No class
carries a longbow and a shield together.

## Disposition

The finding's **counts were independently reproduced** by running its own instrument
(`_researcher-r1-verify.sh` prints 400 lines / 644 occurrences / 17-8-37-7-8 table rows), so its
measurement stands.

Its **quotation does not.** `f-005` is recorded as *support, evidence partially invalidated*:
the splice is the only part of the finding that cites a class-kit line it actually needed to
carry its point, so the support stance rests on weaker footing than the ledger shows.

The later round-2 contrarian shift and the librarian's counter-example were filed against the
finding's *argument*, not its evidence, so neither inherits the defect.

## Method note for future runs

Both integrity failures in this run came from the same cause: **the run was scoped to nine
source files while the questions asked of it are book-wide.**

- One lens concluded a name was invented (`Lyra`) because she is absent from the nine files.
  She is real: 41 mentions across seven chapters incl. `13` and `14`.
- One lens concluded the *Light* property had no consumer procedure "anywhere in the nine
  chapters" and recommended deleting it. The consumer is `13-combat:270-292`, a full
  Two-Weapon Fighting section that requires the property on the off-hand weapon.
  `13-combat` was not in the source set.
- The one fabricated quote was a splice of two real lines, not a phantom, so it is a different
  failure: careless assembly under a verbatim contract rather than a scope error.

**Rule for the next run:** when a topic's question is book-wide, scope the sources book-wide, or
state the scope in the problem statement and forbid conclusions of the form "no consumer exists".
A lens that reasons "nowhere in the sources" is answering a narrower question than the one asked.

---

## ADDENDUM - orchestrator self-audit against the sealed rulings (2026-09-15)

Written after the run was closed. The orchestrator's first oral summary of r-001/r-002/r-003 to the
principal did NOT survive comparison with `judge/rulings.json`. Recorded here because a wrong summary
of a binding ruling is worse than no summary: the principal acts on it.

### What the orchestrator got wrong

| Ruling | Orchestrator's summary | What the sealed ruling actually says |
|---|---|---|
| r-001 | "Kit completeness: kit invites curated picks and does not deliver them. Prefer priced Armament options over more free text; a property menu must be honestly priced." | The kit is an **incomplete substitute**. Five mutually exclusive Armament options cannot hold a pair or triple loadout. Resolution is a choice: **extend the Armament line OR declare extra weapons free fiction outside the budget.** The "prefer priced options over free text" preference was INVENTED; it is not in the ruling. |
| r-002 | "All seven properties must relocate rather than vanish." | Residue is **real but mixed**. Finesse substitution, the two-handed two-slot cost and the general armour band **already survive item-independently**. What does not survive: the ten property-bearing rows, the per-item range column, the Discipline-requirement column. |
| r-003 | "08:192's requirement must be withdrawn (nothing consumes it); the dead ranks are swept with the rows." | The armour gate must be **adjudicated explicitly** - either "Disciplines gate cards, not gear" OR give the armour tables a real requirement column. The dead ranks are a **balance decision with an owner**, not decoration to be deleted. |

Also corrected: the armour slot count. The orchestrator said four distinct values; the ch16 table holds
**three** (Light all 2, Medium 2/3, Heavy 3/4), so no weight-class rule reproduces the column. Condition
3 of r-002 rests on this and the count is right.

### Where the JUDGE is wrong, for the same reason this run has a PROCESS-NOTES file at all

r-002 condition 6 states: *"Do not assume a pre-existing card field will absorb the residue; the supplied
chapters show no such field."*

**That field exists.** The council's source set (15, 16, 08, 21, 22, 17, 20, 02, 05) omitted the chapters
that carry it:

- `19-gm-guidance.qmd:557` documents **`Kit`** as a card field: *"The gear this card assumes, e.g.
  focus:arcane, focus:holy, or weapon:two-hand."*
- **62 cards actually carry a `*Kit:*` field** - `09-talents-abilities` 12, `11-arcane-spells` 30,
  `12-divine-spells` 20.

This is the third instance of the same failure in this run: a sub-corpus cannot answer a whole-corpus
question. It is the same root cause that produced the "Lyra is invented" error and the "Light has no
consumer" error. The judge's caution is still partly sound - the Kit field is documented in ch19 prose
and no card *table* carries a Kit column - but "no such field" is false and must not gate the design.

Confirmed independently by the orchestrator: `15:25` lists the tag values (`weapon:unarmed`,
`weapon:one-hand`, `weapon:two-hand`, `weapon:ranged`, `shield`, `focus:arcane|holy|primal`), and
`02:210` already instructs the player at creation to *"Record your weapon properties and your armor's
slot cost."* The destination for the object-to-property mapping therefore exists and is already
instructed; it is per-character, which is what equipment-as-flavour requires.

### Confirmed correct in the rulings

- **Two permission models** (`r-003`): `08:196` asserts item entry requirements (Dagger 1 Blades,
  Plate 3 Armor) while `15:196` releases class kit gear from prerequisites outright. Both live.
- **Asymmetric gate register**: weapons tabbed in both weapon tables, shields tabbed at `22:359-362`,
  armour tabbed nowhere.
- **Mounts and vehicles must survive** (`r-003` cond. 5): `15:324-394` (Mounts, Mounted Combat,
  Vehicles) carries no permission gate and has no other home.
