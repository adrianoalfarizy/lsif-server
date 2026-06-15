# SAIF / LSIF Dev v0.26A.1.31.1 — ChangeVehicleColours Compile Hotfix

Hotfix compile-only untuk v0.26A.1.31.

Perubahan:
- Mengganti dua pemanggilan native deprecated `ChangeVehicleColor` menjadi `ChangeVehicleColours`.
- Memperbarui tampilan `/version` dan changelog ke v0.26A.1.31.1.

Tidak berubah:
- Database migration/apply/verify/rollback v0.26A.1.31.
- Lifecycle owned vehicle.
- Garage storage.
- `/despawn`.
- Nearest parking spawn.
- Pending/committed vehicle colours.
- Parked vehicle lifecycle.

Paket tetap membawa seluruh SQL v0.26A.1.31 karena hotfix ini menggantikan paket utama sebelum commit/deploy.
