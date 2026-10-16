#!/usr/bin/env python3
"""Read authored Markdown and approved design records; emit Typst, never rewrite sources."""
import argparse, hashlib, json, re, shutil, subprocess, os
from pathlib import Path
from markdown_it import MarkdownIt
from PIL import Image
ROOT=Path(__file__).resolve().parents[2]
BOOK=Path(__file__).resolve().parent
DESIGN=ROOT/'design'
GEN=BOOK/'generated'; GEN.mkdir(exist_ok=True)
OUT=BOOK/'output'; OUT.mkdir(exist_ok=True)
md=MarkdownIt('commonmark').enable('table')
q=lambda s: json.dumps(str(s),ensure_ascii=False)
key=lambda p: 's-'+hashlib.sha1(str(Path(p).resolve().relative_to(ROOT)).encode()).hexdigest()[:12]
name=lambda p: Path(p).read_text().splitlines()[0].lstrip('# ').strip()
rel=lambda p: str(Path(p).resolve().relative_to(ROOT))
files={}; links=[]; excluded=set(); card_records=[]
SELECTED_PATHS={'thinking-fighter','green-healer','spellblade','light-fingered-adventurer'}
(GEN/'art-files.json').write_text(json.dumps([p.stem for p in (BOOK/'art/interior').glob('*.png')]))
art_report=[]
for asset in sorted((BOOK/'art/interior').glob('*.png')):
 with Image.open(asset) as im:
  art_report.append(dict(key=asset.stem,width=im.width,height=im.height,mode=im.mode,sha256=hashlib.sha256(asset.read_bytes()).hexdigest()))
(GEN/'art-report.json').write_text(json.dumps(art_report,indent=2)+'\n')
for folder in ['ancestries','origins','classes','disciplines','cards','paths','equipment','recipes','characters','bestiary/summons']:
 for p in (DESIGN/folder).glob('*.md'):
  if p.name!='README.md' and (folder!='paths' or p.stem in SELECTED_PATHS): files[p.resolve()]=key(p)
for p in (BOOK/'manuscript').glob('*.md'): files[p.resolve()]=key(p)
for f in ['market.md','starting-coins.md','rules/wounds.md','rules/conditions.md','bestiary/summon-choices.md']:
 p=DESIGN/f; files[p.resolve()]=key(p)
aliases={'development.md':'02-creation.md','rules/foundations.md':'06-playing.md','rules/session-resolution.md':'06-playing.md','rules/stability.md':'06-playing.md','card-conventions.md':'09-abilities.md','catalog.md':'09-abilities.md','rules/recovery.md':'08-recovery.md','rules/summoning.md':'11-summons.md','equipment.md':'10-equipment.md','recipes.md':'10-equipment.md','disciplines.md':'05-disciplines.md','fantasy-paths.md':'05-disciplines.md'}
for a,b in aliases.items(): files[(DESIGN/a).resolve()]=key(BOOK/'manuscript'/b)
for a,target in [('ancestry.md','ancestries/human.md'),('class.md','classes/protector.md'),('culture-background.md','origins/culture-border-marches.md')]: files[(DESIGN/a).resolve()]=key(DESIGN/target)

