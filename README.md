# sapa

SAHABAT PANCASILA

## Jenjang/kelas pengguna

Aplikasi membedakan empat pilihan jenjang yang dipilih pada saat pertama kali
dibuka:

| Pilihan | Tema | Materi |
| --- | --- | --- |
| SD Kelas 1 - 6 | Kuning (tema awal) | Menu "Cari Sila" (materi SD, tidak berubah) |
| SMP Kelas 7 | Biru-indigo | `lib/data/materi_kelas7.dart` (5 bab) |
| SMP Kelas 8 | Biru-indigo | Belum tersedia (menampilkan info "segera hadir") |
| SMP Kelas 9 | Biru-indigo | Belum tersedia (menampilkan info "segera hadir") |

Pilihan jenjang disimpan di cache lokal perangkat melalui `shared_preferences`
(`lib/services/level_storage.dart`), sehingga saat aplikasi dibuka kembali
pengguna langsung masuk ke halaman utama sesuai jenjangnya. Tombol **logout**
pada AppBar menghapus cache tersebut dan mengembalikan pengguna ke halaman
pilih jenjang.

## Menambah materi SMP (kelas 8/9)

1. Siapkan dokumen `.docx` dengan judul bab memakai format `MATERI 1: JUDUL`.
2. Jalankan generator:

   ```powershell
   powershell -ExecutionPolicy Bypass -File tools/generate_materi_dart.ps1 `
       -DocxPath "D:/Download/Kelas VIII.docx" -Kelas 8
   ```

3. `lib/data/materi_kelas8.dart` akan terisi otomatis dan langsung tampil pada
   menu **Materi** untuk jenjang SMP Kelas 8. Setelah materi kelas 8/9 terisi,
   ubah juga `materiTersedia` pada `lib/models/student_level.dart` menjadi
   `true` agar banner "segera hadir" di halaman utama hilang.

## Menjalankan

```bash
flutter pub get
flutter run
```

Pengujian: `flutter test` (test alur pilih jenjang, materi SMP, dan logout ada
di `test/widget_test.dart` serta `test/smp_flow_test.dart`).

## Getting Started (template Flutter)

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
