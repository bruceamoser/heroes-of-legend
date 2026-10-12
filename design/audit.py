"""Read-only authoring audit: links, IDs and fields, not mechanical balance."""
from pathlib import Path
import re
R=Path(__file__).resolve().parent
errors=[];ids={};files=list(R.rglob('*.md'))
for p in files:
 s=p.read_text()
 for target in re.findall(r'\]\(([^)]+)\)',s):
  if '://' in target or target.startswith('#'):continue
  path=(p.parent/target.split('#')[0]).resolve()
  if not path.exists():errors.append(f'{p.relative_to(R)}: missing {target}')
 if p.parent.name=='cards':
  for field in ['ID','Status','Type','Tier / minimum level','DP','Requirements to learn','Action','Attribute','Target / range / shape','Duration','Limits','Equipment / acquisition']:
   if f'**{field}:**' not in s:errors.append(f'{p.name}: missing {field}')
  m=re.search(r'\*\*ID:\*\* (.+)',s)
  if m:
   if m[1] in ids:errors.append(f'duplicate ID {m[1]}')
   ids[m[1]]=p.name
  if '| Weak | Standard | Strong |' not in s:errors.append(f'{p.name}: missing outcomes')
for e in errors:print(e)
assert not errors,f'{len(errors)} errors'
print(f'{len(files)} Markdown files; {len(ids)} card IDs; links and fields pass. No balance claim.')
