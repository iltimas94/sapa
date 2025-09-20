import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

// Impor halaman-halaman yang sebenarnya
import 'quiz_page.dart'; // Pastikan path ini benar jika file ada
import 'offline_video_player_page.dart'; // Pastikan path ini benar
import 'tanya_pancasila_ai_page.dart'; // Pastikan path ini benar
// SearchPancasilaPage dihandle via named routes di main.dart, jadi tidak perlu import langsung di sini jika demikian

// --- Widget Animasi Garuda di Header (Bernapas) ---
class AnimatedHeaderGarudaImage extends StatefulWidget {
  const AnimatedHeaderGarudaImage({super.key});

  @override
  State<AnimatedHeaderGarudaImage> createState() =>
      _AnimatedHeaderGarudaImageState();
}

class _AnimatedHeaderGarudaImageState extends State<AnimatedHeaderGarudaImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Image.asset(
        'assets/images/garuda_pancasila.png', // Pastikan path ini ada
        height: 80,
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.flag_circle_rounded, size: 80, color: Colors.grey[350]),
      ),
    );
  }
}

// --- Widget Animasi Maskot Memantul dengan Fakta Menarik (AlertDialog) ---
class BouncingMascotImage extends StatefulWidget {
  final String imagePath;
  final double mascotHeight;
  final double mascotWidth;
  final List<String> funFacts;

  const BouncingMascotImage({
    super.key,
    required this.imagePath,
    this.mascotHeight = 70.0,
    this.mascotWidth = 70.0,
    this.funFacts = const [],
  });

  @override
  State<BouncingMascotImage> createState() => _BouncingMascotImageState();
}

