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
 if p.name.startswith('trait-'):
  s=re.sub(r'^\*\*Ancestry:\*\*[^\n]*\n','',s,flags=re.M)
  s=s.replace('**Duration:** While its stated circumstances apply; permanent for base statistics.','')
 if p.parent.name=='origins':
  s=re.sub(r'^\*\*Type:\*\*[^\n]*\n','',s,flags=re.M)
  s=re.sub(r'^(?:Each option is a pair\.|Grant at level 0\.).*\n','',s,flags=re.M)
 if p.parent.name=='paths':
  s=s.replace('This is a character idea, not a new class, subclass or prerequisite chain.','')
  s=s.replace('These are independent cards. You need every stated discipline rank, not the earlier card.','')
  s=s.replace('Class signatures add a separate personal accent.','')
 if p.parent.name=='equipment':
  for line in [
   'Buying equipment grants no DP advancement, training or ability. Use normal item-handling actions unless an applicable card says otherwise.',
   'Apply this item’s printed benefit only; it grants no ability or action beyond what it states. No DP purchase; found or bought when the DA makes it available. No special recipe is supplied by owning it.',
   '- **Acquisition:** Explicit ability grant, coins, or DA treasure; no automatic extra starting kit.',
  ]:s=s.replace(line,'')
 if p.parent.name=='classes':s=s.replace(' No multiclassing.','').replace('## Rules','')
 if p.parent.name in ('cards','equipment','recipes','origins','ancestries','disciplines'):s=s.replace('## Rules','---')
 if p.parent.name=='disciplines':
  s=re.sub(r'Ranks 1, 2 and 3 are purchased in order\..*?(?=\n\[Discipline index)', '', s, flags=re.S)
 if p.parent.name=='equipment':s=s.replace('No DP price. Purchase does not grant training or an ability.','')
 s=s.replace('**Status:** Proposal. Choose', 'Choose')
 if p.parent==BOOK/'manuscript': return s
 s=re.sub(r'\*\*ID:\*\*[^\n]*','',s)
 s=re.sub(r'(?:- )?\*\*Status:\*\*[^\n]*','',s)
 s=re.sub(r'\*\*Trait status:\*\* revised proposals\.','',s)
 s=re.sub(r'\*\*Type:\*\* (Culture|Background)\. \*\*Status:\*\* Proposal\.',r'**Type:** \1.',s)
 s=re.sub(r'\*\*Inspiration lens:\*\*.*?This is a character\s*idea,', 'This is a character idea,',s,flags=re.S)
 if p.parent.name=='paths':s=s.replace('This is a character idea, not a new class, subclass or prerequisite chain.','')
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
  s=re.sub(r'\b(?:Home|Adjacent|Foreign|Opposed);', 'Class price;', s)
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
   if p.parent.name=='classes':widths=', pad: 4pt, font-size: 10pt, widths:(1fr,33pt,33pt,33pt)'
   if p.parent.name=='recipes':widths=', widths:(65pt,1fr)'
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
 if kind in ('equipment','recipes','trait','culture','background','discipline'):
  icons='[ #discipline-mark('+q(p.stem)+',"",size:28pt) ]' if kind=='discipline' else '[]'
  text='#catalog-card('+q(name(p))+','+q(key(p))+', icons: '+icons+')['+render(s,p)+']\n'
 else:
  text='#entry('+q(name(p))+','+q(key(p))+')\n'+render(s,p)
 if kind=='path': text='#block(breakable: false)[\n'+text+']\n'
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
 s=s.replace('**Limits:** Repeatable; normal action economy applies.','')
 for line in ['**Equipment / acquisition:** None.', '**Gear:** None.',
  '**Duration:** Instant. Applied conditions follow their normal duration and decay.',
  '**Duration:** Resolve once at the stated trigger; applied conditions follow normal decay.']:
  s=s.replace(line,'')
 # General procedures are taught once; retain every card-specific target and outcome.
 s=s.replace('For a player attack, work out each target’s net Boons or Banes. Make one attack roll using the combination least favorable to you and apply that result to every target. Affect the creatures specified under Target, including allies if the area includes them. When an NPC attacks, each affected player makes a separate defense roll.','')
 if '**Summoning' not in s and 'Choose one bestiary entry explicitly approved for' in s:
  s=re.sub(r'Choose anew each casting;.*?Apply \[Command a Summon\].*?\n', 'Use its profile in [Summoned Companions](../player-book/manuscript/11-summons.md) and the shared summoning procedure.\n',s,flags=re.S)
 icons=''.join('#discipline-mark('+q(d.lower())+','+q(r)+')' for d,r in re.findall(r'([A-Za-z]+) ([123])',req) if (DESIGN/'disciplines'/(d.lower()+'.md')).exists())
 return '#card(icons: ['+icons+'],'+','.join(map(q,[name(p),'U' if tier=='Universal' else tier,req,action,attr,tags,'Universal' if tier=='Universal' else price+' DP',key(p)]))+')[\n'+render(s,p)+']\n'

