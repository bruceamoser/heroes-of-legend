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
art=json.loads((B/'art/interior-prompts.json').read_text())+json.loads((B/'art/revision-prompts.json').read_text())
missing_art=[x['path'] for x in art if not (R/x['path']).is_file()]
if missing_art:errors.append(f'{len(missing_art)} missing illustration assets')
if len([x for x in art if x['key'].startswith('symbol-')])!=18:errors.append('Expected 18 simple discipline symbols')
placements=json.loads((B/'generated/illustration-placements.json').read_text())
image_counts=collections.Counter(x['asset'] for x in placements)
duplicated_art={k:v for k,v in image_counts.items() if v>1}
if duplicated_art:errors.append('Repeated illustrations: '+str(duplicated_art))
if n.count('classaffinitysetsthecostofeachrank'):errors.append('Repeated discipline purchase boilerplate remains')
if 'Artwork in production' in text:errors.append('Unfilled illustration placeholder in PDF')
# Creation, the class introduction and glossary may each state the global rule.
if n.count('nomulticlassing')!=3:errors.append('Unexpected multiclassing repetition outside the three global references')
fills=json.loads((B/'generated/space-art.json').read_text())
for f in fills:
 if not (B/'art/interior'/f"{f['asset']}.png").is_file():errors.append('Missing open-space art: '+f['asset'])
 if f['x']<42 or f['x']+f['width']>570 or f['y']<52 or f['y']+f['height']>742:errors.append('Open-space art outside page body')
sheet_names=['Hero & encounter','Training & abilities','Belongings & scars','Creation ledger']
sheet_pages=[]
for title in sheet_names:
 found=[i for i,page in enumerate(text.split('\f'),1) if title.lower() in page.lower()]
 if len(found)!=1:errors.append('Missing or duplicate printable sheet: '+title)
 else:sheet_pages.append(found[0])
if len(sheet_pages)==4 and sheet_pages!=list(range(sheet_pages[0],sheet_pages[0]+4)):errors.append('Printable sheets must occupy four consecutive pages')

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
  if float(a['xMin'])<34 or float(a['xMax'])>578 or float(a['yMin'])<15 or float(a['yMax'])>782:
   outside.append({'page':page_num,'word':word.text,'bounds':a})
if outside:errors.append(f'{len(outside)} words outside content bounds')
(B/'generated/layout-report.json').write_text(json.dumps({'pages':len(pages),'outside_content_bounds':outside},indent=2)+'\n')
# These are transcription/geometry checks, not proof of play balance or visual quality.
report={'counts':dict(c),'illustration_assets':len(art),'missing_art':missing_art,'open_space_illustrations':len(fills),'unique_illustrations':len(image_counts),'duplicate_illustrations':duplicated_art,'printable_sheet_pages':sheet_pages,'ability_outcomes_checked':outcomes,'missing_names':missing_names,'missing_outcomes':missing_outcomes,'wound_rows':len(wounds),'missing_wound_cells':missing_wound_cells,'pages':len(pages),'errors':errors}
(B/'generated/coverage-report.json').write_text(json.dumps(report,indent=2,ensure_ascii=False)+'\n')
print(json.dumps({k:v for k,v in report.items() if k not in ('missing_outcomes',)},indent=2))
if errors:raise SystemExit(1)
