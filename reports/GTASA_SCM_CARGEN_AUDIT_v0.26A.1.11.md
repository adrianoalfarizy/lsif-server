# SAIF v0.26A.1.11 — GTA SA SCM Car Generator Audit

## Safety
- Staging only: `offline_vehicle_queue`.
- `enabled=0`, `apply_status=pending` for every row.
- No mutation to `parked_vehicles` and no vehicle spawn.

## Extraction summary
- Total `create_car_generator*`: **211**
- Resolved concrete vehicle model: **205**
- Random-model references (`modelId=-1`): **3**
- Zero-coordinate placeholders: **3**
- Variable-based transforms successfully resolved: **10**
- Initially switched on (`101`): **72**
- Initially switched off (`0`): **136**
- No initial switch found: **3**
- Custom plate rows: **12**
- `set_has_been_owned` rows: **27**
- Transform duplicate groups (kept as variants): **19** groups / **38** rows

## Context categories
- `world_cargen`: 134
- `import_export`: 36
- `girlfriend_state_pair`: 14
- `reward_reference`: 12
- `emergency_service`: 10
- `activity_reference`: 4
- `story_reference`: 1

## Policy
- Initial SCM switch state is preserved as evidence; it is not converted to runtime `enabled` yet.
- Reward, story, girlfriend, import/export, and activity generators remain reviewable rather than automatically treated as ordinary world cars.
- Duplicate coordinates are not deleted because some are locked/unlocked or progression variants.
- `modelId=-1` rows are references to random-model behavior and cannot be copied directly to `parked_vehicles` without a policy.
- The next stage will classify canonical world candidates and produce an archive/apply planner.
