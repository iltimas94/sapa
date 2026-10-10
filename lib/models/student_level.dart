import 'package:flutter/material.dart';

/// Jenjang/kelas yang dapat dipilih pengguna saat pertama kali membuka
/// aplikasi.
///
/// Pilihan ini disimpan di cache lokal perangkat (lihat `LevelStorage`)
/// sehingga aplikasi langsung membuka halaman utama sesuai jenjang
/// terakhir yang dipilih.
enum StudentLevel {
  sd(
    id: 'sd',
    jenjang: 'SD',
    kelasLabel: 'Kelas 1 - 6',
    shortLabel: 'SD 1-6',
    description: 'Belajar Pancasila dengan gambar, cerita, dan lagu.',
    isSmp: false,
    materiTersedia: true,
    icon: Icons.child_care_rounded,
    color: Color(0xFFFFA000),
  ),
  smp7(
    id: 'smp-7',
    jenjang: 'SMP',
    kelasLabel: 'Kelas 7',
    shortLabel: 'SMP 7',
    description: 'Sejarah Pancasila, penerapan nilai, norma, dan keragaman.',
    isSmp: true,
    materiTersedia: true,
    icon: Icons.menu_book_rounded,
    color: Color(0xFF42A5F5),
  ),
  smp8(
    id: 'smp-8',
    jenjang: 'SMP',
    kelasLabel: 'Kelas 8',
    shortLabel: 'SMP 8',
    description: 'Pancasila sebagai dasar negara, UUD 1945, peraturan, dan budaya.',
    isSmp: true,
    materiTersedia: true,
    icon: Icons.school_rounded,
    color: Color(0xFF1E88E5),
  ),
  smp9(
    id: 'smp-9',
    jenjang: 'SMP',
    kelasLabel: 'Kelas 9',
    shortLabel: 'SMP 9',
    description: 'Materi sedang disusun. Kuis, Lagu, dan Tanya AI tetap aktif.',
    isSmp: true,
    materiTersedia: false,
    icon: Icons.workspace_premium_rounded,
    color: Color(0xFF283593),
  );

  const StudentLevel({
    required this.id,
    required this.jenjang,
    required this.kelasLabel,
    required this.shortLabel,
    required this.description,
    required this.isSmp,
    required this.materiTersedia,
    required this.icon,
    required this.color,
  });

  /// Kunci yang dipakai saat menyimpan pilihan ke cache lokal.
  final String id;

  /// Nama jenjang, contoh: `SD` atau `SMP`.
  final String jenjang;

  /// Label kelas, contoh: `Kelas 1 - 6` atau `Kelas 7`.
  final String kelasLabel;

  /// Label pendek untuk badge, contoh: `SD 1-6` atau `SMP 7`.
  final String shortLabel;

  /// Keterangan singkat jenjang, dipakai di halaman pilih kelas.
  final String description;

  /// True untuk jenjang SMP (kelas 7, 8, dan 9).
  final bool isSmp;

  /// False bila materi jenjang ini belum siap sehingga UI menampilkan
  /// informasi "segera hadir".
  final bool materiTersedia;

  /// Ikon yang ditampilkan pada halaman pilih jenjang.
  final IconData icon;

  /// Warna aksen jenjang.
  final Color color;

  /// Judul lengkap jenjang, contoh: `SD Kelas 1 - 6`.
  String get fullLabel => '$jenjang $kelasLabel';

  /// Mengubah id yang tersimpan di cache menjadi [StudentLevel].
  /// Mengembalikan `null` bila id belum dikenal/kosong.
  static StudentLevel? fromId(String? id) {
    if (id == null) return null;
    for (final StudentLevel level in StudentLevel.values) {
      if (level.id == id) return level;
    }
    return null;
  }
}
