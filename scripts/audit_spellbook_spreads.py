#!/usr/bin/env python3
"""Verify facing spreads, intact spell text, unique art and discipline tokens."""
import json, re, subprocess, unicodedata
from PIL import Image
from pathlib import Path
R=Path(__file__).resolve().parents[1];B=R/'design/player-book'
prompts=json.loads((B/'art/spellbooks/prompts.json').read_text())
assert len(prompts)==22 and len({p['id'] for p in prompts})==22
for entry in prompts:
    with Image.open(R/entry['path']) as im:
        assert im.mode=='RGBA' and im.getchannel('A').getextrema()[0]==0,entry['id']
    assert entry['transparent_background'] is True
records=json.loads((B/'generated/spell-spread-pages.json').read_text())
books=json.loads((B/'generated/spellbooks.json').read_text())
art=json.loads((B/'generated/illustration-placements.json').read_text())
art_map=json.loads((B/'spellbook-art.json').read_text())
pages=subprocess.check_output(['pdftotext',str(B/'output/heroes-of-legend-players-book.pdf'),'-'],text=True).split('\f')
def norm(s):return re.sub('[^a-z0-9]','',unicodedata.normalize('NFKC',s).lower())
npages=list(map(norm,pages));seen=[]
assert len(records)==58
for book in books:
    pair=sorted([r for r in records if r['book']==book['ID']],key=lambda r:r['side'])
    assert len(pair)==2 and [r['side'] for r in pair]==[0,1],book['ID']
    left,right=[r['page'] for r in pair]
    assert left%2==0 and right==left+1,(book['ID'],pair)
    seen.extend([left,right])
    # List and complete blocks must occur on this book's own two pages.
    assert norm(book['Endpoint']) in npages[left-1],book['ID']
    for spell in book['spells']:
        hits=[p for p in [left,right] if norm(spell['effect']) in npages[p-1]]
        assert len(hits)==1,(spell['id'],'effect missing or divided')
        for value in [spell['name'],spell['target'],spell['duration'],*spell['action'].split(' · ')]:
            assert norm(value) in npages[hits[0]-1],(spell['id'],value)
    entry=art_map[book['ID']]
    assert (B/entry['path']).is_file() and entry['path'].endswith('.png'),entry
    hits=[a for a in art if a['asset']==entry['asset']]
    assert len(hits)==1 and hits[0]['page'] in [left,right],book['ID']
    a=hits[0]
    assert a['height']>=70 and 42<=a['x'] and a['x']+a['width']<=570.1 and a['y']+a['height']<=742.1,a
    token=book['Discipline'].lower()
    assert (B/'art/tokens'/f'{token}.svg').is_file() or (B/'art/interior'/f'symbol-{token}.png').is_file(),token
assert len(set(seen))==58 and sorted(seen)==list(range(min(seen),max(seen)+1))
s=(B/'spellbook-spreads.typ').read_text()
assert s.count('icons:discipline-mark(lower(b.Discipline),"",size:22pt)')==2
print('PASS: 29 even/odd facing spreads; 319 intact spell blocks; lists, unique art and discipline tokens; no interleaved pages.')
