# SAIF / LSIF Dev v0.26A.1.16 — Offline-like Map Icon Canonical Audit

## Purpose

This patch audits and consolidates all public-world map icon behavior after the GTA SA offline public interior import.

It fixes icon identity and changes radar rendering to the closest native GTA SA/open.mp behavior:

- Permanent icon registration for the large pause map.
- `MAPICON_LOCAL` for native close-proximity minimap/radar display.
- No custom 1500m radius.
- No global edge marker.
- No nearest-20 public interior truncation.

## Canonical icon IDs

| Type | Icon |
|---|---:|
| Ammu-Nation | 6 |
| Barber | 7 |
| Burger Shot | 10 |
| Cluckin' Bell | 14 |
| Hospital | 22 |
| Caligula's Casino | 25 |
| Mod Garage | 27 |
| Pizza Stack | 29 |
| Police | 30 |
| Property for sale | 31 |
| Save House | 35 |
| Tattoo | 39 |
| Triads/Four Dragons Casino | 44 |
| Clothing | 45 |
| Generic restaurant | 50 |
| 24/7 | 52 |
| Gym | 54 |
| Pay 'n' Spray | 63 |
| City Hall | Hidden; no canonical GTA SA legend icon |

## Owner tools

- `/mapiconaudit`
- `/offlineicons`
- `/offlineiconaudit`
- `/refreshicons`

Menu path:

`/amenus → GTA Offline Import Audit → Offline-like Map Icon Audit`

## Database files

1. `database/fixes/20260613_saif_v0.26A.1.16_offline_map_icon_canonical_fix.sql`
2. `database/verify/verify_saif_v0.26A.1.16_offline_map_icon_canonical.sql`
3. `database/rollback/rollback_saif_v0.26A.1.16_offline_map_icon_canonical.sql`

The fix script stores old values in `offline_public_interior_map_icon_backup` before updating.

## Installation order

1. Replace and compile `gamemodes/lsif.pwn`.
2. Back up `lsif_db`.
3. Run the icon fix SQL.
4. Run verify SQL.
5. Push/deploy the gamemode.
6. Run `/offlineexactreload` or `/refreshicons` as Owner.
7. Open `/mapiconaudit` and verify no public icons are omitted.

## Important behavior changes

- Public interior icons no longer share the old 20-slot nearby manager.
- Hospital can now appear because all canonical public interiors are allocated, not just the nearest 20.
- Clothing uses icon 45.
- Gym uses icon 54.
- Restaurant brands keep separate icons.
- City Hall no longer impersonates a shop/bank icon.
- Bus stops, generic businesses, job, race, dealer and Gang HQ point icons are omitted from the persistent offline-like map registry.
- Turf remains visible through GangZones.
