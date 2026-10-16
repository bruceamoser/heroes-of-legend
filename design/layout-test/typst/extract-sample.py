"""Extract the frozen comparison content/geometry from the reviewed DesignCraft trial.
No application launch or changes to rules. Not a general-purpose file converter.
"""
from pathlib import Path
import json, zipfile, hashlib
HERE=Path(__file__).resolve().parent
source=HERE.parent/'artifacts/hol-library-trial.designcraft'
with zipfile.ZipFile(source) as z:
    d=json.loads(z.read('document.json'))
    (HERE/'library-art.png').write_bytes(z.read('assets/19.png'))
styles={s['name']:s for s in d['styles']['paragraph'] if s['chars']}
pages=[]; flow=None
for spread in d['spreads']:
    items=[]
    for it in spread['items']:
        points=[a['p'] for a in it['path']['subpaths'][0]['anchors']]
        x=min(p[0] for p in points);y=min(p[1] for p in points)
        item={'x':x,'y':y,'w':max(p[0] for p in points)-x,'h':max(p[1] for p in points)-y,
              'fill':it['fill']['swatch'],'stroke':it['stroke']['swatch'],'weight':it['stroke']['weight'],'kind':it['content']['type']}
        if item['kind']=='text':
            story=d['stories'][str(it['content']['story'])]
            if len(story['frames'])>1:
                flow={'text':story['text'],'style':story['paras'][0]['style']}
                continue
            item.update(text=story['text'].replace('DESIGNCRAFT TOOL TRIAL','TYPST TOOL TRIAL'),style=story['paras'][0]['style'])
        items.append(item)
    pages.append(items)
data={'styles':styles,'pages':pages,'flow':flow,'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest()}
(HERE/'sample.json').write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n')
print('Extracted six pages, common styles, embedded artwork and unchanged story text.')
