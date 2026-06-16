# SAIF / LSIF Dev v0.26A.1.31
## Owned Vehicle, Garage Storage & Color Runtime Rework

Patch ini mengganti logika tiga slot kendaraan lama menjadi lifecycle owned vehicle berbasis garage, tanpa langsung menghapus kolom `player_vehicles.slot`. Kolom tersebut dipertahankan sebagai urutan internal kompatibilitas 1–32 agar kendaraan existing tidak hilang.

## Runtime utama

- Parked vehicle umum kembali ke posisi asal setelah meledak melalui respawn native, atau setelah ditinggalkan jauh dari titik asal selama batas policy.
- Kendaraan yang baru dibeli menjadi `dealer_pending` sampai pertama kali disimpan di garage.
- Hanya satu kendaraan `dealer_pending` yang boleh dimiliki sekaligus.
- Kendaraan dengan home garage dapat disimpan melalui checkpoint merah + ALT.
- Garage save menjadi satu-satunya commit posisi default dan modifikasi warna.
- `/park` dinonaktifkan.
- `/despawn` mengembalikan kendaraan aktif ke home garage tanpa menghapus ownership.
- `/myveh [nomor]` memunculkan kendaraan tersimpan di parking spawn point kosong terdekat.
- `/vehcolor [primary] [secondary]` menerapkan warna sementara; warna baru permanen saat garage save berikutnya.
- Kendaraan yang hancur kembali ke home garage setelah cooldown.
- Kendaraan `dealer_pending` yang hancur kembali ke delivery queue dealership.
- Rumah tidak dapat dijual selama masih menjadi home garage kendaraan.

## Scope garage rumah

- 29 lokasi house storage tersedia.
- 12 lokasi exact GTA SA aktif langsung, masing-masing satu physical parking slot.
- 17 lokasi lain tetap pending sampai checkpoint dan spawn ditentukan melalui editor.
- House storage v0.26A.1.31 dibatasi satu physical parking slot per rumah. Multi-slot dipersiapkan untuk public garage pada versi berikutnya.

## Database

Migration menambahkan:

- lifecycle fields pada `player_vehicles`;
- `vehicle_storage_slots`;
- `vehicle_spawn_points`;
- policy fields untuk dealer pending, nearest spawn, despawn, color modification, parked lifecycle, cooldown, dan abandonment.

Apply:

- menormalisasi urutan kendaraan existing menjadi 1–32 per owner tanpa menghapus row;
- mempertahankan home assignment dari `player_vehicle_storage`;
- memastikan 29 house storage dan 12 exact physical slots;
- membuat parking spawn points dari exact storage slots dan offset parked vehicle umum;
- mengaktifkan runtime baru;
- tetap menonaktifkan public garage, impound, dan business storage.

## Compile

`pawncc` dengan seluruh include Qawno project belum dijalankan pada environment packaging. F5 lokal wajib menghasilkan 0 error dan 0 warning sebelum Git/deploy.
