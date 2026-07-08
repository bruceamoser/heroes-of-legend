## Epic 3 — Skills & Talents (#33)

**Dependency:** #32, #42 (classes)
**Est. Effort:** Large

### Goal
Create the complete class-based DP cost matrix — the table that makes every class feel different by pricing skills according to class identity.

### Design Principle
A skill that costs 1 DP is "in-class" (your class naturally excels at it). A skill at 4 DP is "cross-class" (possible but expensive). This replaces traditional D&D class skill lists with a gradient of accessibility.

### Cost Scale
- **1 DP** — Class specialty. Fits the class fantasy perfectly.
- **2 DP** — Adjacent competency. Reasonable for your class.
- **3 DP** — Unusual but possible. Requires investment.
- **4 DP** — Against type. Possible only with significant sacrifice.

### Tasks
- [ ] For each of the 8 classes, categorize all ~20 skills into the 4 cost tiers
- [ ] Validate that each class has at least 3-4 skills at 1 DP
- [ ] Validate that no class has every skill at low cost
- [ ] Create the full 20×8 matrix as an AsciiDoc table
- [ ] Write class-specific skill advice ("As a Protector, you'll want to invest in...")
- [ ] Ensure the matrix is balanced (no "best class" that gets everything cheap)
