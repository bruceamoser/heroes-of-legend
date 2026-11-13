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
 books.append(dict(title=lines[0][2:],key=key(p),**fields,rows=rows))
(G/'spellbooks.json').write_text(json.dumps(books,ensure_ascii=False))
magic='''
#let spellbooks = json("spellbooks.json")
#let section-colors = (rgb("e4eee2"),rgb("e0eaf1"),rgb("ece2f0"),rgb("f2e3c4"))
#let spellbook(b) = catalog-card(b.title,b.key)[
 #text(size:8.5pt,weight:"bold")[#b.Discipline / #b.List]
 #v(5pt)
 #table(columns:(23pt,1fr,23pt,22pt),inset:(x:3pt,y:2pt),stroke:none,
  fill:(x,y)=>if y==0 {forest} else {section-colors.at(if y<=2 {0} else if y<=4 {1} else if y<=6 {2} else {3})},
  table.header(..("Page","Spell","SP","Sect.").map(t=>text(size:8pt,fill:ivory,weight:"bold",t))),
  ..b.rows.map(r=>r.map(c=>text(size:9pt,c))).flatten())
 #v(5pt)
 #text(size:8.5pt)[*Learned sections:* I: 1 DP; II: 2 DP; III: 2 DP; IV: 3 DP, level 3. Learn in order.]
 #v(3pt)
 #text(size:8.5pt)[*Section IV: #b.Endpoint.* Teaches pages 7–8 and all three advanced pages together.]
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
  magic+='#text(size:10pt)[Learn '+d+' access for 1 DP. It opens these four books and teaches no spell. Learn each book’s sections in order; page 1 costs 0 SP to cast.]\n#v(7pt)\n#reading-columns(spellbooks.filter(b=>b.Discipline=='+q(d)+').map(spellbook))\n'
# Place spellbooks before the shared combination references.
pos=s.index('#let combinations =')
s=s[:pos]+magic+s[pos:]
(G/'learning.typ').write_text('#import "../template.typ": *\n'+anchorcode+s)
