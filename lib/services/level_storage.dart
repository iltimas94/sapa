import 'package:shared_preferences/shared_preferences.dart';

import '../models/student_level.dart';

/// Menyimpan jenjang/kelas pilihan pengguna di cache lokal perangkat
/// (SharedPreferences) agar tidak perlu memilih ulang setiap membuka aplikasi.
class LevelStorage {
  LevelStorage._();

  /// Kunci penyimpanan jenjang pada cache lokal.
  static const String storageKey = 'sapa_selected_level';

  /// Menyimpan jenjang yang dipilih pengguna.
  static Future<void> saveLevel(StudentLevel level) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, level.id);
  }

  /// Mengambil jenjang yang tersimpan.
  ///
  /// Mengembalikan `null` bila pengguna belum pernah memilih jenjang atau
  /// data yang tersimpan tidak dikenal.
  static Future<StudentLevel?> loadLevel() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return StudentLevel.fromId(prefs.getString(storageKey));
    } catch (error) {
      // Bila cache lokal tidak dapat dibaca, aplikasi tetap berjalan dengan
      // menampilkan halaman pilih jenjang.
      return null;
    }
  }

  /// Menghapus cache jenjang. Dipakai tombol logout agar pengguna kembali
  /// memilih jenjang/kelas.
  static Future<void> clearLevel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(storageKey);
  }
}
