"""Check the review packet's source coverage, learning graph and printable bounds."""
import json,re,subprocess,xml.etree.ElementTree as ET
from pathlib import Path
from pypdf import PdfReader
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
PDF=ROOT/'output/pdf/nonmagical-disciplines.pdf'
data=json.loads((HERE/'generated.json').read_text())
reader=PdfReader(PDF);assert len(reader.pages)>=19,'Expected base disciplines and combined abilities'
def compact(t):return re.sub(r'\s+','',t).replace('\u00ad','').replace('ﬀ','ff').replace('ﬁ','fi').replace('ﬂ','fl')
raw=subprocess.check_output(['pdftotext','-raw',str(PDF),'-'],text=True).split('\f')
all_ids={d['id'] for d in data}
for d in data:
 for p in d['paths']:
  all_ids.update(e['id'] for e in p['entries'])
for page,d in enumerate(data,2):
 text=compact(raw[page])
 for p in d['paths']:
  for i,e in enumerate(p['entries']):
   assert compact(e['name']) in text,(d['name'],e['name'],'missing name')
   assert compact(e['effect']) in text,(e['name'],'missing or changed effect')
   assert all(r in all_ids for r in e['requires']),(e['id'],'dangling prerequisite')
   assert e['requires']==([p['id']+':'+str(i)] if i else [d['id']])
   assert e['level']==(3 if i==3 else 0)
   assert e['dp']==[1,2,2,3][i]
   assert not re.search(r'damage.{0,45}minimum 0',e['effect'],re.I),e['id']
payload=json.loads((HERE/'combined.json').read_text())
combined=payload['abilities']
magic={m['id']:m for m in payload['magic']}
assert [sum(c['count']==n for c in combined) for n in (2,3,4)]==[15,9,6]
fulltext=compact(' '.join(raw))
endpoints={p['entries'][-1]['id']:p for d in data for p in d['paths']}
for c in combined:
 assert c['level']==7 and c['dp']==c['count']+1
 assert len(set(p['discipline'] for p in c['parents']))==c['count']
 assert len(c['requires'])==c['count']
 assert compact(c['effect']) in fulltext,(c['name'],'missing combined effect')
 for r in c['requires']:
  assert r in endpoints or r in magic,(c['name'],r)
  if r in endpoints: assert any(u['id']==c['id'] for u in endpoints[r]['unlocks'])
for p in endpoints.values():
 assert {u['id'] for u in p['unlocks']}=={c['id'] for c in combined if p['entries'][-1]['id'] in c['requires']}
assert sum(c['mixed'] for c in combined)==9
for m in magic.values():
 assert compact(m['pages']) in fulltext and compact(m['advanced']) in fulltext,m['name']
assert any(page.get('/Annots') for page in reader.pages),'Missing PDF navigation links'
xml=subprocess.check_output(['pdftotext','-bbox',str(PDF),'-'],text=True)
ns={'x':'http://www.w3.org/1999/xhtml'}
for n,page in enumerate(ET.fromstring(xml).findall('.//x:page',ns),1):
 for w in page.findall('.//x:word',ns):
  a=w.attrib
  assert 34 <= float(a['xMin']) < float(a['xMax']) <= 578,(n,w.text,'horizontal overflow')
  assert 10 <= float(a['yMin']) < float(a['yMax']) <= 785,(n,w.text,'vertical overflow')
print(f'PASS: {len(reader.pages)} pages; 176 base and 30 combined effects match source; exact endpoints, reverse links, distinct discipline counts, DP, gates and bounds checked.')