def flow(entries):
 return '#reading-columns(('+','.join('['+c+']' for c in entries)+',))\n'

def reading(s,p):
 chunks=[];pending=''
 for part in re.split(r'\n\s*\n',s.strip()):
  if re.match(r'^# [^\n]+$',part):continue
  if re.match(r'^#{2,3} [^\n]+$',part):pending+=part+'\n\n';continue
  chunks.append(render(pending+part,p));pending=''
 if pending:chunks.append(render(pending,p))
 return '#reading-columns(('+','.join('['+c+']' for c in chunks)+',))\n'

def manuscript(filename,n,title,artbrief=None):
 p=BOOK/'manuscript'/filename;record(p,'chapter')
 v='#chapter('+q(n)+','+q(title)+')\n#metadata('+q(key(p))+')'+ '<'+key(p)+'>\n'
 if artbrief:v+='#illustration('+q({'01-welcome.md':'welcome','06-playing.md':'combat','07-adventure.md':'adventure'}.get(filename,artbrief))+', height: 125pt, fit: "cover")\n'
 if filename=='05-disciplines.md':
  overview,directions=p.read_text().split('## Choose a direction',1)
  v+='#grid(columns:(1fr,1fr),gutter:18pt,['+render(overview,p)+'],['+render('## Choose a direction'+directions,p)+'#v(10pt)#illustration("fields-of-study",height:265pt)])\n'
 elif filename=='09-abilities.md':
  v+=reading(p.read_text(),p)+'#tail-art("learned-relics")\n'
 elif filename=='11-summons.md':
  artkey={'05-disciplines.md':'fields-of-study','09-abilities.md':'learned-relics','11-summons.md':'summoning-ring'}[filename]
  v+='#grid(columns: (1fr,1fr), gutter:18pt, ['+render(p.read_text(),p)+'], [#illustration('+q(artkey)+',height:530pt)])\n'
 else:v+=reading(p.read_text(),p)
 if filename not in ('14-reference.md','05-disciplines.md','09-abilities.md','11-summons.md','06-playing.md','07-adventure.md','01-welcome.md'):v+='#tail-art('+q({'01-welcome.md':'journey','02-creation.md':'journeyman-kit','05-disciplines.md':'disciplines','06-playing.md':'combat','07-adventure.md':'adventure','08-recovery.md':'recovery','09-abilities.md':'abilities','10-equipment.md':'equipment','11-summons.md':'summon-ancestor-guardian'}[filename])+')\n'
 return v

