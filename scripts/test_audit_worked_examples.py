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
        for directory in ("characters", "cards", "paths", "disciplines", "spellbooks", "origins", "classes", "equipment"):
            target = self.book / "design" / directory
            target.mkdir(parents=True)
            for path in (ROOT / "design" / directory).glob("*.md"):
                shutil.copy2(path, target / path.name)

        shutil.copy2(ROOT / "design/market.md", self.book / "design/market.md")

    def mutate(self, path, old, new):
        target = self.book / "design" / path
        text = target.read_text()
        self.assertIn(old, text)
        target.write_text(text.replace(old, new, 1))

    def test_current_sources_pass(self):
        self.assertEqual(verify(self.book)["result"], "pass")

    def test_copied_signature_drift_fails(self):
        self.mutate("characters/lira-ashbow.md", "if the defense was Strong", "whatever the defense result")
        with self.assertRaisesRegex(ValueError, "complete signature procedure"):
            verify(self.book)

    def test_adaptable_omission_fails(self):
        self.mutate("characters/mara-reedheart.md", "= 13 DP**", "= 12 DP**")
        with self.assertRaisesRegex(ValueError, "pool including explicit Adaptable"):
            verify(self.book)

    def test_missing_prerequisite_fails(self):
        self.mutate("characters/pip-copperwink.md", "[Patient Hand II]", "[Patient Hand III]")
        with self.assertRaisesRegex(ValueError, "prerequisites"):
            verify(self.book)

    def test_incorrect_market_price_fails(self):
        self.mutate("characters/lira-ashbow.md", "| 9 | 1 |", "| 5 | 1 |")
        with self.assertRaisesRegex(ValueError, "market price"):
            verify(self.book)


if __name__ == "__main__":
    unittest.main()
