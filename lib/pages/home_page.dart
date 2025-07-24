import 'package:flutter/material.dart';
import './quiz_page.dart'; // Impor QuizPage
import './offline_video_player_page.dart'; // Impor OfflineVideoPlayerPage (pastikan nama kelasnya SamplePlayer atau sesuaikan)
import './search_pancasila_page.dart'; // Impor SearchPancasilaPage

// Model untuk data menu agar lebih terstruktur
class MenuButtonInfo {
  final String title;
  final String description; // Deskripsi singkat
  final String? imageAssetPath; // Path ke gambar aset (opsional)
  final IconData? iconData; // IconData jika tidak ada gambar (opsional)
  final Color? backgroundColor; // Warna latar belakang untuk ikon/gambar container
  final VoidCallback onTap;

  MenuButtonInfo({
    required this.title,
    required this.description,
    this.imageAssetPath,
    this.iconData,
    this.backgroundColor,
    required this.onTap,
  }) : assert(imageAssetPath != null || iconData != null, 'Either imageAssetPath or iconData must be provided for a menu button.');
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Widget helper untuk membuat setiap tombol menu bergambar
  Widget _buildMenuButton(
      BuildContext context, {
        required String title,
        required String description,
        String? imageAssetPath,
        IconData? iconData,
        Color? backgroundColor, // Warna dominan untuk tombol atau latar gambar/ikon
        required VoidCallback onTap,
      }) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final Color defaultBgColor = backgroundColor ?? theme.colorScheme.surfaceVariant;
    final Color contentColor = isDark || (backgroundColor?.computeLuminance() ?? 0.5) < 0.4
        ? Colors.white.withOpacity(0.9) // Konten putih jika latar gelap
        : Colors.black.withOpacity(0.8); // Konten hitam jika latar terang

    // Penyesuaian untuk 4 tombol per baris
    const double containerSize = 50; // Ukuran container ikon/gambar lebih kecil
    const double iconSize = 28; // Ukuran ikon lebih kecil
    const double titleFontSize = 12; // Ukuran font judul lebih kecil
    const double descriptionFontSize = 10; // Ukuran font deskripsi lebih kecil
    const double verticalPadding = 10.0; // Padding vertikal dalam kartu dikurangi
    const double horizontalPadding = 8.0; // Padding horizontal dalam kartu dikurangi
    const double spaceBelowIcon = 8.0; // Jarak bawah ikon dikurangi
    const double spaceBelowTitle = 4.0; // Jarak bawah judul dikurangi


