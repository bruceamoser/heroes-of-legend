"""Build the canonical discipline/spellbook chapter from authored Markdown."""
import json,re,subprocess,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]; D=ROOT/'design'; B=D/'player-book';G=B/'generated'
q=lambda s:json.dumps(str(s),ensure_ascii=False)
subprocess.run([sys.executable,str(B/'nonmagical/build.py'),'--data-only'],check=True)
# Shared book-style fragment: no independent document/page setup.
s=(B/'nonmagical/book.typ').read_text();s=s[s.index('#let prose'):]
s=s.replace('json("procedures.json")','json("../nonmagical/procedures.json")').replace('json("generated.json")','json("../nonmagical/generated.json")').replace('json("combined.json")','json("../nonmagical/combined.json")')
# Stable file anchors preserve links from creation, origins and classes.
import hashlib
key=lambda p:'s-'+hashlib.sha1(str(p.relative_to(ROOT)).encode()).hexdigest()[:12]
anchors={p.stem:key(p) for p in (D/'disciplines').glob('*.md')}
s=s.replace(' heading(level:1,d.name)',' heading(level:1,d.name)\n [#metadata(d.id)#label('+json.dumps(anchors)+'.at(d.id))]') if False else s
s=s.replace(' heading(level:1,d.name)',' heading(level:1,d.name)\n [#metadata(d.id)#label(discipline-anchors.at(d.id))]')
anchorcode='#let discipline-anchors = ('+','.join(q(k)+':'+q(v) for k,v in anchors.items())+',)\n'
# Spell lists are separate authored records with a stable book reference.
books=[]
for p in sorted((D/'spellbooks').glob('*.md')):
 text=p.read_text();lines=text.splitlines();fields={k:v for k,v in re.findall(r'^(Discipline|List|ID|Endpoint): (.+)$',text,re.M)}
 rows=[]
 for line in lines:
  if re.match(r'^\| (?:\d|A\d)',line):rows.append([x.strip() for x in line.strip('|').split('|')])
 spells=[]
 for section in re.split(r'^### ',text,flags=re.M)[1:]:
  title=section.splitlines()[0]
  values=dict(re.findall(r'^\*\*([^*]+):\*\* (.+)$',section,re.M))
  effect=section.split('\n\n',2)[2].strip()
  spells.append(dict(name=title,id=values['ID'],page=values['Page'],action=values['Action'],sp=values['SP'],attribute=values['Attribute'],target=values['Target / range'],duration=values['Duration'],defense=values.get('Defense'),hold=values.get('Hold attribute'),escape=values.get('Escape attribute'),effect=effect))
 assert len(spells)==len(rows)==11,p
 for row,e in zip(rows,spells):assert (row[0],row[1],row[2])==(e['page'],e['name'],e['sp']),p
 books.append(dict(title=lines[0][2:],key=key(p),**fields,rows=rows,spells=spells))
(G/'spellbooks.json').write_text(json.dumps(books,ensure_ascii=False))
magic='#pagebreak()\n#heading(level:1)[Magic and spellbooks]\n'+(G/'magic-rules.typ').read_text()+'\n#import "../spellbook-spreads.typ": spell-spread\n#let spellbooks = json("spellbooks.json")\n'
magic+='#pagebreak()\n#heading(level:2)[Choose your magical studies]\nBegin studying a discipline for its class-listed DP cost, then choose a spellbook. Follow a title to its complete two-page reference.\n#v(8pt)\n'
directory=[]
for d in ['Elements','Life','Mentalism','Divination','Invocation','Force','Wards']:
 panel='#block(breakable:false,above:5pt,below:12pt)[#metadata('+q(d)+')#label('+q(anchors[d.lower()])+')\n#grid(columns:(1fr,auto),[#text(font:"Cinzel",size:13pt,weight:"bold",fill:forest)['+d+']],[#discipline-mark('+q(d.lower())+',"",size:22pt)])\n#v(5pt)\n'
 for book in [b for b in books if b['Discipline']==d]:
  panel+='#block(above:3pt,below:3pt)[#grid(columns:(1fr,22pt),gutter:5pt,[#xref('+q(book['key'])+')['+book['title']+']],[#align(right)[#pageref('+q(book['key'])+')]])]\n'
 directory.append('['+panel+'] ]')
