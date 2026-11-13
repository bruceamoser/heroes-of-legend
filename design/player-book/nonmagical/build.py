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
lookup={e['id']:(d,p,e) for d in records for p in d['paths'] for e in p['entries']}
magic=[]
for section in re.split(r'^## ',(SOURCE/'magical-endpoints.md').read_text(),flags=re.M)[1:]:
 name,ident,discipline,book,pages,advanced=section.strip().split('\n')
 ref=ident.removeprefix('ID: ')
 magic.append({'id':ref,'anchor':'magic:'+ref,'name':name,'discipline':discipline.removeprefix('Discipline: '),'branch':book.removeprefix('List: '),'pages':pages.removeprefix('Pages 7–8: '),'advanced':advanced.removeprefix('Advanced pages: ')})
magic_lookup={m['id']:m for m in magic}
combined=[]
source=(SOURCE/'combined.md').read_text()
for section in re.split(r'^## ',source,flags=re.M)[1:]:
 name,meta,req,effect=section.strip().split('\n',3)
 m=re.fullmatch(r'DP: (\d+) \| Level: (\d+)',meta);assert m
 refs=req.removeprefix('Requires: ').split(', ')
 assert len(refs)==len(set(refs))
 parents=[]
 for ref in refs:
  if ref in magic_lookup:
   parents.append(magic_lookup[ref]);continue
  assert ref in lookup,ref
  d,p,e=lookup[ref];assert e is p['entries'][-1],ref
  parents.append({'id':ref,'anchor':p['id'],'discipline':d['name'],'branch':p['name'],'name':e['name']})
 count=len({p['discipline'] for p in parents})
 assert count==len(refs) and count in (2,3,4),(name,refs)
 assert int(m[1])==count+1 and int(m[2])==7
 combined.append({'id':'combined:'+slug(name),'name':name,'dp':int(m[1]),'level':7,'count':count,'requires':refs,'parents':parents,'effect':effect.strip(),'mixed':any(r in magic_lookup for r in refs)})
assert len({c['id'] for c in combined})==len(combined)
for d in records:
 for p in d['paths']:
  p['unlocks']=[{'id':c['id'],'name':c['name']} for c in combined if p['entries'][-1]['id'] in c['requires']]
intro=source.split('\n## ')[0].split('\n\n')[1:]
HERE.joinpath('combined.json').write_text(json.dumps({'intro':intro,'abilities':combined,'magic':magic},indent=2,ensure_ascii=False))
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
print(f'Validated 11 disciplines, 176 base entries and {len(combined)} level-7 combinations.')
