import 'package:flutter/material.dart';

import '../models/student_level.dart';

/// Kumpulan tema aplikasi Sahabat Pancasila.
///
/// * Jenjang **SD** memakai tema kuning/ceria seperti versi awal aplikasi.
/// * Jenjang **SMP** memakai tema biru-indigo yang lebih formal.
class AppTheme {
  AppTheme._();

  /// Warna dasar tema jenjang SD.
  static const Color sdSeed = Color(0xFFFFA000);

  /// Warna dasar tema jenjang SMP.
  static const Color smpSeed = Color(0xFF3949AB);

  /// Warna AppBar tema SMP.
  static const Color smpAppBar = Color(0xFF283593);

  /// Tema jenjang SD (tampilan tetap seperti sebelumnya).
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

  /// Tema jenjang SMP (kelas 7, 8, dan 9).
  static ThemeData smpTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: smpSeed),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF4F6FB),
      appBarTheme: const AppBarTheme(
        backgroundColor: smpAppBar,
        foregroundColor: Colors.white,
        elevation: 2,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: smpSeed,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  /// Memilih tema sesuai jenjang yang sedang aktif.
  static ThemeData forLevel(StudentLevel? level) {
    if (level != null && level.isSmp) {
      return smpTheme();
    }
    return sdTheme();
  }
}