def coin_reference():
 p=DESIGN/'starting-coins.md';record(p,'market-reference');t=clean(p)
 sections=dict((m.group(1),m.group(2)) for m in re.finditer(r'## ([^\n]+)\n(.*?)(?=\n## |\Z)',t,re.S))
 def table(title):return render('### '+title.replace(' contribution','')+'\n'+sections[title],p,base=1)
 intro=t.split('## Ancestry')[0]
 result='#pagebreak(weak: true)\n#entry("Starting coins",'+q(key(p))+')\n'+render(intro,p)+'\n'
 result+='#grid(columns: (2fr,1fr), gutter: 10pt, [#grid(columns:(1fr,1fr),gutter:10pt,['+table('Ancestry contribution')+table('Class contribution')+'],['+table('Culture contribution')+'])#illustration("coin-purse",height:125pt)], ['+table('Background contribution')+'])\n'
 result+='#note['+render('### Examples\n'+sections['Checks and examples'],p,base=1)+']\n'
 return result

def summon_roster():
 p=DESIGN/'bestiary/summon-choices.md';record(p,'summon-index');t=clean(p)
 chunks=dict((m.group(1),m.group(2)) for m in re.finditer(r'## ([^\n]+)\n(.*?)(?=\n## |\Z)',t,re.S))
 def group(k):return '#block(breakable: false)['+render('## '+k+'\n'+chunks[k],p,base=1)+']'
 result='#pagebreak(weak: true)\n#entry("Choose a summoned companion",'+q(key(p))+')\n'+render(t.split('## Animal')[0],p)+'\n'
 result+='#grid(columns: (1fr,1fr,1fr), gutter: 10pt, ['+group('Animal')+group('Spirit')+'], ['+group('Undead')+group('Elemental')+'], ['+group('Fey')+group('Construct')+'])\n'
 result+='#tail-art("forest-sanctuary")\n'
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

CLASS_ORDER=['protector','blade','arcanist','shepherd','intellect','leader','unbalanced','shadow','odd','warden']
DISCIPLINES=sorted(p.stem for p in (DESIGN/'disciplines').glob('*.md'))
SUMMARIES=json.loads((BOOK/'ability-summaries.json').read_text())

def rank_costs(p):
 text=p.read_text()
 if 'Adjacent for every discipline' in text:return {d:(2,4,8) for d in DISCIPLINES}
 result={d:(3,6,12) for d in DISCIPLINES}
 for band,cost in [('Home',(1,2,4)),('Adjacent',(2,4,8)),('Opposed',(4,8,16))]:
  m=re.search(band+r': ([^.]+)\.',text)
  if m:
   for d in m.group(1).lower().split(', '):
    assert d in result,(p,d)
    result[d]=cost
 return result

def class_page(p):
 record(p,'class');s=clean(p);raw=p.read_text()
 narrative=re.search(r'^\*([^*]+)\*$',s,re.M).group(1)
 attrs=re.search(r'minimum 0 in ([^;]+);',raw)
 attrs=(attrs.group(1).replace(' and ', ', ')+' ≥ 0') if attrs else 'No minimums'
 hp=re.search(r'HP contribution (\+\d+)',raw).group(1)
 coins=re.search(r'\*\*Starting coin contribution:\*\* (\+\d+)',raw).group(1)
 starting=re.search(r'choose two distinct rank-1 disciplines from ([^.]+)',raw).group(1)
 if p.stem=='odd':starting='any two disciplines'
 else:starting=starting+'.'
 core='*'+narrative+'*\n\n**Attributes:** '+attrs+'. **HP:** '+hp+'. **Coins:** '+coins+'.\n\n**Starting ranks:** Choose two distinct rank-1 disciplines from '+starting+'\n'
 if p.stem=='odd':core=core.replace('from any two disciplines','the full list below.')
 costs=rank_costs(p)
 cost_table='| Discipline | 1 | 2 | 3 |\n|---|---:|---:|---:|\n'+'\n'.join('| ['+d.title()+'](../disciplines/'+d+'.md) | '+' | '.join(map(str,costs[d]))+' |' for d in DISCIPLINES)
 core+='\n### Discipline costs · DP per rank\n'+cost_table
 choices=s[s.index('## Level 1 choices'):]
 choices=choices.split('## Signature identity in play')[0].split('## Signature identity')[0].split('## The character at the table')[0]
 # The Warden uses the same three choice headings but has no review appendix.
 choices=re.sub(r'\*\*Starting coin contribution:.*','',choices,flags=re.S)
 sigs='#grid(columns:(1fr,1fr,1fr),gutter:12pt,'+','.join('['+render('## '+part,p,base=1)+']' for part in choices.split('## ')[1:])+')'
 result='#pagebreak(weak:true)\n#class-panel('+q(name(p))+','+q(key(p))+')[\n#grid(columns:(1.05fr,1fr),gutter:16pt,['+render(core,p,base=1)+'],[#illustration('+q('class-'+p.stem+'-cutout')+',height:520pt)])]\n'
 result+='#v(8pt)\n#signature-menu['+sigs+']\n'
 return result

