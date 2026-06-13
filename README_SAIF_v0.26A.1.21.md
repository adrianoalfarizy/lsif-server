# SAIF / LSIF Dev v0.26A.1.21 — GTA SA House, Savehouse & Property Queue Foundation

## Purpose

Create an audit-only source queue that combines:

- 98 SCM property/save pickup statements;
- 105 IPL ENEX property/savehouse records;
- 52 IPL garage boundaries.

Total: **255 evidence rows**. No runtime or ownership apply occurs in this version.

## SQL order

```bash
sudo mariadb lsif_db < database/migrations/20260613_saif_v0.26A.1.21_house_property_queue_foundation.sql
sudo mariadb lsif_db < database/imports/20260613_gtasa_house_property_source_queue_v0.26A.1.21.sql
sudo mariadb lsif_db < database/verify/verify_saif_v0.26A.1.21_house_property_source_queue.sql
```

## Owner commands

```text
/offlineproperties
/offlinepropertylist
/offlineproperty [evidence_id]
```

## Expected verify

```text
total=255
for-sale=32
locked=29
savegame=37
enex savehouse=99
enex property=6
garage=52
unique property slots=32
unique save positions=19
enabled=0
non-pending apply=0
```

## Next version

`v0.26A.1.22 — House / Property Canonical Resolver & Pair Planner`
