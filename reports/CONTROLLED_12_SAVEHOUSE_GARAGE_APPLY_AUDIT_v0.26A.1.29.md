# CONTROLLED 12 SAVEHOUSE GARAGE APPLY AUDIT — v0.26A.1.29

## Controlled target

- 12 geometry plans with `safety_class=baseline_savehouse_candidate`.
- 12 geometry plans with `geometry_status=baseline_ready`.
- 12 unique canonical garage plans.
- 12 unique canonical house slots.
- 12 active live `house_catalog` rows.

## Runtime result

- 12 rows inserted into `garage_catalog`.
- 12 rows inserted into `house_garage_links`.
- Catalog rows are enabled so the existing runtime loader can load them.
- `spawn_status=ready` for all 12 rows.
- `garage_runtime_policy.enabled=0`.
- `store_enabled=0`.
- `retrieve_enabled=0`.
- `door_animation_enabled=0`.

## Safety

No player vehicle, parked vehicle, house ownership, door object, checkpoint, or storage mutation is performed. The apply is tracked by an apply session and a pre-apply runtime archive. Rollback deletes only tracked rows and restores the archived runtime/policy state.
