#!/usr/bin/env python3
"""Coverage and PDF transcription checks for the player-book proof."""
import collections,hashlib,json,re,subprocess,unicodedata
import xml.etree.ElementTree as ET
from pathlib import Path
B=Path(__file__).resolve().parent;R=B.parents[1]
m=json.loads((B/'generated/manifest.json').read_text())
c=collections.Counter(x['kind'] for x in m['included'])
errors=[]
for k,v in m['expected'].items():
 if c[k]!=v:errors.append(f'{k}: {c[k]} != {v}')
if len({x['path'] for x in m['included']})!=len(m['included']):errors.append('Duplicate source entries')
if len({x['key'] for x in m['included']})!=len(m['included']):errors.append('Duplicate labels')
body=(B/'generated/body.typ').read_text()
for x in m['included']:
 if x['key'] not in body:errors.append('Missing source label: '+x['path'])
 if hashlib.sha256((R/x['path']).read_bytes()).hexdigest()!=x['sha256']:errors.append('Source changed since build: '+x['path'])
pdf=B/'output/heroes-of-legend-players-book.pdf'
text=subprocess.check_output(['pdftotext',str(pdf),'-'],text=True)
def norm(s):
 s=unicodedata.normalize('NFKC',s).replace('\u00ad','')
 s=re.sub(r'\[([^\]]+)\]\([^)]*\)',r'\1',s)
 return re.sub(r'[^a-z0-9]','',s.lower())
n=norm(text)
missing_names=[];missing_outcomes=[];outcomes=0
for x in m['cards']:
 if norm(x['name']) not in n:missing_names.append(x['name'])
 source=(R/x['path']).read_text()
 for val in re.findall(r'^- \*\*(?:Weak|Standard|Strong):\*\* (.+)$',source,re.M):
  outcomes+=1
  if norm(val) not in n:missing_outcomes.append({'card':x['name'],'text':val})
if missing_names:errors.append(f'{len(missing_names)} card names missing')
if missing_outcomes:errors.append(f'{len(missing_outcomes)} outcome lines require inspection')
wounds=[line for line in (R/'design/rules/wounds.md').read_text().splitlines() if re.match(r'^\| [1-6]{3} \|',line) and len(line.split('|'))==7]
if len(wounds)!=280:errors.append('Wound source count is not 280')
missing_wound_cells=[]
for line in wounds:
 cells=line.strip('|').split('|')
 for cell in cells[1:4]:
  if norm(cell) not in n:missing_wound_cells.append(cell.strip())
if missing_wound_cells:errors.append(f'{len(missing_wound_cells)} wound cells require inspection')
bbox=subprocess.check_output(['pdftotext','-bbox',str(pdf),'-'],text=True)
root=ET.fromstring(bbox);ns={'x':'http://www.w3.org/1999/xhtml'}
pages=root.findall('.//x:page',ns);outside=[]
for page_num,page in enumerate(pages,1):
 if page_num==1:continue # The approved cover intentionally fills the page.
 for word in page.findall('.//x:word',ns):
  a=word.attrib
  if float(a['xMin'])<40 or float(a['xMax'])>573 or float(a['yMin'])<15 or float(a['yMax'])>782:
   outside.append({'page':page_num,'word':word.text,'bounds':a})
if outside:errors.append(f'{len(outside)} words outside content bounds')
(B/'generated/layout-report.json').write_text(json.dumps({'pages':len(pages),'outside_content_bounds':outside},indent=2)+'\n')
# These are transcription/geometry checks, not proof of play balance or visual quality.
report={'counts':dict(c),'ability_outcomes_checked':outcomes,'missing_names':missing_names,'missing_outcomes':missing_outcomes,'wound_rows':len(wounds),'missing_wound_cells':missing_wound_cells,'pages':len(pages),'errors':errors}
(B/'generated/coverage-report.json').write_text(json.dumps(report,indent=2,ensure_ascii=False)+'\n')
print(json.dumps({k:v for k,v in report.items() if k not in ('missing_outcomes',)},indent=2))
if errors:raise SystemExit(1)
