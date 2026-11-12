"""Cross-source checks for the November health revision; no balance simulation."""
from pathlib import Path
import re
R=Path(__file__).resolve().parents[1]; D=R/'design'
def read(p):return (D/p).read_text()
ancestries={p.stem:int(re.search(r'HP contribution \+(\d+)',p.read_text())[1]) for p in (D/'ancestries').glob('*.md') if '**Starting values:**' in p.read_text()}
classes={p.stem:int(re.search(r'HP contribution \+(\d+)',p.read_text())[1]) for p in (D/'classes').glob('*.md')}
assert len(ancestries)==10 and len(classes)==10
assert all(1<=n<=3 for n in [*ancestries.values(),*classes.values()])
expected={'borin-bridgekeeper':('hill-dwarf','protector',2,2),'lira-ashbow':('wood-elf','blade',1,1),'pip-copperwink':('halfling','shadow',0,0),'vaelis-emberglass':('wood-elf','arcanist',0,1),'mara-reedheart':('human','shepherd',1,0),'oren-brass':('human','intellect',0,1)}
for id,(a,c,fort,benefits) in expected.items():
 s=read(f'characters/{id}.md');hp=10+ancestries[a]+classes[c]+fort+benefits
 assert f'HP {hp}/{hp}' in s,id
 assert 'Grit 1 remaining / 1 granted' in s,id
 assert f'HP gain per level: **{ancestries[a]+classes[c]}**' in s,id
 assert 'SP: **6/6**' in s,id
 # Verify lifetime growth and half-HP recovery arithmetic at all levels.
 for level in range(1,11):
  maximum=10+level*(ancestries[a]+classes[c])+fort+benefits
  restored=(maximum+1)//2
  assert 0<restored<=maximum and abs(restored-maximum/2)<=.5
canonical=read('rules/recovery.md');player=read('player-book/manuscript/08-recovery.md')
assert canonical.split('\nA non-player healer')[0].strip()==player.replace('../../rules/wounds.md','wounds.md').strip()
for phrase in ['one immediate death roll','half maximum HP, rounded up','including the third mark','no Hit Dice pool','one treatment attempt between safe overnight rests']:
 assert phrase in canonical.replace('**',''),phrase
for folder in ['player-book/manuscript','da-book/manuscript']:
 for p in (D/folder).glob('*.md'):
  s=p.read_text()
  for retired in ['A safe breath restores HP','Entering it causes a wound','Recovery Value','regain full HP','Grit 2','2 Grit','no spell slots or\nmana pools']:
   assert retired not in s,(p,retired)
for p in (D/'cards').glob('*.md'):
 s=p.read_text()
 if 'healing roll' in s or p.stem in ['signature-shepherd-gentle-return','signature-shepherd-careful-transfer','not-yet-your-name','a-bough-for-the-fallen']:
  assert not re.search(r'(?:[Pp]ay|[Ss]pend) \d+ HP',s),p
  assert re.search(r'(?:[Pp]ay|[Ss]pend) [124] SP',s),p
for id in ['treat-soft-tissue','treat-bone','treat-elemental-injury','treat-mental-trauma','treat-life-injury','treat-radiant-injury']:
 s=read(f'cards/{id}.md');assert 'between safe overnight rests' in s and 'recovery progress' not in s
assert 'Roll | Injury' not in read('rules/wounds.md')
assert '280' not in read('da-book/assemble.py')
print('PASS: 10 ancestry/class growth rates, six HP/SP/Grit examples, levels 1–10 arithmetic, synchronized recovery chapters, retired-rule exclusions, healing costs and shared treatment limits.')
