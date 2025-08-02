import 'package:flutter/material.dart';
import 'package:sapa/pages/home_page.dart'; // Ganti 'sapa' dengan nama project Anda
import 'package:sapa/pages/search_pancasila_page.dart'; // Ganti 'sapa'

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sahabat Pancasila',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber), // Contoh tema
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
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
              )
          )
      ),
      debugShowCheckedModeBanner: false, // Hilangkan banner debug
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/searchPancasila': (context) => const SearchPancasilaPage(),
        // Anda bisa menambahkan named routes lain di sini jika diperlukan
      },
    );
  }
}
