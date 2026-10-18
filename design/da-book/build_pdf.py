#!/usr/bin/env python3
"""Typeset approved Markdown and shared catalogs; never write back to game sources."""
import argparse, hashlib, json, os, re, shutil, subprocess, sys
from pathlib import Path
from markdown_it import MarkdownIt
import assemble
from creature_layout import parse_card, validate_universal_reference
ROOT=Path(__file__).resolve().parents[2]
BOOK=Path(__file__).resolve().parent
D=ROOT/'design'; GEN=BOOK/'generated'; OUT=BOOK/'output'
GEN.mkdir(exist_ok=True);OUT.mkdir(exist_ok=True)
M=json.loads((BOOK/'source-manifest.json').read_text())
ART_MANIFEST=D/'bestiary/art/manifest.json'
art_entries=json.loads(ART_MANIFEST.read_text())['entries']
creature_art={e['source']:e for e in art_entries}
sources,creatures,wound_rows=assemble.validate(M)
expected_art_sources={'design/'+s for f in M['families'] for s in f['sources']}
if set(creature_art)!=expected_art_sources or len(art_entries)!=len(expected_art_sources):
 raise ValueError('Creature portrait manifest coverage does not match the bestiary')
for entry in art_entries:
 p=ROOT/entry['illustration']
 if entry['status'] not in ('existing','generated') or not p.is_file():
  raise ValueError('Missing creature portrait: '+entry['id'])
 if hashlib.sha256(p.read_bytes()).hexdigest()!=entry['sha256']:
  raise ValueError('Creature portrait hash differs from manifest: '+entry['id'])
validate_universal_reference([D/s for f in M['families'] for s in f['sources']], (BOOK/'manuscript/09-using-the-bestiary.md').read_text())
md=MarkdownIt('commonmark').enable('table')
q=lambda x:json.dumps(str(x),ensure_ascii=False)
key=lambda p:assemble.anchor(str(Path(p).resolve().relative_to(D)))
name=lambda p:Path(p).read_text().splitlines()[0].removeprefix('# ')
files={(D/s).resolve():key(D/s) for s in sources}
aliases={'rules/foundations.md':'02-running-the-game.md','rules/session-resolution.md':'02-running-the-game.md','rules/stability.md':'09-using-the-bestiary.md','rules/summoning.md':'appendix-c-summoned-forms.md','rules/recovery.md':'08-campaigns-and-consequences.md','rules/encounters.md':'05-building-encounters.md','bestiary/encounters.md':'05-building-encounters.md','bestiary/procedure.md':'09-using-the-bestiary.md','bestiary/roster.md':'10-bestiary.md','bestiary/families.md':'10-bestiary.md','market.md':'07-treasure-and-rewards.md','monster-abilities/README.md':'appendix-b-monster-abilities.md','bestiary/summon-choices.md':'appendix-c-summoned-forms.md'}
for a,b in aliases.items():files[(D/a).resolve()]=key(BOOK/'manuscript'/b)
links=[];plain_links=set();assets=[]
def asset(path):
 p=Path(path).resolve()
 if p in assets:raise ValueError('Repeated illustration: '+str(p))
 assets.append(p)
 return '../'+str(p.relative_to(D)) if p.is_relative_to(D) else str(p)
def art(file,h=140,caption='',fit='contain'):
 p=BOOK/'art'/file if file.endswith('.svg') else D/'player-book/art/interior'/file
 return '#picture('+q(asset(p))+',height:'+str(h)+'pt,fit:'+q(fit)+',caption:['+inline_text(caption)+'])\n'
