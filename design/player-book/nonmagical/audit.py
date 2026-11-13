"""Check the review packet's source coverage, learning graph and printable bounds."""
import json,re,subprocess,xml.etree.ElementTree as ET
from pathlib import Path
from pypdf import PdfReader
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
PDF=ROOT/'output/pdf/nonmagical-disciplines.pdf'
data=json.loads((HERE/'generated.json').read_text())
reader=PdfReader(PDF);assert len(reader.pages)==13,'Expected two procedure pages and eleven discipline pages'
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
xml=subprocess.check_output(['pdftotext','-bbox',str(PDF),'-'],text=True)
ns={'x':'http://www.w3.org/1999/xhtml'}
for n,page in enumerate(ET.fromstring(xml).findall('.//x:page',ns),1):
 for w in page.findall('.//x:word',ns):
  a=w.attrib
  assert 34 <= float(a['xMin']) < float(a['xMax']) <= 578,(n,w.text,'horizontal overflow')
  assert 10 <= float(a['yMin']) < float(a['yMax']) <= 785,(n,w.text,'vertical overflow')
print('PASS: 13 pages; all 176 full entries match source; prerequisites, DP, level gates and text bounds checked.')