# Historical authoring metadata is omitted; the approval is recorded centrally.
def clean(p):
 s=p.read_text()
 if p.parent.name=='classes':s=s.replace(' No multiclassing.','').replace('## Rules','')
 if p.parent.name in ('cards','equipment','recipes','origins','ancestries','disciplines'):s=s.replace('## Rules','---')
 if p.parent.name=='equipment':s=s.replace('No DP price. Purchase does not grant training or an ability.','')
 s=s.replace('**Status:** Proposal. Choose', 'Choose')
 if p.parent==BOOK/'manuscript': return s
 s=re.sub(r'\*\*ID:\*\*[^\n]*','',s)
 s=re.sub(r'(?:- )?\*\*Status:\*\*[^\n]*','',s)
 s=re.sub(r'\*\*Trait status:\*\* revised proposals\.','',s)
 s=re.sub(r'\*\*Type:\*\* (Culture|Background)\. \*\*Status:\*\* Proposal\.',r'**Type:** \1.',s)
 s=re.sub(r'\*\*Inspiration lens:\*\*.*?This is a character\s*idea,', 'This is a character idea,',s,flags=re.S)
 # Navigation and review apparatus do not belong in the printed entry.
 s='\n'.join(line for line in s.splitlines() if not (line.startswith('[') and ('](' in line)) and not re.match(r'^-?\s*\*\*ID:',line))
 s=re.sub(r'See the \[full signature review\].*?Individual effects remain proposals\.','',s,flags=re.S)
 s=s.replace('The revised options aim for these moments, with a deliberate advantage over shared\ncards of their tier. Each is an independent choice, not a progression chain.','Each signature is an independent choice, not a progression chain.')
 s=s.replace('**Agreed:**','**Class foundations:**').replace('**Agreed concept:**','**Identity:**').replace('**Proposed foundations:**','**Class foundations:**').replace('**Proposal:**','**Starting disciplines:**').replace('**Proposed starting disciplines:**','**Starting disciplines:**').replace('**Proposed pricing:**','**Discipline pricing:**')
 s=s.replace(' (proposed allocation)','').replace('Proposal: ','').replace('no Opposed assignment proposed yet','no Opposed disciplines').replace('no Opposed assignment proposed','no Opposed disciplines')
 s=s.replace('New affinities are proposals. ','').replace('These are invitations to a familiar fantasy,','These are invitations to a familiar fantasy,')
 s=re.sub(r'Proposal; see \[market rules\]\([^)]*\)\.', '',s)
 s=s.replace('These are fresh proposals, not approved subclasses or mandatory shopping lists.','These are suggestions, not subclasses or mandatory shopping lists.')
 s=s.replace('This is a proposed ordinary recipe;','This is an ordinary recipe;')
 s=s.replace('This card does not target an unwilling creature.','An unwilling creature harmed by healing can be targeted as described below.')
 s=s.replace('**Offensive healing — latest agreement:**','**Offensive healing:**')
 if p.name=='use-a-healing-potion.md': s=s.split('**Offensive healing:')[0]
 if p.parent.name=='summons':
  s=re.sub(r' \(CV \d+\)','',s)
  s=s.replace('**Summoned form — player reference.**','')
  attributes=re.search(r'^\*\*Attributes:\*\*[^\n]*',s,re.M)
  if attributes:
   s=s.replace(attributes.group(0),'')
   s=s.replace('**HP:**',attributes.group(0)+'\n\n**HP:**',1)
 if p.name=='market.md':
  s=s[s.index('## What a coin buys'):]
  s=s.replace('**Proposed shop policy:**','**Shop refills:**').replace('explicitly proposed exception','exception').replace('proposed universal','universal').replace('proposed free','free').replace('proposed starting','starting').replace('proposed range','starting range')
  s=s.split('## Shopping bundles and starting range')[0]+s[s.index('## Shopping bundles and starting range'):].split('**Agreed starting target:')[0]
  s=s.replace('This is not a closed or proven macroeconomy: foraging success,','Foraging success,').replace('Large production should be\nreviewed before assigning guaranteed commercial income.','Discuss large commercial projects with the DA before assuming guaranteed income.')
 if p.name=='starting-coins.md':
  s=re.sub(r'\*\*Agreed target:\*\*.*?\n\n','',s,count=1,flags=re.S)
  s=s.replace('These allocations are a starting proposal, not an inference from the characters’ biology.','These allocations describe preparation, not biology.')
 if p.name=='summon-choices.md':
  s=s.replace('**Proposed permissions:**','**Selection:**').replace('Minimum card tier', 'Tier').replace('Useful command role', 'Role')
 if p.name=='conditions.md':
  # Teaching and timing are in the authored recovery chapter. Keep the complete table.
  start=s.index('| Condition |'); end=s.index('\n\n',s.index('| Invisible',start))
  s='# Condition reference\n\n'+s[start:end]
 if p.name=='wounds.md':
  s=s[s.index('## Physical\n'):]
  s=s.replace('Broad activity Banes replace the earlier limb-, Force-, and attribute-specific penalties.','The DA judges when a physical-activity penalty applies.')
  s=re.sub(r'##? [^\n]*?(?:design|review|concerns)[^\n]*\n.*?(?=\n##|\Z)','',s,flags=re.S|re.I)
 s=s.replace(' — proposed', '').replace(' proposal', '').replace('proposed ', '')
 if p.parent.name=='characters':
  s=re.sub(r'###? Summoning catalog.*?(?=\n##|\Z)', '', s, flags=re.S)
  s=s.replace('actual creature selection awaits the eligible bestiary profiles', 'choose from the Summoned Companions chapter')
 s=s.replace('The six worked characters now include purses and actual shopping ledgers. No one receives higher-level cards, extra DP or', 'The six worked characters include complete shopping ledgers. No one receives higher-level cards, extra DP or')
 s=re.sub(r'^\s*-\s*$', '', s, flags=re.M)
 return s.strip()+'\n'