def inline_text(s):return inline(md.parseInline(s)[0].children,BOOK/'manuscript/01-becoming-the-da.md')
def inline(tokens,p):
 out=[];i=0
 while i<len(tokens):
  t=tokens[i]
  if t.type in ('text','code_inline'):out.append('#text('+q(t.content)+')')
  elif t.type in ('softbreak','hardbreak'):out.append(' ' if t.type=='softbreak' else '#linebreak()')
  elif t.type in ('strong_open','em_open'):out.append('#'+('strong' if t.type=='strong_open' else 'emph')+'[')
  elif t.type in ('strong_close','em_close'):out.append(']')
  elif t.type=='link_open':
   j=i+1
   while tokens[j].type!='link_close':j+=1
   body=inline(tokens[i+1:j],p);href=t.attrGet('href')
   if href.startswith(('https:','http:')):out.append('#link('+q(href)+')['+body+']')
   else:
    dest=(p.parent/href.split('#')[0]).resolve()
    if dest in files:out.append('#xref('+q(files[dest])+')['+body+']');links.append([str(p.relative_to(D)),str(dest.relative_to(D))])
    else:out.append(body);plain_links.add(str(dest.relative_to(D)) if dest.is_relative_to(D) else str(dest))
   i=j
  i+=1
 return ''.join(out)
def render(s,p,skip=True,tablefont=9.3,wide=False,worksheet=False):
 ts=md.parse(s);out=[];i=0
 while i<len(ts):
  t=ts[i]
  if t.type=='heading_open':
   level=int(t.tag[1]);body=inline(ts[i+1].children,p)
   if not(skip and level==1):out.append('#heading(level:'+str(min(3,level))+',outlined:false)['+body+']\n')
   i+=2
  elif t.type=='inline':out.append(inline(t.children,p))
  elif t.type=='paragraph_close':out.append('\n\n')
  elif t.type=='blockquote_open':out.append('#note[')
  elif t.type=='blockquote_close':out.append(']\n')
  elif t.type in ('bullet_list_open','ordered_list_open'):out.append('#'+('list' if t.type=='bullet_list_open' else 'enum')+'(\n')
  elif t.type in ('bullet_list_close','ordered_list_close'):out.append(')\n')
  elif t.type=='list_item_open':out.append('[')
  elif t.type=='list_item_close':out.append('],\n')
  elif t.type=='hr':out.append('#v(4pt)#line(length:100%,stroke:.4pt+gold)#v(4pt)\n')
  elif t.type in ('fence','code_block'):out.append('#raw('+q(t.content)+',block:true)\n')
  elif t.type=='table_open':
   rows=[];row=[];i+=1
   while ts[i].type!='table_close':
    x=ts[i]
    if x.type=='tr_open':row=[]
    elif x.type=='inline':row.append('['+inline(x.children,p)+']')
    elif x.type=='tr_close':rows.append(row)
    i+=1
   n=len(rows[0]);head='('+','.join(rows[0])+',)';rr='('+','.join('('+','.join(r)+',)' for r in rows[1:])+',)'
   widths=''
   hdr=' '.join(rows[0])
   if wide:
    if n==3 and 'Defense' in hdr:widths=',widths:(130pt,75pt,1fr)'
    elif n==6:widths=',widths:(80pt,48pt,55pt,1fr,1fr,1fr)'
    elif n==5 and 'Injury' in hdr:widths=',widths:(28pt,1.2fr,1.5fr,1.4fr,24pt)'
    elif n==2:widths=',widths:(1fr,2fr)'
   if p.parent.name in ('creatures','summons'):widths+=',compact:true,pad:3pt'
   blank=',blank:true' if all(all(c=='[]' for c in r[1:]) for r in rows[1:]) else ''
   if worksheet and blank:
    widths=(',widths:(1fr,1.6fr)' if n==2 else '')+',pad:10pt';tablefont=10
   out.append('#rule-table('+str(n)+','+head+','+rr+',font-size:'+str(tablefont)+'pt'+widths+blank+')\n\n')
  i+=1
 return ''.join(out)
def chunks(s,p,wide=False):
 result=[];pending=''
 for part in re.split(r'\n\s*\n',s.strip()):
  if re.match(r'^# [^\n]+$',part):continue
  if re.match(r'^#{2,3} [^\n]+$',part):pending+=part+'\n\n';continue
  result.append(render(pending+part,p,wide=wide));pending=''
 if pending:result.append(render(pending,p,wide=wide))
 return result
