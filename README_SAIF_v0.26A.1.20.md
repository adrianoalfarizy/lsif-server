# SAIF / LSIF Dev v0.26A.1.20 — Full Baseline-89 World Pickup Apply Transaction

## Scope

Apply terkontrol untuk 89 pickup dunia permanen GTA San Andreas:

- 49 police bribe;
- 40 body armour.

Semua berasal dari blok SCM `INITIAL`, memiliki transform world resolved, interior/VW 0, dan telah lolos canonical resolver v0.26A.1.18.

## Safety contract

- membutuhkan archive `world_pickups` terbaru yang complete;
- runtime count, enabled-state, linkage, dan SHA-256 harus masih sama dengan archive;
- semua pickup aktif lama dicatat dan hanya diubah menjadi `enabled=0`;
- tidak ada `DELETE FROM world_pickups`;
- 89 row baru memiliki source tag per apply session;
- setiap plan/queue/runtime row dipetakan;
- rollback menonaktifkan 89 hasil import dan mengembalikan enabled-state lama;
- apply dan rollback memerlukan confirmation token binary-safe.

## Files

- migration tracking apply;
- final dry-run apply gate;
- apply transaction;
- verify transaction;
- failed-state diagnostics;
- one-command rollback;
- gamemode status/reload Owner tools.

## Runtime behavior

- bribe: model 1247, wanted -1, cooldown 180 detik;
- armour: model 1242, amount 100, cooldown 240 detik;
- runtime Z menggunakan source Z + 0.25;
- armour pickup tidak dikonsumsi bila armour player sudah penuh;
- bribe tidak dikonsumsi bila wanted player 0.

## Commands

- `/offlinepickupapplystatus`
- `/offlinepickupfullapply`
- `/offlinepickup89status`
- `/offlinepickupreload`
- `/offlinepickup89reload`

Apply tetap SQL-only.

## Required order

1. Backup database.
2. Compile/deploy gamemode.
3. Jalankan migration v0.26A.1.20.
4. Capture archive v0.26A.1.19 yang fresh.
5. Verify archive v0.26A.1.19.
6. Jalankan final dry-run gate v0.26A.1.20.
7. Jalankan apply dengan token.
8. Jalankan verify.
9. `/offlinepickupreload`.
10. Test bribe/armour, relog, dan restart.

## Confirmation tokens

Apply:

`APPLY_89_OFFLINE_WORLD_PICKUPS`

Rollback:

`ROLLBACK_LATEST_89_OFFLINE_WORLD_PICKUPS`