def inline(tokens,p):
 out=[];i=0
 while i<len(tokens):
  t=tokens[i]
  if t.type in ('text','code_inline'): out.append('#text('+q(t.content)+')')
  elif t.type in ('softbreak','hardbreak'): out.append(' ' if t.type=='softbreak' else '#linebreak()')
  elif t.type=='strong_open': out.append('#strong[')
  elif t.type=='em_open': out.append('#emph[')
  elif t.type in ('strong_close','em_close'): out.append(']')
  elif t.type=='link_open':
   j=i+1;depth=1
   while j<len(tokens):
    if tokens[j].type=='link_open':depth+=1
    if tokens[j].type=='link_close':depth-=1
    if not depth:break
    j+=1
   body=inline(tokens[i+1:j],p);href=t.attrGet('href')
   if href.startswith(('http:','https:')): out.append('#link('+q(href)+')['+body+']')
   else:
    dest=(p.parent/href.split('#')[0]).resolve()
    if dest in files:
     out.append('#xref('+q(files[dest])+')['+body+']');links.append((rel(p),rel(dest)))
    else: out.append(body);excluded.add(rel(dest) if dest.is_relative_to(ROOT) else str(dest))
   i=j
  elif t.type=='html_inline': out.append('#text('+q(t.content)+')')
  elif t.type=='image': out.append('#text('+q(t.content)+')')
  i+=1
 return ''.join(out)

def render(s,p,base=2,skip_title=True):
 ts=md.parse(s);out=[];i=0
 while i<len(ts):
  t=ts[i]
  if t.type=='heading_open':
   lev=int(t.tag[1]);body=inline(ts[i+1].children,p)
   if not(skip_title and lev==1): out.append('#heading(level: '+str(min(3,base+lev-1))+')['+body+']\n')
   i+=2
  elif t.type=='paragraph_open': pass
  elif t.type=='inline': out.append(inline(t.children,p))
  elif t.type=='paragraph_close': out.append('\n\n')
  elif t.type=='blockquote_open':out.append('#note[\n')
  elif t.type=='blockquote_close':out.append(']\n')
  elif t.type in ('bullet_list_open','ordered_list_open'):out.append('#'+('list' if t.type=='bullet_list_open' else 'enum')+'(\n')
  elif t.type in ('bullet_list_close','ordered_list_close'):out.append(')\n')
  elif t.type=='list_item_open':out.append('[')
  elif t.type=='list_item_close':out.append('],\n')
  elif t.type=='hr':out.append('#v(3pt)#line(length: 100%, stroke: .4pt + gold)#v(3pt)\n')
  elif t.type in ('fence','code_block'):out.append('#raw('+q(t.content)+', block: true)\n')
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
   if p.name=='summon-choices.md':widths=', pad: 2pt, font-size: 8.5pt, widths: (27pt, 1.3fr, 1fr)'
   if p.name=='starting-coins.md':widths=', pad: 2pt, font-size: 8.7pt, widths: (1fr,27pt)'
   if p.name=='wounds.md' and n==5:widths=', widths: (30pt, 1.4fr, 1.65fr, 1.1fr, 25pt)'
   out.append('#rule-table('+str(n)+','+head+','+rr+widths+')\n\n')
  i+=1
 return ''.join(out)

included=[]
def record(p,kind):
 if rel(p) not in [r['path'] for r in included]:included.append({'path':rel(p),'kind':kind,'key':key(p),'sha256':hashlib.sha256(p.read_bytes()).hexdigest()})
