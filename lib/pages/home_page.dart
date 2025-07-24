import 'package:flutter/material.dart';
import './quiz_page.dart'; // Impor QuizPage
import './offline_video_player_page.dart'; // Impor OfflineVideoPlayerPage (pastikan nama kelasnya SamplePlayer atau sesuaikan)
import './search_pancasila_page.dart'; // Impor SearchPancasilaPage
import './tanya_pancasila_ai_page.dart'; // <--- Tambahkan impor ini

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

    // Tentukan warna latar belakang default untuk container ikon jika tidak ada gambar
    // dan tidak ada backgroundColor spesifik yang diberikan untuk tombol.
    final Color iconContainerBgColor = backgroundColor ?? theme.colorScheme.primaryContainer.withOpacity(0.3);

    // Logika untuk menentukan warna konten (teks dan ikon) berdasarkan kontras
    Color determineContentColor() {
      // Jika ada backgroundColor spesifik untuk tombol, gunakan itu untuk menentukan kontras
      if (backgroundColor != null) {
        // Jika luminansi backgroundColor rendah (gelap), gunakan teks putih pekat
        // Jika luminansi tinggi (terang), gunakan teks hitam pekat
        return backgroundColor.computeLuminance() > 0.5 // Anda bisa sesuaikan threshold 0.5 ini
            ? Colors.black87 // Hitam yang tidak terlalu pekat, lebih lembut
            : Colors.white;  // Putih pekat
      }
      // Jika tidak ada backgroundColor spesifik, gunakan warna default berdasarkan tema
      return isDark ? Colors.white : Colors.black87;
    }

    final Color contentColor = determineContentColor();

    // Penyesuaian untuk 4 tombol per baris
    const double containerSize = 50;
    const double iconSize = 28;
    const double titleFontSize = 12;
    const double descriptionFontSize = 10;
    const double verticalPadding = 10.0;
    const double horizontalPadding = 8.0;
    const double spaceBelowIcon = 8.0;
    const double spaceBelowTitle = 4.0;


    return Card(
      elevation: 2.5,
      margin: const EdgeInsets.all(4.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      clipBehavior: Clip.antiAlias,
      color: backgroundColor, // Set warna latar belakang Card jika ada
      child: InkWell(
        onTap: onTap,
        // Splash dan highlight color bisa mengambil dari contentColor atau primaryColor
        splashColor: contentColor.withOpacity(0.12),
        highlightColor: contentColor.withOpacity(0.08),
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
                  // Jika ada image, biarkan transparan atau gunakan backgroundColor tombol
                  // Jika tidak ada image, gunakan iconContainerBgColor
                  color: imageAssetPath != null ? (backgroundColor != null ? Colors.transparent : theme.colorScheme.surfaceVariant.withOpacity(0.1)) : iconContainerBgColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: imageAssetPath != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    imageAssetPath,
                    fit: BoxFit.cover, // BoxFit.cover bisa membuat gambar terpotong jika aspek rasio beda
                    // Pertimbangkan BoxFit.contain jika ingin gambar terlihat utuh
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.broken_image_outlined, size: iconSize - 5, color: contentColor.withOpacity(0.7)),
                  ),
                )
                    : Icon(
                  iconData,
                  size: iconSize,
                  // Pastikan warna ikon selalu kontras
                  color: contentColor,
                ),
              ),
              const SizedBox(height: spaceBelowIcon),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize,
                  color: contentColor, // Gunakan contentColor yang sudah ditentukan
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: spaceBelowTitle),
              Text(
                description,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: descriptionFontSize,
                  color: contentColor.withOpacity(0.85), // Sedikit kurangi opacity untuk deskripsi agar tidak terlalu dominan
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

// ... sisa kode HomePage Anda tetap sama ...


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Tambahkan item menu baru di sini
    // Jika ada 4 item sebelumnya, dan Anda ingin tetap 4 per baris,
    // Anda bisa memindahkan 'Tentang Aplikasi' atau item lain ke baris baru,
    // atau jika Anda ingin 5 item di satu baris, GridView akan mengaturnya
    // tetapi mungkin terlihat sedikit berbeda.
    // Untuk contoh ini, saya akan menambahkan sebagai item kelima,
    // yang berarti akan ada satu baris dengan 4 item dan baris berikutnya dengan 1 item (atau lebih jika Anda menambahkan lebih banyak).
    // Atau, kita bisa membuat jumlah item menjadi kelipatan 4 jika ingin barisnya penuh.

    final List<MenuButtonInfo> menuButtons = [
      MenuButtonInfo(
        title: 'Cari Pancasila',
        description: 'Info sila & butir.',
        imageAssetPath: 'assets/images/menu_search_pancasila.png',
        backgroundColor: const Color(0xFF42A5F5),
        onTap: () => Navigator.pushNamed(context, '/searchPancasila'),
      ),
      MenuButtonInfo(
        title: 'Kuis Seru',
        description: 'Asah ilmumu.',
        imageAssetPath: 'assets/images/menu_quiz.png',
        backgroundColor: const Color(0xFFFFCA28),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizPage())),
      ),
      MenuButtonInfo(
        title: 'Tanya AI', // <--- MENU BARU
        description: 'Tanya AI Gemini.',
        imageAssetPath: 'assets/images/menu_ai_gemini.png', // <-- Ganti dengan gambar ikon AI Anda
        // iconData: Icons.smart_toy_outlined, // Alternatif jika tidak ada gambar
        backgroundColor: const Color(0xFFBA68C8), // Warna ungu muda (contoh)
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TanyaPancasilaAiPage()),
          );
        },
      ),
      MenuButtonInfo(
        title: 'Lagu Nasional',
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
      // Pindahkan 'Tentang App' ke sini agar menu AI bisa di tengah jika jumlah item ganjil
      // atau sesuaikan urutannya sesuai keinginan Anda.
      // Jika jumlah item sekarang 5 dan crossAxisCount: 4, maka baris kedua akan punya 1 item.
      // Jika ingin baris tetap penuh, buat jumlah item kelipatan 4.
      // Untuk contoh ini, saya akan biarkan 5 item, dan "Tentang App" menjadi item kelima.

      // MenuButtonInfo( // Item ke-5
      //   title: 'Tentang App',
      //   description: 'Info SAPA Ceria.',
      //   imageAssetPath: 'assets/images/menu_about.png',
      //   backgroundColor: const Color(0xFF66BB6A),
      //   onTap: () {
      //     // ... (kode dialog tentang app) ...
      //   },
      // ),
    ];

    // Jika Anda ingin memastikan 4 item per baris dan baris terakhir juga penuh
    // Anda perlu memiliki jumlah item kelipatan 4.
    // Atau, jika Anda hanya memiliki 5 item, Anda bisa menyesuaikan `crossAxisCount` atau menerima
    // bahwa baris terakhir tidak akan penuh.

    // Untuk contoh ini, saya akan tambahkan menu "Tentang App" setelah menu AI
    // sehingga total ada 5 menu. GridView akan menangani ini.
    // Jika Anda ingin urutan yang berbeda, ubah saja posisinya di list.

    // final List<MenuButtonInfo> finalMenuButtons = [
    //   ...menuButtons, // Ambil 4 menu pertama
    // MenuButtonInfo( // Tambahkan menu AI di sini jika ingin jadi item ke-3 atau ke-4
    //   title: 'Tanya AI',
    //   description: 'Tanya AI Gemini.',
    //   imageAssetPath: 'assets/images/menu_ai_gemini.png',
    //   backgroundColor: const Color(0xFFBA68C8),
    //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TanyaPancasilaAiPage())),
    // ),
    // ];
    // Saya akan menyisipkan menu AI setelah Kuis.

    List<MenuButtonInfo> allMenuButtons = [
      MenuButtonInfo(
        title: 'Cari Pancasila',
        description: 'Info sila & butir.',
        imageAssetPath: 'assets/images/menu_search_pancasila.png',
        backgroundColor: const Color(0xFF42A5F5),
        onTap: () => Navigator.pushNamed(context, '/searchPancasila'),
      ),
      MenuButtonInfo(
        title: 'Kuis Seru',
        description: 'Asah ilmumu.',
        imageAssetPath: 'assets/images/menu_quiz.png',
        backgroundColor: const Color(0xFFFFCA28),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizPage())),
      ),
      MenuButtonInfo( // <-- ITEM BARU DITAMBAHKAN DI SINI
        title: 'Tanya AI',
        description: 'Seputar Pancasila.', // Deskripsi diperpendek
        imageAssetPath: 'assets/images/menu_ai_gemini.png', // <-- GANTI DENGAN GAMBAR ANDA
        // iconData: Icons.smart_toy_outlined, // Alternatif
        backgroundColor: const Color(0xFFBA68C8), // Ungu muda
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TanyaPancasilaAiPage()),
          );
        },
      ),
      MenuButtonInfo(
        title: 'Lagu Nasional',
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
      // Item kelima: Tentang Aplikasi. Ini akan membuat 1 item di baris kedua jika crossAxisCount = 4
      MenuButtonInfo(
        title: 'Tentang App',
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
            // Bagian Header (tetap sama)
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

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Tetap 4 tombol per baris
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.9, // Anda mungkin masih perlu menyesuaikan ini
                // Terutama jika deskripsi menu baru lebih panjang/pendek
              ),
              itemCount: allMenuButtons.length, // Gunakan list yang sudah diperbarui
              itemBuilder: (context, index) {
                final item = allMenuButtons[index];
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
            const SizedBox(height: 16),
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