def discipline_matrix():
 ps=[DESIGN/'classes'/f'{c}.md' for c in CLASS_ORDER];costs={p.stem:rank_costs(p) for p in ps}
 head=['[Discipline]']+['[#text('+q(name(p))+')]' for p in ps]
 rows=[]
 for d in DISCIPLINES:
  row=['[#xref('+q(key(DESIGN/'disciplines'/f'{d}.md'))+')[#text('+q(d.title())+')]]']
  row+=['['+'/'.join(map(str,costs[p.stem][d]))+']' for p in ps];rows.append('('+','.join(row)+',)')
 result='#pagebreak(weak:true)\n#heading(level:2)[Discipline costs by class]\n'
 result+='Each cell gives *rank 1 / rank 2 / rank 3*, in DP. These are separate purchases, not cumulative totals. Read across to compare classes or down to plan your own studies.\n\n'
 result+='#cost-matrix(('+','.join(head)+',),('+','.join(rows)+',))\n'
 result+='#v(12pt)\n#grid(columns:(1fr,1fr),gutter:18pt,[Some studies come naturally to your class; others take more development. Every discipline remains available after level 0.],[A starting rank granted by your origin or class is already owned. Pay only for ranks you still need, in order. Ability prices remain 2 / 4 / 8 DP by tier.])\n#tail-art("discipline-instruments")\n'
 return result

def hp_reference():
 p=BOOK/'manuscript/02-creation.md'
 ancestry=[]
 for a in ['human','elf','dwarf','halfling']:
  row=next(l for l in p.read_text().splitlines() if l.startswith('| '+a.title()+' |'));cells=row.strip('|').split('|');ancestry.append('| '+cells[0].strip()+' | '+cells[1].strip()+' |')
 classes=[]
 for c in CLASS_ORDER:
  cp=DESIGN/'classes'/f'{c}.md';classes.append('| '+name(cp)+' | '+re.search(r'HP contribution (\+\d+)',cp.read_text()).group(1)+' |')
 intro='#pagebreak(weak:true)\n#heading(level:2)[Starting HP]\n#label("starting-hp")\nYour maximum HP brings together your heritage, training and endurance. Calculate it after choosing your traits and purchases; then start at that maximum.\n\n#note[#align(center)[#text(size:15pt,weight:"bold")[12 + ancestry + class + Fortitude + explicit benefits]]]\n'
 table=lambda title,rows:render('## '+title+'\n| Choice | HP |\n|---|---:|\n'+'\n'.join(rows),p,base=1).replace('#rule-table(2,','#rule-table(widths:(1fr,45pt),pad:5pt,font-size:11pt,2,')
 intro+='#grid(columns:(1fr,1fr),gutter:18pt,['+table('Ancestry',ancestry)+'#heading(level:3)[Fortitude and benefits]\nAdd your Fortitude, including a negative value. Then add only benefits you actually chose. Deep Constitution and Conditioned Body, for example, each add 1 HP.\n\nHP does not increase automatically with level. Record current HP separately from your maximum.],['+table('Class',classes)+'])\n'
 intro+='#v(12pt)\n#heading(level:3)[Two different beginnings]\n#grid(columns:(1fr,1fr),gutter:18pt,[*Dwarf Protector*\n\n12 + 4 ancestry + 5 class + 2 Fortitude = *23 HP*. With the dwarf’s HP trait and Conditioned Body, the total is *25*.],[*Halfling Arcanist*\n\n12 + 1 ancestry + 2 class − 1 Fortitude = *14 HP*, before any explicit benefits. Low HP need not limit the hero’s imagination or ambition.])\n'
 intro+='#tail-art("hp-vitality")\n'
 return intro

