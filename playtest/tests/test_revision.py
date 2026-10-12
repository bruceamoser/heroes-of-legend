"""Regression checks for the reviewed rules and their engine integration."""
import unittest,copy,itertools,random
from unittest.mock import patch
from mechanics import *
from combat import hurt_amount,battle,new_party,fixture,run
from catalog import CARDS,CLASSES
from builds import initial,CONFIG,get_card,grant_disc

class RevisionTests(unittest.TestCase):
 def test_healing_cost_boundary_and_resistance(self):
  for tier,(profile,cost) in HEALING.items():
   self.assertFalse(can_pay(cost,cost));self.assertTrue(can_pay(cost+1,cost))
   for r in range(4):self.assertEqual([healing_amount(x,r) for x in profile],[max(1,x-r) for x in profile])
  self.assertEqual(healing_amount(3,3),1)
  self.assertEqual(hurt_amount({'physical':3,'fire':3},{'physical':3,'fire':3}),1)
 def test_cap_applies_even_to_oversized_source(self):
  self.assertEqual(hurt_amount({'physical':5},{'physical':9}),2)
  self.assertEqual(CLASS_HP:=CLASSES['Protector']['hp'],5)
 def test_decay_and_duration_only_conditions(self):
  d={'Bleeding':3,'Dazed':3,'Paralyzed':3,'Blinded':2}
  damage=0;allow=[]
  for _ in range(3):damage+=d['Bleeding'];allow.append(actions(d['Dazed']));decay(d)
  self.assertEqual(damage,6);self.assertEqual(allow,[0,1,2]);self.assertFalse(any(d.values()))
  self.assertEqual(actions(0,3),0)
 def test_main_removal_then_decay(self):
  d={'Bleeding':3};reduce_condition(d,'Bleeding');damage=d['Bleeding'];decay(d)
  self.assertEqual((damage,d['Bleeding']),(2,1))
  with self.assertRaises(AssertionError):reduce_condition({'Paralyzed':2},'Paralyzed')
 def test_grapple_vulnerability_uses_ordinary_cancellation(self):
  self.assertEqual(grapple_attack_net(3,1,2),2)
  self.assertEqual(grapple_attack_net(1),1)
  self.assertEqual(grapple_attack_net(2),2)
  self.assertEqual(grapple_attack_net(5),3)
 def test_healing_harmed_damage_matches_result(self):
  for amount in [3,6,9,10,15,16,24]:
   for res in range(4):self.assertEqual(hurt_amount({'life':amount},{'life':res}),healing_amount(amount,res))
 def test_wound_coverage_and_star(self):
  expected={100*a+10*b+c for a,b,c in itertools.combinations_with_replacement(range(1,7),3)}
  for table,rows in wound_tables().items():
   self.assertEqual(set(rows),expected)
   for code,w in rows.items():
    self.assertNotIn('brief',w['effect'].lower())
    if w['rv']:
     low,high={1:(1,2),2:(2,3),3:(3,5),4:(5,7),5:(7,9)}[code//100]
     self.assertTrue(low<=w['rv']<=high)
  w=wound_effects(wound_tables()['Physical'][366])
  self.assertEqual(w['lasting'],{'Blinded':1});self.assertEqual(w['temporary'],{})
 def test_once_daily_treatment_and_specific_remedy(self):
  w=copy.deepcopy(wound_tables()['Physical'][346])
  with self.assertRaises(AssertionError):treat(w,'Bone',1,3)
  self.assertFalse(treat(w,'Soft Tissue',1,3))
  with self.assertRaises(AssertionError):treat(w,'Soft Tissue',1,3)
  self.assertTrue(treat(w,'Soft Tissue',2,2));self.assertEqual(w['code'],346)
  with self.assertRaises(AssertionError):treat(copy.deepcopy(wound_tables()['Physical'][566]),'Soft Tissue',1,3)
 def test_recipe_purchase_has_real_gates(self):
  b=initial(CONFIG[0]);b['pool']=20
  with self.assertRaises(AssertionError):get_card(b,'recipes')
  grant_disc(b,'Craft');get_card(b,'craft');before=b['pool'];get_card(b,'recipes')
  self.assertEqual(before-b['pool'],2);self.assertEqual(len(b['recipes']),4)
  with self.assertRaises(AssertionError):get_card(b,'recipes')
  self.assertEqual(b['hp_purchases'],[])
 def test_tether_for_either_actor_and_forced_movement(self):
  self.assertTrue(tether((0,0),(6,6)))
  self.assertFalse(tether((0,0),(7,0)))
  self.assertFalse(tether((-1,0),(6,0)))
  self.assertTrue(tether((1,0),(6,0)))
 def test_engine_cost_paid_and_enemy_cost_paid(self):
  s=dict(count=4,ehp=24,eres=1,damage=[5,6,8],policy='all',enemy_healers=2,target='spread')
  r=run(s,100)
  self.assertGreater(r['heals'],0);self.assertAlmostEqual(r['heals'],r['healing_cost'])
  self.assertGreater(r['enemy_heals'],0);self.assertAlmostEqual(r['enemy_heals'],r['enemy_healing_cost'])
 def test_engine_active_wounds_retain_real_injuries(self):
  s=dict(count=4,ehp=20,eres=1,damage=[7,8,10],policy='none',active_wounds=True)
  injuries=[]
  for i in range(30):
   m,p=battle(s,random.Random(i));injuries.extend(w for pc in p for w in pc['injuries'])
   self.assertTrue(all(pc['wounds']>=len(pc['injuries']) for pc in p))
  self.assertTrue(injuries)
  self.assertTrue(all(w['code'] in wound_tables()[w['table']] for w in injuries))
 def test_healing_catalog_consistent(self):
  for c in CARDS.values():
   if 'healing' in c:self.assertEqual(c['hp_cost'],c['level']);self.assertIn('HP',c['text'])
  self.assertEqual({c['treatment'] for c in CARDS.values() if 'treatment' in c},{'Soft Tissue','Bone','Elemental','Mental','Radiant','Life'})
if __name__=='__main__':unittest.main()
