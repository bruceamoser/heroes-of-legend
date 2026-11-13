# Talven’s Book of Channeling
Discipline: Spellcraft
List: Channeling
ID: channeling
Endpoint: Master Channels

Draw, give and redirect magical power between existing reserves. Casting costs are paid separately from the points you transfer.

| Page | Spell | SP | Section |
|---|---|---:|---|
| 1 | Power Shock | 0 | I |
| 2 | Give Power | 1 | I |
| 3 | Draw Power | 1 | II |
| 4 | Siphon Power | 2 | II |
| 5 | Distant Channel | 2 | III |
| 6 | Channel Spell | 3 | III |
| 7 | Directed Siphon | 3 | IV |
| 8 | Greater Channel | 4 | IV |
| A1 | Lord Channels | 5 | IV |
| A2 | Rechanneling | 5 | IV |
| A3 | Power Bridge | 5 | IV |

## Spells

### Power Shock

**ID:** spell:channeling:1
**Page:** 1
**Action:** Main Action
**SP:** 0
**Attribute:** Reason
**Target / range:** One creature within 6 squares
**Duration:** Instant

Strike with a pulse of raw magical pressure. Deal 2/3/5 force damage. This attack changes HP through damage; SP transfer uses the later pages of this book.

### Give Power

**ID:** spell:channeling:2
**Page:** 2
**Action:** Main Action
**SP:** 1
**Attribute:** None
**Target / range:** One adjacent willing creature with its own SP reserve
**Duration:** Instant

After paying this spell's 1 SP cost, transfer up to 3 of your remaining SP to the recipient. Choose the amount up to its missing SP. Subtract every point received from your reserve.

### Draw Power

**ID:** spell:channeling:3
**Page:** 3
**Action:** Main Action
**SP:** 1
**Attribute:** None
**Target / range:** One adjacent willing creature with its own SP reserve
**Duration:** Instant

After paying this spell's 1 SP cost, receive up to 3 SP from the donor, limited by its current reserve and your missing SP. The donor chooses the amount and loses exactly what you receive.

### Siphon Power

**ID:** spell:channeling:4
**Page:** 4
**Action:** Main Action
**SP:** 2
**Attribute:** Reason
**Target / range:** One creature within 3 squares with its own SP reserve
**Duration:** Instant

Transfer 1/2/3 of the target's current SP into your reserve, limited by its available SP and your missing SP after paying the casting cost. Every point received leaves the target's reserve. An empty reserve transfers 0.

### Distant Channel

**ID:** spell:channeling:5
**Page:** 5
**Action:** Main Action
**SP:** 2
**Attribute:** None
**Target / range:** One willing creature within 8 squares with its own SP reserve
**Duration:** Instant

Give or receive up to 5 existing SP after paying this spell's casting cost. Both parties agree on the direction and amount. Respect the donor's remaining reserve and the recipient's missing SP.

### Channel Spell

**ID:** spell:channeling:6
**Page:** 6
**Action:** Main Action
**SP:** 3
**Attribute:** As the transmitted spell
**Target / range:** One willing ally within 6 squares; targets measured from that ally
**Duration:** As the transmitted spell

Choose one known Main Action spell costing at most 3 SP. Pay its normal cost plus this spell's 3 SP. The ally spends its Reaction immediately to release it from its position, choosing legal targets; you make any casting roll with the spell's attribute. Resolve it once. You remain responsible for any sustain and duration.

### Directed Siphon

**ID:** spell:channeling:7
**Page:** 7
**Action:** Main Action
**SP:** 3
**Attribute:** Reason
**Target / range:** One donor and one different recipient within 6 squares, each with its own SP reserve
**Duration:** Instant

Transfer 2/3/5 SP from the donor to the recipient. Willing participants may accept the full Strong amount automatically; if either is unwilling, roll once using the least favorable applicable modifiers. Limit transfer to the donor's current SP and recipient's missing SP. Pay the casting cost from your own reserve first.

### Greater Channel

**ID:** spell:channeling:8
**Page:** 8
**Action:** Main Action
**SP:** 4
**Attribute:** Reason
**Target / range:** Two different creatures within 6 squares with their own SP reserves
**Duration:** Instant

Choose a donor and recipient. Transfer up to 8 existing SP with both parties' consent. If either is unwilling, transfer 3/5/7 instead. Roll once using the least favorable applicable modifiers. Apply the donor's available and recipient's missing SP limits after paying your own casting cost.

### Lord Channels

**ID:** spell:channeling:a1
**Page:** A1
**Action:** Main Action
**SP:** 5
**Attribute:** As the funded spell
**Target / range:** Self and up to three willing donors within 3 squares
**Duration:** As the funded spell

Pay this spell's 5 SP yourself. Choose one known Main Action spell costing at most 6 SP. Each donor spends its Reaction and contributes an agreed amount toward that spell's cost; you pay the remainder. Cast it once with its normal attribute and targets. Contributions pay the spell directly, and you sustain any continuing effect.

### Rechanneling

**ID:** spell:channeling:a2
**Page:** A2
**Action:** Reaction · when a visible spell transfers SP between creatures
**SP:** 5
**Attribute:** Reason
**Target / range:** The transfer and a replacement recipient within 6 squares
**Duration:** Instant

Add 3/5/7 cancellation progress against the transfer, target 2 plus its casting SP cost. At completion, redirect its stated transferred amount to the replacement recipient, limited by the original donor's available SP and the new recipient's missing SP. Otherwise the original transfer resolves. Pay your own casting cost separately.

### Power Bridge

**ID:** spell:channeling:a3
**Page:** A3
**Action:** Main Action
**SP:** 5
**Attribute:** Reason
**Target / range:** Two different creatures within 6 squares with their own SP reserves
**Duration:** Sustained, up to 1 minute

Choose a donor and recipient. On casting, and on each later upkeep, transfer up to 6 existing SP if both consent, or roll for 2/4/6 if either is unwilling. Use the donor's current reserve and recipient's missing SP as limits. The bridge ends if either moves beyond 6 squares of you. Your casting and upkeep costs remain separate.
