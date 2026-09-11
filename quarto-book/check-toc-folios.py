#!/usr/bin/env python3
"""Acceptance gate for the book's page-numbering scheme (issues #71 / #477).

THE SCHEME (decided 2026-09-11): continuous folios.
  * front matter (physical pages 1-14) carries roman folios I-XIV
  * the body carries Arabic folios continuing the same count (15, 16, 17, ...)
  * therefore the printed folio always EQUALS the physical/PDF page number, and every
    table-of-contents reference must equal the folio of the page it points at

This gate checks exactly that: it reads every TOC page reference, then asserts that the
folio printed on that physical page renders the same number.

SCOPE — read before trusting a failure: this gate encodes the CONTINUOUS scheme's model,
i.e. "a TOC reference is a physical page index". It is not a general validator. Under the
discarded restart scheme the TOC legitimately referenced *reset-space* numbers (Attributes
-> 39, the folio of physical page 53), so running this gate against that scheme reports a
huge number of false failures. Its job is to pin the continuous scheme and catch any
regression that reintroduces a counter reset; treat a failure here as "numbering is no
longer continuous", not as "this many entries are broken".

Usage:  python3 check-toc-folios.py     exit 0 = every reference matches its folio.
"""
import pathlib
import re
import subprocess
import sys

HERE = pathlib.Path(__file__).resolve().parent
PDF = HERE / "_output" / "Heroes-of-Legend.pdf"
# TOC occupies the front matter; search a generous window of the opening pages.
TOC_PAGES = (3, 9)
FRONT_MATTER_LAST = 14


def page_text(pg: int) -> str:
    return subprocess.run(
        ["pdftotext", "-layout", "-f", str(pg), "-l", str(pg), str(PDF), "-"],
        capture_output=True, text=True, check=True
    ).stdout


def roman(n: int) -> str:
    vals = [(1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100, "C"), (90, "XC"),
            (50, "L"), (40, "XL"), (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")]
    out = ""
    for v, s in vals:
        while n >= v:
            out += s
            n -= v
    return out


def folio(pg: int) -> str:
    """The folio a page should print under the continuous scheme."""
    lines = [l.strip() for l in page_text(pg).split("\n") if l.strip()]
    if not lines:
        return ""
    last = lines[-1]
    m = re.search(r"—\s*([IVXLCDM]+|\d+)\s*—", last) or re.search(r"^\s*([IVXLCDM]+|\d+)\s*$", last)
    if not m:
        m = re.search(r"([IVXLCDM]+|\d+)\s*$", last)
    return m.group(1) if m else f"<unreadable: {last[:40]!r}>"


def main() -> int:
    # Collect TOC entries: a title followed by a page reference at the line end.
    refs = []
    for pg in range(TOC_PAGES[0], TOC_PAGES[1] + 1):
        for line in page_text(pg).split("\n"):
            m = re.search(r"^(.*?)[\s.·]{3,}(\d+)\s*$", line.rstrip())
            if m and m.group(1).strip():
                refs.append((m.group(1).strip()[:58], int(m.group(2))))

    if not refs:
        print("FAIL - no table-of-contents references parsed; TOC pages may have moved")
        return 1

    bad = []
    for title, ref in refs:
        want = roman(ref) if ref <= FRONT_MATTER_LAST else str(ref)
        got = folio(ref)
        if got != want:
            bad.append((title, ref, want, got))

    print(f"checked {len(refs)} TOC reference(s) between pages {TOC_PAGES[0]}-{TOC_PAGES[1]}")
    if bad:
        print(f"FAIL - {len(bad)} reference(s) do not match the folio of their target page")
        for title, ref, want, got in bad[:25]:
            print(f"  p{ref}: TOC says {ref}, folio prints {got!r} (expected {want!r})  <- {title}")
        return 1
    print("OK - every TOC reference equals the folio of the page it points at")
    return 0


if __name__ == "__main__":
    sys.exit(main())
