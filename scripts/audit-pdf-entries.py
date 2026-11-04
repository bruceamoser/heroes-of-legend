#!/usr/bin/env python3
"""Read-only per-ability PDF transcription audit; approval conformance is separate."""
import argparse,hashlib,json,re,subprocess,unicodedata,xml.etree.ElementTree as ET
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--book',required=True);p.add_argument('--player',required=True);p.add_argument('--da',required=True);p.add_argument('--output',required=True);a=p.parse_args()
def norm(s):
 s=re.sub(r'\[([^\]]+)\]\([^)]*\)',r'\1',s)
 return re.sub('[^a-z0-9]','',unicodedata.normalize('NFKC',s).replace('\u00ad','').lower())
def pages(path):
 root=ET.fromstring(subprocess.check_output(['pdftotext','-bbox-layout',path,'-']))
 out=[]
 for pg in root.findall('.//{*}page'):
  lines=[]
  for line in pg.findall('.//{*}line'):
   words=line.findall('{*}word')
   if not words:continue
   lines.append({'text':' '.join(''.join(w.itertext()) for w in words),'x':float(line.attrib['xMin']),'y':float(line.attrib['yMin']),'x2':float(line.attrib['xMax']),'y2':float(line.attrib['yMax'])})
  out.append({'width':float(pg.attrib['width']),'lines':lines,'text':'\n'.join(x['text'] for x in lines)})
 return out
book=Path(a.book);pgs=pages(a.player);dapgs=pages(a.da)
cards=[]
sources=[('ability',f) for f in sorted((book/'design/cards').glob('*.md'))]+[('trait',f) for f in sorted((book/'design/ancestries').glob('trait-*.md'))]
for kind,f in sources:
 s=f.read_text();title=re.search(r'^# (.+)',s).group(1);sid=re.search(r'\*\*ID:\*\* (\S+)',s).group(1)
 narrative=s.split('\n\n')[1].strip('*')
 fields={}
 for label,value in re.findall(r'\*\*([^*]+):\*\*\s*(.*?)(?=\s*·\s*\*\*|\n|$)',s):fields[label]=value.strip()
 body=s.split('## Rules',1)[1].split('\n---',1)[0]
 if kind == 'trait':body=body.split('**Ancestry:**',1)[0]
 rules=[b.strip() for b in re.split(r'\n\s*\n',body) if b.strip() and not b.lstrip().startswith(('**','#'))]
 cards.append({'kind':kind,'id':sid,'path':str(f.relative_to(book)),'title':title,'narrative':narrative,'fields':fields,'rules':rules})
names={norm(c['title']) for c in cards};heads=[]
for pi,pg in enumerate(pgs):
 for i,line in enumerate(pg['lines']):
  for n in range(1,4):
   ls=pg['lines'][i:i+n]
   if len(ls)!=n or any(abs(t['x']-line['x'])>35 for t in ls):continue
   name=norm(' '.join(t['text'] for t in ls))
   if name in names:heads.append({'name':name,'page':pi,'x':line['x'],'y':line['y'],'end':ls[-1]['y2']})
rows=[]
intentional={'Limits':{'Repeatable; normal action economy applies.','Repeatable; pay the action and any stated costs each use.'},'Equipment / acquisition':{'None.','No item needed unless named above.'},'Duration':{'Instant. Applied conditions follow their normal duration and decay.','Resolve once at the stated trigger; applied conditions follow normal decay.'}}
for c in cards:
 candidates=[]
 for h in heads:
  if h['name']!=norm(c['title']):continue
  pg=pgs[h['page']];mid=pg['width']/2;right=h['x']>=mid
  later=[x['y'] for x in heads if x['page']==h['page'] and (x['x']>=mid)==right and x['y']>h['y']+2]
  bottom=min(later,default=10000)
  lines=[x for x in pg['lines'] if (x['x']>=mid)==right and x['y']>=h['y']-1 and x['y']<bottom-1]
  text='\n'.join(x['text'] for x in lines)
  score=sum(norm(b) in norm(text) for b in c['rules'])+int(norm(c['narrative']) in norm(text))*5
  candidates.append((score,h,text))
 if not candidates:rows.append({**{k:c[k] for k in ['kind','id','path','title']},'status':'missing_title','fields':[]});continue
 _,h,text=max(candidates,key=lambda x:x[0]);checks=[];nt=norm(text)
 checks.append({'field':'Narrative','expected':c['narrative'],'status':'present' if norm(c['narrative']) in nt else 'review_missing'})
 for i,b in enumerate(c['rules']):checks.append({'field':f'Rules paragraph {i+1}','expected':b,'status':'present' if norm(b) in nt else 'review_missing'})
 for key in ([] if c['kind']=='trait' else ['Action','Attribute','Target / range / shape','Duration','Equipment / acquisition','Limits','Requirements to learn','DP','Type']):
  v=c['fields'].get(key)
  if not v:continue
  display = (v + ' DP') if key == 'DP' and v.isdigit() else v
  if key == 'DP' and v == 'Not purchased' and c['fields'].get('Tier / minimum level') == 'Universal':
   display='Universal'
  status='present' if norm(display) in nt else 'review_missing'
  if v in intentional.get(key,set()):status='shared_omission' if status!='present' else status
  checks.append({'field':key,'expected':v,'status':status})
 rows.append({'kind':c['kind'],'id':c['id'],'path':c['path'],'title':c['title'],'pdf_page':h['page']+1,'status':'review' if any(x['status']=='review_missing' for x in checks) else 'present','fields':checks,'extracted_text':text})
shared=[]
for f in sorted((book/'design/rules').glob('*.md')):
 for para in re.split(r'\n\s*\n',f.read_text()):
  if not para.strip() or para.startswith(('#','|')):continue
  if f.name not in ['vision.md','ancestry-procedures.md','summoning.md','conditions.md','recovery.md','stability.md','languages.md']:continue
  shared.append({'path':str(f.relative_to(book)),'paragraph':para,'player_pages':[i+1 for i,pg in enumerate(pgs) if norm(para) in norm(pg['text'])],'da_pages':[i+1 for i,pg in enumerate(dapgs) if norm(para) in norm(pg['text'])]})
report={'scope':'PDF transcription from current canonical source, not approval verification; missing cases require manual review of transformations and scope. DA guide does not contain the character ability catalog.','pdfs':{k:{'path':v,'sha256':hashlib.sha256(Path(v).read_bytes()).hexdigest()} for k,v in [('player',a.player),('da',a.da)]},'cards':[r for r in rows if r['kind']=='ability'],'traits':[r for r in rows if r['kind']=='trait'],'shared_paragraphs':shared}
out=Path(a.output);out.parent.mkdir(parents=True,exist_ok=True);out.write_text(json.dumps(report,indent=2,ensure_ascii=False)+'\n')
from collections import Counter
print(json.dumps({'cards':sum(r['kind']=='ability' for r in rows),'traits':sum(r['kind']=='trait' for r in rows),'status':dict(Counter(x['status'] for x in rows)),'field_status':dict(Counter(y['status'] for x in rows for y in x['fields'])),'shared_paragraphs':len(shared)},indent=2))

failures=[r for r in rows if r['status']!='present']
if failures:
 print('Entry-local PDF failures: '+', '.join(r['title'] for r in failures))
 raise SystemExit(1)