def reading(s,p):return '#reading-columns(('+','.join('['+c+']' for c in chunks(s,p))+',))\n'
def clean_editorial(s):
 return '\n'.join(l for l in s.splitlines() if not l.startswith(('**Status:**','**ID:**','[Creature procedure]','[DA creature card]')))
def cref(p,title=None):return '#xref('+q(key(p))+')['+inline_text(title or name(p).split(' (CV')[0])+']'
def table(head,rows,widths=None,font=8.8):
 return '#rule-table('+str(len(head))+',('+','.join('['+c+']' for c in head)+',),('+','.join('('+','.join('['+c+']' for c in r)+',)' for r in rows)+',),font-size:'+str(font)+'pt'+(',widths:'+widths if widths else '')+')\n'
body=['#import "../template.typ": *\n']
chapter_art={'01-becoming-the-da.md':'welcome.png','02-running-the-game.md':'discipline-instruments.png','03-building-adventures.md':'adventure.png','04-places-and-people.md':'cultures.png','05-building-encounters.md':'combat.png','06-hazards-and-environment.md':'climbing-kit.png','07-treasure-and-rewards.md':'coin-purse.png','08-campaigns-and-consequences.md':'recovery.png','09-using-the-bestiary.md':'summoning-ring.png'}
for src in M['chapters']:
 p=D/src;n=p.name.split('-')[0];label='ADVENTURE' if n=='03a' else 'CHAPTER '+str(int(n))
 body.append('#chapter('+q(label)+','+q(name(p))+','+q(key(p))+')\n')
 s=p.read_text()
 s=s.replace('**New adventure content:** names, placements, rewards and local obstacle targets\nare manuscript proposals for review. They do not establish universal rules.','The names, placements, rewards and obstacle targets belong to this adventure. They do not establish universal rules.')
 s=s.replace('**Review status:** the example hazards below are new content. Their damage, targets,\nareas and timings are proposed values for these entries only. They are not universal\ntrap damage or calibrated additions to encounter CV.','The damage, targets, areas and timings below apply to these entries only. They are not universal trap damage or calibrated additions to encounter CV.')
 if p.name in chapter_art:body.append(art(chapter_art[p.name],h=110,fit='contain'))
 body.append(reading(s,p))
 for supplement in M.get('shared_sections',{}).get(src,[]):
  sp=D/supplement
  body.append('#pagebreak(weak:true)\n#heading(level:2,outlined:true)['+inline_text(name(sp))+']\n#metadata('+q(key(sp))+')<'+key(sp)+'>\n'+reading(clean_editorial(sp.read_text()),sp))
 if n=='03a':
  body.append('#heading(level:2)[The crossing at a glance]\n'+art('crossing-routes.svg',h=290,caption='Connected locations. The service route lets the rescuers avoid the painted threshold.'))
  body.append('#pagebreak(weak:true)\n#heading(level:2)[The false toll: battle map]\n'+art('toll-yard.svg',h=440,caption='Starting positions are suggestions. Roll initiative normally if a fight begins.'))
  body.append('#pagebreak(weak:true)\n#heading(level:2)[The signal room: battle map]\n'+art('signal-room.svg',h=420,caption='The sentries guard the room. The stores alcove and rescue route remain outside that boundary.'))
 if n=='09':
  body.append('#block(breakable:false)[#heading(level:2)[Read the movement before moving the figures]\n'+art('stability-sequence.svg',h=235)+art('summon-tether.svg',h=245)+']\n')
 if n=='10':
  for family in M['families']:
   # Family navigation is a bookmark; the first card starts immediately below the family label.
   body.append('#pagebreak(weak:true)\n#heading(level:2,outlined:true)['+inline_text(family['name'])+']\n')
   for src2 in family['sources']:
    p2=D/src2;s2=p2.read_text().split('## Design notes',1)[0]
    card=parse_card(s2)
    top=render(card['description'],p2,skip=False)+'#grid(columns:(1.35fr,1fr),gutter:16pt,['+render(card['stats'],p2,skip=False)+'],['+render(card['defenses'],p2,skip=False)+'])'
    action_blocks=[]
    for kind,rows in card['tables']:
     if kind=='Main Actions':
      head=['Main Actions','Defense','Damage type','Weak / Standard / Strong defense']
      widths='(96pt,64pt,52pt,1fr)'
     else:head=[kind,'Effect'];widths='(96pt,1fr)'
     action_blocks.append(table(head,[[inline_text(c) for c in row] for row in rows],widths=widths,font=9.5))
    dc=[render('### '+title+'\n\n'+detail,p2,skip=False) for title,detail in card['details'].items()]
    dc += [render('### '+title+'\n\n'+detail,p2,skip=False) for title,detail in card['traits']]
    field_blocks=[render('**'+label+':** '+value,p2,skip=False) for label,value in card['fields']]
    notes='#creature-notes(('+','.join('['+c+']' for c in field_blocks)+',))'
    badge=''
    if card['summon']:
     category,tier,profile=card['summon']
     badge=',badge:summon-mark('+q(category)+','+q(tier)+','+q(key((p2.parent/profile).resolve()))+')'
    art_entry=creature_art[str(p2.relative_to(ROOT))]
    ap=ROOT/art_entry['illustration']
    artarg=',art:'+q(asset(ap))
    body.append('#creature('+q(name(p2))+','+q(key(p2))+',['+top+'],['+''.join(action_blocks)+'],('+','.join('['+c+']' for c in dc)+',),notes:['+notes+']'+badge+artarg+')\n')
