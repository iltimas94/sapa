import 'package:flutter/material.dart';
import './quiz_page.dart'; // Impor QuizPage
import './offline_video_player_page.dart'; // Impor OfflineVideoPlayerPage
import './search_pancasila_page.dart'; // Impor SearchPancasilaPage


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Widget helper untuk membuat setiap item menu agar lebih rapi

  Widget _buildMenuItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
        Color iconBackgroundColor = Colors.transparent,
        Color? iconColor,
      }) {
    // ... (implementasi _buildMenuItem yang sudah ada sebelumnya tetap sama) ...
    // Isi dari _buildMenuItem tidak perlu diubah, yang diubah adalah pemanggilannya
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Card(
      elevation: 2.5,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: onTap, // onTap sekarang akan diisi oleh pemanggil
        splashColor: theme.colorScheme.secondary.withOpacity(0.3),
        highlightColor: theme.colorScheme.primary.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: iconBackgroundColor == Colors.transparent
                    ? primaryColor.withOpacity(0.12)
                    : iconBackgroundColor,
                child: Icon(
                  icon,
                  size: 28,
                  color: iconColor ?? primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: theme.textTheme.bodyLarge?.color?.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                        fontSize: 13.5,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey[400],
                size: 18,
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

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Bisa tambahkan ikon aplikasi di sini jika mau
            // const Icon(Icons.school_rounded, color: Colors.white, size: 28),
            // const SizedBox(width: 8),
            const Text('🎉 SAPA Ceria! 🥳'), // Judul AppBar
            const SizedBox(width: 8),
            Image.asset(
              'assets/images/maskot_ceria.png', // Pastikan path asset benar
              height: 35,
              errorBuilder: (context, error, stackTrace) =>
              const SizedBox.shrink(),
            ),
          ],
        ),
        // actions: [ // Contoh jika ingin menambahkan tombol aksi di AppBar
        //   IconButton(
        //     icon: const Icon(Icons.settings_rounded),
        //     onPressed: () {
        //       // Navigasi ke halaman pengaturan atau tampilkan dialog
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(content: Text('Tombol Pengaturan ditekan!')),
        //       );
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Bagian Header dengan Gambar dan Teks Sambutan
            Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 25.0, horizontal: 10.0),
              decoration: BoxDecoration(
                // Anda bisa menambahkan gradient atau warna latar belakang di sini
                // borderRadius: BorderRadius.circular(15),
                // color: theme.colorScheme.primary.withOpacity(0.05),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/images/garuda_pancasila.png',
                        // Pastikan path asset benar
                        height: 100, // Ukuran gambar Garuda disesuaikan
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.flag_circle_rounded, size: 100,
                                color: Colors.grey[350]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Pendidikan Pancasila',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Yuk, belajar Pancasila dengan seru bersama SAPA!',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(
                          0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Jarak antara header dan menu

            // Daftar Menu
            _buildMenuItem(
              context,
              icon: Icons.search_rounded,
              title: 'Cari Tahu Pancasila',
              subtitle: 'Temukan semua tentang sila-sila!',
              iconBackgroundColor: const Color(0xFFE3F2FD),
              // Biru muda
              onTap: () {
                Navigator.pushNamed(context, '/searchPancasila');
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.extension_rounded,
              // Atau Icons.quiz_rounded
              title: 'Kuis Seru Pancasila',
              subtitle: 'Asah pengetahuanmu dengan kuis ini!',
              iconBackgroundColor: const Color(0xFFFFF9C4),
              // Kuning muda
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizPage()),
                );
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.music_video_rounded,
              title: 'Nyanyi Garuda Pancasila',
              subtitle: 'Putar video lagu nasional (dari aset)!', // Subtitle diperbarui
              iconBackgroundColor: const Color(0xFFFFE0B2), // Oranye muda
              onTap: () {
                const String assetVideoPath = 'assets/videos/garuda_pancasila.mp4';
                // Pastikan file video ini sudah ada di folder assets/videos/
                // dan sudah terdaftar di pubspec.yaml

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SamplePlayer(
                      videoPath: assetVideoPath,
                      isAsset: true, // Beritahu SamplePlayer bahwa ini adalah video dari aset
                    ),
                  ),
                );
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.info_outline_rounded,
              title: 'Tentang Aplikasi SAPA',
              subtitle: 'Informasi mengenai aplikasi ini',
              iconBackgroundColor: const Color(0xFFC8E6C9),
              // Hijau muda
              onTap: () {
                // Tampilkan dialog informasi atau navigasi ke halaman "Tentang"
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
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
                            Text(
                                'Dibuat untuk membantu anak-anak belajar Pancasila dengan cara yang menyenangkan.'),
                            SizedBox(height: 16),
                            Text(
                                'Terima kasih sudah menggunakan aplikasi ini! ❤️'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Tutup',
                              style: TextStyle(color: theme.primaryColor)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            // Jarak di akhir halaman
            // Footer sederhana (opsional)
            // Center(
            //   child: Text(
            //     '© 2024 Tim SAPA Ceria',
            //     style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            //   ),
            // ),
            // const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
