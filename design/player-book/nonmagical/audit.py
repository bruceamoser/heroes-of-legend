"""Check current seven-step discipline sources and the standalone review PDF."""
import json,re,subprocess,xml.etree.ElementTree as ET
from pathlib import Path
from pypdf import PdfReader
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
PDF=ROOT/'output/pdf/nonmagical-disciplines.pdf'
data=json.loads((HERE/'generated.json').read_text())
reader=PdfReader(PDF)
def compact(t):return re.sub(r'\s+','',t).replace('\u00ad','').replace('ﬀ','ff').replace('ﬁ','fi').replace('ﬂ','fl')
raw=subprocess.check_output(['pdftotext','-raw',str(PDF),'-'],text=True).split('\f')
assert len(data)==11 and sum(len(d['paths']) for d in data)==44
entries=[e for d in data for p in d['paths'] for e in p['entries']]
assert len(entries)==308 and len({e['id'] for e in entries})==308
all_ids={d['id'] for d in data}|{e['id'] for e in entries}
for d in data:
 assert len(d['paths'])==4,d['id']
 for path in d['paths']:
  assert len(path['entries'])==7,path['id']
  for i,e in enumerate(path['entries']):
   assert all(r in all_ids for r in e['requires']),(e['id'],'dangling prerequisite')
   assert e['requires']==([path['id']+':'+str(i)] if i else [d['id']]),e['id']
   assert e['level']==[1,1,1,3,3,3,7][i],e['id']
   assert e['dp']==[1,2,2,3,4,4,5][i],e['id']
   hits=[page for page,text in enumerate(raw) if compact(e['name']) in compact(text) and compact(e['effect']) in compact(text)]
   assert len(hits)==1,(e['id'],'missing, duplicated, divided or changed entry')
   assert not re.search(r'damage.{0,45}minimum 0',e['effect'],re.I),e['id']
# No former intersection catalog is part of this review packet. Spellcraft's
# three training paths and the book masteries are verified by their own audits.
assert 'Combined disciplines' not in ' '.join(raw)
xml=subprocess.check_output(['pdftotext','-bbox',str(PDF),'-'],text=True)
ns={'x':'http://www.w3.org/1999/xhtml'}
for n,page in enumerate(ET.fromstring(xml).findall('.//x:page',ns),1):
 for w in page.findall('.//x:word',ns):
  a=w.attrib
  assert 34 <= float(a['xMin']) < float(a['xMax']) <= 578,(n,w.text,'horizontal overflow')
  assert 10 <= float(a['yMin']) < float(a['yMax']) <= 785,(n,w.text,'vertical overflow')
print(f'PASS: {len(reader.pages)} pages; 11 disciplines, 44 paths and 308 complete effects; sequential prerequisites, costs, gates and bounds checked.')
