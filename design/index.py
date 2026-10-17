"""Rebuild navigation only. Authored cards and origin text are never overwritten."""
from pathlib import Path
import re
R=Path(__file__).resolve().parent
def field(s,k):
 m=re.search(r'\*\*'+re.escape(k)+r':\*\* ([^\n]+)',s)
 return m[1].split(' · **')[0].strip() if m else ''
def title(p):return p.read_text().splitlines()[0].removeprefix('# ')
def link(p):return f'[{title(p)}]({p.relative_to(R)})'
def main():
 cards=[]
 for p in sorted((R/'cards').glob('*.md')):
  s=p.read_text();cards.append((p,s))
 txt='# Find your next ability\n\nStart with [the character you imagine](fantasy-paths.md), or browse below.\nEach ability is an editable Markdown page. Class signatures remain exclusive;\nshared paths can be mixed by anyone who meets their card requirements.\n\n'
 for label,test in [('Universal actions',lambda s:field(s,'Tier / minimum level')=='Universal'),('Shared abilities',lambda s:field(s,'Tier / minimum level')!='Universal' and field(s,'Type')!='Signature'),('Class signatures',lambda s:field(s,'Type')=='Signature')]:
  txt+='## '+label+'\n\n'
  for p,s in cards:
   if test(s):txt+=f'- {link(p)} — {field(s,"Action")}; level {field(s,"Tier / minimum level")}; {field(s,"Requirements to learn")}.\n'
  txt+='\n'
 for heading,key in [('Choose by action','Action'),('Choose by kind','Type')]:
  txt+='## '+heading+'\n\n';groups={}
  for p,s in cards:
   for v in field(s,key).split('/') if key=='Type' else [field(s,key)]:groups.setdefault(v.strip(),[]).append(p)
  for k,ps in sorted(groups.items()):txt+='### '+k+'\n\n'+', '.join(link(p) for p in ps)+'\n\n'
 (R/'catalog.md').write_text(txt.rstrip()+'\n')
 txt='# Where you grew up, and what you did\n\nAncestry does not dictate culture. Choose one culture and one background, then\none paired gift from each. A past can suggest a personality without prescribing it.\n\n'
 for kind in ['culture','background']:
  ps=sorted((R/'origins').glob(kind+'-*.md'));txt+=f'## {len(ps)} '+('cultures' if kind=='culture' else 'backgrounds')+'\n\n'
  for p in ps:
   paragraphs=p.read_text().split('\n\n');desc=paragraphs[1] if len(paragraphs)>1 else ''
   txt+=f'- {link(p)} — {desc}\n'
  txt+='\n'
 (R/'culture-background.md').write_text(txt.rstrip()+'\n')
 txt='# Disciplines and their possibilities\n\nThe eighteen fields use the class rank costs in the current catalog. Buy ranks in\norder; no ability chain is required.\n\n'
 for p in sorted((R/'disciplines').glob('*.md')):
  d=title(p);txt+=f'## {link(p)}\n\n'
  for cp,s in cards:
   if re.search(r'\b'+re.escape(d)+r' [123]\b',field(s,'Requirements to learn')):txt+=f'- {link(cp)} — level {field(s,"Tier / minimum level")}; {field(s,"Action")}.\n'
  txt+='\n'
 (R/'disciplines.md').write_text(txt.rstrip()+'\n')
 for folder,name in [('recipes','Recipes'),('equipment','Equipment')]:
  (R/(folder+'.md')).write_text('# '+name+'\n\nFollow the printed acquisition and requirements; a recipe\nis knowledge, not a free finished item.\n\n'+'\n'.join('- '+link(p) for p in sorted((R/folder).glob('*.md')))+'\n')
 print(f'Navigation rebuilt for {len(cards)} cards; authored entries unchanged.')
if __name__=='__main__':main()
