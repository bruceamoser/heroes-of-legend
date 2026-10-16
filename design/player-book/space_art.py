#!/usr/bin/env python3
"""Place a finite set of relevant illustrations once, never cycle filler artwork.

Functional discipline symbols and the book logo are not scene illustrations.
Whitespace is preferable to repeating an image or inserting an unrelated portrait.
"""
import json,subprocess,tempfile
from pathlib import Path
from PIL import Image,ImageChops,ImageDraw
B=Path(__file__).resolve().parent

def gaps(mask,x0,x1):
 result=[];start=None
 for y in range(52,743):
  clear=y<742 and mask.crop((x0,y,x1,y+1)).getbbox() is None
  if clear and start is None:start=y
  if not clear and start is not None:
   if y-start>=165:result.append((start+12,y-12))
   start=None
 return result

KEYWORDS={
 'protector-shield':['class protector'],
 'blade-sword':['class blade'],
 'arcanist-instruments':['class arcanist'],
 'shepherd-crook':['class shepherd'],
 'intellect-lens':['class intellect'],
 'leader-standard':['class leader'],
 'unbalanced-maul':['class unbalanced'],
 'shadow-cloak':['class shadow'],
 'odd-curios':['class odd'],
 'warden-bow':['class warden'],
 'climbing-kit':['climb','rope','ledge','leap','height'],
 'healers-bowl':['heal','wound','medicine','life','restore'],
 'elemental-stones':['flame','frost','storm','elemental','fire'],
 'shadow-lantern':['hidden','dark','shadow','light'],
 'broken-chain':['force','grapple','break','push','bound'],
 'root-and-thorn':['thorn','root','plant','earth','grove'],
 'feather-and-seal':['influence','promise','message','oath','bargain'],
 'folded-spell':['spell','knowledge','arcane','scholarship'],
 'healing-vials':['potion','healing','bottle'],
 'camp-kettle':['camp','travel','rest','journey'],
 'recipe-tools':['recipe','craft','derive'],
 'hourglass':['recovery','death','dying','wound'],
 'mountain-pass':['climb','cross','travel','path'],
 'forest-sanctuary':['wilderness','grove','forest','root'],
 'ruined-observatory':['knowledge','reason','star','perceive','study'],
}

def plan(pdf,art=()):
 text=subprocess.check_output(['pdftotext','-layout',str(pdf),'-'],text=True).split('\f')
 used={a['asset'] for a in art};placements=[];candidates=[]
 with tempfile.TemporaryDirectory(prefix='hol-space-') as tmp:
  subprocess.run(['pdftoppm','-r','72','-png',str(pdf),tmp+'/page'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL,check=True)
  sheet=False
  for n,page in enumerate(text,1):
   if n<=2 or not page.strip():continue
   if 'Hero & encounter' in page:sheet=True
   if sheet:continue
   # A creature portrait or an existing illustration already gives this page its visual focus.
   if any(a['page']==n for a in art):continue
   header=' '.join(page.splitlines()[:4])
   scope=next((v for k,v in [('Classes','classes'),('Abilities','abilities'),('Equipment','equipment'),('Battlefield','adventure'),('Recovery','recovery')] if k in header),None)
   if not scope:continue
   png=Path(tmp)/f'page-{n:03d}.png'
   if not png.exists():continue
   im=Image.open(png).convert('RGB');paper=im.getpixel((20,400))
   diff=ImageChops.difference(im,Image.new('RGB',im.size,paper))
   masks=[diff.getchannel(i).point(lambda v:255 if v>45 else 0) for i in range(3)]
   mask=ImageChops.lighter(ImageChops.lighter(masks[0],masks[1]),masks[2])
   ranges=[gaps(mask,42,297),gaps(mask,315,570)]
   common=[(max(a,c),min(b,d)) for a,b in ranges[0] for c,d in ranges[1] if min(b,d)-max(a,c)>=150]
   if common:
    start,end=max(common,key=lambda r:r[1]-r[0]);candidates.append(dict(page=n,x=42,y=start,width=528,height=min(end-start,260),scope=scope,text=page.lower(),wide=True))
   for col,rs in enumerate(ranges):
    if rs:
     start,end=max(rs,key=lambda r:r[1]-r[0]);candidates.append(dict(page=n,x=42+col*273,y=start,width=255,height=min(end-start,360 if scope=='classes' else 250),scope=scope,text=page.lower(),wide=False))
 assets=json.loads((B/'art/revision-prompts.json').read_text())
 for asset in assets:
  key=asset['key']
  if key in used or key not in KEYWORDS:continue
  choices=[c for c in candidates if c['scope']==asset['scope'] and (asset['role']!='landscape' or c['wide'])]
  if not choices:continue
  if asset['scope']=='classes':choices=[c for c in choices if any(w in c['text'] for w in KEYWORDS[key])]
  if not choices:continue
  score=lambda c: ((1 if asset['scope']=='classes' else sum(c['text'].count(w) for w in KEYWORDS[key])),c['height'],c['width'])
  chosen=max(choices,key=score)
  if score(chosen)[0]==0:continue
  placement={k:chosen[k] for k in ('page','x','y','width','height')}
  # Object cutouts remain modest, even if a large blank area is available.
  if asset['role']=='spot':
   width=min(placement['width'],240);placement['x']+=(placement['width']-width)/2;placement['width']=width;placement['height']=min(placement['height'],340 if asset['scope']=='classes' else 230)
  placements.append(dict(**placement,asset=key));used.add(key)
  candidates=[c for c in candidates if c['page']!=chosen['page']]
 return sorted(placements,key=lambda p:p['page'])

if __name__=='__main__':
 import sys
 result=plan(Path(sys.argv[1]))
 (B/'generated/space-art.json').write_text(json.dumps(result,indent=2)+'\n')
 print(f'Placed {len(result)} unique contextual illustrations.')