class _BouncingMascotImageState extends State<BouncingMascotImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late double dx;
  late double dy;
  late double velocityX;
  late double velocityY;
  final Random _random = Random();

  double _areaWidth = 0;
  double _areaHeight = 0;
  bool _hasInitialized = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(days: 99), // Durasi sangat panjang untuk animasi kontinu
    )..addListener(_updatePosition);

    _initializeVelocities();
  }

  void _initializeVelocities() {
    velocityX = (_random.nextBool() ? 1 : -1) * (_random.nextDouble() * 1.0 + 0.5); // Kecepatan acak
    velocityY = (_random.nextBool() ? 1 : -1) * (_random.nextDouble() * 1.0 + 0.5);
  }

  void _initializePositionAndStart(BoxConstraints constraints) {
    if (!_hasInitialized && mounted) {
      _areaWidth = constraints.maxWidth;
      _areaHeight = constraints.maxHeight;

      if (_areaWidth > 0 && _areaHeight > 0) {
        // Mulai dari posisi acak di dalam area yang valid
        dx = _random.nextDouble() * (_areaWidth - widget.mascotWidth).clamp(0.0, _areaWidth);
        dy = _random.nextDouble() * (_areaHeight - widget.mascotHeight).clamp(0.0, _areaHeight);
        _hasInitialized = true;

        if (!_animationController.isAnimating) {
          _animationController.repeat(); // Mulai animasi
        }
      }
    }
  }

  void _updatePosition() {
    if (!mounted || !_hasInitialized) return;

    setState(() {
      dx += velocityX;
      dy += velocityY;

      // Logika pantulan pada batas area
      if (dx <= 0) {
        dx = 0;
        velocityX = -velocityX;
      } else if (dx >= _areaWidth - widget.mascotWidth) {
        dx = _areaWidth - widget.mascotWidth;
        velocityX = -velocityX;
      }

      if (dy <= 0) {
        dy = 0;
        velocityY = -velocityY;
      } else if (dy >= _areaHeight - widget.mascotHeight) {
        dy = _areaHeight - widget.mascotHeight;
        velocityY = -velocityY;
      }
    });
  }

  void _showRandomFunFactDialog() {
    if (widget.funFacts.isNotEmpty && mounted) {
      final fact = widget.funFacts[_random.nextInt(widget.funFacts.length)];
      final theme = Theme.of(context);

      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            title: Row(
              children: [
                Icon(Icons.lightbulb_outline_rounded, color: theme.colorScheme.primary, size: 28),
                const SizedBox(width: 10),
                Text(
                  'Tahukah Kamu?',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Text(
              fact,
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.4),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Menarik!', style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _animationController.removeListener(_updatePosition);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Inisialisasi posisi dan mulai animasi setelah widget dibangun dan memiliki ukuran
        if (!_hasInitialized && constraints.maxWidth > 0 && constraints.maxHeight > 0) {
          // Menggunakan addPostFrameCallback untuk memastikan constraints sudah final
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) { // Pastikan widget masih mounted sebelum memanggil setState
              _initializePositionAndStart(constraints);
            }
          });
        }

        // Jika belum terinisialisasi, tampilkan SizedBox kosong agar tidak error
        if (!_hasInitialized) {
          return const SizedBox.shrink();
        }

        return Stack(
          children: [
            Positioned(
              left: dx,
              top: dy,
              child: GestureDetector(
                onTap: _showRandomFunFactDialog,
                child: Image.asset(
                  widget.imagePath,
                  height: widget.mascotHeight,
                  width: widget.mascotWidth,
                  errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.mood_bad_rounded,
                      size: widget.mascotHeight,
                      color: Colors.grey),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// --- Model dan Widget Menu ---
class MenuButtonInfo {
  final String title;
  final String description;
  final String? imageAssetPath;
  final IconData? iconData;
  final Color? backgroundColor;
  final VoidCallback onTap; // Perhatikan: onTap akan diubah untuk menangani konfirmasi AI

  MenuButtonInfo({
    required this.title,
    required this.description,
    this.imageAssetPath,
    this.iconData,
    this.backgroundColor,
    required this.onTap,
  }) : assert(imageAssetPath != null || iconData != null,
  'Either imageAssetPath or iconData must be provided');
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<String> _pancasilaFunFacts = [
    "Pancasila dirumuskan oleh BPUPKI (Badan Penyelidik Usaha-usaha Persiapan Kemerdekaan Indonesia).",
    "Hari Lahir Pancasila diperingati setiap tanggal 1 Juni, berdasarkan pidato Soekarno tahun 1945.",
    "Lambang negara Garuda Pancasila dirancang oleh Sultan Hamid II dari Pontianak dan diresmikan pada tahun 1950.",
    "Sila ke-3, 'Persatuan Indonesia', dilambangkan dengan pohon beringin yang memiliki akar tunggal panjang dan rindang.",
    "Butir-butir pengamalan Pancasila pertama kali ditetapkan melalui Tap MPR No. II/MPR/1978.",
    "Pancasila adalah dasar ideologi dan falsafah hidup bangsa Indonesia yang mempersatukan keragaman.",
    "Nama 'Pancasila' berasal dari bahasa Sansekerta: 'pañca' berarti lima dan 'śīla' berarti prinsip atau asas.",
    "Mohammad Yamin, Soepomo, dan Soekarno adalah tiga tokoh utama yang menyampaikan gagasan dasar negara pada sidang BPUPKI.",
    "Piagam Jakarta (Jakarta Charter) yang dirumuskan pada 22 Juni 1945 memuat rumusan awal Pancasila dengan sila pertama yang sedikit berbeda.",
    "Sila ke-5, 'Keadilan sosial bagi seluruh rakyat Indonesia', dilambangkan dengan padi dan kapas yang melambangkan pangan dan sandang."
  ];

  // --- FUNGSI UNTUK DIALOG KONFIRMASI TANYA AI ---
  Future<bool?> _showTanyaAiConfirmationDialog(BuildContext context) async {
    final theme = Theme.of(context);
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // Pengguna harus memilih salah satu opsi
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Row(
            children: [
              Icon(Icons.help_outline_rounded, color: theme.colorScheme.primary),
              const SizedBox(width: 10),
              const Text('Konfirmasi Akses AI'),
            ],
          ),
          content: const Text(
            'Anda akan membuka fitur Tanya AI yang menggunakan layanan eksternal (Google Gemini) dan memerlukan koneksi internet. Lanjutkan?',
            style: TextStyle(fontSize: 15, height: 1.4),
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: <Widget>[
            TextButton(
              child: Text('Batal', style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500)),
              onPressed: () {
                Navigator.of(dialogContext).pop(false); // Mengembalikan false
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              child: const Text('Lanjutkan', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(dialogContext).pop(true); // Mengembalikan true
              },
            ),
          ],
        );
      },
    );
  }
  // --- END FUNGSI DIALOG ---


  Widget _buildMenuButton(
      BuildContext context, {
        required String title,
        required String description,
        String? imageAssetPath,
        IconData? iconData,
        Color? backgroundColor,
        required VoidCallback onTap,
        required double circleDiameter,
      }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color iconContentColor = Colors.white;
    if (backgroundColor != null) {
      iconContentColor = backgroundColor.computeLuminance() > 0.4
          ? Colors.black.withOpacity(0.75)
          : Colors.white.withOpacity(0.9);
    } else {
      iconContentColor = isDark ? Colors.white.withOpacity(0.9) : Colors.black.withOpacity(0.75);
    }

    final textColor = isDark ? Colors.white.withOpacity(0.95) : Colors.black.withOpacity(0.85);
    final effectiveBgColor = backgroundColor ?? theme.colorScheme.primaryContainer.withOpacity(0.8);
    final double imageOrIconSize = circleDiameter * 0.7; // Ukuran disesuaikan agar tidak terlalu besar

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: circleDiameter,
              height: circleDiameter,
              decoration: BoxDecoration(
                color: effectiveBgColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 2))
                ],
              ),
              child: Center(
                child: imageAssetPath != null
                    ? Padding( // Tambahkan padding untuk gambar aset di dalam lingkaran
                  padding: EdgeInsets.all(imageOrIconSize * 0.15), // 15% dari ukuran ikon
                  child: Image.asset(
                    imageAssetPath,
                    fit: BoxFit.contain,
                    errorBuilder: (ctx, err, st) => Icon(
                      Icons.broken_image_outlined,
                      size: imageOrIconSize * 0.7,
                      color: iconContentColor.withOpacity(0.7),
                    ),
                  ),
                )
                    : Icon(
                  iconData,
                  size: imageOrIconSize,
                  color: iconContentColor,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12, // Ukuran font untuk judul menu
                    color: textColor,
                    shadows: [
                      Shadow(
                        blurRadius: 1.0,
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0.5, 0.5),
                      ),
                    ]
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
    final isDark = theme.brightness == Brightness.dark;
    const double menuItemWidth = 85.0;
    final double circleMenuDiameter = menuItemWidth * 0.7;

    final List<MenuButtonInfo> allMenuButtons = [
      MenuButtonInfo(
          title: 'Cari Sila',
          description: 'Info sila & butir.',
          imageAssetPath: 'assets/images/menu_search_pancasila.png',
          backgroundColor: const Color(0xFF42A5F5), // Biru
          onTap: () {
            Navigator.pushNamed(context, '/searchPancasila');
          }),
      MenuButtonInfo(
          title: 'Kuis',
          description: 'Asah ilmumu.',
          imageAssetPath: 'assets/images/menu_quiz.png',
          backgroundColor: const Color(0xFFFFCA28), // Kuning
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const QuizPage()))),
      MenuButtonInfo(
          title: 'Tanya AI',
          description: 'Seputar Pancasila.',
          imageAssetPath: 'assets/images/menu_ai_gemini.png',
          backgroundColor: const Color(0xFFBA68C8), // Ungu
          onTap: () async { // Jadikan onTap async untuk Tanya AI
            final bool? confirm = await _showTanyaAiConfirmationDialog(context);
            if (confirm == true && context.mounted) { // Periksa context.mounted sebelum navigasi
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TanyaPancasilaAiPage()));
            }
          }),
      MenuButtonInfo(
          title: 'Lagu',
          description: 'Garuda Pancasila.',
          imageAssetPath: 'assets/images/menu_music.png',
          backgroundColor: const Color(0xFFFFA726), // Oranye
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OfflineVideoPlayerPage()))),
      MenuButtonInfo(
        title: 'Tentang',
        description: 'Info Sahabat Pancasila.',
        imageAssetPath: 'assets/images/menu_about.png',
        backgroundColor: const Color(0xFF66BB6A), // Hijau
        onTap: () => showDialog(
          context: context,
          builder: (BuildContext dialogContext) => AlertDialog(
            backgroundColor: theme.dialogBackgroundColor.withOpacity(0.95),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(children: [
              Icon(Icons.info_outline_rounded, color: theme.colorScheme.primary),
              const SizedBox(width: 10),
              Text('Tentang Sahabat Pancasila', style: TextStyle(color: theme.textTheme.titleLarge?.color, fontWeight: FontWeight.bold))
            ]),
            content: SingleChildScrollView(
                child: ListBody(children: [
                  Text('Sahabat Pancasila', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: theme.textTheme.bodyMedium?.color)),
                  const SizedBox(height: 8),
                  Text('Versi 1.0.8 - Latar Belakang & Peningkatan UI', style: TextStyle(color: theme.textTheme.bodySmall?.color)), // Sesuaikan versi jika perlu
                  const SizedBox(height: 10),
                  Text('Aplikasi edukasi untuk mengenalkan Pancasila kepada anak-anak dengan cara yang interaktif dan menyenangkan.', style: TextStyle(color: theme.textTheme.bodyMedium?.color, height: 1.4)),
                  const SizedBox(height: 16),
                  Text('Dikembangkan dengan ❤️ oleh Tim Sapa.', style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
                ])),
            actions: [
              TextButton(
                  child: Text('Tutup', style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
                  onPressed: () => Navigator.of(dialogContext).pop())
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sahabat Pancasila',
              style: TextStyle(
                  color: isDark ? Colors.white.withOpacity(0.9) : Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 20, // Ukuran font judul AppBar
                  shadows: [
                    Shadow(
                      blurRadius: 1.5,
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(1, 1),
                    ),
                  ]
              ),
            ),
            const SizedBox(width: 8),
            // Opsional: Tambahkan ikon kecil jika diinginkan
            // Icon(Icons.shield_moon_rounded, color: isDark ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.7), size: 22)
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/app_background.png"), // GANTI DENGAN NAMA FILE GAMBAR ANDA
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 92), // Padding bawah untuk mengakomodasi maskot
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: kToolbarHeight + 10),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: theme.cardColor.withOpacity(0.88),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(children: [
                        const AnimatedHeaderGarudaImage(),
                        const SizedBox(height: 16),
                        Text('Pendidikan Pancasila',
                            style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                                fontSize: 21,
                                shadows: [
                                  Shadow(blurRadius: 1.0, color: Colors.black.withOpacity(0.15), offset: const Offset(0.5,0.5)),
                                ]
                            ),
                            textAlign: TextAlign.center),
                        const SizedBox(height: 8),
                        Text(
                            'Yuk, belajar Pancasila dengan seru bersama Sahabat Pancasila!',
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: (isDark ? Colors.white.withOpacity(0.9) : Colors.black.withOpacity(0.75)),
                                fontSize: 14.5,
                                height: 1.3,
                                shadows: [
                                  Shadow(blurRadius: 1.0, color: Colors.black.withOpacity(0.1), offset: const Offset(0.5,0.5)),
                                ]
                            ),
                            textAlign: TextAlign.center),
                      ]),
                    ),
                    const SizedBox(height: 28),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Wrap(
                        spacing: 10.0,
                        runSpacing: 14.0,
                        alignment: WrapAlignment.center,
                        children: allMenuButtons.map((item) => SizedBox(
                          width: menuItemWidth,
                          child: _buildMenuButton(context,
                              title: item.title,
                              description: item.description,
                              imageAssetPath: item.imageAssetPath,
                              iconData: item.iconData,
                              backgroundColor: item.backgroundColor,
                              onTap: item.onTap, // onTap sudah dimodifikasi untuk Tanya AI
                              circleDiameter: circleMenuDiameter
                          ),
                        )).toList(),
                      ),
                    ),
                    const SizedBox(height: 80), // Ruang ekstra di bawah menu
                  ],
                ),
              ),
              const BouncingMascotImage(
                imagePath: 'assets/images/maskot.png', // Pastikan path ini benar
                mascotHeight: 65, // Ukuran maskot disesuaikan
                mascotWidth: 65,
                funFacts: _pancasilaFunFacts,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
