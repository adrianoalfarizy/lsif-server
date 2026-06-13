# SAIF v0.26A.1.7 — ENEX Pair Audit & Apply Planner

- Candidate exterior plans: **93**
- Unique pair-ready plans: **91**
- Dry-run ready with current canonical service points: **44**
- Exact service point still required: **47**
- Exact duplicate exteriors blocked: **2**
- Current compiled public interior capacity: **80**
- Minimum capacity required for all unique core plans: **91**

## Per family

| Family | Candidate | Dry-run ready | Service pending | Blocked |
|---|---:|---:|---:|---:|
| Ammu-Nation | 11 | 2 | 9 | 0 |
| 24/7 Supermarket | 13 | 0 | 13 | 0 |
| Burger Shot | 10 | 10 | 0 | 0 |
| Cluckin' Bell | 12 | 12 | 0 | 0 |
| Pizza Stack | 12 | 10 | 0 | 2 |
| Barber Shop | 7 | 1 | 6 | 0 |
| Tattoo Shop | 4 | 2 | 2 | 0 |
| Clothing Store | 17 | 4 | 13 | 0 |
| Gym | 3 | 1 | 2 | 0 |
| Police Station | 4 | 2 | 2 | 0 |

## Mapping contract

- Exterior ENEX Point A → exterior arrow/interaction marker.
- Exterior ENEX Point B → safe exterior return spawn.
- Interior template Point A → interior exit arrow.
- Interior template Point B → interior arrival spawn.
- All plan rows remain `enabled=0` and `apply_status=draft`.
- No runtime table is mutated.

## Gates before apply

1. Raise `MAX_PUBLIC_INTERIORS` above 91; recommended 128.
2. Resolve exact service/cashier checkpoints for 47 variant interiors.
3. Keep two duplicate FDPIZA rows blocked.
4. Create archive/replace/rollback transaction only after in-game pair audit is clear.
