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
body=(B/'generated/body.typ').read_text()+(B/'generated/learning.typ').read_text()
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
for shared in ['vision.md','ancestry-procedures.md']:
 source=R/'design/rules'/shared
 for paragraph in re.split(r'\n\s*\n',source.read_text()):
  if paragraph.startswith(('#','|')):continue
  if norm(paragraph) not in n:errors.append('Shared rule text missing: '+shared+' '+paragraph[:50])
art=json.loads((B/'art/interior-prompts.json').read_text())+json.loads((B/'art/revision-prompts.json').read_text())+json.loads((B/'art/class-cutout-prompts.json').read_text())+json.loads((B/'art/reference-prompts.json').read_text())+json.loads((B/'art/ancestry-expansion-prompts.json').read_text())+[json.loads((B/'art/ancestry-lineup-prompt.json').read_text())]
missing_art=[x['path'] for x in art if not (R/x['path']).is_file()]
if missing_art:errors.append(f'{len(missing_art)} missing illustration assets')
# Verify complete ancestry trait rules reach the PDF, not only the entry titles.
for entry in (x for x in m['included'] if x['kind']=='trait'):
 source=(R/entry['path']).read_text()
 rules=source.split('## Rules',1)[1].split('**Ancestry:**',1)[0].strip()
 if norm(rules) not in n:errors.append('Ancestry trait rules missing or split: '+entry['path'])
for portrait in (B/'art/interior').glob('ancestry-*-cutout.png'):
 from PIL import Image
 with Image.open(portrait) as im:
  if im.mode!='RGBA' or im.getchannel('A').getextrema()[0]!=0:errors.append('Ancestry portrait lacks transparency: '+portrait.stem)
if len([x for x in art if x['key'].startswith('symbol-')])!=18:errors.append('Expected 18 simple discipline symbols')
placements=json.loads((B/'generated/illustration-placements.json').read_text())
image_counts=collections.Counter(x['asset'] for x in placements)
duplicated_art={k:v for k,v in image_counts.items() if v>1}
if duplicated_art:errors.append('Repeated illustrations: '+str(duplicated_art))
if n.count('classaffinitysetsthecostofeachrank'):errors.append('Repeated discipline purchase boilerplate remains')
for phrase in ['Each option is a pair.', 'Class affinity', 'Home:', 'Adjacent:', 'Foreign;',
               'one of your two traits', 'Recipe permission:', 'Type: Culture', 'Type: Background']:
 if phrase in text:errors.append('Retired reader boilerplate: '+phrase)
for title in ['Starting HP', 'Starting SP', 'Starting coins', 'Learning and using disciplines',
              'Basic action index', 'Talent index', 'Level 1 signature index', 'Level 3 signature index', 'Level 7 signature index']:
 if norm(title) not in n:errors.append('Missing reader reference: '+title)
for phrase in ['safe breath', 'hit dice pool', 'recovery value', 'life cost',
               'moser’s law', 'as the wound', 'class discipline prices', 'no discipline purchases']:
 if norm(phrase) in n:errors.append('Retired player rule or wording: '+phrase)
summaries=json.loads((B/'ability-summaries.json').read_text())
shared=[x for x in m['cards'] if x['tier']=='Universal']
for x in shared:
 slug=Path(x['path']).stem
 if slug not in summaries:errors.append('Missing ability summary: '+slug)
 elif norm(summaries[slug]) not in n:errors.append('Missing ability-directory summary: '+slug)
# Verify the new chapter's mechanics and exact prerequisite names survived typesetting.
learning=json.loads((B/'nonmagical/generated.json').read_text())
for d in learning:
 for path in d['paths']:
  for entry in path['entries']:
   for value in [entry['name'],entry['effect']]:
    if norm(value) not in n:errors.append('Missing learning text: '+entry['name'])
combinations=json.loads((B/'nonmagical/combined.json').read_text())['abilities']
for entry in combinations:
 for value in [entry['name'],entry['effect'],*[parent['name'] for parent in entry['parents']]]:
  if norm(value) not in n:errors.append('Missing combined text: '+entry['name'])
books=json.loads((B/'generated/spellbooks.json').read_text())
if len(books)!=29 or sum(len(b['rows']) for b in books)!=319:errors.append('Incomplete spellbook atlas')
for book in books:
 for spell in book['spells']:
  for value in [spell['name'],*spell['action'].split(' · '),spell['target'],spell['duration'],spell['effect']]:
   if norm(value) not in n:errors.append('Missing spell block text: '+spell['id'])
 for row in book['rows']:
  if norm(row[1]) not in n:errors.append('Missing spell: '+row[1])
for phrase in ['Choose your languages', 'Ordinary languages', 'Uncommon and ancient languages', 'Use languages at the table', 'Keep learning grounded']:
 if norm(phrase) not in n:errors.append('Missing language section: '+phrase)
for row in (R/'design/rules/languages.md').read_text().splitlines():
 if row.startswith('| ') and not row.startswith('| Language'):
  if norm(row.split('|')[1]) not in n:errors.append('Missing language choice: '+row)
if body.count('#ability-directory(')!=1:errors.append('Expected one Basic Actions directory')
if body.count('#class-panel(')!=10:errors.append('Expected ten styled class introductions')
for cp in (R/'design/origins').glob('*.md'):
 for grant in re.findall(r'^- (\*\*[^\n]+)',cp.read_text(),re.M):
  printed = re.sub(r'^\*\*(\w+) access\*\* and ', r'Study \1 and learn ', grant)
  if norm(printed) not in n:errors.append('Origin grant missing: '+cp.stem+' '+printed)
from PIL import Image
for portrait in (B/'art/interior').glob('class-*-cutout.png'):
 with Image.open(portrait) as im:
  if im.mode!='RGBA' or im.getchannel('A').getextrema()[0]!=0:errors.append('Class portrait lacks transparency: '+portrait.stem)
for source in m.get('presentation_sources',[])+m.get('learning_sources',[]):
 if hashlib.sha256((R/source['path']).read_bytes()).hexdigest()!=source['sha256']:errors.append('Presentation source changed: '+source['path'])
if 'Artwork in production' in text:errors.append('Unfilled illustration placeholder in PDF')
if 'chooseoneclass' not in n:errors.append('Missing instruction to choose one class')
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
wounds=[];missing_wound_cells=[]
scar_rows=[line for line in (R/'design/rules/wounds.md').read_text().splitlines() if line.startswith('| ')][1:]
for row in scar_rows:
 for cell in row.strip('|').split('|'):
  if norm(cell.strip()) not in n:errors.append('Missing scar prompt: '+cell.strip())
for required in ['Scars and Survival','half maximum HP','First Aid','Death Failures','Death Successes','Add 1 failure mark','Add 1 success mark']:
 if norm(required) not in n:errors.append('Missing recovery rule: '+required)
for obsolete in ['Roll 3d6 plus one die per prior wound','One treatment attempt per wound per day']:
 if norm(obsolete) in n:errors.append('Obsolete wound procedure: '+obsolete)
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
