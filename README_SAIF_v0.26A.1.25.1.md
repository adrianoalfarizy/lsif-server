# SAIF / LSIF Dev v0.26A.1.25.1 — Map Icon Allocator Gate Fix

Hotfix untuk controlled GTA SA 29-savehouse apply.

## Root cause

Apply v0.26A.1.25 menganggap jumlah kandidat public icon harus <=91. Runtime Pawn sebenarnya sudah memakai allocator tetap:

- slot 0–90: public service/hospital, diprioritaskan dan dipotong maksimal 91;
- slot 91: rumah milik player;
- slot 92–99: delapan rumah for-sale terdekat.

Karena itu public candidates >91 adalah kondisi overflow terkelola, bukan alasan membatalkan apply rumah.

## Perubahan

- Menghapus fatal gate `public_overflow<>0` dari apply.
- Tetap mewajibkan policy 91+1+8 aktif.
- Menghitung candidate/rendered/omitted secara eksplisit.
- Menampilkan omitted sebagai informational pada dry-run, apply output, verify, dan menu in-game.
- Tidak ada migration baru.
- Tidak ada perubahan pada house_catalog/player_houses saat percobaan apply sebelumnya karena error terjadi sebelum apply session dan transaksi.

## SQL utama

- `database/dry_run/dry_run_saif_v0.26A.1.25.1_controlled_29_savehouse_apply_gate.sql`
- `database/apply/apply_saif_v0.26A.1.25.1_controlled_29_gtasa_savehouses.sql`
- `database/verify/verify_saif_v0.26A.1.25.1_controlled_29_savehouse_apply.sql`
- `database/verify/audit_public_map_icon_allocator_v0.26A.1.25.1.sql`

Rollback v0.26A.1.25 tetap kompatibel dengan apply session v0.26A.1.25.1.

## Installation order

1. Replace and compile `gamemodes/lsif.pwn`.
2. Deploy repository files.
3. Run `database/verify/audit_public_map_icon_allocator_v0.26A.1.25.1.sql`.
4. Run `database/dry_run/dry_run_saif_v0.26A.1.25.1_controlled_29_savehouse_apply_gate.sql`.
5. Confirm all non-informational gates are clear.
6. Run apply with token `APPLY_29_GTASA_SAVEHOUSES`.
7. Run `database/verify/verify_saif_v0.26A.1.25.1_controlled_29_savehouse_apply.sql`.
8. Reload via `/offlinehousereload`.

A fresh archive is only required if `house_catalog` or `player_houses` changed after archive session 8. Public icon candidate count does not alter either archived dataset.
