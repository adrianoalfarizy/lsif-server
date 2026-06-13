# SAIF v0.26A.1.12 — Parked Vehicle Canonical Resolver & Apply Planner

## Safety
- Planner/staging only.
- `parked_vehicles` is not mutated.
- All planner rows remain `enabled=0`, `apply_status=draft`.

## Classification
| Decision | Rows | Meaning |
|---|---:|---|
| Baseline ready | 68 | Original SCM startup ON; recommended first apply. |
| Progression optional | 62 | Exact positions initially OFF; may be enabled if full offline visibility is desired. |
| Stateful deferred | 60 | Import/export, girlfriend, reward, story state bridge required. |
| Duplicate blocked | 13 | Shadow duplicates blocked to avoid double-spawn. |
| Random model review | 3 | modelId=-1 needs model-pool resolution. |
| Placeholder blocked | 3 | 0,0,0 transforms are not spawnable. |
| Switch unknown review | 2 | No startup switch state resolved. |

## Capacity
- Runtime `MAX_PARKED_VEHICLES`: 200.
- Recommended baseline first apply: 68.
- Baseline + progression + switch-review canonical maximum: 132.
- Existing runtime rows must be archived/replaced before actual apply.
