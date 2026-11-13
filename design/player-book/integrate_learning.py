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
  spells.append(dict(name=title,id=values['ID'],page=values['Page'],action=values['Action'],sp=values['SP'],attribute=values['Attribute'],target=values['Target / range'],duration=values['Duration'],effect=effect))
 assert len(spells)==len(rows)==11,p
 for row,e in zip(rows,spells):assert (row[0],row[1],row[2])==(e['page'],e['name'],e['sp']),p
 books.append(dict(title=lines[0][2:],key=key(p),**fields,rows=rows,spells=spells))
(G/'spellbooks.json').write_text(json.dumps(books,ensure_ascii=False))
magic='#pagebreak()\n#heading(level:1)[Magic and spellbooks]\n'+(G/'magic-rules.typ').read_text()+'\n' + '''
#let spellbooks = json("spellbooks.json")
#let section-colors = (rgb("e4eee2"),rgb("e0eaf1"),rgb("ece2f0"),rgb("f2e3c4"))
#let spellbook(b) = catalog-card(b.title,b.key)[
 #text(size:8.5pt,weight:"bold")[#b.Discipline / #b.List]
 #v(5pt)
 #table(columns:(23pt,1fr,23pt,22pt),inset:(x:3pt,y:2pt),stroke:none,
  fill:(x,y)=>if y==0 {forest} else {section-colors.at(if y<=2 {0} else if y<=4 {1} else if y<=6 {2} else {3})},
  table.header(..("Page","Spell","SP","Sect.").map(t=>text(size:8pt,fill:ivory,weight:"bold",t))),
  ..b.rows.map(r=>(text(size:9pt,r.at(0)),text(size:9pt)[#xref("spell:"+b.ID+":"+lower(r.at(0)),r.at(1))],text(size:9pt,r.at(2)),text(size:9pt,r.at(3)))).flatten())
 #v(5pt)
 #text(size:8.5pt,style:"italic")[IV · #b.Endpoint]
]
#let spell-entry(b,e) = catalog-card(e.name,e.id)[
 #text(size:8.5pt,fill:forest)[#b.List · Page #e.page]
 #v(4pt)
 #let action-parts = e.action.split(" · ")
 #grid(columns:(1fr,auto),gutter:6pt,text(weight:"bold",action-parts.first()),text(weight:"bold",e.sp+" SP"))
 #if action-parts.len() > 1 { v(3pt); text(size:8.8pt, action-parts.slice(1).join(" · ")) }
 #v(3pt)
 #text(size:8.8pt)[*Resolution:* #if e.attribute == "None" { [Automatic] } else {e.attribute}]
 #linebreak()
 #text(size:8.8pt)[*Target / range:* #e.target]
 #linebreak()
 #text(size:8.8pt)[*Duration:* #e.duration]
 #v(5pt)
 #text(e.effect)
]
'''
for d in ['Elements','Life','Mentalism','Divination','Invocation','Force','Wards','Spellcraft']:
 magic+='#pagebreak()\n#heading(level:1,'+q(d)+')\n#metadata('+q(d)+')#label('+q(anchors[d.lower()])+')\n'
 if d=='Spellcraft':
  text=(D/'disciplines/spellcraft.md').read_text();panels=[]
  intro=text.split('## ',1)[0].split('\n\n',1)[1].strip()
  magic+='#text(size:10pt,'+q(intro)+')\n#v(7pt)\n'
  for sec in re.split(r'^## ',text,flags=re.M)[1:]:
   if '### ' not in sec:continue
   title=sec.splitlines()[0];body=[]
   for e in sec.split('### ')[1:]:
    n,meta,effect=e.strip().split('\n',2);dp,level=re.findall(r'\d+',meta)
    body.append(('#v(5pt)#line(length:100%,stroke:.4pt+gold)#v(5pt)\n' if body else '')+'#text(weight:"bold",'+q(n)+') #h(1fr) '+dp+' DP'+(' · Level 3' if level=='3' else '')+'\n\n#text('+q(effect)+')\n\n')
   panels.append('#catalog-card('+q(title)+','+q('spellcraft-'+title.lower().replace(' ','-'))+')['+''.join(body)+']')
  magic+='#reading-columns(('+','.join('['+p+']' for p in panels)+',[#spellbook(spellbooks.find(b=>b.ID=="channeling"))],))\n'
 else:
  magic+='#text(size:10pt)[Begin studying '+d+' for 1 DP, then choose one of these four spellbooks. Learn its sections in order, adding pages as your knowledge grows. Page 1 costs 0 SP to cast.]\n#v(7pt)\n#reading-columns(spellbooks.filter(b=>b.Discipline=='+q(d)+').map(spellbook))\n'
 for book in [b for b in books if b['Discipline']==d]:
  magic+='#pagebreak()\n#heading(level:2,'+q(book['title'])+')\n#text(size:10pt)['+d+' / '+book['List']+']\n#v(7pt)\n#reading-columns(spellbooks.find(b=>b.ID=='+q(book['ID'])+').spells.map(e=>spell-entry(spellbooks.find(b=>b.ID=='+q(book['ID'])+'),e)))\n'
# Place spellbooks before the shared combination references.
pos=s.index('#let combinations =')
s=s[:pos]+magic+s[pos:]
(G/'learning.typ').write_text('#import "../template.typ": *\n'+anchorcode+s)
