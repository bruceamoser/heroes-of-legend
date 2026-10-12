import unittest,copy,random
from engine import *
class FixedRandom:
 def randint(self,a,b):return 1
class TacticalTests(unittest.TestCase):
 def enc(self,**kw):return Encounter(dict(board='open',hand_policy='drop_shield',**kw),random.Random(2))
 def test_stow_and_drink_consumes_main_and_maneuver(self):
  e=self.enc(potions=True);e.s['hand_policy']='stow';a=e.pcs[0];a['hp']=5
  self.assertEqual(held_hands(a),2);self.assertTrue(e.potion(a))
  self.assertFalse(a['main']);self.assertFalse(a['m']);self.assertEqual(a['held'],['melee'])
 def test_drop_shield_preserves_main_but_loses_shield(self):
  e=self.enc(potions=True);a=e.pcs[0];a['hp']=5;a['shield']=True
  self.assertTrue(e.potion(a));self.assertTrue(a['main']);self.assertFalse(a['m']);self.assertFalse(a['shield'])
  self.assertEqual(a['ground']['shield'],a['pos'])
 def test_dropped_bow_cannot_attack_after_potion(self):
  e=self.enc(potions=True);a=e.pcs[1];a['hp']=5
  self.assertTrue(e.potion(a));self.assertIn('ranged',a['ground'])
  self.assertTrue(e.draw(a,'ranged'));self.assertFalse(a['main']) # Pickup consumes remaining Main converted to Maneuver.
 def test_weapon_draw_from_stowed_is_part_of_attack(self):
  e=self.enc();a=e.pcs[1];a['held']=[];a['m']=False
  self.assertTrue(e.draw(a,'melee'));self.assertTrue(a['main'])
 def test_dropped_item_requires_same_square(self):
  e=self.enc();a=e.pcs[0];e.free_hand(a);a['pos']=(2,2)
  self.assertFalse(e.draw(a,'shield'))
 def test_prepared_policy_keeps_one_hand(self):
  e=self.enc();e=Encounter(dict(hand_policy='prepared'),random.Random(2))
  self.assertTrue(all(held_hands(a)<=1 for a in e.pcs))
  self.assertFalse(e.draw(e.pcs[0],'shield'))
 def test_d4_last_use_works(self):
  e=self.enc(potions=True);e.rng=FixedRandom();a=e.pcs[0];a['hp']=5
  e.potion(a);self.assertEqual(a['hp'],11);self.assertEqual(a['bottle'],0)
 def test_d4_empirical_probability(self):
  r=random.Random(100);n=20000
  self.assertLess(abs(sum(r.randint(1,4)==1 for _ in range(n))/n-.25),.01)
 def test_walls_occupied_and_prone(self):
  b=Board('door');self.assertFalse(b.line((3,2),(6,2)))
  occupied={(4,3):False};self.assertIsNone(b.path((3,2),lambda p:p==(6,2),occupied))
  occupied[(4,3)]=True;self.assertIsNotNone(b.path((3,2),lambda p:p==(6,2),occupied))
 def test_free_step_does_not_spend_or_extend_ordinary_movement(self):
  e=self.enc();a=e.pcs[2];a['move']=8
  e.move(a,lambda p:p==(3,0),free=1)
  self.assertEqual(distance(a['pos'],(1,2)),1);self.assertEqual(a['move'],8)
 def test_prone_occupant_not_legal_endpoint(self):
  e=self.enc();a=e.pcs[2];q=e.pcs[0];q['pos']=(2,2);q['prone']=True;a['move']=2;a['m']=False
  e.move(a,lambda p:p==(3,2));self.assertNotEqual(a['pos'],q['pos'])
 def test_wall_collision_and_forced_tether(self):
  e=self.enc();a=e.pcs[2];a['pos']=(0,0);hp=a['hp'];e.push(a,(-1,0),2)
  self.assertEqual(a['hp'],hp-1) # physical 3 minus armor 2
  q=actor(dict(hp=6,speed=5,resistance=0,attrs={},gear=[],cards=[]),(6,0),200,'summon');q['controller']=a;e.summons=[q]
  e.push(q,(1,0),1);self.assertTrue(q['terminal']);self.assertEqual(e.stats['tether_losses'],1)
 def test_healing_payment_free_hand_and_no_sacrifice(self):
  e=self.enc();a=e.pcs[3];b=e.pcs[0];b['hp']=1;a['hp']=1
  self.assertFalse(e.heal(a,b,CARDS['heal']));self.assertEqual(b['hp'],1)
 def test_adaptive_choice_respects_learned_cards(self):
  e=self.enc(level=7,healing_choice='adaptive');a=e.pcs[3];b=e.pcs[0];b['hp']-=2
  c=e.healing_choice(a,b);self.assertEqual(c['level'],1);self.assertIn('heal',a['b']['cards'])
 def test_wounded_campaign_keeps_scars_and_penalties(self):
  e=self.enc(wounds=True);a=e.pcs[0];w=copy.deepcopy(wound_tables()['Physical'][455]);w['lasting']={'movement':3};a['injuries']=[w];a['scars']=1
  self.assertEqual(e.speed(a),2);e2=Encounter(e.s,random.Random(3),e.pcs)
  self.assertEqual(e2.pcs[0]['scars'],1);self.assertEqual(e2.speed(e2.pcs[0]),2)
 def test_enemy_departure_provokes_player_basic_melee(self):
  e=self.enc(opportunity=True);npc=e.enemies[0];npc['pos']=(4,2);npc['move']=6;npc['m']=False
  before=npc['hp'];e.move(npc,lambda p:p==(5,2))
  self.assertEqual(e.stats['player_opportunities'],1);self.assertFalse(e.pcs[0]['r'])
  self.assertIn(before-npc['hp'],[1,2,4])
 def test_attack_spell_provokes_too(self):
  e=self.enc(opportunity=True);a=e.pcs[2];a['pos']=(5,1);a['move']=0
  e.attack(a);self.assertGreater(e.stats['opportunities'],0)
 def test_modes_terminate_and_have_no_overlap(self):
  for board in ['open','door','rough']:
   for policy in ['ignore','drop_shield','drop_weapon','stow','prepared']:
    e=Encounter(dict(board=board,hand_policy=policy,potions=True,wounds=True,opportunity=True),random.Random(10))
    r,_=e.run();self.assertEqual(r['win']+r['loss']+r['timeout'],1)
if __name__=='__main__':unittest.main()
