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
      duration: const Duration(days: 99),
    )..addListener(_updatePosition);

    _initializeVelocities();
  }

  void _initializeVelocities() {
    velocityX = (_random.nextBool() ? 1 : -1) * (_random.nextDouble() * 1.0 + 0.5);
    velocityY = (_random.nextBool() ? 1 : -1) * (_random.nextDouble() * 1.0 + 0.5);
  }

  void _initializePositionAndStart(BoxConstraints constraints) {
    if (!_hasInitialized && mounted) {
      _areaWidth = constraints.maxWidth;
      _areaHeight = constraints.maxHeight;

      if (_areaWidth > 0 && _areaHeight > 0) {
        dx = _random.nextDouble() * (_areaWidth - widget.mascotWidth).clamp(0.0, _areaWidth);
        dy = _random.nextDouble() * (_areaHeight - widget.mascotHeight).clamp(0.0, _areaHeight);
        _hasInitialized = true;

        if (!_animationController.isAnimating) {
          _animationController.repeat();
        }
      }
    }
  }

  void _updatePosition() {
    if (!mounted || !_hasInitialized) return;

    setState(() {
      dx += velocityX;
      dy += velocityY;

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
        if (!_hasInitialized && constraints.maxWidth > 0 && constraints.maxHeight > 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _initializePositionAndStart(constraints);
            }
          });
        }

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
  final VoidCallback onTap;

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

    // Menentukan warna konten ikon/gambar berdasarkan luminansi background
    // Jika background gelap, konten terang, begitu sebaliknya
    Color iconContentColor = Colors.white; // Default untuk background berwarna
    if (backgroundColor != null) {
      iconContentColor = backgroundColor.computeLuminance() > 0.4 // Ambang batas bisa disesuaikan
          ? Colors.black.withOpacity(0.75)
          : Colors.white.withOpacity(0.9);
    } else { // Jika tidak ada background color spesifik, gunakan skema tema
      iconContentColor = isDark ? Colors.white.withOpacity(0.9) : Colors.black.withOpacity(0.75);
    }


    // Menentukan warna teks berdasarkan tema (terang/gelap) agar kontras dengan background utama halaman
    final textColor = isDark ? Colors.white.withOpacity(0.95) : Colors.black.withOpacity(0.85);
    final effectiveBgColor = backgroundColor ?? theme.colorScheme.primaryContainer.withOpacity(0.8); // Opacity untuk tombol menu

    final double imageOrIconSize = circleDiameter * 0.75; // Ukuran gambar/ikon sedikit lebih kecil agar pas

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0), // Radius untuk efek ripple
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
                      color: Colors.black.withOpacity(0.15), // Shadow lebih jelas sedikit
                      blurRadius: 4,
                      offset: const Offset(0, 2))
                ],
              ),
              child: Center(
                child: imageAssetPath != null
                    ? Image.asset(
                  imageAssetPath,
                  width: imageOrIconSize,
                  height: imageOrIconSize,
                  fit: BoxFit.contain,
                  errorBuilder: (ctx, err, st) => Icon(
                    Icons.broken_image_outlined,
                    size: imageOrIconSize * 0.7,
                    color: iconContentColor.withOpacity(0.7),
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
                    fontSize: 12,
                    color: textColor, // Menggunakan textColor yang sudah disesuaikan
                    shadows: [ // Shadow tipis untuk teks agar lebih terbaca di atas background ramai
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
    const double menuItemWidth = 85.0; // Sedikit lebih lebar untuk spacing
    final double circleMenuDiameter = menuItemWidth * 0.7;

    final List<MenuButtonInfo> allMenuButtons = [
      MenuButtonInfo(
          title: 'Cari Sila',
          description: 'Info sila & butir.',
          imageAssetPath: 'assets/images/menu_search_pancasila.png',
          backgroundColor: const Color(0xFF42A5F5),
          onTap: () {
            Navigator.pushNamed(context, '/searchPancasila');
          }),
      MenuButtonInfo(
          title: 'Kuis',
          description: 'Asah ilmumu.',
          imageAssetPath: 'assets/images/menu_quiz.png',
          backgroundColor: const Color(0xFFFFCA28),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const QuizPage()))),
      MenuButtonInfo(
          title: 'Tanya AI',
          description: 'Seputar Pancasila.',
          imageAssetPath: 'assets/images/menu_ai_gemini.png',
          backgroundColor: const Color(0xFFBA68C8),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TanyaPancasilaAiPage()))),
      MenuButtonInfo(
          title: 'Lagu',
          description: 'Garuda Pancasila.',
          imageAssetPath: 'assets/images/menu_music.png',
          backgroundColor: const Color(0xFFFFA726),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OfflineVideoPlayerPage(
                      videoPath: 'assets/videos/garuda_pancasila.mp4',
                      isAsset: true)))),
      MenuButtonInfo(
        title: 'Tentang',
        description: 'Info Sahabat Pancasila.',
        imageAssetPath: 'assets/images/menu_about.png',
        backgroundColor: const Color(0xFF66BB6A),
        onTap: () => showDialog(
          context: context,
          builder: (BuildContext dialogContext) => AlertDialog(
            backgroundColor: theme.dialogBackgroundColor.withOpacity(0.95), // Dialog semi-transparan
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(children: [
              Icon(Icons.info_outline_rounded, color: theme.colorScheme.primary),
              const SizedBox(width: 10),
              Text('Tentang Sahabat Pancasila', style: TextStyle(color: theme.textTheme.titleLarge?.color))
            ]),
            content: SingleChildScrollView(
                child: ListBody(children: [
                  Text('Sahabat Pancasila', style: TextStyle(fontWeight: FontWeight.bold, color: theme.textTheme.bodyMedium?.color)),
                  const SizedBox(height: 8),
                  Text('Versi 1.0.8 - Latar Belakang & Peningkatan UI', style: TextStyle(color: theme.textTheme.bodySmall?.color)), // Sesuaikan versi jika perlu
                  const SizedBox(height: 8),
                  Text('Belajar Pancasila dengan cara yang menyenangkan.', style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
                  const SizedBox(height: 16),
                  Text('Terima kasih! ❤️', style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
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
      extendBodyBehindAppBar: true, // Membuat body bisa di belakang AppBar jika AppBar transparan
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sahabat Pancasila',
              style: TextStyle(
                  color: isDark ? Colors.white.withOpacity(0.9) : Colors.black.withOpacity(0.8), // Warna judul AppBar
                  fontWeight: FontWeight.bold,
                  shadows: [ // Shadow tipis untuk teks AppBar
                    Shadow(
                      blurRadius: 1.5,
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(1, 1),
                    ),
                  ]
              ),
            ),
            const SizedBox(width: 8),
            Image.asset('assets/images/maskot_ceria.png', height: 35,
                errorBuilder: (ctx, err, st) => const SizedBox.shrink()),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // AppBar dibuat transparan
        elevation: 0, // Menghilangkan shadow bawaan AppBar
        scrolledUnderElevation: 0, // Menghilangkan shadow saat di-scroll jika ada konten di bawahnya
      ),
      body: Container(
        width: double.infinity, // Memastikan Container mengisi seluruh lebar
        height: double.infinity, // Memastikan Container mengisi seluruh tinggi
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/app_background.png"), // GANTI DENGAN NAMA FILE GAMBAR ANDA
            fit: BoxFit.cover,
            // Opsional: Tambahkan colorFilter untuk menggelapkan/mencerahkan background
            // colorFilter: ColorFilter.mode(
            //   Colors.black.withOpacity(0.3), // 0.0 (original) - 1.0 (hitam penuh)
            //   BlendMode.darken, // atau BlendMode.lighten, BlendMode.dstATop, dll.
            // ),
          ),
        ),
        child: SafeArea( // SafeArea agar konten tidak tertutup notch atau area sistem lainnya
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 92), // Padding lebih konsisten
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: kToolbarHeight + 10), // Memberi ruang untuk AppBar transparan
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: theme.cardColor.withOpacity(0.88), // Opacity disesuaikan
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
                                fontSize: 21, // Sedikit lebih besar
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
                                fontSize: 14.5, // Sedikit lebih besar
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
                        spacing: 10.0, // Spasi antar item
                        runSpacing: 14.0, // Spasi antar baris
                        alignment: WrapAlignment.center,
                        children: allMenuButtons.map((item) => SizedBox(
                          width: menuItemWidth,
                          child: _buildMenuButton(context,
                              title: item.title,
                              description: item.description,
                              imageAssetPath: item.imageAssetPath,
                              iconData: item.iconData,
                              backgroundColor: item.backgroundColor,
                              onTap: item.onTap,
                              circleDiameter: circleMenuDiameter
                          ),
                        )).toList(),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
              const BouncingMascotImage(
                imagePath: 'assets/images/maskot.png', // Pastikan path benar
                mascotHeight: 70,
                mascotWidth: 70,
                funFacts: _pancasilaFunFacts,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