def ability_browser(paths,tier):
 title={'Universal':'Universal actions','1':'Novice abilities','3':'Adept abilities','7':'Master abilities'}[tier]
 result='#pagebreak(weak:true)\n#heading(level:2,'+q(title)+')\n'
 result+='Find a useful option here, then follow its name to the complete card. Summaries help you choose; the card supplies the exact targets, costs and outcomes.\n\n'
 rows=[]
 for p in paths:
  s=p.read_text()
  field=lambda label:re.search(r'\*\*'+re.escape(label)+r':\*\*\s*(.*?)(?=\s*·\s*\*\*|\n|$)',s).group(1).strip()
  req=field('Requirements to learn');action=field('Action')
  rows.append('([#xref('+q(key(p))+')[#text('+q(name(p))+')]], [#text('+q(req)+')], [#text('+q(action)+')], [#text('+q(SUMMARIES[p.stem])+')])')
 result+='#ability-directory(('+','.join(rows)+',))\n#pagebreak(weak:true)\n'
 result+=flow([card(p) for p in paths])
 return result

def recipe_card(p):
 record(p,'recipes');s=p.read_text();data=json.loads((BOOK/'recipe-presentation.json').read_text())[p.stem]
 flavor=re.search(r'^\*([^*]+)\*$',s,re.M).group(1)
 field=lambda label:re.search(r'\*\*'+re.escape(label)+r':\*\*\s*(.*?)(?=\s*\*\*|\n|$)',s).group(1).strip().rstrip('.')
 tools=field('Tools');materials=field('Materials per attempt') if '**Materials per attempt:**' in s else field('Materials')
 grant=data['granted_by'];users=data['used_with'];finish=data['completion']
 body='*'+flavor+'*\n\n**Granted by:** '+grant+'\n\n**Used with:** '+users+'\n\n---\n\n'
 body+='| Preparation | Per attempt |\n|---|---|\n| Tools | '+tools+' |\n| Time | One hour |\n\n'
 body+='**Materials**\n\n'+materials+'.\n\n---\n\n**Work and completion**\n\n'+finish+'\n'
 return '#catalog-card('+q(name(p))+','+q(key(p))+')['+render(body,p)+']\n'


def section(n,title):return '#chapter('+q(n)+','+q(title)+')\n'
parts=['#import "../template.typ": *\n']
parts.append(manuscript('01-welcome.md','1','Welcome to Heroes of Legend','Four companions pause at a ruined library threshold: shield, lantern, open book and bow. Show their anticipation, not a battle.'))
parts.append(manuscript('02-creation.md','2','Create Your Hero'))
parts.append(hp_reference())
parts.append(coin_reference())
parts.append(section('3','Ancestry, Culture and Background'))
parts.append('#twocol[Choose the people, places and experiences that shaped you. Choose two ancestry traits, then one complete culture pair and one complete background pair. Any ancestry may come from any culture.\n\nYour ancestry supplies inherited traits. Your culture describes a community and its traditions. Your background recalls something you did or experienced before adventuring. These choices offer connections, memories and capabilities; they do not dictate your personality. Ancestry traits are passive unless stated otherwise. Base-statistic changes are permanent; other benefits last while their stated circumstances apply.\n\nChoose each origin as a complete pair: its rank and ability belong together. Resolve all level-0 grants before making purchases. Duplicate grants add one DP to that stage rather than a higher rank or unrestricted replacement.]\n#illustration("origins", height: 330pt, fit: "cover")\n')
for a in ['human','elf','dwarf','halfling']:
 parts.append('#pagebreak(weak: true)\n#grid(columns: (1fr,1fr), gutter: 18pt, [\n'+doc(DESIGN/'ancestries'/f'{a}.md','ancestry',wide=True)+'], [#illustration('+q('ancestry-'+a)+', height: 245pt)])\n#v(10pt)\n')
 parts.append('#twocol[\n'+''.join(doc(DESIGN/'ancestries'/x,'trait',wide=True) for x in re.findall(r'\]\((trait-[^)]+\.md)\)',(DESIGN/'ancestries'/f'{a}.md').read_text()))+']\n')
