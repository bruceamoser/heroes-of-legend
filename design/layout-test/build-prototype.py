"""Disposable DesignCraft 0.8.0 trial. Run with the desktop app --control 7979.
Reads HOL Markdown; never edits rules. Output lives in /tmp unless HOL_LAYOUT_OUT is set.
"""
import json, os, re, socket
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
OUT=Path(os.environ.get('HOL_LAYOUT_OUT','/tmp/hol-designcraft/output'));OUT.mkdir(parents=True,exist_ok=True)
PORT=int(os.environ.get('HOL_DESIGNCRAFT_PORT','7979'))
def call(method,params=None):
    with socket.create_connection(('127.0.0.1',PORT),timeout=60) as s:
        s.sendall((json.dumps({'id':1,'method':method,'params':params or {}})+'\n').encode())
        r=json.loads(s.makefile('r').readline())
        if not r.get('ok'): raise RuntimeError(r)
        return r['result']
def cmd(command,**params): return call('engine.execute',{'command':command,'params':params})
def plain(t):
    t=re.sub(r'\[([^]]+)\]\([^)]+\)',r'\1',t)
    t=t.replace('\\\n','\n\n')
    t=re.sub(r'(?<!\n)\n(?!\n|- )', ' ', t)
    t=re.sub(r'\n{2,}', '\n', t)
    return re.sub(r'(?m)^#{1,6} ','',t).replace('**','').replace('\\\n','\n')
def frame(page,x,y,w,h,text=None,fill=None,stroke=None):
    r=cmd('frame.create',spread=page,rect=[x,y,x+w,y+h],content='text' if text is not None else 'unassigned',**({'text':text} if text is not None else {}))
    if fill:cmd('object.fill',swatch=fill,ids=[r['id']])
    if stroke:cmd('object.stroke',swatch=stroke,weight=.6,ids=[r['id']])
    return r
def text(page,x,y,w,h,t,style):
    r=frame(page,x,y,w,h,t)
    cmd('selection.set',ids=[r['id']]);cmd('style.paragraph.apply',name=style)
    return r
def base(p,section):
    frame(p,0,0,612,792,fill='Ivory')
    frame(p,0,0,612,26,fill='Forest')
    text(p,42,6,528,18,'HEROES OF LEGEND  /  '+section,'KickerLight')
    frame(p,42,741,528,1,fill='Gold')
    text(p,42,752,470,20,'LAYOUT TRIAL • GREAT LIBRARY • RULE EXCERPTS','Footer')
    text(p,540,750,30,22,str(p+1).zfill(2),'Footer')
cmd('file.new',width=612,height=792,pages=6,facingPages=False,margins=42,title='Heroes of Legend — Great Library trial')
for n,c in {'Forest':'#0e1714','Panel':'#15221c','Gold':'#c9a766','Ivory':'#f1e6ce','Ink':'#28251c','Parchment':'#e2d6b8'}.items():cmd('swatch.create',name=n,color=c)
for name,font,size,color in [('Title','Cinzel',38,'Ivory'),('Heading','Cinzel',24,'Forest'),('Subhead','Cinzel',15,'Forest'),('Body','EB Garamond',11,'Ink'),('Flavor','EB Garamond',12,'Forest'),('Kicker','Cinzel',9,'Gold'),('KickerLight','Cinzel',8,'Ivory'),('Footer','Cinzel',8,'Forest'),('CoverBody','EB Garamond',16,'Ivory')]:
    cmd('style.paragraph.create',name=name,chars={'fontFamily':font,'size':size,'fill':color,'leading':{'kind':'points','value':size*1.28}},para={'spaceAfter':3,'hyphenate':False})
frame(0,0,0,612,792,fill='Forest')
art=Path('/mnt/disk5/rpg-app/static/great-library.png')
if art.exists():
    r=frame(0,0,0,612,355)
    cmd('file.place',path=str(art),frame=r['id'])
    cmd('object.fit',mode='fillProportionally',ids=[r['id']])
