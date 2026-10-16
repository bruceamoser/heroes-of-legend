"""Two-pass illustrated proof export; preserves the full-resolution source assets."""
import json, subprocess, tempfile, importlib.util, sys, os, collections, hashlib
from pathlib import Path
from space_art import plan

def export(typst, root, book):
 pdf_python=os.environ.get('PDF_PYTHON') or sys.executable
 if not os.environ.get('PDF_PYTHON') and importlib.util.find_spec('pypdf') is None:
  bundled=Path('/home/bruce/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/bin/python3')
  if bundled.exists():pdf_python=str(bundled)
  else:raise SystemExit('Install pypdf and Pillow, or set PDF_PYTHON to a Python runtime containing them.')
 fills=book/'generated/space-art.json';fills.write_text('[]\n')
 with tempfile.TemporaryDirectory(prefix='hol-book-') as tmp:
  raw=Path(tmp)/'layout.pdf'
  command=[typst,'compile','--root',str(root),'--font-path',str(book/'fonts'),str(book/'book.typ'),str(raw)]
  subprocess.run(command,check=True)
  art=json.loads(subprocess.check_output([typst,'eval','--root',str(root),'--font-path',str(book/'fonts'),'--in',str(book/'book.typ'),'query(<art-placement>).map(it => it.value)'],text=True))
  duplicates={key:count for key,count in collections.Counter(a['asset'] for a in art).items() if count>1}
  if duplicates:raise RuntimeError(f'Repeated in-flow illustrations: {duplicates}')
  placements=plan(raw,art)
  all_art=art+placements
  (book/'generated/illustration-placements.json').write_text(json.dumps(all_art,indent=2)+'\n')
  fills.write_text(json.dumps(placements,indent=2)+'\n')
  subprocess.run(command,check=True)
  target=book/'output/heroes-of-legend-players-book.pdf'
  subprocess.run([pdf_python,str(book/'optimize_pdf.py'),str(raw),str(target)],check=True)
  # Keep PDF transcription unchanged through the image-only export optimization.
  extract=lambda p:subprocess.check_output(['pdftotext',str(p),'-'],text=True)
  before,after=extract(raw),extract(target)
  if before!=after:
   raise RuntimeError('PDF optimization changed extracted text; inspect before delivery.')
  (book/'generated/export-report.json').write_text(json.dumps(dict(text_identical_to_raw=True,text_sha256=hashlib.sha256(after.encode()).hexdigest(),bytes=target.stat().st_size,sha256=hashlib.sha256(target.read_bytes()).hexdigest()),indent=2)+'\n')
  print(f'Exported {target.stat().st_size/1024/1024:.1f} MiB PDF; {len(placements)} open-space illustrations.')