for typ,title in [('culture','Cultures'),('background','Backgrounds')]:
 parts.append('#pagebreak(weak:true)\n#heading(level:2,'+q(title)+')\n')
 intro=BOOK/'manuscript'/('intro-'+typ+'.md');record(intro,'section')
 entries=['#metadata('+q(key(intro))+')<'+key(intro)+'>\n'+render(intro.read_text(),intro)]
 entries += [doc(p,typ,wide=True) for p in sorted((DESIGN/'origins').glob(typ+'-*.md'),key=name)]
 parts.append(flow(entries)+'#tail-art('+q(typ+'s')+')\n')
parts.append(section('4','Classes'))
parts.append('#grid(columns:(1fr,1fr),gutter:18pt,[Choose the identity you want to bring to the company. Each class grants two starting discipline choices and a signature at levels 1, 3 and 7. Shared abilities remain open to anyone who qualifies. Signatures belong only to their class. Choose one free signature at each milestone; extra eligible signatures cost 2 / 4 / 8 DP. They require only your class and level, with no discipline or earlier-signature requirement.\n\nMeet both attribute minimums before choosing your class. A minimum of zero leaves room for an unconventional hero who succeeds through other strengths. Odd has no minimums and pays the same discipline prices across every field.\n\nChoose one class; there is no multiclassing. You can still learn any shared ability whose requirements you meet, but another class’s signatures remain exclusive.], [\n')
class_rows=[]
for cp in sorted((DESIGN/'classes').glob('*.md'),key=name):
 ct=cp.read_text(); mm=re.search(r'minimum 0 in ([^;]+);',ct); hp=re.search(r'HP contribution (\+\d+)',ct)
 class_rows.append('| ['+name(cp)+'](classes/'+cp.name+') | '+(mm.group(1) if mm else 'None')+' | '+hp.group(1)+' |')
parts.append(render('| Class | Attributes at least 0 | HP contribution |\n|---|---|---|\n'+'\n'.join(class_rows), DESIGN/'class.md')+'])\n')
parts.append('#illustration("classes", height: 350pt, fit: "cover")\n')
for cname in CLASS_ORDER:
 p=DESIGN/'classes'/f'{cname}.md'
 parts.append(class_page(p)+'#pagebreak(weak:true)\n')
 sigs=re.findall(r'\]\(\.\./cards/(signature-[^)]+\.md)\)',p.read_text())
 parts.append(flow([card(DESIGN/'cards'/sig) for sig in sigs]))
parts.append(manuscript('05-disciplines.md','5','Disciplines and Character Paths'))
parts.append(discipline_matrix())
discipline_files=sorted((DESIGN/'disciplines').glob('*.md'),key=name)
for offset in (0,9):
 group=discipline_files[offset:offset+9]
 parts.append('#pagebreak(weak: true)\n#grid(columns:(1fr,1fr),gutter:18pt,['+''.join(doc(p,'discipline',wide=True) for p in group[:5])+'],['+''.join(doc(p,'discipline',wide=True) for p in group[5:])+'])\n')
parts.append('#pagebreak(weak: true)\n#heading(level: 2)[Character paths]\nThese four example builds show how shared abilities can express familiar fantasy heroes. Use a path as a starting idea, combine it with another, or change it freely. The suggestions waive no costs or requirements; choose a few starting abilities and grow toward the rest.\n\n#twocol[\n')
for p in sorted((DESIGN/'paths').glob('*.md'),key=name):
 if p.stem in SELECTED_PATHS:parts.append(doc(p,'path',wide=True))
