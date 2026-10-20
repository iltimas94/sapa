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
| SMP Kelas 9 | Navy/indigo tua (formal, siap SMA) | `lib/data/materi_kelas9.dart` (5 bab) |

Tema tiap jenjang mencakup warna dasar, AppBar, latar halaman utama, dan palet
warna menu (lihat `lib/theme/app_theme.dart`: `forLevel`, `menuPalette`, dan
`bodyDecoration`). Semakin naik kelasnya, tampilan berangsur meninggalkan nuansa
kanak-kanak dan menjadi lebih formal.

Pilihan jenjang disimpan di cache lokal perangkat melalui `shared_preferences`
(`lib/services/level_storage.dart`), sehingga saat aplikasi dibuka kembali
pengguna langsung masuk ke halaman utama sesuai jenjangnya. Tombol **logout**
pada AppBar menghapus cache tersebut dan mengembalikan pengguna ke halaman
pilih jenjang.

## Menambah / memperbarui materi SMP (kelas 7, 8, 9)

Semua jenjang kini punya materi (masing-masing 5 bab). Untuk memperbarui
atau menambah bab:

1. Siapkan dokumen `.docx` dengan judul bab memakai format `MATERI 1: JUDUL`.
2. Jalankan generator, contoh untuk kelas 9:

   ```powershell
   powershell -ExecutionPolicy Bypass -File tools/generate_materi_dart.ps1 `
       -DocxPath "D:/Download/Kelas IX.docx" -Kelas 9
   ```

3. `lib/data/materi_kelas9.dart` langsung terisi dan tampil pada menu
   **Materi** jenjang tersebut. Bila kelak ada kelas yang materinya
   dikosongkan lagi, set `materiTersedia` di `lib/models/student_level.dart`
   menjadi `false` supaya banner "segera hadir" tampil di halaman utama.

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

## Build Windows di mesin ini (Visual Studio 2026)

Mesin ini hanya punya toolchain C++ di **Visual Studio Build Tools 2026 (v18)**;
VS 2022 Community terpasang tetapi tanpa workload C++ (tidak ada `cl.exe`).
Flutter 3.32.7 belum mengenali versi 18 sehingga mengirim generator CMake
`Visual Studio 16 2019` yang tidak ada, dan build Windows gagal dengan:

```
CMake Error: generator : Visual Studio 16 2019
Does not match the generator used previously: Visual Studio 17 2022
```

Dua hal berikut sudah dikerjakan dan perlu dijaga:

1. **Patch lokal SDK Flutter** di
   `D:\Android\flutter_windows_3.32.7-stable\flutter\packages\flutter_tools\lib\src\windows\visual_studio.dart`,
   menambahkan cabang `18 => 'Visual Studio 18 2026'` pada `cmakeGenerator`
   (baris ~190). Karena instalasinya ZIP, snapshot `flutter_tools` harus
   dikompilasi ulang setelah patch: hapus
   `flutter\bin\cache\flutter_tools.stamp` dan `flutter_tools.snapshot`.
   **Patch ini hilang bila Flutter di-upgrade** — ulangi langkahnya setelah
   upgrade, atau pasang workload *Desktop development with C++* pada VS 2022
   Community lalu hapus patch (Flutter akan memakai VS 17 2022).
2. **`windows/CMakeLists.txt`** menambahkan
   `add_definitions(-D_SILENCE_EXPERIMENTAL_COROUTINE_DEPRECATION_WARNINGS)`
   karena MSVC 14.5x (VS 2026) menaikkan deprecated header
   `<experimental/coroutine>` yang dipakai plugin `audioplayers_windows` dan
   `flutter_inappwebview_windows` menjadi error STL1011.

Bila muncul lagi error generator mismatch, hapus folder `build/windows`
(lakukan `attrib -r "build\windows\*.*" /s /d` dulu bila folder terkunci
atribut ReadOnly buatan Google Drive) lalu build ulang.

Build desktop: `flutter build windows --debug` (keluaran:
`build\windows\x64\runner\Debug\sapa.exe`).

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
