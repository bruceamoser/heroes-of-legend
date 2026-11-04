#!/usr/bin/env python3
"""Regression: navigation cleanup must retain link-leading rules and teaching."""
import ast,re,tempfile,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
module=ast.parse((ROOT/'design/player-book/build.py').read_text())
clean_node=next(n for n in module.body if isinstance(n,ast.FunctionDef) and n.name=='clean')
context={'re':re,'BOOK':ROOT/'design/player-book'}
exec(compile(ast.Module(body=[clean_node],type_ignores=[]),'<book clean>','exec'),context)
clean=context['clean']
class CleaningTests(unittest.TestCase):
 def test_real_vision_grants(self):
  for file,rating in [('trait-high-elf-starlight-eyes.md',1),('trait-deep-dwarf-eyes-for-the-dark.md',2)]:
   p=ROOT/'design/ancestries'/file
   if not p.exists():p=next((ROOT/'design/ancestries').glob('*'+file.split('trait-',1)[1]))
   self.assertIn(f'[Low-Light Vision](../rules/vision.md) {rating}.',clean(p))
 def test_language_price_and_grant(self):
  self.assertIn('costs 1 DP',clean(ROOT/'design/rules/languages.md'))
 def test_only_standalone_navigation_is_removed(self):
  with tempfile.TemporaryDirectory() as folder:
   p=Path(folder)/'example.md'
   p.write_text('# Example\n\n[Vision](vision.md) imposes 1 Bane.\n\n[Choices](choices.md) · [Rules](rules.md)\n')
   result=clean(p)
   self.assertIn('[Vision](vision.md) imposes 1 Bane.',result)
   self.assertNotIn('[Choices]',result)
if __name__=='__main__':unittest.main()
