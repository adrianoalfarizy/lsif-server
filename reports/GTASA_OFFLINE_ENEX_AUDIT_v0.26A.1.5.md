# SAIF / LSIF Dev v0.26A.1.5 — GTA Offline ENEX Audit Report

## Scope

Tahap ini hanya membangun **source registry dan staging/audit queue**. Tidak ada perubahan pada `public_interiors`, `world_pickups`, `parked_vehicles`, `world_locations`, atau tabel runtime lain.

## Source identity

- Source label: `SAIF-OFFLINE-SOURCE`
- Source version: `GTA SA PC 1.0 US`
- Parser: `saif-offline-parser-v0.26A.1.5`
- Session key: `ecbbfa867b491c93570b92e0c6d3ff34e1e916da9df914d83edb066c1eac52c3`
- Source files registered: **275**
- IPL files parsed: **53**
- Major map zones: **6**
- Named info zones: **378**
- ENEX queue rows: **376**
- Warnings: **4**

## Safety state

Every generated ENEX row starts as:

```text
enabled = 0
review_status = pending
apply_status = pending
source_tag = offline_enex_queue
```

The import SQL performs no insert, update, delete, truncate, archive, spawn, or reload against runtime world tables.

## Category distribution

| Category | Rows |
|---|---:|
| entertainment | 30 |
| gang | 2 |
| garage | 3 |
| mission | 34 |
| property | 105 |
| restaurant | 60 |
| service | 34 |
| shop | 69 |
| transport | 2 |
| unknown | 37 |

## Context distribution

| Context | Rows |
|---|---:|
| savehouse | 99 |
| unknown | 37 |
| story_interior | 31 |
| restaurant | 22 |
| 247 | 19 |
| ammunation | 16 |
| clothing | 15 |
| wardrobe | 15 |
| cluckin_bell | 13 |
| pizza_stack | 13 |
| burger_shot | 11 |
| bar | 10 |
| barber | 10 |
| casino | 8 |
| police | 8 |
| tattoo | 7 |
| club | 6 |
| gym | 6 |
| property | 6 |
| stadium | 6 |
| driving_school | 4 |
| adult_venue | 3 |
| vehicle_mod_shop | 3 |
| adult_shop | 2 |
| airport | 2 |
| gang_hq | 2 |
| bike_school | 1 |
| donut_shop | 1 |

## Parser warnings

All four warnings are unnamed ENEX records. They remain in the queue with low confidence so they can be inspected manually.

- `00_RAW/data/maps/country/countn2.ipl:472` — Nama ENEX kosong.
- `00_RAW/data/maps/interior/int_veg.ipl:62` — Nama ENEX kosong.
- `00_RAW/data/maps/SF/SFe.ipl:315` — Nama ENEX kosong.
- `00_RAW/data/maps/SF/SFe.ipl:316` — Nama ENEX kosong.

## Interpretation

- High-confidence shop/service rows are **classification candidates**, not automatically approved runtime interiors.
- `property/savehouse` rows still need matching against SCM property logic before ownership is applied.
- Mission/story interiors must remain excluded from automatic public-interior replacement.
- Blank or unknown rows require location preview and source-line review.
- City code may be blank for countryside/desert records outside the six broad `map.zon` city boxes; `area_code` remains available from `info.zon` when matched.

## Acceptance criteria for this stage

```text
[ ] Migration creates four staging/audit tables.
[ ] Import registers 275 source files.
[ ] Import creates 376 ENEX queue rows.
[ ] enabled rows = 0.
[ ] unlinked source_file_id rows = 0.
[ ] warning logs = 4.
[ ] runtime tables are unchanged.
[ ] /offlineaudit is Owner-only.
[ ] /offlineinteriors can show queue detail.
[ ] Goto only previews the exterior coordinate and creates nothing.
```