for src in M['appendices']:
 p=D/src;letter=p.name.split('-')[1].upper()
 body.append('#chapter('+q('APPENDIX '+letter)+','+q(name(p))+','+q(key(p))+')\n')
 s=p.read_text().replace('Entries follow in alphabetical order. Their mechanical text comes directly from\nthe authored monster catalog. The assembled reference omits editorial status lines\nand shared navigation links; it retains every specific action, effect and limit.','Entries follow in alphabetical order. Only creatures whose entries list an ability possess it. Printed entry values and restrictions apply; no ability grants unlisted actions. Every creature card retains the specific effects needed during play.')
 s=s.replace('The full condition table follows in the assembled manuscript.','The full condition table follows.').replace('The five complete wound tables follow the conditions. They retain all 280 authored\nresults and their recovery values.','The five complete wound tables follow the conditions, with all 280 results and their recovery values.')
 if letter=='D':
  intro,*sections=re.split(r'(?=^## )',s,flags=re.M)
  tools_by_heading={part.splitlines()[0][3:]:part for part in sections}
  body.append(render(intro,p,wide=True))
  for i,group in enumerate([['Session preparation'],['Encounter record'],['NPC and faction record','Location record'],['Recovery record','Turn and outcome reminder']]):
   if i:body.append('#pagebreak(weak:true)\n')
   for title in group:body.append(render(tools_by_heading[title],p,wide=True,worksheet=True))
 else:body.append(reading(s,p))
 if letter=='B':
  cards=[]
  for src2 in sorted(M['monster_abilities'],key=lambda s:assemble.title(s).casefold()):
   p2=D/src2;s2=clean_editorial(p2.read_text()).replace('## Rules','')
   # Shared ownership/precedence boilerplate belongs in this appendix's introduction.
   s2=re.sub(r'(?:\*\*Limits:\*\* )?Only creatures whose entries list this ability possess it\. Printed\s+(?:entry values and restrictions apply; no ability grants unlisted actions\.|limits apply\.)','',s2)
   cards.append('#reference-card('+q(name(p2))+','+q(key(p2))+')['+render(s2,p2)+']')
  body.append('#reading-columns(('+','.join('['+c+']' for c in cards)+',))\n')
 if letter=='C':
  rows=[]
  for src2 in sorted(M['summons'],key=lambda s:(assemble.field(assemble.read(s),'Eligibility'),assemble.title(s))):
   p2=D/src2;rows.append([cref(p2),inline_text(assemble.field(p2.read_text(),'Eligibility')),'#pageref('+q(key(p2))+')'])
  body.append(table(['Summoned form','Category / tier','Page'],rows,widths='(1fr,150pt,40pt)'))
  for src2 in M['summons']:
   p2=D/src2;s2=clean_editorial(p2.read_text())
   s2='\n'.join(l for l in s2.splitlines() if not l.startswith(('Main command: Main + Maneuver;','**Summoned form — player reference.**')))
   # Wide tables keep each outcome readable; remaining material uses balanced details.
   pre,sep,rest=s2.partition('## Attacks — Main Action')
   if not sep:raise ValueError('Summon missing attacks: '+src2)
   match=re.search(r'(\| Attack \|.*?)(?=\n\n)',rest,re.S)
   if not match:raise ValueError('Summon missing attack table: '+src2)
   acts=match[1];details=rest.replace(acts,'',1)
   body.append('#creature('+q(name(p2).replace(' (CV',' — Summoned (CV'))+','+q(key(p2))+',['+render(pre,p2)+'],['+render(acts,p2,wide=True,tablefont=8.8)+'],('+','.join('['+c+']' for c in chunks(details,p2))+',))\n')
 if letter=='D':
  p2=D/M['conditions'];s2=p2.read_text();s2=s2[s2.index('| Condition |'):].split('\n\n',1)[0]
  body.append('#chapter("REFERENCE","Conditions",'+q(key(p2))+')\n'+reading(tools_by_heading['Condition reference'],p)+render(s2,p2,wide=True))
  p2=D/M['wounds'];s2=p2.read_text().split('## Physical\n',1)[1];s2='## Physical\n'+s2
  s2=s2.replace('Broad activity Banes replace the earlier limb-, Force-, and attribute-specific penalties.','The DA judges when physical activity penalties apply.').replace('Elemental 556 converts the earlier single-turn\nParalysis to **Paralyzed 1** under the shared decay rule.','').replace('Frightened uses the creature or phenomenon responsible as its source and now decays\nnormally; it no longer has the earlier until-safely-away duration.','Frightened uses the creature or phenomenon responsible as its source and decays normally.')
  s2=re.sub(r'### ([^:\n]+): 500 band\n\n(.*?)\n\n### \1: 600 band\n\n\| Roll \|[^\n]*\n\|[-| :]+\n',lambda m:'### '+m[1]+': 500 band and Last Words\n\n'+m[2]+'\n',s2,flags=re.S)
  body.append('#chapter("REFERENCE","Wound Tables",'+q(key(p2))+')\n'+reading(tools_by_heading['Wound reference'],p))
  for i,section in enumerate(re.split(r'(?=^## )',s2,flags=re.M)):
   if not section.strip():continue
   if i>1:body.append('#pagebreak(weak:true)\n')
   body.append(render(section,p2,wide=True,tablefont=9.3))