def doc(p,kind='entry',wide=False,break_before=False):
 record(p,kind);s=clean(p)
 prefix='#pagebreak(weak: true)\n' if break_before else ''
 text='#entry('+q(name(p).replace(' (CV '+str(0)+')',''))+','+q(key(p))+')\n'+render(s,p)
 if kind=='discipline': text='#discipline-mark('+q(p.stem)+',"", size: 30pt)\n'+text
 if kind in ('equipment','recipes'):
  text='#catalog-card('+q(name(p))+','+q(key(p))+')['+render(s,p)+']\n'
 if kind in ('trait','culture','background','discipline','path'): text='#block(breakable: false)[\n'+text+']\n'
 return prefix+(text if wide else '#twocol[\n'+text+']\n')
def card(p):
 record(p,'ability');s=clean(p)
 def field(label,default=''):
  m=re.search(r'\*\*'+re.escape(label)+r':\*\*\s*(.*?)(?=\s*·\s*\*\*|\n|$)',s);return m.group(1).strip() if m else default
 tier=field('Tier / minimum level');req=field('Requirements to learn');action=field('Action');attr=field('Attribute');tags=field('Type');price=field('DP')
 card_records.append({'path':rel(p),'name':name(p),'tier':tier,'action':action,'requirements':req,'key':key(p)})
 if field('Tags'):tags+=' / '+field('Tags')
 s=re.sub(r'^\*\*(?:Action|Tier / minimum level|Type|Tags):\*\*.*\n','',s,flags=re.M)
 s=s.replace('## Rules','---')
 s=s.replace('**Equipment / acquisition:** No item needed unless named above.','').replace('**Equipment / acquisition:**','**Gear:**').replace('**Target / range / shape:**','**Target:**')
 s=s.replace('**Limits:** Repeatable; pay the action and any stated costs each use.','')
 icons=''.join('#discipline-mark('+q(d.lower())+','+q(r)+')' for d,r in re.findall(r'([A-Za-z]+) ([123])',req) if (DESIGN/'disciplines'/(d.lower()+'.md')).exists())
 return '#card(icons: ['+icons+'],'+','.join(map(q,[name(p),'U' if tier=='Universal' else tier,req,action,attr,tags,'Universal' if tier=='Universal' else price+' DP',key(p)]))+')[\n'+render(s,p)+']\n'

def manuscript(filename,n,title,artbrief=None):
 p=BOOK/'manuscript'/filename;record(p,'chapter')
 v='#chapter('+q(n)+','+q(title)+')\n#metadata('+q(key(p))+')'+ '<'+key(p)+'>\n'
 if artbrief:v+='#illustration('+q({'01-welcome.md':'welcome','06-playing.md':'combat','07-adventure.md':'adventure'}.get(filename,artbrief))+', height: 125pt, fit: "cover")\n'
 if filename in ('05-disciplines.md','09-abilities.md','11-summons.md'):
  artkey={'05-disciplines.md':'class-intellect','09-abilities.md':'class-odd','11-summons.md':'summon-ancestor-guardian'}[filename]
  v+='#grid(columns: (1fr,1fr), gutter:18pt, ['+render(p.read_text(),p)+'], [#illustration('+q(artkey)+',height:530pt)])\n'
 else:v+='#twocol[\n'+render(p.read_text(),p)+']\n'
 if filename not in ('14-reference.md','05-disciplines.md','09-abilities.md','11-summons.md'):v+='#tail-art('+q({'01-welcome.md':'journey','02-creation.md':'heroes','05-disciplines.md':'disciplines','06-playing.md':'combat','07-adventure.md':'adventure','08-recovery.md':'recovery','09-abilities.md':'abilities','10-equipment.md':'equipment','11-summons.md':'summon-ancestor-guardian'}[filename])+')\n'
 return v

