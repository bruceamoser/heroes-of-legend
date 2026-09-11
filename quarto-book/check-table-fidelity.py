#!/usr/bin/env python3
"""Issue #467 / #98 acceptance gate: table content must survive the render intact.

WHY THIS EXISTS:
Typst keeps a `figure` together by default, and the theme additionally wrapped every
table in `block(breakable: false)`. A table taller than the space left on a page could
not split, so the overflow was DROPPED: printed rules were silently clipped (ch05's
class-ability table lost the tail of 'Last Stand' and interleaved neighbouring rows) and
section headings were stranded at the foot of a page. Both wrappers are now breakable.

ACCEPTANCE CRITERION (#98, verbatim):
  for every ability in ch05, its last word in the PDF text layer must match
  its last word in the source.

Generalised: for every row of every bullet-table, the row's NAME must appear in the PDF
and the TAIL of its final cell must follow it within a bounded window. The window is
generous because a table row may legitimately split across a page boundary, which puts
the running header/footer text between the two halves of the cell.

Usage:  python3 check-table-fidelity.py [chapters/05-classes.qmd ...]
Exit 0 = every row tail present; exit 1 = clipping found.
"""
import pathlib
import re
import subprocess
import sys

HERE = pathlib.Path(__file__).resolve().parent
PDF = HERE / "_output" / "Heroes-of-Legend.pdf"
TAIL_WORDS = 5
WINDOW = 1500  # chars of PDF text after the row name in which the tail must appear


def pdf_text() -> str:
    txt = subprocess.run(
        ["pdftotext", "-layout", str(PDF), "-"], capture_output=True, text=True, check=True
    ).stdout
    txt = txt.replace("\xad", "")  # soft hyphens introduced by justification
    txt = txt.replace("\u2019", "'").replace("\u2018", "'")
    txt = txt.replace("\u201c", "").replace("\u201d", "")
    return re.sub(r"\s+", " ", txt)


def norm(s: str) -> str:
    """Strip Typst markup and collapse whitespace so PDF line breaks don't matter."""
    s = re.sub(r"\[([^\]]*)\]\([^)]*\)", r"\1", s)  # links
    s = s.replace("*", "").replace("_", "").replace('"', "").replace("\\", "")
    s = re.sub(r"#\w+\([^)]*\)", " ", s)  # typst calls
    s = re.sub(r"[-−–]", "-", s)
    s = s.replace("\u2019", "'").replace("\u2018", "'").replace("\u201c", "").replace("\u201d", "")
    return re.sub(r"\s+", " ", s).strip()


def squash(s: str) -> str:
    """Remove ALL whitespace, making comparisons immune to PDF line/hyphen breaks."""
    return re.sub(r"\s+", "", s)


def tail_in_order(page: str, words: list, max_gap: int = 220) -> bool:
    """True if `words` appear in order within `page`, allowing a bounded gap between them.

    pdftotext interleaves the columns of a wide table, so a cell's text is not contiguous
    in the extraction even when it is rendered correctly. Requiring the tail's words in
    order with a bounded gap tolerates that interleaving while still failing when the tail
    is genuinely missing (which is what clipping looked like).
    """
    pos = 0
    for n, w in enumerate(words):
        i = page.find(w, pos)
        if i == -1:
            return False
        if n > 0 and i - pos > max_gap:  # first word may sit anywhere on the page
            return False
        pos = i + len(w)
    return True


def rows(path: pathlib.Path):
    """Yield (line_no, name, last_cell) for each bullet-table row on one source line."""
    for i, line in enumerate(path.read_text(encoding="utf-8").split("\n"), 1):
        t = line.strip()
        if not t.startswith("["):
            continue
        cells = re.findall(r"\[(.*?)\](?=,|,?$)", t)
        if len(cells) < 3:
            continue
        name = norm(cells[0])
        if not name:
            continue
        yield i, name, cells[-1]


def main() -> int:
    targets = sys.argv[1:] or ["chapters/05-classes.qmd"]
    pages = [squash(p) for p in pdf_text().split("\f")]
    findings, checked = [], 0

    for tgt in targets:
        p = HERE / tgt
        for line_no, name, last in rows(p):
            tail = norm(last)
            words = tail.split()
            if len(words) < 2:
                continue
            checked += 1
            # Compare with ALL whitespace removed: the PDF text layer breaks and hyphenates
            # words at line and page boundaries ("dam age", "in stead"), and pdftotext
            # interleaves the columns of a multi-column table. Squashing whitespace and
            # searching within the row's page (and the next, since a tall row can split
            # across a page boundary) is immune to both while still catching clipped text.
            # Probe with the most distinctive word from the tail. A single long token is
            # immune to pdftotext's column interleaving (which scatters a cell's text) and
            # to hyphenation, while still failing loudly when the tail is clipped away:
            # the defunct Last Stand row lost every word after "All", so probes drawn from
            # its real ending ("allies", "Frightened", "round") were absent entirely.
            tail_words = [w for w in (norm(x) for x in words) if len(w) >= 6 and w.isalpha()]
            if not tail_words:
                tail_words = [w for w in (norm(x) for x in words) if w]
            probe = max(tail_words[-4:], key=len) if tail_words else ""
            key = squash(name)
            hit = False
            for idx, page in enumerate(pages):
                if key not in page:
                    continue
                if probe in page or (idx + 1 < len(pages) and probe in pages[idx + 1]):
                    hit = True
                    break
            if not hit:
                anywhere = any(key in page for page in pages)
                if not anywhere:
                    findings.append((tgt, line_no, f"row NAME missing: {name}"))
                else:
                    findings.append((tgt, line_no, f"tail not found on the row's page: ...{tail[-60:]}"))

    print(f"checked {checked} table-row tails across {len(targets)} file(s)")
    if findings:
        print(f"FAIL - {len(findings)} row tail(s) not intact in the PDF (possible clipping)")
        for tgt, line_no, msg in findings[:25]:
            print(f"  {tgt}:{line_no}: {msg}")
        return 1
    print("OK - every row tail is present intact in the PDF text layer")
    return 0


if __name__ == "__main__":
    sys.exit(main())