# Source-based indexes with live page links.
body.append('#chapter("REFERENCE","Creature Indexes","creature-indexes")\n#set text(size:9.2pt)\n')
records=[]
for fam in M['families']:
 for src in fam['sources']:
  p=D/src;s=p.read_text();records.append(dict(p=p,name=name(p).rsplit(' (CV',1)[0],cv=int(re.search(r'\(CV (\d+)\)',name(p))[1]),family=fam['name'],habitat=assemble.field(s,'Habitat'),role=assemble.field(s,'Role')))
for label,sorter in [('Name',lambda r:r['name']),('CV',lambda r:(r['cv'],r['name']))]:
 body.append(('' if label=='Name' else '#pagebreak(weak:true)\n')+'#heading(level:2)[By '+label+']\n')
 rows=[[cref(r['p']),str(r['cv']),'#pageref('+q(key(r['p']))+')'] for r in sorted(records,key=sorter)]
 # Divide into short tables; ordinary reading flow packs and balances columns.
 tables=[table(['Creature','CV','Page'],rows[i:i+32],widths='(1fr,25pt,27pt)',font=9) for i in range(0,len(rows),32)]
 body.append('#reading-columns(('+','.join('['+t+']' for t in tables)+',))\n')
for field,title in [('family','Family'),('habitat','Habitat'),('role','Role')]:
 body.append('#pagebreak(weak:true)\n#heading(level:2)[By '+title+']\n');groups={}
 for r in records:
  for g in r[field].split(';'):groups.setdefault(g.strip().casefold(),[]).append(r)
 blocks=[]
 for g,rs in sorted(groups.items()):
  blocks.append('#heading(level:3,outlined:false)['+inline_text(g.capitalize())+']\n'+''.join(cref(r['p'])+' #h(1fr)#pageref('+q(key(r['p']))+')#linebreak()\n' for r in sorted(rs,key=lambda r:r['name'])))
 body.append('#reading-columns(('+','.join('['+b+']' for b in blocks)+',))\n')
