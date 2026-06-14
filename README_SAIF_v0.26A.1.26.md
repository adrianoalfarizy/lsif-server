# SAIF / LSIF Dev v0.26A.1.26 — GTA SA Garage Offline Canonical Queue Foundation

## Tujuan

Membentuk katalog staging deterministik dari 52 exact-source IPL `GRGE` yang sudah tersedia di `offline_property_source_queue`, kemudian memisahkan hubungan garage-to-house ke tabel link tersendiri.

## Expected source result

- 52 exact GRGE definitions.
- 13 canonical house-plan links.
- 12 links belong to `baseline_ready` savehouses.
- 1 link belongs to deferred Verdant Meadows story asset.
- Remaining garage definitions stay unlinked/service/world references.

## Safety

Patch ini tidak membuat door, checkpoint, map icon, vehicle storage, ownership garage, object, atau runtime garage.

`enabled` tetap `0` dan `apply_status` tetap `draft`.

## SQL order

```bash
sudo mariadb lsif_db < database/migrations/20260614_saif_v0.26A.1.26_offline_garage_canonical_queue.sql
sudo mariadb lsif_db < database/imports/20260614_gtasa_garage_canonical_queue_v0.26A.1.26.sql
sudo mariadb lsif_db < database/verify/verify_saif_v0.26A.1.26_offline_garage_canonical_queue.sql
```

## Owner commands

```text
/offlinegarages
/offlinegaragelist
/offlinegarage [garage_id]
```

Menu juga tersedia pada `/amenus` → GTA Offline Import Audit → GTA SA Garage Canonical Queue.

## Next safe phase

Setelah queue dan link verify CLEAR, fase berikutnya adalah garage runtime archive/dry-run. Runtime door/checkpoint apply tetap memerlukan patch dan konfirmasi terpisah.