    return Card(
      elevation: 2.5, // Sedikit kurangi elevasi agar tidak terlalu ramai
      margin: const EdgeInsets.all(4.0), // Margin antar kartu lebih kecil
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), // Radius border lebih kecil
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: (backgroundColor ?? theme.primaryColor).withOpacity(0.3),
        highlightColor: (backgroundColor ?? theme.primaryColor).withOpacity(0.15),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: containerSize,
                height: containerSize,
                decoration: BoxDecoration(
                  color: imageAssetPath == null ? defaultBgColor.withOpacity(0.15) : defaultBgColor,
                  borderRadius: BorderRadius.circular(10.0), // Radius border container ikon
                ),
                child: imageAssetPath != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    imageAssetPath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.broken_image_outlined, size: iconSize - 5, color: contentColor.withOpacity(0.7)),
                  ),
                )
                    : Icon(
                  iconData,
                  size: iconSize,
                  color: backgroundColor != null ? contentColor : theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: spaceBelowIcon),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleSmall?.copyWith( // Menggunakan titleSmall agar lebih pas
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize,
                  color: contentColor,
                ),
                maxLines: 1, // Judul mungkin lebih baik 1 baris
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: spaceBelowTitle),
              Text(
                description,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: descriptionFontSize,
                  color: contentColor.withOpacity(0.75),
                ),
                maxLines: 2, // Deskripsi tetap 2 baris jika memungkinkan
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<MenuButtonInfo> menuButtons = [
      MenuButtonInfo(
        title: 'Cari Pancasila',
        description: 'Info sila & butir.', // Deskripsi lebih singkat
        imageAssetPath: 'assets/images/menu_search_pancasila.png',
        backgroundColor: const Color(0xFF42A5F5),
        onTap: () => Navigator.pushNamed(context, '/searchPancasila'),
      ),
      MenuButtonInfo(
        title: 'Kuis Seru',
        description: 'Asah ilmumu.', // Deskripsi lebih singkat
        imageAssetPath: 'assets/images/menu_quiz.png',
        backgroundColor: const Color(0xFFFFCA28),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizPage())),
      ),
      MenuButtonInfo(
        title: 'Lagu Nasional',
        description: 'Garuda Pancasila.', // Deskripsi lebih singkat
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
        title: 'Tentang App', // Judul lebih singkat
        description: 'Info SAPA Ceria.', // Deskripsi lebih singkat
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
      // Anda mungkin perlu menambahkan item dummy untuk melihat baris penuh jika jumlahnya bukan kelipatan 4
      // MenuButtonInfo(title: 'Menu 5', description: 'Deskripsi 5', iconData: Icons.star, onTap: () {}),
      // MenuButtonInfo(title: 'Menu 6', description: 'Deskripsi 6', iconData: Icons.settings, onTap: () {}),
      // MenuButtonInfo(title: 'Menu 7', description: 'Deskripsi 7', iconData: Icons.help, onTap: () {}),
      // MenuButtonInfo(title: 'Menu 8', description: 'Deskripsi 8', iconData: Icons.book, onTap: () {}),
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
        padding: const EdgeInsets.all(12.0), // Sedikit kurangi padding utama jika perlu
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Bagian Header (tetap sama)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0), // Kurangi padding vertikal
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/garuda_pancasila.png',
                    height: 80, // Kurangi tinggi gambar header jika perlu
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.flag_circle_rounded, size: 80, color: Colors.grey[350]),
                  ),
                  const SizedBox(height: 16), // Kurangi jarak
                  Text(
                    'Pendidikan Pancasila',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                      fontSize: 20, // Kurangi ukuran font header jika perlu
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6), // Kurangi jarak
                  Text(
                    'Yuk, belajar Pancasila dengan seru bersama SAPA!',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                      fontSize: 14, // Kurangi ukuran font subheader jika perlu
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16), // Kurangi jarak

            Padding(
              padding: const EdgeInsets.only(bottom: 10.0), // Kurangi padding bawah judul menu
              child: Text(
                'Pilih Fitur',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18, // Kurangi ukuran font judul menu jika perlu
                ),
                textAlign: TextAlign.center,
              ),
            ),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Tampilkan 4 tombol per baris
                crossAxisSpacing: 8.0, // Jarak horizontal antar tombol lebih kecil
                mainAxisSpacing: 8.0,   // Jarak vertikal antar tombol lebih kecil
                childAspectRatio: 0.9,  // !!! PENTING: Sesuaikan nilai ini!
                // Dengan 4 item, rasio mungkin perlu > 1.0 (misal 1.0, 1.1)
                // agar tidak terlalu gepeng, ATAU
                // konten di dalam _buildMenuButton harus sangat kecil.
                // Jika konten tetap besar, childAspectRatio mungkin < 1.0 (misal 0.7, 0.8)
                // tapi akan membuat item jadi tinggi dan sempit.
                // Coba antara 0.8 s/d 1.2 dan lihat hasilnya.
              ),
              itemCount: menuButtons.length,
              itemBuilder: (context, index) {
                final item = menuButtons[index];
                return _buildMenuButton(
                  context,
                  title: item.title,
                  description: item.description,
                  imageAssetPath: item.imageAssetPath,
                  iconData: item.iconData,
                  backgroundColor: item.backgroundColor,
                  onTap: item.onTap,
                );
              },
            ),
            const SizedBox(height: 16), // Kurangi jarak
          ],
        ),
      ),
    );
  }
}

// Dummy class untuk SamplePlayer jika belum ada implementasi sebenarnya
// Pastikan Anda memiliki kelas SamplePlayer atau ganti dengan nama kelas pemutar video Anda
class SamplePlayer extends StatelessWidget {
  final String videoPath;
  final bool isAsset;

  const SamplePlayer({super.key, required this.videoPath, this.isAsset = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isAsset ? 'Video Lagu Nasional' : 'Video Player')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.play_circle_fill_rounded, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            Text(isAsset ? 'Memutar video dari aset:' : 'Memutar video dari path:'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(videoPath, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