def coin_reference():
 p=DESIGN/'starting-coins.md';record(p,'market-reference');t=clean(p)
 sections=dict((m.group(1),m.group(2)) for m in re.finditer(r'## ([^\n]+)\n(.*?)(?=\n## |\Z)',t,re.S))
 def table(title):return render('### '+title.replace(' contribution','')+'\n'+sections[title],p,base=1)
 intro=t.split('## Ancestry')[0]
 result='#pagebreak(weak: true)\n#entry("Starting coins",'+q(key(p))+')\n'+render(intro,p)+'\n'
 result+='#grid(columns: (2fr,1fr), gutter: 10pt, [#grid(columns:(1fr,1fr),gutter:10pt,['+table('Ancestry contribution')+table('Class contribution')+'],['+table('Culture contribution')+'])#illustration("equipment",height:125pt)], ['+table('Background contribution')+'])\n'
 result+='#note['+render('### Examples\n'+sections['Checks and examples'],p,base=1)+']\n'
 return result

def summon_roster():
 p=DESIGN/'bestiary/summon-choices.md';record(p,'summon-index');t=clean(p)
 chunks=dict((m.group(1),m.group(2)) for m in re.finditer(r'## ([^\n]+)\n(.*?)(?=\n## |\Z)',t,re.S))
 def group(k):return '#block(breakable: false)['+render('## '+k+'\n'+chunks[k],p,base=1)+']'
 result='#pagebreak(weak: true)\n#entry("Choose a summoned companion",'+q(key(p))+')\n'+render(t.split('## Animal')[0],p)+'\n'
 result+='#grid(columns: (1fr,1fr,1fr), gutter: 10pt, ['+group('Animal')+group('Spirit')+'], ['+group('Undead')+group('Elemental')+'], ['+group('Fey')+group('Construct')+'])\n'
 result+='#tail-art("summon-great-stag")\n'
 return result

def summon_card(p):
 record(p,'summon');s=clean(p)
 # The command/tether paragraph is taught once on the chapter introduction.
 s=re.sub(r'Main command:.*?No permanent loot\.', '',s,flags=re.S)
 s=re.sub(r'Roll its printed attack attribute.*?no independent active effects\.', '',s,flags=re.S)
 title=name(p).split(' (CV')[0]
 before,sep,after=s.partition('## Attacks')
 if not sep:before,sep,after=s.partition('## Actions')
 intro=render(before,p)
 body=render('## '+('Attacks' if '## Attacks' in s else 'Actions')+after,p) if sep else ''
 return '#companion-card('+q(title)+','+q(key(p))+','+q('summon-'+p.stem)+')['+intro+']['+body+']\n'

def section(n,title):return '#chapter('+q(n)+','+q(title)+')\n'
parts=['#import "../template.typ": *\n']
parts.append(manuscript('01-welcome.md','1','Welcome to Heroes of Legend','Four companions pause at a ruined library threshold: shield, lantern, open book and bow. Show their anticipation, not a battle.'))
parts.append(manuscript('02-creation.md','2','Create Your Hero'))
parts.append(section('3','Ancestry, Culture and Background'))
parts.append('#twocol[Choose the people, places and experiences that shaped you. Choose two ancestry traits, then one complete culture pair and one complete background pair. Any ancestry may come from any culture.\n\nYour ancestry supplies inherited traits. Your culture describes a community and its traditions. Your background recalls something you did or experienced before adventuring. These choices offer connections, memories and capabilities; they do not dictate your personality.\n\nChoose each origin as a complete pair: its rank and ability belong together. Resolve all level-0 grants before making purchases. Duplicate grants add one DP to that stage rather than a higher rank or unrestricted replacement.]\n#illustration("origins", height: 330pt, fit: "cover")\n')
for a in ['human','elf','dwarf','halfling']:
 parts.append('#pagebreak(weak: true)\n#grid(columns: (1fr,1fr), gutter: 18pt, [\n'+doc(DESIGN/'ancestries'/f'{a}.md','ancestry',wide=True)+'], [#illustration('+q('ancestry-'+a)+', height: 245pt)])\n')
 parts.append('#twocol[\n'+''.join(doc(DESIGN/'ancestries'/x,'trait',wide=True) for x in re.findall(r'\]\((trait-[^)]+\.md)\)',(DESIGN/'ancestries'/f'{a}.md').read_text()))+']\n')
for typ,title in [('culture','Cultures'),('background','Backgrounds')]:
 parts.append('#pagebreak(weak: true)\n#heading(level: 2,'+q(title)+')\n#twocol[\n')
 intro=BOOK/'manuscript'/('intro-'+typ+'.md');record(intro,'section');parts.append('#metadata('+q(key(intro))+')<'+key(intro)+'>\n'+render(intro.read_text(),intro))
 for p in sorted((DESIGN/'origins').glob(typ+'-*.md'),key=name):parts.append(doc(p,typ,wide=True))
 parts.append(']\n#tail-art('+q(typ+'s')+')\n')
