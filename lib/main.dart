import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Import halaman-halaman yang sudah dipisah
import 'pages/home_page.dart';
import 'pages/search_pancasila_page.dart';
// Jika Anda membuat file tema terpisah, import di sini juga
// import 'theme/app_theme.dart';

void main() {
  // Pastikan Flutter binding telah diinisialisasi sebelum menjalankan aplikasi,
  // terutama jika ada plugin yang memerlukannya sebelum runApp().
  WidgetsFlutterBinding.ensureInitialized();

  // Mengatur orientasi perangkat yang diizinkan (opsional, sesuai kebutuhan)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisi warna dan tema bisa tetap di sini, atau dipindahkan ke file tema terpisah
    // (misalnya, lib/theme/app_theme.dart) untuk organisasi yang lebih baik jika tema kompleks.

    const primaryColor = Color(0xFFFF6347); // Contoh: Tomato Red
    const accentColor = Color(0xFFFFD700); // Contoh: Gold
    const backgroundColor = Color(0xFFFFF8DC); // Contoh: Cornsilk
    const String defaultFontFamily = 'ArialRounded'; // Pastikan font ini ada di pubspec.yaml dan folder assets

    return MaterialApp(
      title: 'Aplikasi Edukasi Pancasila',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          secondary: accentColor,
          background: backgroundColor,
          brightness: Brightness.light, // Atur kecerahan tema
          primary: primaryColor, // Eksplisit set primary color jika fromSeed tidak sesuai
          onPrimary: Colors.white, // Warna teks di atas primaryColor
          // Anda bisa menambahkan warna lain di sini jika perlu
        ),
        useMaterial3: true,
        fontFamily: defaultFontFamily, // Set font default untuk seluruh aplikasi

        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white, // Warna ikon dan teks di AppBar
          elevation: 4.0,
          titleTextStyle: TextStyle(
            fontFamily: defaultFontFamily,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          centerTitle: true,
        ),

        cardTheme: CardThemeData(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0), // Margin default untuk Card
          color: Colors.white,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
            foregroundColor: Colors.black87, // Warna teks pada ElevatedButton
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(
              fontFamily: defaultFontFamily,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),

        listTileTheme: ListTileThemeData(
          iconColor: primaryColor,
          titleTextStyle: const TextStyle(
            fontFamily: defaultFontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          subtitleTextStyle: TextStyle(
            fontFamily: defaultFontFamily,
            fontSize: 14,
            color: Colors.grey[700],
          ),
          shape: RoundedRectangleBorder( // Bentuk untuk ListTile jika diperlukan (misalnya di dalam Card)
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),

        // Definisikan textTheme secara global jika perlu kustomisasi lebih lanjut
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: defaultFontFamily,
          bodyColor: Colors.grey[850], // Warna teks default untuk body
          displayColor: Colors.black87, // Warna teks default untuk display (headline, title)
        ).copyWith(
          // Kustomisasi spesifik jika diperlukan
          titleLarge: TextStyle(fontFamily: defaultFontFamily, color: Colors.grey[900]),
          bodyMedium: TextStyle(fontFamily: defaultFontFamily, color: Colors.grey[800], height: 1.4),
        ),
        // Anda bisa menambahkan kustomisasi komponen lain di sini
        // seperti inputDecorationTheme, dialogTheme, dll.
      ),
      home: const HomePage(), // Halaman awal aplikasi Anda
      routes: {
        // Definisikan rute bernama Anda di sini
        // Pastikan nama rute konsisten dengan yang Anda gunakan di Navigator.pushNamed
        '/searchPancasila': (context) => const SearchPancasilaPage(),
        // Tambahkan rute lain jika ada, misalnya:
        // '/quizPage': (context) => const QuizPage(), // Jika ingin navigasi ke QuizPage via nama rute
        // '/offlineVideoPlayer': (context) => OfflineVideoPlayerPage(videoPath: 'path/default.mp4', isAsset: true), // Contoh, mungkin kurang praktis untuk video
      },
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
    );
  }
}
