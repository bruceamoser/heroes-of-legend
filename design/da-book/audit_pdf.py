#!/usr/bin/env python3
"""Coverage and geometry checks for the DA review PDF; visual review is also required."""
from pathlib import Path
import hashlib,json,re,subprocess,xml.etree.ElementTree as ET
from pypdf import PdfReader
B=Path(__file__).resolve().parent;D=B.parent
pdf=B/'output/heroes-of-legend-da-guide-bestiary.pdf'
m=json.loads((B/'generated/pdf-manifest.json').read_text())
r=PdfReader(pdf)
errors=[]
for source,digest in m['sources'].items():
 if hashlib.sha256((D/source).read_bytes()).hexdigest()!=digest:errors.append('Stale source: '+source)
for section in ['asset_hashes','build_hashes']:
 for path,digest in m[section].items():
  if hashlib.sha256((D.parent/path).read_bytes()).hexdigest()!=digest:errors.append('Stale build input: '+path)
if len(m['assets'])!=len(set(m['assets'])):errors.append('Duplicate illustration source')
layout=json.loads((B/'generated/layout-metadata.json').read_text())
placed=layout['art-placement']
if len(placed)!=len(m['assets']) or len({x['path'] for x in placed})!=len(placed):errors.append('Missing or repeated placed illustration')
card_pages={}
for edge in layout['card-edge']:card_pages.setdefault(edge['key'],{}).setdefault(edge['edge'],[]).append(edge['page'])
if len(card_pages)!=358:errors.append(f'Expected 358 complete card boundaries, found {len(card_pages)}')
for key,edges in card_pages.items():
 if len(edges.get('start',[]))!=1 or len(edges.get('end',[]))!=1 or edges['start']!=edges['end']:errors.append('Card split across pages or missing boundary: '+key)
outline=[]
def walk(items):
 for item in items:
  if isinstance(item,list):walk(item)
  else:outline.append((item.title,r.get_destination_page_number(item)+1))
walk(r.outline)
titles=[t for t,p in outline]
manifest=json.loads((B/'source-manifest.json').read_text())
for family in manifest['families']:
 for source in family['sources']:
  title=(D/source).read_text().splitlines()[0][2:]
  if titles.count(title)!=1:errors.append('Creature bookmark coverage: '+title)
for source in manifest['monster_abilities']:
 title=(D/source).read_text().splitlines()[0][2:]
 if titles.count(title)!=1:errors.append('Monster ability bookmark: '+title)
for source in manifest['summons']:
 title=(D/source).read_text().splitlines()[0][2:].replace(' (CV',' — Summoned (CV')
 if titles.count(title)!=1:errors.append('Summon bookmark: '+title)
refs={p.indirect_reference.idnum for p in r.pages};nlinks=0
for n,page in enumerate(r.pages,1):
 for ref in page.get('/Annots',[]):
  a=ref.get_object()
  if a.get('/Subtype')!='/Link':continue
  nlinks+=1;dest=a.get('/Dest')
  if dest is None and a.get('/A'):
   action=a['/A'].get_object()
   if action.get('/S')=='/GoTo':dest=action.get('/D')
  if isinstance(dest,list) and dest:
   target=dest[0]
   if hasattr(target,'idnum') and target.idnum not in refs:errors.append(f'Invalid link page {n}')
xml=B/'output/bounds.xhtml'
subprocess.run(['pdftotext','-bbox',str(pdf),str(xml)],check=True)
root=ET.parse(xml).getroot();ns={'h':'http://www.w3.org/1999/xhtml'}
page_words=[];bounds=[]
for n,page in enumerate(root.findall('.//h:page',ns),1):
 words=page.findall('h:word',ns);page_words.append(len(words))
 for word in words:
  x=float(word.get('xMin'));xx=float(word.get('xMax'));y=float(word.get('yMin'));yy=float(word.get('yMax'))
  if n>1 and (x<40 or xx>573 or y<12 or yy>784):bounds.append([n,word.text,round(x,2),round(xx,2),round(y,2),round(yy,2)])
  if word.text and '\ufffd' in word.text:errors.append(f'Replacement glyph page {n}')
if bounds:errors.append(f'{len(bounds)} text words outside page-safe bounds')
short=[i+1 for i,n in enumerate(page_words) if n<30 and i!=0]
if short:errors.append('Unexpected nearly empty pages: '+str(short))
text=B/'output/proof.txt';subprocess.run(['pdftotext','-layout',str(pdf),str(text)],check=True)
s=text.read_text();pages=s.split('\f')
start=next(p for t,p in outline if t=='Wound Tables');end=next(p for t,p in outline if t=='Creature Indexes')
wounds='\n'.join(pages[start-1:end-1])
rolls=re.findall(r'^\s*([1-6]{3})\s+',wounds,re.M)
if len(rolls)!=280:errors.append(f'Wound table row count {len(rolls)} != 280')
raw=B/'output/da-guide-unoptimized.pdf'
raw_text=subprocess.check_output(['pdftotext','-layout',str(raw),'-'])
if raw_text!=text.read_bytes():errors.append('Image compression changed extracted text')
raw_reader=PdfReader(raw)
if len(raw_reader.pages)!=len(r.pages):errors.append('Image compression changed page count')
raw_links=sum(len(p.get('/Annots',[])) for p in raw_reader.pages)
if raw_links!=nlinks:errors.append('Image compression changed link count')
report={'pages':len(r.pages),'bytes':pdf.stat().st_size,'sha256':hashlib.sha256(pdf.read_bytes()).hexdigest(),'bookmarks':len(outline),'links':nlinks,'source_count':len(m['sources']),'creatures':m['creatures'],'monster_abilities':m['monster_abilities'],'summons':m['summons'],'wound_rows':len(rolls),'distinct_interior_assets':len(m['assets']),'placed_interior_assets':len(placed),'single_page_cards':len(card_pages),'largest_creature_card_points':round(max(x['height'] for x in layout['card-size']),1),'compression_preserves_text_pages_links':raw_text==text.read_bytes() and len(raw_reader.pages)==len(r.pages) and raw_links==nlinks,'word_bounds_findings':bounds,'short_pages':short,'errors':errors}
(B/'output/pdf-audit.json').write_text(json.dumps(report,indent=2)+'\n')
(B/'output/page-index.json').write_text(json.dumps(outline,ensure_ascii=False,indent=2)+'\n')
print(json.dumps(report,indent=2))
if errors:raise SystemExit(1)