parts.append(section('4','Classes'))
parts.append('#grid(columns:(1fr,1fr),gutter:18pt,[Choose the identity you want to bring to the company. Each class grants two starting discipline choices and a signature at levels 1, 3 and 7. Shared abilities remain open to anyone who qualifies. Signatures belong only to their class.\n\nMeet both attribute minimums before choosing your class. A minimum of zero leaves room for an unconventional hero who succeeds through other strengths. Odd has no minimums and pays the same discipline prices across every field.\n\nChoose one class; there is no multiclassing. You can still learn any shared ability whose requirements you meet, but another class’s signatures remain exclusive.], [\n')
class_rows=[]
for cp in sorted((DESIGN/'classes').glob('*.md'),key=name):
 ct=cp.read_text(); mm=re.search(r'minimum 0 in ([^;]+);',ct); hp=re.search(r'HP contribution (\+\d+)',ct)
 class_rows.append('| ['+name(cp)+'](classes/'+cp.name+') | '+(mm.group(1) if mm else 'None')+' | '+hp.group(1)+' |')
parts.append(render('| Class | Attributes at least 0 | HP contribution |\n|---|---|---|\n'+'\n'.join(class_rows), DESIGN/'class.md')+'])\n')
parts.append('#illustration("classes", height: 350pt, fit: "cover")\n')
for cname in ['protector','blade','arcanist','shepherd','intellect','leader','unbalanced','shadow','odd','warden']:
 p=DESIGN/'classes'/f'{cname}.md'
 parts.append('#pagebreak(weak: true)\n#grid(columns: (1fr,1fr), gutter: 18pt, [\n'+doc(p,'class',wide=True)+'], [#illustration('+q('class-'+cname)+', height: 460pt, fit: "cover")])\n#pagebreak(weak: true)\n#twocol[\n')
 sigs=re.findall(r'\]\(\.\./cards/(signature-[^)]+\.md)\)',p.read_text())
 for sig in sigs:parts.append(card(DESIGN/'cards'/sig))
 parts.append(']\n#tail-art('+q('class-'+cname)+')\n')
parts.append(manuscript('05-disciplines.md','5','Disciplines and Character Paths'))
parts.append('#pagebreak(weak: true)\n#twocol[\n')
for p in sorted((DESIGN/'disciplines').glob('*.md'),key=name):parts.append(doc(p,'discipline',wide=True))
parts.append(']\n#pagebreak(weak: true)\n#heading(level: 2)[Character paths]\n#twocol[\n')
for p in sorted((DESIGN/'paths').glob('*.md'),key=name):
 if p.stem in SELECTED_PATHS:parts.append(doc(p,'path',wide=True))
parts.append(']\n#tail-art("paths")\n')
parts.append(manuscript('06-playing.md','6','Playing the Game','Overhead square-grid scene: one guardian blocks a doorway while companions use cover and a forced push opens an escape route. Clear spaces and no decorative grid distortion.'))
parts.append(manuscript('07-adventure.md','7','Beyond the Battlefield','An adventuring company shares a riverside camp with travelers; one mends a rope, one bargains, one watches the forest.'))
parts.append(manuscript('08-recovery.md','8','Harm and Recovery'))
parts.append(doc(DESIGN/'rules/conditions.md','condition-reference',wide=True,break_before=True))
parts.append(manuscript('09-abilities.md','9','Abilities'))
for tier in ['Universal','1','3','7']:
 parts.append('#pagebreak(weak: true)\n#heading(level: 2,'+q({'Universal':'Universal actions','1':'Novice abilities','3':'Adept abilities','7':'Master abilities'}[tier])+')\n#twocol[\n')
 for p in sorted((DESIGN/'cards').glob('*.md'),key=name):
  if p.name.startswith('signature-'):continue
  m=re.search(r'\*\*Tier / minimum level:\*\*\s*(\w+)',p.read_text())
  if m and m.group(1)==tier:parts.append(card(p))
 parts.append(']\n')
