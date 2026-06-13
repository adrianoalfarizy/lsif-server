# Offline-like Map Icon Audit — v0.26A.1.16

## Root causes found

1. Public interiors and dynamic locations shared only 20 slots (`80..99`).
2. Only the nearest entries inside a custom 1500m radius were installed.
3. Installed icons used `MAPICON_GLOBAL`, forcing icons toward the radar edge.
4. Clothing used generic business icon 52 instead of clothes icon 45.
5. Gym used trucking/job icon 51 instead of gym icon 54.
6. Hospital had the correct fallback ID 22 but could be excluded by the nearest-20 slot manager.
7. Casino and City Hall used generic business icon 52.
8. Persistent business, bus stop, gang HQ and other multiplayer markers competed for overlapping native icon slots.

## New policy

- Public interior icons are canonicalized to GTA SA map icon IDs.
- All allocated public interior icons are registered permanently.
- Five slots are reserved for buyable houses/property.
- `MAPICON_LOCAL` is used: pause-map registration stays permanent, radar visibility follows native close proximity.
- The custom 1500m radius, nearest-20 selection, eight-second refresh timer and global edge behavior are retired.
- City Hall is intentionally not assigned a fake shop/bank icon.
- Persistent bus stop, generic business, dealer, race, job and Gang HQ point icons are omitted from the offline-like registry.
- Turf remains represented by GangZones.

## Capacity

Native `SetPlayerMapIcon` supports 100 icon slots per player. SAIF reserves:

- 95 slots for canonical public interiors.
- 5 slots for property-for-sale houses.

The in-game Owner audit reports candidate, rendered, omitted and stored-mismatch counts.
