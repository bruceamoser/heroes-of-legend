#!/usr/bin/env python3
"""Place contextual art in clear page areas without changing text pagination.

Inspect the undecorated proof, including full reserved illustration rectangles.
Do not fill writing fields, the index, card interiors, or an illustration's margins.
"""
import json,subprocess,tempfile
from pathlib import Path
from PIL import Image,ImageChops,ImageDraw
B=Path(__file__).resolve().parent
SCENES=['journey','adventure','paths','classes','origins','equipment','abilities']
PORTRAITS=['class-arcanist','class-blade','class-warden','class-shepherd','class-shadow','class-intellect','class-odd','class-protector','class-leader','class-unbalanced']

def gaps(mask,x0,x1):
 result=[];start=None
 for y in range(52,743):
  clear=y<742 and mask.crop((x0,y,x1,y+1)).getbbox() is None
  if clear and start is None:start=y
  if not clear and start is not None:
   if y-start>=165:result.append((start+10,y-6))
   start=None
 return result

def plan(pdf,art=()):
 text=subprocess.check_output(['pdftotext','-layout',str(pdf),'-'],text=True).split('\f');placements=[]
 with tempfile.TemporaryDirectory(prefix='hol-space-') as tmp:
  subprocess.run(['pdftoppm','-r','72','-png',str(pdf),tmp+'/page'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL,check=True)
  sheet=False
  for n,page in enumerate(text,1):
   if n<=2 or not page.strip():continue
   if 'Hero & encounter' in page:sheet=True
   if sheet:continue
   png=next(iter(Path(tmp).glob(f'page-{n:03d}.png')),None)
   if not png:continue
   im=Image.open(png).convert('RGB');paper=im.getpixel((20,400))
   diff=ImageChops.difference(im,Image.new('RGB',im.size,paper))
   masks=[diff.getchannel(i).point(lambda v:255 if v>45 else 0) for i in range(3)]
   mask=ImageChops.lighter(ImageChops.lighter(masks[0],masks[1]),masks[2]);draw=ImageDraw.Draw(mask)
   existing=[a for a in art if a['page']==n];used={a['asset'] for a in existing}
   for a in existing:draw.rectangle((a['x'],a['y'],a['x']+a['width'],a['y']+a['height']),fill=255)
   ranges=[gaps(mask,42,297),gaps(mask,315,570)]
   header=' '.join(page.splitlines()[:4]);wide='journey';spot=PORTRAITS[n%len(PORTRAITS)]
   if 'Classes' in header:wide=SCENES[n%len(SCENES)]
   elif 'Ancestry' in header:wide,spot='origins','class-warden'
   elif 'Disciplines' in header:wide,spot='disciplines','class-intellect'
   elif 'Summoned' in header:wide,spot=SCENES[n%len(SCENES)],'summon-raven'
   elif 'Equipment' in header:wide,spot='equipment','class-odd'
   elif 'Wound' in header:wide,spot='wounds','summon-ancestor-guardian'
   elif 'Recovery' in header:wide,spot='recovery','summon-ancestor-guardian'
   elif 'Ready-to-Play' in header:wide='heroes'
   elif 'Abilities' in header:wide=SCENES[n%len(SCENES)]
   common=[(max(a,c),min(b,d)) for a,b in ranges[0] for c,d in ranges[1] if min(b,d)-max(a,c)>=150]
   has_landscape=any(a['asset'] in SCENES+['heroes','backgrounds','cultures','recovery','wounds','recipes','disciplines'] and a['height']>=200 for a in existing)
   if common and has_landscape:continue
   if common:
    start,end=max(common,key=lambda r:r[1]-r[0]);asset=next(x for x in [wide]+SCENES if x not in used)
    placements.append(dict(page=n,x=42,y=start,width=528,height=min(end-start,270),asset=asset));continue
   for col,rs in enumerate(ranges):
    if not rs:continue
    start,end=max(rs,key=lambda r:r[1]-r[0])
    asset=next(x for x in [spot]+PORTRAITS if x not in used);used.add(asset)
    placements.append(dict(page=n,x=42 if col==0 else 315,y=start,width=255,height=min(end-start,330),asset=asset))
 return placements

if __name__=='__main__':
 import sys
 result=plan(Path(sys.argv[1]))
 (B/'generated/space-art.json').write_text(json.dumps(result,indent=2)+'\n')
 print(f'Placed {len(result)} contextual illustrations in open page areas.')