parts.append(manuscript('10-equipment.md','10','Equipment and Recipes'))
parts.append(coin_reference())
parts.append(doc(DESIGN/'market.md','market-reference',wide=True,break_before=True))
for folder,title in [('equipment','Equipment entries'),('recipes','Recipes')]:
 parts.append('#pagebreak(weak: true)\n#heading(level: 2,'+q(title)+')\n#twocol[\n')
 intro=BOOK/'manuscript'/('intro-'+folder+'.md');record(intro,'section');parts.append('#metadata('+q(key(intro))+')<'+key(intro)+'>\n'+render(intro.read_text(),intro))
 for p in sorted((DESIGN/folder).glob('*.md'),key=name):parts.append(doc(p,folder,wide=True))
 parts.append(']\n#tail-art('+q(folder)+')\n')
parts.append(manuscript('11-summons.md','11','Summoned Companions'))
parts.append(summon_roster())
for p in sorted((DESIGN/'bestiary/summons').glob('*.md'),key=name):parts.append(summon_card(p))
parts.append(section('12','Wound Tables'))
parts.append('#note[Roll 3d6 plus one die per prior wound, maximum five dice total. Keep the highest three, sort ascending and read the three-digit result. Use the damage-type table. Each wound always leaves a scar; treatment removes only its printed treatable effects. See Harm and Recovery for the complete procedure.]\n')
p=DESIGN/'rules/wounds.md';record(p,'wound-tables');parts.append('#metadata('+q(key(p))+')<'+key(p)+'>\n'+render(clean(p),p,base=1))
parts.append(section('13','Ready-to-Play Heroes'))
parts.append('#twocol[These six level-1 heroes show complete creation, including both DP ledgers and paid equipment. Use one as written or follow its ledger as an example. A changed choice must still meet requirements. Lira is an archer built as a Blade; the Warden provides another route to a wilderness-focused hero.]\n')
hero_intro=(DESIGN/'characters/README.md').read_text()
hero_rows=[]
for line in hero_intro.splitlines():
 if line.startswith('| ['):
  cells=line.strip('|').split('|')
  if len(cells)!=8:continue
  hero_rows.append('| '+cells[0].strip()+' | '+cells[1].strip()+' | '+cells[2].strip()+' |')
assert len(hero_rows)==6, 'Expected six character overview rows'
parts.append(render('| Hero | Fantasy | Ancestry and class |\n|---|---|---|\n'+'\n'.join(hero_rows), DESIGN/'characters/README.md'))
parts.append('#illustration("heroes", height: 340pt, fit: "cover")\n')
for p in sorted((DESIGN/'characters').glob('*.md'),key=name):
 if p.name!='README.md':parts.append(doc(p,'character',wide=True,break_before=True))
parts.append(manuscript('14-reference.md','14','Table References'))
parts.append('#include "../sheets.typ"\n')
parts.append('#pagebreak(weak: true)\n#heading(level: 2)[Ability index]\n#twocol[\n#set text(size: 9pt)\n')
for c in sorted(card_records,key=lambda x:x['name'].casefold()):
 parts.append('#block(below: 4pt, breakable: false)[#grid(columns: (1fr, 23pt), gutter: 5pt, [#xref('+q(c['key'])+')[#text('+q(c['name'])+')]#linebreak()#text(size: 8pt)['+c['tier']+' · '+c['action']+']], align(right)[#pageref('+q(c['key'])+')])]\n')
parts.append(']\n')
(GEN/'body.typ').write_text(''.join(parts))
manifest={'included':included,'cards':card_records,'internal_links':links,'external_design_references_rendered_as_text':sorted(excluded),'expected':{'ability':350,'ancestry':4,'trait':20,'culture':18,'background':32,'class':10,'discipline':18,'path':4,'equipment':43,'recipes':10,'summon':73,'character':6}}
(GEN/'manifest.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n')
print('Included',len(included),'records;',len(card_records),'abilities;',len(links),'internal links.')
if '--compile' in os.sys.argv:
 typst=os.environ.get('TYPST') or shutil.which('typst') or '/tmp/hol-typst/typst-x86_64-unknown-linux-musl/typst'
 from export import export
 export(typst,ROOT,BOOK)
