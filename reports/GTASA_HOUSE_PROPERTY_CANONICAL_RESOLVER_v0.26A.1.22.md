# GTA SA House / Property Canonical Resolver — v0.26A.1.22

## Summary

- Source evidence: 255 rows from v0.26A.1.21.
- Canonical property slots: **32**.
- Purchasable savehouses source-ready: **29**.
- Business assets deferred: **2** — Wang Cars and Zero RC Shop.
- Story asset deferred: **1** — Verdant Meadows.
- Exact ENEX pairs: **30**.
- Unpaired business assets: **2**.
- Savepoint templates linked: **30**.
- Nearby garage candidates: **13 total / 12 baseline houses**.
- Runtime mutation: **none**.

## Backend finding

SAIF currently defines `MAX_HOUSES = 5` and keeps exterior positions, prices and names in hardcoded Pawn arrays. The 29 GTA SA savehouses are therefore source-ready but **not apply-ready**. A dynamic `house_catalog` must be created before archive/apply so existing `player_houses` ownership rows can remain safe.

## Decision table

| Slot | Canonical name | Offline price | Decision | ENEX pair | Garage candidate |
|---:|---|---:|---|---|---|
| 0 | Wang Cars Asset [SFDWT6] | $50,000 | business_asset_deferred | - / Int 0 | - |
| 1 | Zero RC Shop Asset [GARC] | $30,000 | business_asset_deferred | - / Int 0 | - |
| 2 | Verdant Meadows Airstrip [MEAD] | $80,000 | story_asset_deferred | DESHOUS / Int 10 | cn2gar2 |
| 3 | GTA SA Savehouse [SMB2] | $30,000 | baseline_ready | SVLAMD / Int 8 | beacsv |
| 4 | GTA SA Savehouse [RSW2] | $20,000 | baseline_ready | SVLAMD / Int 8 | vEsvgrg |
| 5 | GTA SA Savehouse [CARSO] | $30,000 | baseline_ready | SVCUNT / Int 6 | cn2gar1 |
| 6 | GTA SA Savehouse [PRP2] | $50,000 | baseline_ready | SVVGMD / Int 9 | blob69 |
| 7 | GTA SA Savehouse [WWE] | $30,000 | baseline_ready | SVLAMD / Int 8 | blob7 |
| 8 | GTA SA Savehouse [PALO] | $35,000 | baseline_ready | SVCUNT / Int 6 | burbdoo |
| 9 | GTA SA Savehouse [REDW2] | $30,000 | baseline_ready | SVLAMD / Int 8 | blob6 |
| 10 | GTA SA Savehouse [BLUF2] | $10,000 | baseline_ready | SVLAMD / Int 8 | - |
| 11 | GTA SA Savehouse [CALT] | $100,000 | baseline_ready | SVSFBG / Int 6 | sav1sfe |
| 12 | GTA SA Savehouse [MUL2b] | $120,000 | baseline_ready | SVSFBG / Int 6 | CEsafe1 |
| 13 | GTA SA Savehouse [PARA] | $20,000 | baseline_ready | SVSFSM / Int 6 | sav1sfw |
| 14 | GTA SA Savehouse [HASH] | $40,000 | baseline_ready | SVSFMD / Int 10 | svgsfs1 |
| 15 | GTA SA Savehouse [VERO1] | $10,000 | baseline_ready | SVLAMD / Int 8 | - |
| 16 | GTA SA Savehouse [PIRA] | $6,000 | baseline_ready | SVVGHO2 / Int 2 | - |
| 17 | GTA SA Savehouse [CAM] | $6,000 | baseline_ready | SVVGHO1 / Int 1 | - |
| 18 | GTA SA Savehouse [CHINA] | $20,000 | baseline_ready | SVSFSM / Int 6 | - |
| 19 | GTA SA Savehouse [WHET] | $100,000 | baseline_ready | SVCUNT / Int 6 | - |
| 20 | GTA SA Savehouse [DOH2] | $20,000 | baseline_ready | SVSFBG / Int 6 | - |
| 21 | GTA SA Savehouse [WESTP2] | $50,000 | baseline_ready | SVHOT1 / Int 5 | - |
| 22 | GTA SA Savehouse [ANGPI] | $20,000 | baseline_ready | SVCUNT / Int 6 | - |
| 23 | GTA SA Savehouse [ELQUE] | $20,000 | baseline_ready | SVCUNT / Int 6 | - |
| 24 | GTA SA Savehouse [ROBAD1] | $20,000 | baseline_ready | SVCUNT / Int 6 | - |
| 25 | GTA SA Savehouse [DILLI] | $40,000 | baseline_ready | SVCUNT / Int 6 | burbdo2 |
| 26 | GTA SA Savehouse [JEF2] | $10,000 | baseline_ready | SVLASM / Int 11 | - |
| 27 | GTA SA Savehouse [OVS] | $6,000 | baseline_ready | SVVGHO2 / Int 2 | - |
| 28 | GTA SA Savehouse [RING] | $6,000 | baseline_ready | SVVGHO1 / Int 1 | - |
| 29 | GTA SA Savehouse [CREE] | $10,000 | baseline_ready | SVSFSM / Int 6 | - |
| 30 | GTA SA Savehouse [LIND3] | $10,000 | baseline_ready | SVLASM / Int 11 | - |
| 31 | GTA SA Savehouse [BLUEB1] | $10,000 | baseline_ready | SVCUNT / Int 6 | - |

## Safety contract

This resolver creates only `offline_property_resolver_sessions` and `offline_property_canonical_plan`. It does not insert, update, or delete `player_houses`, public interiors, pickups, ownership, or garage runtime rows.
