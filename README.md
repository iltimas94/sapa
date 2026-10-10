# sapa

SAHABAT PANCASILA

## Jenjang/kelas pengguna

Aplikasi membedakan empat pilihan jenjang yang dipilih pada saat pertama kali
dibuka:

| Pilihan | Tema (bergradasi) | Materi |
| --- | --- | --- |
| SD Kelas 1 - 6 | Kuning/amber + warna-warni (ceria, kanak-kanak) | Menu "Cari Sila" (materi SD, tidak berubah) |
| SMP Kelas 7 | Biru langit cerah (awal transisi, masih ramah) | `lib/data/materi_kelas7.dart` (5 bab) |
| SMP Kelas 8 | Biru sedang (mapan, lebih teratur) | `lib/data/materi_kelas8.dart` (5 bab) |
| SMP Kelas 9 | Navy/indigo tua (formal, siap SMA) | Belum tersedia (menampilkan info "segera hadir") |

Tema tiap jenjang mencakup warna dasar, AppBar, latar halaman utama, dan palet
warna menu (lihat `lib/theme/app_theme.dart`: `forLevel`, `menuPalette`, dan
`bodyDecoration`). Semakin naik kelasnya, tampilan berangsur meninggalkan nuansa
kanak-kanak dan menjadi lebih formal.

Pilihan jenjang disimpan di cache lokal perangkat melalui `shared_preferences`
(`lib/services/level_storage.dart`), sehingga saat aplikasi dibuka kembali
pengguna langsung masuk ke halaman utama sesuai jenjangnya. Tombol **logout**
pada AppBar menghapus cache tersebut dan mengembalikan pengguna ke halaman
pilih jenjang.

## Menambah materi SMP (kelas 9)

1. Siapkan dokumen `.docx` dengan judul bab memakai format `MATERI 1: JUDUL`.
2. Jalankan generator:

   ```powershell
   powershell -ExecutionPolicy Bypass -File tools/generate_materi_dart.ps1 `
       -DocxPath "D:/Download/Kelas IX.docx" -Kelas 9
   ```

3. `lib/data/materi_kelas9.dart` akan terisi otomatis dan langsung tampil pada
   menu **Materi** untuk jenjang SMP Kelas 9. Setelah materi kelas 9 terisi,
   ubah juga `materiTersedia` pada `lib/models/student_level.dart` menjadi
   `true` agar banner "segera hadir" di halaman utama hilang.

Catatan: nomor bab otomatis mengikuti urutan dokumen, jadi typo nomor di
dokumen sumber (misalnya dua "MATERI 4" seperti pada Kelas VIII) tetap aman
dan id tetap unik. Judul bab otomatis dinormalisasi (contoh: `Uud` menjadi
`UUD`).

## Build APK di Windows (AccessDeniedException Google Drive)

Masalah umum di mesin ini:

```
Execution failed for task ':app:packageRelease'.
> java.nio.file.AccessDeniedException: ...\build\app\outputs\apk\release\baselineProfiles\0
```

**Penyebab:** Google Drive for Desktop (`GoogleDriveFS.exe`) menyuntikkan
`desktop.ini` ke folder di dalam `Documents`, dan Windows otomatis memberi
atribut **ReadOnly** pada folder berisi `desktop.ini` itu. Gradle lalu tidak
bisa menghapus folder output lama saat task `packageRelease`.

**Cara build yang aman:**

```powershell
powershell -ExecutionPolicy Bypass -File tools/build_apk.ps1
```

Skrip itu membersihkan `desktop.ini` + atribut ReadOnly lalu menjalankan
`flutter build apk --release` (otomatis mengulang sekali bila gagal).

**Solusi permanen (pilih salah satu):**

1. Pindahkan repo ke luar folder `Documents`, misalnya `C:\dev\sapa`.
2. Matikan backup folder Documents di Google Drive for Desktop:
   Settings/Preferences → *Back up to Google Drive* → hapus centang
   Desktop & Documents.
3. Bila ingin build manual tetap aman, jalankan dulu sebelum `flutter build`:

   ```powershell
   attrib -r "build\*.*" /s /d
   Get-ChildItem -Recurse -Force -Filter desktop.ini build | Remove-Item -Force
   ```

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
