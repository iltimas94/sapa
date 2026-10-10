import 'package:flutter/material.dart';

import '../models/student_level.dart';

/// Kumpulan tema aplikasi Sahabat Pancasila.
///
/// Tema dirancang bergradasi mengikuti usia siswa, dari paling kanak-kanak
/// sampai paling formal SMP:
///
/// * SD Kelas 1-6  -> kuning/amber + warna-warni (ceria, kanak-kanak)
/// * SMP Kelas 7   -> biru muda cerah (transisi, masih ramah)
/// * SMP Kelas 8   -> biru sedang (mapan, lebih teratur)
/// * SMP Kelas 9   -> navy/indigo tua (formal, siap SMA)
///
/// Selain warna dasar, setiap jenjang juga punya warna AppBar, latar halaman,
/// dan palet warna menu utama yang berbeda (lihat [menuPalette] dan
/// [bodyDecoration]).
class AppTheme {
  AppTheme._();

  // --- Warna dasar tiap jenjang ---
  static const Color sdSeed = Color(0xFFFFA000); // kuning ceria (SD)
  static const Color smp7Seed = Color(0xFF42A5F5); // biru langit (transisi)
  static const Color smp8Seed = Color(0xFF1E88E5); // biru sedang
  static const Color smp9Seed = Color(0xFF283593); // navy formal

  // --- Warna AppBar tiap jenjang SMP ---
  static const Color smp7AppBar = Color(0xFF1E88E5);
  static const Color smp8AppBar = Color(0xFF1565C0);
  static const Color smp9AppBar = Color(0xFF1A237E);

  /// Tema jenjang SD (tampilan tetap seperti versi awal aplikasi).
  static ThemeData sdTheme() {
    return ThemeData(
      colorScheme:
          ColorScheme.fromSeed(seedColor: sdSeed), // Contoh tema (SD)
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.amber[700], // Contoh warna AppBar
        foregroundColor: Colors.white,
        elevation: 4,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber[600],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  /// Tema SMP Kelas 7: biru muda yang cerah dan ramah (awal transisi).
  static ThemeData smp7Theme() {
    return _smpTheme(
      seed: smp7Seed,
      appBarColor: smp7AppBar,
      buttonColor: smp7Seed,
      backgroundTop: const Color(0xFFF1FAFF),
      backgroundBottom: const Color(0xFFFAFDFF),
    );
  }

  /// Tema SMP Kelas 8: biru sedang, lebih mapan dan teratur.
  static ThemeData smp8Theme() {
    return _smpTheme(
      seed: smp8Seed,
      appBarColor: smp8AppBar,
      buttonColor: smp8Seed,
      backgroundTop: const Color(0xFFEBF2FC),
      backgroundBottom: const Color(0xFFF8FAFD),
    );
  }

  /// Tema SMP Kelas 9: navy/indigo tua, paling formal.
  static ThemeData smp9Theme() {
    return _smpTheme(
      seed: smp9Seed,
      appBarColor: smp9AppBar,
      buttonColor: smp9Seed,
      backgroundTop: const Color(0xFFECEEF7),
      backgroundBottom: const Color(0xFFF7F8FC),
    );
  }

  static ThemeData _smpTheme({
    required Color seed,
    required Color appBarColor,
    required Color buttonColor,
    required Color backgroundTop,
    required Color backgroundBottom,
  }) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: seed),
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundTop,
      appBarTheme: AppBarTheme(
        backgroundColor: appBarColor,
        foregroundColor: Colors.white,
        elevation: 2,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  /// Memilih tema sesuai jenjang yang sedang aktif.
  static ThemeData forLevel(StudentLevel? level) {
    if (level == null) {
      return sdTheme();
    }
    switch (level) {
      case StudentLevel.sd:
        return sdTheme();
      case StudentLevel.smp7:
        return smp7Theme();
      case StudentLevel.smp8:
        return smp8Theme();
      case StudentLevel.smp9:
        return smp9Theme();
    }
  }

  /// Empat warna lingkaran menu utama (urut: Materi/Cari Sila, Kuis,
  /// Tanya AI, Lagu). SD memakai warna-warni cerah, sedangkan SMP makin
  /// beraturan menuju navy pada kelas 9.
  static List<Color> menuPalette(StudentLevel level) {
    switch (level) {
      case StudentLevel.sd:
        return const <Color>[
          Color(0xFF42A5F5), // biru
          Color(0xFFFFCA28), // kuning
          Color(0xFFBA68C8), // ungu
          Color(0xFFFFA726), // oranye
        ];
      case StudentLevel.smp7:
        return const <Color>[
          Color(0xFF4FC3F7), // biru langit
          Color(0xFF66BB6A), // hijau cerah
          Color(0xFF9575CD), // ungu lembut
          Color(0xFFFFB74D), // kuning keemasan
        ];
      case StudentLevel.smp8:
        return const <Color>[
          Color(0xFF1E88E5), // biru sedang
          Color(0xFF26C6DA), // cyan
          Color(0xFF5C6BC0), // indigo muda
          Color(0xFF00ACC1), // teal
        ];
      case StudentLevel.smp9:
        return const <Color>[
          Color(0xFF283593), // navy
          Color(0xFF1A237E), // navy tua
          Color(0xFF37474F), // biru-abu gelap
          Color(0xFF3949AB), // indigo
        ];
    }
  }

  /// Latar halaman utama: SD memakai gambar ceria, SMP memakai gradasi
  /// lembut yang makin pekat seiring kelasnya naik.
  static BoxDecoration bodyDecoration(StudentLevel level) {
    if (!level.isSmp) {
      return const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/app_background.png'),
          fit: BoxFit.cover,
        ),
      );
    }
    switch (level) {
      case StudentLevel.smp7:
        return const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xFFF1FAFF), Color(0xFFFAFDFF)],
          ),
        );
      case StudentLevel.smp8:
        return const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xFFEBF2FC), Color(0xFFF8FAFD)],
          ),
        );
      case StudentLevel.smp9:
        return const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xFFECEEF7), Color(0xFFF7F8FC)],
          ),
        );
      case StudentLevel.sd:
        return const BoxDecoration();
    }
  }
}
