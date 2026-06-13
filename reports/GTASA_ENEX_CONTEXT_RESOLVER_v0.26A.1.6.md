# SAIF v0.26A.1.6 — ENEX Context Resolver Report

- Resolver: `saif-enex-context-resolver-v0.26A.1.6`
- Source session: `ecbbfa867b491c93570b92e0c6d3ff34e1e916da9df914d83edb066c1eac52c3`
- ENEX rows processed: **376**
- Runtime mutation: **none**
- Queue enabled/apply state changed: **no**

## Resolver status

- `partial`: **39**
- `resolved`: **329**
- `review_required`: **8**

## Recommended runtime targets

- `public_interiors+public_service_config`: **118**
- `player_houses`: **110**
- `reference_only`: **49**
- `public_interiors+skin_catalog`: **23**
- `public_interiors+ammu_config`: **16**
- `skin_wardrobe_reference`: **15**
- `public_interiors+police_service`: **8**
- `public_interiors+casino_service`: **8**
- `public_interiors+event_reference`: **6**
- `public_interiors+license_service`: **5**
- `review_required`: **4**
- `public_interiors`: **4**
- `public_interiors+betting_reference`: **3**
- `public_interiors+offline_garage_queue`: **3**
- `gang_preset_config`: **2**
- `public_interiors+transport_reference`: **2**

## Access scopes

- `public_shared`: **190**
- `property_private`: **110**
- `mission_reference`: **45**
- `player_private`: **15**
- `review_required`: **8**
- `event_shared`: **6**
- `gang_shared`: **2**

## Pair status

- `exterior_interior_pair`: **289**
- `single_record`: **58**
- `interior_group`: **17**
- `multi_exterior_group`: **12**

## Context counts

- `savehouse`: **104**
- `story_interior`: **31**
- `clothing`: **23**
- `restaurant`: **22**
- `247`: **19**
- `ammunation`: **16**
- `wardrobe`: **15**
- `cluckin_bell`: **13**
- `pizza_stack`: **13**
- `burger_shot`: **11**
- `bar`: **10**
- `barber`: **10**
- `police`: **8**
- `casino`: **8**
- `tattoo`: **7**
- `property`: **6**
- `club`: **6**
- `gym`: **6**
- `stadium`: **6**
- `unknown`: **4**
- `atrium`: **4**
- `driving_school`: **4**
- `casino_heist_access`: **4**
- `betting_shop`: **3**
- `adult_venue`: **3**
- `vehicle_mod_shop`: **3**
- `adult_shop`: **2**
- `test_interior`: **2**
- `crack_den`: **2**
- `gang_hq`: **2**
- `building_access`: **2**
- `airport`: **2**
- `pier_access`: **2**
- `warehouse`: **1**
- `donut_shop`: **1**
- `bike_school`: **1**

## Rows still requiring review

- `<blank>` / `8545e082b89d` — Baseline ENEX name classification retained and enriched with source evidence.; no exact quoted main.scm reference; pair=multi_exterior_group/4
- `ATRIUMX` / `c2b60710fc9a` — Interior-source atrium endpoint; no safe gameplay binding found in main.scm.; no exact quoted main.scm reference; pair=exterior_interior_pair/2
- `ATRIUME` / `a9060cdef5fb` — Interior-source atrium endpoint; no safe gameplay binding found in main.scm.; no exact quoted main.scm reference; pair=exterior_interior_pair/2
- `<blank>` / `e2ac591c2a22` — Baseline ENEX name classification retained and enriched with source evidence.; no exact quoted main.scm reference; pair=multi_exterior_group/4
- `ATRIUME` / `ba563288587f` — Interior-source atrium endpoint; no safe gameplay binding found in main.scm.; no exact quoted main.scm reference; pair=exterior_interior_pair/2
- `ATRIUMX` / `ace458923ea9` — Interior-source atrium endpoint; no safe gameplay binding found in main.scm.; no exact quoted main.scm reference; pair=exterior_interior_pair/2
- `<blank>` / `8ff898fc2158` — Baseline ENEX name classification retained and enriched with source evidence.; no exact quoted main.scm reference; pair=multi_exterior_group/4
- `<blank>` / `4019e1a81b1c` — Baseline ENEX name classification retained and enriched with source evidence.; no exact quoted main.scm reference; pair=multi_exterior_group/4

## Safety statement

This resolver writes only to `offline_interior_queue`, `offline_interior_context_evidence`, `offline_import_sessions`, and `offline_import_logs`.
It does not insert, update, delete, archive, reload, or spawn records in `public_interiors`, `world_pickups`, `parked_vehicles`, `player_houses`, or any other runtime dataset.
