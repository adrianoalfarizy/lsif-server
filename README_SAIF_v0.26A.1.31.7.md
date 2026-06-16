# SAIF v0.26A.1.31.7 — Semantic Public Parking Zone Runtime

Versi ini mengubah kontrak pemanggilan owned vehicle agar kendaraan hanya muncul pada slot parkir publik yang memang telah didefinisikan sebagai parkiran, misalnya parkiran restoran, toko, rumah sakit, kantor polisi, mall, gym, kasino, hotel, gedung pemerintah, dan fasilitas umum.

## Perubahan inti

- Menambahkan tabel `public_parking_zones` dan `public_parking_slots`.
- Menambahkan policy `public_parking_policy` dengan radius pencarian 250 / 500 / 1000 meter.
- `/myveh` untuk kendaraan berstatus `stored` hanya memakai slot dengan:
  - zone `enabled=1` dan `review_status='approved'`;
  - slot `enabled=1` dan `review_status='approved'`;
  - interior dan virtual world sama dengan player;
  - slot berada di dalam radius zone;
  - tidak ditempati kendaraan atau player;
  - lolos validasi collision ColAndreas.
- Menolak pemanggilan jika tidak ada slot parkir publik resmi yang tersedia.
- Menghapus sumber berikut dari jalur spawn owned vehicle:
  - posisi parked vehicle;
  - offset kiri/kanan parked vehicle;
  - garage/storage slot;
  - mission spawn point;
  - permukaan kosong hasil dynamic near-player solver.
- Marker kuning tetap menunjukkan lokasi kendaraan yang berhasil dipanggil.
- Dynamic ColAndreas solver lama tetap tersedia melalui `/parkingprobe`, tetapi hanya sebagai diagnostic dan tidak dipakai oleh `/myveh`.

## Import fasilitas existing

Controlled apply membaca fasilitas aktif dari `public_interiors` dan membuat **candidate zone**, bukan menebak slot parkir.

Jenis fasilitas yang dicakup:

- Burger Shot, Cluckin' Bell, Pizza Stack;
- 24/7;
- hospital;
- police;
- gym;
- casino;
- clothing, barber, tattoo, Ammu-Nation;
- city hall.

Candidate zone menggunakan posisi eksterior fasilitas agar admin dapat menuju area tersebut. Candidate tidak menjadi sumber runtime sebelum admin menentukan center parkiran dan menambahkan slot nyata.

## Workflow kurasi parkiran

1. Jalankan migration, controlled apply, dan verify.
2. Deploy AMX v0.26A.1.31.7.
3. Jalankan `/parkingzoneaudit`.
4. Jalankan `/parkingzonelist` untuk melihat ID candidate zone.
5. Jalankan `/parkingzonegoto [zone_id]`.
6. Berjalan ke tengah area parkir yang sebenarnya lalu jalankan `/parkingzonesetcenter [zone_id]`.
7. Masuk kendaraan admin dan parkir tepat pada garis slot.
8. Jalankan `/parkingslotadd [zone_id]`.
9. Ulangi langkah 7–8 untuk setiap slot yang ingin tersedia.
10. Jalankan `/parkingzonereload`.
11. Uji `/myveh [nomor]` dari dekat fasilitas tersebut.

## Membuat zone baru

```text
/parkingzonecreate [type] [nama zona]
```

Contoh:

```text
/parkingzonecreate restaurant_parking Idlewood Burger Shot Parking
```

Tipe valid:

```text
restaurant_parking
shop_parking
hospital_parking
police_parking
government_parking
mall_parking
hotel_parking
gym_parking
casino_parking
facility_parking
public_parking
```

## Command admin

```text
/parkingzoneaudit
/parkingzonelist
/parkingzonegoto [zone_id]
/parkingzonecreate [type] [nama zona]
/parkingzonesetcenter [zone_id]
/parkingslotadd [zone_id]
/parkingzonedisable [zone_id]
/parkingslotdisable [slot_id]
/parkingzonereload
```

`/parkingpointadd` legacy tidak lagi menjadi sumber owned vehicle.

## Catatan runtime awal

Jika database sebelumnya belum mempunyai `admin_custom` parking point yang dapat dikonversi, jumlah approved runtime slot setelah apply dapat bernilai 0. Ini bukan kegagalan schema. Candidate facility zone harus dikurasi secara visual karena server tidak dapat mengenali garis parkir dari texture map secara otomatis.

Selama approved slot masih 0, `/myveh` akan menolak pemanggilan kendaraan stored. Setelah minimal satu slot approved dibuat dan runtime direload, slot tersebut dapat digunakan.

## Database safety

Patch tidak menghapus ownership kendaraan, home garage, warna, fuel, health, atau transaksi storage. Controlled apply hanya:

- membuat candidate semantic zones;
- mengonversi legacy `admin_custom` points yang aktif menjadi approved semantic zone + slot;
- menonaktifkan legacy spawn sources yang tidak boleh digunakan untuk owned vehicle;
- mengaktifkan semantic parking policy.

Rollback mengembalikan status enabled legacy spawn points. Candidate yang belum dikurasi dihapus, sedangkan zone/slot manual dan facility zone yang sudah dikurasi dipertahankan.