frame(0,32,32,548,728,stroke='Gold')
text(0,52,387,508,22,'ENTER, WANDERER. YOUR LEGEND AWAITS.','Kicker')
text(0,52,432,508,128,'Heroes of\nLegend','Title')
text(0,52,582,480,75,'Steel, scars, and the choices\nthat make a hero.','CoverBody')
text(0,52,702,490,26,'GREAT LIBRARY  /  DESIGNCRAFT TOOL TRIAL','Kicker')
for p,s in [(1,'CORE RULES'),(2,'ABILITIES'),(3,'BESTIARY'),(4,'FLOW TEST'),(5,'FLOW TEST / CONTINUED')]:base(p,s)
text(1,42,53,528,48,'When the dice speak','Heading')
src=(ROOT/'design/rules/foundations.md').read_text()
resolution=src.split('## Resolution\n')[1].split('\n## Turns')[0].strip()
text(1,42,118,324,320,plain(resolution),'Body')
frame(1,388,118,182,286,fill='Forest',stroke='Gold')
text(1,403,136,152,22,'THREE OUTCOMES','Kicker')
text(1,403,178,152,210,'WEAK · 8 OR BELOW\nProgress, not automatic success.\n\nSTANDARD · 9–14\n\nSTRONG · 15 OR ABOVE','CoverBody')
text(1,42,452,528,36,'A turn at the table','Subhead')
turns=src.split('## Turns and attacks\n')[1].split('\n## Movement')[0].strip()
text(1,42,500,528,224,plain(turns),'Body')
text(2,42,53,528,48,'Make the world move','Heading')
for name,y in [('force',118),('gust-hammer',432)]:
    s=(ROOT/f'design/cards/{name}.md').read_text()
    title=s.splitlines()[0][2:];flavor=s.split('\n\n')[1].strip('*')
    rules=s.split('## Rules\n')[1].split('\n---')[0].strip()
    text(2,42,y,528,30,title,'Subhead')
    text(2,42,y+30,528,20,'UNIVERSAL • NO DP COST' if name=='force' else 'TIER 1 • LEVEL 1 • 2 DP • STORM 1 • MAGIC / ATTACK','Footer')
    text(2,42,y+55,528,32,flavor,'Flavor')
    text(2,42,y+92,528,208,plain(rules),'Body')
    if y==118:frame(2,42,419,528,1,fill='Gold')
g=(ROOT/'design/bestiary/creatures/goblin-scrapper.md').read_text()
text(3,42,53,528,48,g.splitlines()[0][2:],'Heading')
text(3,42,111,528,68,g.split('\n\n')[1].strip('*'),'Flavor')
stats=g.split('**Attributes:**')[1].split('## Actions')[0]
text(3,42,192,528,136,plain('Attributes:'+stats),'Body')
text(3,42,338,528,27,'Actions','Subhead')
text(3,42,374,528,35,'Weak / Standard / Strong PLAYER DEFENSE','Kicker')
rows=[['MAIN ACTION','DEFENSE','DAMAGE'],['Basic Melee','Agility','4 / 2 / 1'],['Scrap knife','Agility','5 / 3 / 2']]
for i,row in enumerate(rows):
    frame(3,42,412+i*28,528,28,fill='Forest' if i==0 else 'Parchment')
    for x,w,t in zip([52,300,446],[235,130,114],row):text(3,x,418+i*28,w,22,t,'KickerLight' if i==0 else 'Body')
text(3,42,513,528,83,'Roll Away — Move up to 2 squares in a straight line without provoking opportunity attacks. Normal terrain costs and occupied-square restrictions apply.\nDefend — +1 Bane.','Body')
text(3,42,613,528,98,'Opportunity Attack — Basic Melee.\n\nA quick-reference excerpt; the source creature contains the full timing, tactics, loot, and encounter details.','Body')
text(4,42,53,528,50,'Rules in motion','Heading')
text(5,42,53,528,50,'The story continues','Heading')
flow=plain(src.split('## Resolution\n')[1].split('\n[Recovery boundary]')[0])
a=text(4,42,122,528,600,flow,'Body')
b=frame(5,42,122,528,600,text='')
cmd('text.thread',**{'from':a['id'],'to':b['id']})
cmd('selection.set',ids=[])
cmd('file.saveAs',path=str(OUT/'hol-library-trial.designcraft'))
(OUT/'flow.json').write_text(json.dumps({'story':a['story'],'text':flow,'frame':a['id']}))
(OUT/'inspect.json').write_text(json.dumps(call('document.inspect'),indent=2))
print(json.dumps(cmd('preflight.run'),indent=2))
print(cmd('file.exportPdf',path=str(OUT/'hol-library-trial.pdf'),title='Heroes of Legend — Great Library layout trial',author='Bruce A. Moser',tagged=True))
call('ui.set',{'page':0,'fit':'page'})
