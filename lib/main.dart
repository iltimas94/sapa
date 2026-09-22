import 'package:flutter/material.dart';

import 'models/student_level.dart';
import 'pages/home_page.dart';
import 'pages/level_selection_page.dart';
import 'pages/search_pancasila_page.dart';
import 'services/level_storage.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Baca jenjang/kelas yang tersimpan di cache lokal.
  // Hasilnya null bila pengguna belum pernah memilih jenjang.
  final StudentLevel? savedLevel = await LevelStorage.loadLevel();
  runApp(MyApp(initialLevel: savedLevel));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.initialLevel});

  /// Jenjang yang tersimpan di cache lokal saat aplikasi dibuka.
  final StudentLevel? initialLevel;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StudentLevel? _level;

  /// True bila halaman pilih jenjang tampil karena tombol logout ditekan.
  bool _isSwitchingLevel = false;

  @override
  void initState() {
    super.initState();
    _level = widget.initialLevel;
  }

  /// Menyimpan jenjang pilihan pengguna ke cache lokal lalu membuka
  /// halaman utama sesuai jenjang tersebut.
  void _handleLevelSelected(StudentLevel level) {
    setState(() {
      _level = level;
      _isSwitchingLevel = false;
    });
    // Penyimpanan ke cache lokal dijalankan tanpa menunggu (fire and forget).
    LevelStorage.saveLevel(level);
  }

  /// Menghapus cache jenjang (logout) agar pengguna kembali memilih
  /// jenjang/kelas.
  Future<void> _handleLogout() async {
    await LevelStorage.clearLevel();
    if (!mounted) return;
    setState(() {
      _level = null;
      _isSwitchingLevel = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final StudentLevel? level = _level;

    return MaterialApp(
      title: 'Sahabat Pancasila',
      // Jenjang SD memakai tema kuning, jenjang SMP (kelas 7-9) memakai
      // tema biru-indigo yang lebih formal.
      theme: AppTheme.forLevel(level),
      debugShowCheckedModeBanner: false, // Hilangkan banner debug
      routes: {
        '/searchPancasila': (context) => const SearchPancasilaPage(),
        // Anda bisa menambahkan named routes lain di sini jika diperlukan
      },
      home: level == null
          ? LevelSelectionPage(
              onLevelSelected: _handleLevelSelected,
              isSwitching: _isSwitchingLevel,
            )
          : HomePage(level: level, onLogout: _handleLogout),
    );
  }
}
