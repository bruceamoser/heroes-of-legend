#!/usr/bin/env python3
"""Issue #467 / #84 measurement: section headings stranded at the foot of a page.

A heading is 'stranded' (orphaned) when it is the last thing on a page and its section's
content starts on the following page. Before the fix, style.typ wrapped every table in
`block(breakable: false)` inside a figure that Typst also kept together, so a heading
followed by a table that did not fit was left alone at the page bottom.

Usage:  python3 check-orphan-headings.py        (prints the count and the list)
Not a pass/fail gate: the count is a quality metric, reported for before/after comparison.
"""
import pathlib
import re
import subprocess

HERE = pathlib.Path(__file__).resolve().parent
PDF = HERE / "_output" / "Heroes-of-Legend.pdf"
FOOTER = re.compile(r"^(—\s*\d+\s*—|\d+)$")
RUNNING_HEAD = "HEROES OF LEGEND"


def headings() -> set:
    """Collect every heading title from the chapter sources."""
    out = set()
    for p in (HERE / "chapters").glob("*.qmd"):
        for line in p.read_text(encoding="utf-8").split("\n"):
            m = re.match(r"^(#{1,5})\s+(.+?)(\s*\{#.*\})?\s*$", line)
            if m:
                t = re.sub(r"[*_`\[\]]", "", m.group(2)).strip()
                if t:
                    out.add(t)
    return out


def main() -> int:
    hs = headings()
    txt = subprocess.run(
        ["pdftotext", "-layout", str(PDF), "-"], capture_output=True, text=True, check=True
    ).stdout
    stranded = []
    for n, page in enumerate(txt.split("\f"), 1):
        lines = [l.strip() for l in page.split("\n")]
        lines = [l for l in lines if l and not FOOTER.match(l) and RUNNING_HEAD not in l]
        if not lines:
            continue
        last = lines[-1]
        clean = re.sub(r"^❧\s*", "", last).strip()
        if clean in hs:
            stranded.append((n, clean))

    print(f"{len(stranded)} heading(s) sit last on a page (orphaned) across the book")
    for pg, t in stranded[:30]:
        print(f"  p{pg}: {t}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
