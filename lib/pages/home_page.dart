import 'package:flutter/material.dart';
import './quiz_page.dart';
import './offline_video_player_page.dart';
import './search_pancasila_page.dart';
import './tanya_pancasila_ai_page.dart';

// Model MenuButtonInfo tetap sama
class MenuButtonInfo {
  final String title;
  final String description;
  final String? imageAssetPath;
  final IconData? iconData;
  final Color? backgroundColor;
  final VoidCallback onTap;

  MenuButtonInfo({
    required this.title,
    required this.description,
    this.imageAssetPath,
    this.iconData,
    this.backgroundColor,
    required this.onTap,
  }) : assert(imageAssetPath != null || iconData != null, 'Either imageAssetPath or iconData must be provided.');
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildMenuButton(
      BuildContext context, {
        required String title,
        required String description,
        String? imageAssetPath,
        IconData? iconData,
        Color? backgroundColor,
        required VoidCallback onTap,
      }) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    Color determineIconContentColor() {
      if (backgroundColor != null) {
        return backgroundColor.computeLuminance() > 0.5 ? Colors.black.withOpacity(0.75) : Colors.white;
      }
      return isDark ? Colors.white70 : Colors.black54;
    }

    final Color iconContentColor = determineIconContentColor();
    final Color textColor = isDark ? Colors.white.withOpacity(0.9) : Colors.black.withOpacity(0.8);
    final Color effectiveBackgroundColor = backgroundColor ?? theme.colorScheme.primaryContainer;

    const double circleButtonDiameter = 60;
    const double iconSize = 28;
    const double titleFontSize = 12;
    // const double descriptionFontSize = 10; // Deskripsi tidak ditampilkan di versi ini untuk simplisitas
    const double spaceBelowCircle = 8.0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      splashColor: effectiveBackgroundColor.withOpacity(0.3),
      highlightColor: effectiveBackgroundColor.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Mulai dari atas
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // Penting untuk Wrap agar tinggi item konsisten
          children: [
            Container(
              width: circleButtonDiameter,
              height: circleButtonDiameter,
              decoration: BoxDecoration(
                color: effectiveBackgroundColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: const Offset(0, 1.5),
                  ),
                ],
              ),
              child: imageAssetPath != null
                  ? ClipOval(
                child: Image.asset(
                  imageAssetPath,
                  width: circleButtonDiameter,
                  height: circleButtonDiameter,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.broken_image_outlined, size: iconSize, color: iconContentColor.withOpacity(0.7)),
                ),
              )
                  : Icon(
                iconData,
                size: iconSize,
                color: iconContentColor,
              ),
            ),
            const SizedBox(height: spaceBelowCircle),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: titleFontSize,
                  color: textColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Tentukan lebar perkiraan untuk setiap item menu.
    // Ini akan membantu Wrap menentukan berapa banyak item yang muat per baris.
    // (LebarLayar - (paddingHorizontalTotalUntukWrap)) / jumlahItemPerBarisIdeal - spacingAntarItem
    // Misalnya, jika ingin ~4 item per baris di layar 360px:
    // (360 - 32) / 4 - 8 = (328 / 4) - 8 = 82 - 8 = 74.
    // Ini hanya perkiraan kasar, Anda bisa set nilai tetap.
    const double menuItemWidth = 80.0; // Sesuaikan nilai ini!

    final List<MenuButtonInfo> allMenuButtons = [
      MenuButtonInfo(
        title: 'Cari Sila',
        description: 'Info sila & butir.',
        imageAssetPath: 'assets/images/menu_search_pancasila.png',
        backgroundColor: const Color(0xFF42A5F5),
        onTap: () => Navigator.pushNamed(context, '/searchPancasila'),
      ),
      MenuButtonInfo(
        title: 'Kuis',
        description: 'Asah ilmumu.',
        imageAssetPath: 'assets/images/menu_quiz.png',
        backgroundColor: const Color(0xFFFFCA28),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizPage())),
      ),
      MenuButtonInfo(
        title: 'Tanya AI',
        description: 'Seputar Pancasila.',
        imageAssetPath: 'assets/images/menu_ai_gemini.png',
        backgroundColor: const Color(0xFFBA68C8),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TanyaPancasilaAiPage()),
          );
        },
      ),
      MenuButtonInfo(
        title: 'Lagu',
        description: 'Garuda Pancasila.',
        imageAssetPath: 'assets/images/menu_music.png',
        backgroundColor: const Color(0xFFFFA726),
        onTap: () {
          const String assetVideoPath = 'assets/videos/garuda_pancasila.mp4';
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SamplePlayer(
                videoPath: assetVideoPath,
                isAsset: true,
              ),
            ),
          );
        },
      ),
      MenuButtonInfo(
        title: 'Tentang',
        description: 'Info SAPA Ceria.',
        imageAssetPath: 'assets/images/menu_about.png',
        backgroundColor: const Color(0xFF66BB6A),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                title: Row(
                  children: [
                    Icon(Icons.adb_rounded, color: theme.primaryColor),
                    const SizedBox(width: 10),
                    const Text('Tentang SAPA Ceria'),
                  ],
                ),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('SAPA Ceria (Sahabat Pancasila Ceria)'),
                      SizedBox(height: 8),
                      Text('Versi 1.0.0'),
                      SizedBox(height: 8),
                      Text('Dibuat untuk membantu anak-anak belajar Pancasila dengan cara yang menyenangkan.'),
                      SizedBox(height: 16),
                      Text('Terima kasih sudah menggunakan aplikasi ini! ❤️'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Tutup', style: TextStyle(color: theme.primaryColor)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
          );
        },
      ),
      // Contoh jika ada item ke-6 atau ke-7 untuk melihat efek WrapAlignment.center
      // MenuButtonInfo(
      //   title: 'Ekstra 1',
      //   description: 'Menu tambahan.',
      //   iconData: Icons.star_border,
      //   backgroundColor: Colors.teal,
      //   onTap: () {},
      // ),
      // MenuButtonInfo(
      //   title: 'Ekstra 2',
      //   description: 'Menu tambahan lagi.',
      //   iconData: Icons.star_half,
      //   backgroundColor: Colors.indigo,
      //   onTap: () {},
      // ),
    ];

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🎉 SAPA Ceria!!! 🥳'),
            const SizedBox(width: 8),
            Image.asset(
              'assets/images/maskot_ceria.png',
              height: 35,
              errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/garuda_pancasila.png',
                    height: 80,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.flag_circle_rounded, size: 80, color: Colors.grey[350]),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Pendidikan Pancasila',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Yuk, belajar Pancasila dengan seru bersama SAPA!',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Pilih Fitur',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Menggunakan Wrap untuk menata menu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0), // Padding di sekitar Wrap jika diperlukan
              child: Wrap(
                spacing: 8.0, // Spasi horizontal antar item
                runSpacing: 12.0, // Spasi vertikal antar baris
                alignment: WrapAlignment.center, // Kunci untuk rata tengah baris terakhir
                children: allMenuButtons.map((item) {
                  // Setiap item dibungkus SizedBox untuk memberikan lebar yang konsisten
                  return SizedBox(
                    width: menuItemWidth, // Gunakan lebar yang telah ditentukan
                    child: _buildMenuButton(
                      context,
                      title: item.title,
                      description: item.description,
                      imageAssetPath: item.imageAssetPath,
                      iconData: item.iconData,
                      backgroundColor: item.backgroundColor,
                      onTap: item.onTap,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
