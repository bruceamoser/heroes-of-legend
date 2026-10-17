from pathlib import Path
from html import escape
D=Path(__file__).resolve().parent/'art';D.mkdir(exist_ok=True)
forest='#15221c';gold='#b39253';paper='#f7f3e9';ink='#28251c'
def svg(name,w,h,body):
 (D/(name+'.svg')).write_text(f'<svg xmlns="http://www.w3.org/2000/svg" width="{w}" height="{h}" viewBox="0 0 {w} {h}"><rect width="100%" height="100%" fill="{paper}"/>'+body+'</svg>')
def text(x,y,s,size=14,anchor='middle',fill=ink):return f'<text x="{x}" y="{y}" font-family="serif" font-size="{size}" text-anchor="{anchor}" fill="{fill}">{escape(s)}</text>'
def rect(x,y,w,h,fill=paper):return f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="3" fill="{fill}" stroke="{gold}" stroke-width="1.2"/>'
def line(x,y,a,b,dash=''):return f'<path d="M{x} {y} L{a} {b}" fill="none" stroke="{gold}" stroke-width="2"'+(f' stroke-dasharray="{dash}"' if dash else '')+'/>'
# Location graph: intentionally not a tactical scale map.
b=line(90,160,260,160,'5 4')+line(260,160,450,250,'5 4')
for a,c in [((90,250),(90,70)),((90,250),(260,250)),((260,250),(450,70)),((90,70),(260,70)),((260,70),(450,70))]:b+=line(*a,*c)
for x,y,name in [(90,250,'Ferry shelter'),(90,70,'Toll yard'),(90,160,'Causeway'),(260,70,'Bell loft'),(450,70,'Signal entrance'),(260,250,'Far landing'),(450,250,'Stores alcove'),(260,160,'Service hatch')]:
 b+=rect(x-67,y-23,134,46,forest)+text(x,y+5,name,15,fill=paper)
b+=text(173,280,'Boat',12)+text(412,168,'Stone passage',12)
b+=text(265,314,'Dashed route: bank path and maintenance corridor. Not to scale.',12)
svg('crossing-routes',540,335,b)
# Tactical yard.
s=27;ox=55;oy=40;b=''
for x in range(13):b+=line(ox+x*s,oy,ox+x*s,oy+10*s)
for y in range(11):b+=line(ox,oy+y*s,ox+12*s,oy+y*s)
b+=rect(ox+2*s,oy+5*s,8*s,s, '#c7b695')+text(ox+6*s,oy+5.7*s,'CART',12)
for x,y in [(1,2),(9,2)]:b+=rect(ox+x*s,oy+y*s,2*s,.5*s,'#7d826e')
for x,y,l in [(3,4,'B'),(8,4,'B'),(5,7,'B'),(10,1,'A')]:b+=f'<circle cx="{ox+(x+.5)*s}" cy="{oy+(y+.5)*s}" r="10" fill="{forest}"/>'+text(ox+(x+.5)*s,oy+(y+.5)*s+4,l,12,fill=paper)
b+=text(ox+6*s,22,'NORTH: loft stairs and landing',13)+text(ox+6*s,338,'SOUTH: causeway approach',13)
b+=text(27,235,'West',11)+text(27,248,'exit',11)+line(35,oy+8*s,ox,oy+8*s)
b+=text(270,370,'12 × 10 squares · B: Road Bandit (3) · A: Bandit Bow (1)',13)
b+=text(270,391,'Green walls: heavy cover where an attack path remains.',12)
svg('toll-yard',540,410,b)
# Signal room.
s=30;ox=140;oy=40;b=''
for x in range(9):b+=line(ox+x*s,oy,ox+x*s,oy+8*s)
for y in range(9):b+=line(ox,oy+y*s,ox+8*s,oy+y*s)
b+=rect(ox+3*s,oy,2*s,s,'#c7b695')+text(ox+4*s,oy+21,'SIGNAL',11)
for x,y in [(1,3),(5,4)]:b+=rect(ox+x*s,oy+y*s,2*s,s,'#d9d1bd')
for x,y in [(2,2),(5,2),(4,5)]:b+=f'<circle cx="{ox+(x+.5)*s}" cy="{oy+(y+.5)*s}" r="10" fill="{forest}"/>'+text(ox+(x+.5)*s,oy+(y+.5)*s+4,'S',12,fill=paper)
b+=f'<path d="M{ox+3*s} {oy+8*s} L{ox+5*s} {oy+8*s}" stroke="#994c38" stroke-width="5"/>'
b+=text(260,312,'Two-square entrance / painted threshold',13)
b+=rect(15,65,100,95)+text(65,93,'Stores',14)+text(65,115,'alcove',14)+text(65,138,'outside wall',11)
b+=text(270,344,'8 × 8 squares · S: Skeleton Sentry (3) · shaded squares: difficult terrain',12)
b+=text(270,365,'The rescue route does not cross the painted threshold.',13)
svg('signal-room',540,385,b)
# Explicit accounting diagram, avoids implying a new packing rule.
b=text(270,28,'FORCED MOVEMENT: APPLY EACH COST ONCE',17)
for x,n,title,lines in [(12,'5','Printed push',['Target Stability 1','5 − 1 = 4']),(147,'4','Movement begins',['One normal square','4 − 1 = 3']),(282,'3','Contact',['Both take 3 damage*','then Stability 2']),(417,'1','Group continues',['3 − 2 = 1','One square remains'])]:
 b+=rect(x,52,112,145)+text(x+56,88,n,30)+text(x+56,115,title,12)+text(x+56,148,lines[0],11)+text(x+56,172,lines[1],11)
 if x<417:b+=text(x+123,128,'›',22)
b+=text(270,222,'*Apply matching damage resistance. Stability reduces movement, not damage.',12)
svg('stability-sequence',540,245,b)
# Nearest-square tether.
s=43;ox=60;oy=55;b=text(270,25,'THE SIX-SQUARE TETHER',17)
for x in range(10):b+=line(ox+x*s,oy,ox+x*s,oy+3*s)
for y in range(4):b+=line(ox,oy+y*s,ox+9*s,oy+y*s)
b+=rect(ox,oy+s,s,s,forest)+text(ox+s/2,oy+1.65*s,'C',18,fill=paper)
b+=rect(ox+6*s,oy,2*s,2*s,'#d3c29e')+text(ox+7*s,oy+s,'SUMMON',12)
for x in range(1,7):b+=text(ox+(x+.5)*s,oy+2.65*s,str(x),14)
b+=text(270,212,'Nearest occupied squares are 6 apart: the form remains.',14)
b+=text(270,235,'If the nearest distance becomes 7, it immediately disappears.',13)
svg('summon-tether',540,260,b)