magic+='#reading-columns(('+','.join(directory)+',))\n'
d='Spellcraft'
magic+='#pagebreak()\n#heading(level:2)[Spellcraft]\n#metadata("Spellcraft")#label('+q(anchors['spellcraft'])+')\n'
text=(D/'disciplines/spellcraft.md').read_text();panels=[]
intro=text.split('## ',1)[0].split('\n\n',1)[1].strip()
magic+='#text(size:10pt,'+q(intro)+')\n#v(7pt)\n'
for sec in re.split(r'^## ',text,flags=re.M)[1:]:
 if '### ' not in sec:continue
 title=sec.splitlines()[0];entries=sec.split('### ')[1:]
 assert len(entries)==7,title
 for advanced,subset in [(False,entries[:3]),(True,entries[3:])]:
  body=[]
  for e in subset:
   n,meta,effect=e.strip().split('\n',2);dp,level=re.findall(r'\d+',meta)
   body.append(('#v(5pt)#line(length:100%,stroke:.4pt+gold)#v(5pt)\n' if body else '')+'#text(weight:"bold",'+q(n)+') #h(1fr) '+dp+' DP'+(' · Level '+level if int(level)>=3 else '')+'\n\n#text(size:9.5pt,'+q(effect)+')\n\n')
  panels.append('#catalog-card('+q(title+(' · Advanced practice' if advanced else ' · Foundations'))+','+q('spellcraft-'+title.lower().replace(' ','-')+('-advanced' if advanced else ''))+',icons:discipline-mark("spellcraft","",size:22pt))['+''.join(body)+']')
magic+='#reading-columns(('+','.join('['+p+']' for p in panels)+',))\n'
book=next(b for b in books if b['ID']=='channeling')
magic+='#block(above:4pt,below:4pt)[#xref('+q(book['key'])+')['+book['title']+'] #h(1fr) #pageref('+q(book['key'])+')]\n'
# Every book begins on a left-hand page and occupies exactly one facing spread.
for d in ['Elements','Life','Mentalism','Divination','Invocation','Force','Wards','Spellcraft']:
 for book in [b for b in books if b['Discipline']==d]:
  magic+='#spell-spread(spellbooks.find(b=>b.ID=='+q(book['ID'])+'))\n'
# Independent mastery spells accompany the existing two-page book spreads.
masteries=[]
for section in re.split(r'^## ',(D/'spell-masteries.md').read_text(),flags=re.M)[1:]:
 title=section.splitlines()[0]
 meta=dict(re.findall(r'^(ID|Book): (.+)$',section,re.M))
 cost=re.search(r'^DP: (\d+) \| Level: (\d+)$',section,re.M)
 values=dict(re.findall(r'^\*\*([^*]+):\*\* (.+)$',section,re.M))
 lines=section.splitlines();last=max(i for i,l in enumerate(lines) if l.startswith('**'))
 masteries.append(dict(name=title,id=meta['ID'],book=meta['Book'],dp=int(cost[1]),level=int(cost[2]),page='Mastery',action=values['Action'],sp=values['SP'],attribute=values['Attribute'],target=values['Target / range'],duration=values['Duration'],defense=values.get('Defense'),hold=values.get('Hold attribute'),escape=values.get('Escape attribute'),effect='\n'.join(lines[last+1:]).strip()))
assert len(masteries)==20
(G/'spell-masteries.json').write_text(json.dumps(masteries,ensure_ascii=False))
magic+='#pagebreak()\n#heading(level:1)[Spellbook masteries]\nAt level 7, learn a mastery after section IV of its named spellbook. Each costs 4 DP to learn; its printed SP is paid when casting. The original spells in each book remain available through its four sections.\n\nWeapon and shield workings use a required held weapon or shield as their casting focus in place of a free hand. Their normal casting, equipment and opportunity attack rules still apply.\n#import "../spellbook-spreads.typ": spell-entry\n#let masteries = json("spell-masteries.json")\n'
magic+='#let mastery-panels = ()\n'
for book in books:
 selected=[m for m in masteries if m['book']==book['ID']]
 if not selected:continue
 for i,entry in enumerate(selected):
  prefix=('#heading(level:2)['+book['title']+']\n#text(size:9pt)[Learn '+book['Endpoint']+' (section IV) first.]\n#v(5pt)\n') if i==0 else ''
  magic+='#mastery-panels.push(block(breakable:false)['+prefix+'#spell-entry(spellbooks.find(b=>b.ID=='+q(book['ID'])+'),masteries.find(m=>m.id=='+q(entry['id'])+'))])\n'
magic+='#reading-columns(mastery-panels)\n'
s=s+magic
(G/'learning.typ').write_text('#import "../template.typ": *\n'+anchorcode+s)