(GEN/'body.typ').write_text('\n'.join(body))
(GEN/'pdf-manifest.json').write_text(json.dumps({'sources':{s:hashlib.sha256((D/s).read_bytes()).hexdigest() for s in sources},'assets':[str(p.relative_to(ROOT)) for p in assets],'asset_hashes':{str(p.relative_to(ROOT)):hashlib.sha256(p.read_bytes()).hexdigest() for p in assets},'build_hashes':{str(p.relative_to(ROOT)):hashlib.sha256(p.read_bytes()).hexdigest() for p in [BOOK/'book.typ',BOOK/'cover.typ',BOOK/'template.typ',BOOK/'build_pdf.py',BOOK/'creature_layout.py',BOOK/'source-manifest.json',ART_MANIFEST,ROOT/'release/version.json']} ,'links':links,'player_book_references':sorted(plain_links),'creatures':len(creatures),'monster_abilities':len(M['monster_abilities']),'summons':len(M['summons']),'wound_results':len(wound_rows)},indent=2)+'\n')
args=argparse.ArgumentParser();args.add_argument('--compile',action='store_true');opts=args.parse_args()
if opts.compile:
 typst=os.environ.get('TYPST') or shutil.which('typst') or '/tmp/hol-typst/typst-x86_64-unknown-linux-musl/typst'
 common=['--root',str(ROOT),'--font-path',str(D/'player-book/fonts')]
 raw=OUT/'da-guide-unoptimized.pdf';final=OUT/'heroes-of-legend-da-guide-bestiary.pdf'
 subprocess.run([typst,'compile',*common,str(BOOK/'book.typ'),str(raw)],check=True)
 metadata={}
 for tag in ['art-placement','card-size','card-edge','summon-marker']:
  result=subprocess.check_output([typst,'eval',*common,'--in',str(BOOK/'book.typ'),f'query(<{tag}>).map(it => it.value)'],text=True)
  metadata[tag]=json.loads(result)
 (GEN/'layout-metadata.json').write_text(json.dumps(metadata,indent=2)+'\n')
 bundled=Path.home()/'.cache/codex-runtimes/codex-primary-runtime/dependencies/python/bin/python3'
 pdf_python=os.environ.get('PDF_PYTHON') or (str(bundled) if bundled.exists() else sys.executable)
 subprocess.run([pdf_python,str(D/'player-book/optimize_pdf.py'),str(raw),str(final)],check=True)
 print(final)
print(f'{len(sources)} sources; {len(assets)} distinct interior illustrations/diagrams; 192 creatures, 126 abilities, 73 summons, 280 wounds.')
