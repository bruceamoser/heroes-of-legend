#!/usr/bin/env python3
"""Build, audit and package both starter-kit books. Never publishes a release."""
import argparse, hashlib, json, os, shutil, subprocess, sys, zipfile
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]

def run(*args):
    subprocess.run([str(a) for a in args], cwd=ROOT, check=True)

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--package-only', action='store_true', help='Audit existing builds and package them; no compilation')
    parser.add_argument('--require-clean', action='store_true', help='Reject a dirty source tree before packaging')
    args = parser.parse_args()
    version = json.loads((ROOT/'release/version.json').read_text())
    dirty = bool(subprocess.check_output(['git','status','--porcelain'], cwd=ROOT, text=True).strip())
    if args.require_clean and dirty:
        raise SystemExit('Commit reviewed source changes before producing a clean release package.')
    py = sys.executable
    pdf_py = os.environ.get('PDF_PYTHON', py)
    for script in ('design/audit.py','design/bestiary/audit.py','design/bestiary/art/audit.py','scripts/audit_repository.py'):
        run(py, ROOT/script)
    if not args.package_only:
        typst = os.environ.get('TYPST') or shutil.which('typst')
        if not typst:
            raise SystemExit('Provide Typst 0.15.1 on PATH or set TYPST.')
        actual = subprocess.check_output([typst,'--version'], text=True)
        if not actual.startswith('typst 0.15.1 '):
            raise SystemExit('This release requires Typst 0.15.1; got '+actual.strip())
        os.environ['TYPST'] = typst
        run(py, ROOT/'design/da-book/assemble.py')
        run(py, ROOT/'design/da-book/draw_diagrams.py')
        run(py, ROOT/'design/player-book/build.py', '--compile')
        run(py, ROOT/'design/da-book/build_pdf.py', '--compile')
    run(py, ROOT/'design/da-book/assemble.py', '--check')
    run(py, ROOT/'design/player-book/audit.py')
    run(pdf_py, ROOT/'design/da-book/audit_pdf.py')
    out = ROOT/'dist'/('v'+version['version']); out.mkdir(parents=True, exist_ok=True)
    books = {
        'Heroes-of-Legend-Players-Book.pdf': ROOT/'design/player-book/output/heroes-of-legend-players-book.pdf',
        'Heroes-of-Legend-DA-Guide-and-Bestiary.pdf': ROOT/'design/da-book/output/heroes-of-legend-da-guide-bestiary.pdf',
    }
    records = []
    for name, source in books.items():
        destination = out/name; shutil.copy2(source,destination)
        info = subprocess.check_output(['pdfinfo',str(destination)],text=True)
        pages = int(next(line.split(':',1)[1] for line in info.splitlines() if line.startswith('Pages:')))
        front = subprocess.check_output(['pdftotext','-f','2','-l','2',str(destination),'-'],text=True)
        if 'StarterKitv'+version['version'] not in ''.join(front.split()):
            raise RuntimeError('PDF edition differs from release/version.json: '+name)
        records.append(dict(file=name,pages=pages,bytes=destination.stat().st_size,sha256=sha(destination)))
    notes = out/'READ-ME.txt'
    notes.write_text(f'Heroes of Legend Starter Kit v{version["version"]}\n\n'
                     'Includes the Player’s Book and Dungeon Architect’s Guide & Bestiary.\n'
                     'Start with the Player’s Book; the DA uses the companion for adventures and creatures.\n'
                     'Both books cover levels 1–10. This is a digital playtest edition.\n'
                     'Creature CV and encounter budgets remain estimates for table testing.\n'
                     'Game design: Bruce A. Moser.\n')
    manifest = out/'manifest.json'
    manifest.write_text(json.dumps(dict(version=version['version'],date=version['date'],
        source_commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),
        source_dirty=dirty,books=records),indent=2)+'\n')
    members = [out/n for n in books] + [notes,manifest]
    sums = out/'SHA256SUMS.txt'
    sums.write_text(''.join(f'{sha(p)}  {p.name}\n' for p in members))
    archive = out/f'Heroes-of-Legend-Starter-Kit-v{version["version"]}.zip'
    with zipfile.ZipFile(archive,'w',compression=zipfile.ZIP_STORED) as z:
        for p in members+[sums]: z.write(p,p.name)
    # The external list also verifies the bundle; its internal list verifies members.
    with sums.open('a') as f: f.write(f'{sha(archive)}  {archive.name}\n')
    with zipfile.ZipFile(archive) as z:
        if z.testzip() is not None: raise RuntimeError('Archive integrity check failed')
        for record in records:
            if hashlib.sha256(z.read(record['file'])).hexdigest()!=record['sha256']:
                raise RuntimeError('Packaged PDF differs from its audited source')
    print(json.dumps(dict(output=str(out),books=records,bundle=archive.name,source_dirty=dirty),indent=2))

if __name__ == '__main__': main()
