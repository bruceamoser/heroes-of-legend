---
name: review-pr
description: Review rules, source and PDF integrity for Heroes of Legend.
---

# Review rules, source and PDF integrity

Automatically review each book PR before merging. Check the current diff against the issue, current rules and Bruce’s decisions. Verify links, IDs, card counts, attack and defense perspectives, conditions, requirements and equipment grants. Run affected audits. For shared-source or deletion work, verify both builds for the reviewed content. Inspect rendered pages, art uniqueness and summon markers. The creature-art manifest must cover every creature and preserve stable VTT references. Check language rules and grants in both books when changed. Verify release bundles contain both PDFs and matching checksums when the PR changes release artifacts. Treat balance as a playtest question.

Resolve findings within scope and verify the fixes. Ask Bruce when a design decision or unresolved concern requires his judgment. When checks pass and findings are resolved, continue to the squash-merge workflow under Bruce’s standing authorization.

Follow [project instructions](../../../.github/copilot-instructions.md).
