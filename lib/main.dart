import 'package:flutter/material.dart';

import 'pages/level_selection_page.dart';
import 'pages/search_pancasila_page.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sahabat Pancasila',
      theme: AppTheme.forLevel(null),
      debugShowCheckedModeBanner: false,
      routes: {
        '/searchPancasila': (context) => const SearchPancasilaPage(),
      },
      home: const LevelSelectionPage(),
    );
  }
}