parts.append(']\n#tail-art("paths")\n')
parts.append(manuscript('06-playing.md','6','Playing the Game','Overhead square-grid scene: one guardian blocks a doorway while companions use cover and a forced push opens an escape route. Clear spaces and no decorative grid distortion.'))
parts.append(manuscript('07-adventure.md','7','Beyond the Battlefield','An adventuring company shares a riverside camp with travelers; one mends a rope, one bargains, one watches the forest.'))
parts.append(manuscript('08-recovery.md','8','Harm and Recovery'))
parts.append(doc(DESIGN/'rules/conditions.md','condition-reference',wide=True,break_before=True))
parts.append(manuscript('09-abilities.md','9','Abilities'))
for tier in ['Universal','1','3','7']:
 paths=[]
 for p in sorted((DESIGN/'cards').glob('*.md'),key=name):
  if p.name.startswith('signature-'):continue
  m=re.search(r'\*\*Tier / minimum level:\*\*\s*(\w+)',p.read_text())
  if m and m.group(1)==tier:paths.append(p)
 parts.append(ability_browser(paths,tier))
parts.append(manuscript('10-equipment.md','10','Equipment and Recipes'))
parts.append(doc(DESIGN/'market.md','market-reference',wide=True,break_before=True))
for folder,title in [('equipment','Equipment entries'),('recipes','Recipes')]:
 parts.append('#pagebreak(weak:true)\n#heading(level:2,'+q(title)+')\n')
 intro=BOOK/'manuscript'/('intro-'+folder+'.md');record(intro,'section')
 entries=['#metadata('+q(key(intro))+')<'+key(intro)+'>\n'+render(intro.read_text(),intro)]
 entries += [recipe_card(p) if folder=='recipes' else doc(p,folder,wide=True) for p in sorted((DESIGN/folder).glob('*.md'),key=name)]
 parts.append(flow(entries)+('#tail-art("recipes")\n' if folder=='recipes' else ''))
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
for tier,title in [('Universal','Universal action index'),('1','Novice ability index'),('3','Adept ability index'),('7','Master ability index')]:
 parts.append('#pagebreak(weak:true)\n#heading(level:2,'+q(title)+')\nShared abilities and class signatures are listed together. A class requirement marks an exclusive signature.\n\n')
 entries=[]
 for c in sorted((c for c in card_records if c['tier']==tier),key=lambda x:x['name'].casefold()):
  entries.append('#block(breakable:false)[#set text(size:9pt)\n#grid(columns:(1fr,23pt),gutter:5pt,[#xref('+q(c['key'])+')[#strong[#text('+q(c['name'])+')]]#linebreak()#text(size:8pt)['+c['requirements']+']],align(right)[#pageref('+q(c['key'])+')])]\n')
 parts.append(flow(entries))
(GEN/'body.typ').write_text(''.join(parts))
manifest={'included':included,'cards':card_records,'internal_links':links,'external_design_references_rendered_as_text':sorted(excluded),'expected':{'ability':350,'ancestry':4,'trait':20,'culture':18,'background':32,'class':10,'discipline':18,'path':4,'equipment':43,'recipes':10,'summon':73,'character':6}}
manifest['presentation_sources']=[{'path':rel(p),'sha256':hashlib.sha256(p.read_bytes()).hexdigest()} for p in [BOOK/'ability-summaries.json',BOOK/'recipe-presentation.json']]
manifest['class_rank_costs']={c:rank_costs(DESIGN/'classes'/f'{c}.md') for c in CLASS_ORDER}
(GEN/'manifest.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n')
print('Included',len(included),'records;',len(card_records),'abilities;',len(links),'internal links.')
if '--compile' in os.sys.argv:
 typst=os.environ.get('TYPST') or shutil.which('typst') or '/tmp/hol-typst/typst-x86_64-unknown-linux-musl/typst'
 from export import export
 export(typst,ROOT,BOOK)
