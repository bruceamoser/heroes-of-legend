"""Render authored revision Markdown; never rewrite rules from generated data."""
import json,re,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
SOURCE=ROOT/'design/revision/nonmagical'
HERE=Path(__file__).resolve().parent
ORDER=['arms','armor','guard','marksmanship','athletics','subterfuge','wilderness','medicine','craft','scholarship','influence']
def slug(s):return re.sub(r'[^a-z0-9]+','-',s.lower()).strip('-')
records=[]
for ident in ORDER:
 lines=(SOURCE/f'{ident}.md').read_text().splitlines()
 d={'id':ident,'name':lines[0][2:],'theme':lines[1],'intro':lines[3],'paths':[]}
 for part in re.split(r'^## ', '\n'.join(lines[4:]), flags=re.M)[1:]:
  title,body=part.split('\n',1)
  path={'id':ident+':'+slug(title),'name':title,'entries':[]}
  for entry in body.split('### ')[1:]:
   name,meta,effect=entry.strip().split('\n',2)
   m=re.fullmatch(r'DP: (\d+) \| Level: (\d+)',meta); assert m,meta
   i=len(path['entries']); eid=path['id']+':'+str(i+1)
   path['entries'].append({'id':eid,'name':name,'dp':int(m[1]),'level':int(m[2]),'effect':effect.strip(),'requires':[path['id']+':'+str(i)] if i else [ident]})
  assert len(path['entries'])==4,(ident,title)
  assert [e['dp'] for e in path['entries']]==[1,2,2,3]
  assert [e['level'] for e in path['entries']]==[0,0,0,3]
  base=path['entries'][0]['name'].removesuffix(' I')
  assert [e['name'] for e in path['entries'][:3]]==[base+' '+n for n in ['I','II','III']]
  d['paths'].append(path)
 assert len(d['paths'])==4,ident
 records.append(d)
assert len({e['id'] for d in records for p in d['paths'] for e in p['entries']})==176
out=ROOT/'output/pdf';out.mkdir(parents=True,exist_ok=True)
HERE.joinpath('generated.json').write_text(json.dumps(records,indent=2,ensure_ascii=False))
# Procedures use a deliberately small Markdown subset: headings and paragraphs.
procs=[]
for para in (SOURCE/'procedures.md').read_text().strip().split('\n\n'):
 if para.startswith('# '):procs.append({'kind':'page','text':para[2:]})
 elif para.startswith('## '):procs.append({'kind':'heading','text':para[3:]})
 else:procs.append({'kind':'paragraph','text':para.replace('\n',' ')})
HERE.joinpath('procedures.json').write_text(json.dumps(procs,ensure_ascii=False))
# The shared template reads its generated artwork manifest at import time.
manifest=HERE.parent/'generated/art-files.json'
if not manifest.exists():
 manifest.parent.mkdir(parents=True,exist_ok=True)
 manifest.write_text(json.dumps([p.stem for p in (HERE.parent/'art/interior').glob('*.png')]))
subprocess.run(['typst','compile','--root',str(ROOT),str(HERE/'book.typ'),str(out/'nonmagical-disciplines.pdf')],check=True)
print('Validated 11 disciplines, 44 sequential paths, 176 uniquely identified entries.')
