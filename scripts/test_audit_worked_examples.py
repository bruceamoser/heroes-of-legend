#!/usr/bin/env python3
"""Mutation checks for the independent authored-example gate."""
from pathlib import Path
import shutil
import tempfile
import unittest

from audit_worked_examples import ROOT, verify


class WorkedExampleAuditTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.book = Path(self.temp.name)
        for directory in ("characters", "ancestries", "classes", "disciplines", "equipment", "origins", "spellbooks"):
            target = self.book / "design" / directory
            target.mkdir(parents=True)
            for path in (ROOT / "design" / directory).iterdir():
                if path.suffix not in (".md", ".json"):
                    continue
                shutil.copy2(path, target / path.name)

    def mutate(self, path, old, new):
        target = self.book / "design" / path
        text = target.read_text()
        self.assertIn(old, text)
        target.write_text(text.replace(old, new, 1))

    def test_current_sources_pass(self):
        self.assertEqual(len(verify(self.book)["characters"]), 6)

    def test_wrong_class_signature_fails(self):
        self.mutate("characters/examples.json", '"signatureId": "ability-signature-blade-measured-guard"', '"signatureId": "ability-signature-shepherd-gentle-return"')
        with self.assertRaisesRegex(ValueError, "lira-ashbow: signature"):
            verify(self.book)

    def test_adaptable_omission_fails(self):
        self.mutate("characters/mara-reedheart.md", "= **13 DP**", "= **12 DP**")
        with self.assertRaisesRegex(ValueError, "mara-reedheart: printed totals"):
            verify(self.book)

    def test_missing_prerequisite_fails(self):
        self.mutate("characters/examples.json", '"id": "subterfuge:locks:2"', '"id": "subterfuge:locks:3"')
        with self.assertRaisesRegex(ValueError, "pip-copperwink: legal purchase subterfuge:locks:3"):
            verify(self.book)

    def test_incorrect_market_price_fails(self):
        self.mutate("characters/lira-ashbow.md", "| 9 | 1 |", "| 5 | 1 |")
        with self.assertRaisesRegex(ValueError, "lira-ashbow: printed gear Food Bundle"):
            verify(self.book)


if __name__ == "__main__":
    unittest.main()
