import 'package:flutter/material.dart';
import 'dart:async'; // Diperlukan untuk Timer
import 'dart:math';  // Diperlukan untuk Random

// Asumsi halaman-halaman ini ada di proyek Anda
import './quiz_page.dart';
import './offline_video_player_page.dart';
import './search_pancasila_page.dart';
import './tanya_pancasila_ai_page.dart';

// --- Widget Animasi Garuda Mengambang dari Kanan Bawah (FloatingActionButton kustom) ---
class FloatingGarudaImage extends StatefulWidget {
  final VoidCallback? onTap;

  const FloatingGarudaImage({super.key, this.onTap});

  @override
  State<FloatingGarudaImage> createState() => _FloatingGarudaImageState();
}

class _FloatingGarudaImageState extends State<FloatingGarudaImage> {
  double _bottomPosition = -100.0;
  double _rightPosition = -100.0;
  double _opacity = 0.0;
  double _scale = 0.8;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1200), () { // Penundaan lebih lama agar maskot memantul dulu
      if (mounted) {
        setState(() {
          _bottomPosition = 20.0;
          _rightPosition = 20.0;
          _opacity = 1.0;
          _scale = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      bottom: _bottomPosition,
      right: _rightPosition,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 600),
        opacity: _opacity,
        curve: Curves.easeIn,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 700),
          scale: _scale,
          curve: Curves.elasticOut,
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(2, 2),
                    )
                  ]),
              child: Image.asset(
                'assets/images/garuda_pancasila.png', // Anda mungkin ingin maskot di sini atau garuda lain
                height: 60,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.flag_circle_rounded, size: 60, color: Colors.grey[350]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
        'assets/images/garuda_pancasila.png',
        height: 80,
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.flag_circle_rounded, size: 80, color: Colors.grey[350]),
      ),
    );
  }
}

// --- Widget Animasi Maskot Memantul ---
class BouncingMascotImage extends StatefulWidget {
  final String imagePath;
  final double mascotHeight;
  final double mascotWidth;

  const BouncingMascotImage({
    super.key,
    required this.imagePath,
    this.mascotHeight = 50.0,
    this.mascotWidth = 50.0,
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
      duration: const Duration(days: 99), // Durasi sangat panjang, hanya untuk ticker
    )..addListener(_updatePosition);

    // Kecepatan awal diinisialisasi di sini, posisi setelah layout
    _initializeVelocities();
    dx = 0; // Akan diupdate oleh LayoutBuilder
    dy = 0; // Akan diupdate oleh LayoutBuilder
  }

  void _initializeVelocities() {
    velocityX = (_random.nextBool() ? 1 : -1) * (_random.nextDouble() * 1.0 + 0.5); // Kecepatan lebih lambat
    velocityY = (_random.nextBool() ? 1 : -1) * (_random.nextDouble() * 1.0 + 0.5);
  }

  void _initializePositionAndStart(BoxConstraints constraints) {
    if (!_hasInitialized && mounted) { // Hanya inisialisasi sekali dan jika widget masih ada
      _areaWidth = constraints.maxWidth;
      _areaHeight = constraints.maxHeight;

      if (_areaWidth > 0 && _areaHeight > 0) {
        dx = _random.nextDouble() * (_areaWidth - widget.mascotWidth);
        dy = _random.nextDouble() * (_areaHeight - widget.mascotHeight);
        _hasInitialized = true; // Tandai bahwa inisialisasi selesai

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
        // Panggil _initializePositionAndStart di sini, aman karena LayoutBuilder
        // akan memanggil ulang builder jika constraints berubah (meskipun kita hanya butuh saat pertama kali)
        if (!_hasInitialized && constraints.maxWidth > 0 && constraints.maxHeight > 0) {
          // Jadwalkan agar dijalankan setelah build selesai untuk frame ini
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _initializePositionAndStart(constraints);
          });
        }

        if (!_hasInitialized) {
          return const SizedBox.shrink(); // Jangan tampilkan apa-apa sampai ukuran diketahui
        }

        return Stack( // Stack lokal untuk Positioned
          children: [
            Positioned(
              left: dx,
              top: dy,
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
  }) : assert(imageAssetPath != null || iconData != null);
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
    final isDark = theme.brightness == Brightness.dark;
    Color iconContentColor = (backgroundColor?.computeLuminance() ?? (isDark ? 0.0 : 1.0)) > 0.5
        ? Colors.black.withOpacity(0.75)
        : Colors.white;
    final textColor = isDark ? Colors.white.withOpacity(0.9) : Colors.black.withOpacity(0.8);
    final effectiveBgColor = backgroundColor ?? theme.colorScheme.primaryContainer;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: effectiveBgColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 3,
                      offset: const Offset(0, 1.5))
                ],
              ),
              child: imageAssetPath != null
                  ? ClipOval(
                  child: Image.asset(imageAssetPath,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, st) => Icon(
                          Icons.broken_image_outlined,
                          size: 28,
                          color: iconContentColor.withOpacity(0.7))))
                  : Icon(iconData, size: 28, color: iconContentColor),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600, fontSize: 12, color: textColor),
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
    const menuItemWidth = 80.0;

    final List<MenuButtonInfo> allMenuButtons = [
      MenuButtonInfo(
          title: 'Cari Sila',
          description: 'Info sila & butir.',
          imageAssetPath: 'assets/images/menu_search_pancasila.png',
          backgroundColor: const Color(0xFF42A5F5),
          onTap: () => Navigator.pushNamed(context, '/searchPancasila')),
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
                  builder: (context) => const SamplePlayer(
                      videoPath: 'assets/videos/garuda_pancasila.mp4',
                      isAsset: true)))),
      MenuButtonInfo(
        title: 'Tentang',
        description: 'Info SAPA Ceria.',
        imageAssetPath: 'assets/images/menu_about.png',
        backgroundColor: const Color(0xFF66BB6A),
        onTap: () => showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(children: [
              Icon(Icons.adb_rounded, color: theme.primaryColor),
              const SizedBox(width: 10),
              const Text('Tentang SAPA Ceria')
            ]),
            content: const SingleChildScrollView(
                child: ListBody(children: [
                  Text('SAPA Ceria (Sahabat Pancasila Ceria)'),
                  SizedBox(height: 8),
                  Text('Versi 1.0.1 - Bouncing Mascot'),
                  SizedBox(height: 8),
                  Text('Belajar Pancasila dengan cara yang menyenangkan.'),
                  SizedBox(height: 16),
                  Text('Terima kasih! ❤️'),
                ])),
            actions: [
              TextButton(
                  child: Text('Tutup', style: TextStyle(color: theme.primaryColor)),
                  onPressed: () => Navigator.of(ctx).pop())
            ],
          ),
        ),
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
            Image.asset('assets/images/maskot_ceria.png', height: 35,
                errorBuilder: (ctx, err, st) => const SizedBox.shrink()),
          ],
        ),
        centerTitle: true, // Untuk memastikan judul benar-benar di tengah
      ),
      body: Stack(
        children: [
          // Layer 0: Konten utama halaman (Scrollable)
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 82), // Padding bawah lebih besar untuk FloatingGarudaImage
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10.0),
                  child: Column(children: [
                    const AnimatedHeaderGarudaImage(),
                    const SizedBox(height: 16),
                    Text('Pendidikan Pancasila',
                        style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                            fontSize: 20),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 6),
                    Text('Yuk, belajar Pancasila dengan seru bersama SAPA!',
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.8),
                            fontSize: 14),
                        textAlign: TextAlign.center),
                  ]),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text('Pilih Fitur',
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.center),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 12.0,
                    alignment: WrapAlignment.center,
                    children: allMenuButtons.map((item) => SizedBox(
                      width: menuItemWidth,
                      child: _buildMenuButton(context,
                          title: item.title,
                          description: item.description,
                          imageAssetPath: item.imageAssetPath,
                          iconData: item.iconData,
                          backgroundColor: item.backgroundColor,
                          onTap: item.onTap),
                    )).toList(),
                  ),
                ),
                // SizedBox tambahan di akhir konten scrollable jika diperlukan
                // agar tidak tertutup oleh elemen Stack di atasnya saat di-scroll ke bawah
                const SizedBox(height: 60),
              ],
            ),
          ),

          // Layer 1: Maskot yang memantul (menutupi seluruh area Stack)
          // Widget ini akan mengambil seluruh ruang yang tersedia di Stack karena tidak ada batasan Positioned.
          const BouncingMascotImage(
            imagePath: 'assets/images/maskot.png', // Pastikan path ini benar
            mascotHeight: 45, // Ukuran bisa disesuaikan
            mascotWidth: 45,
          ),

          // Layer 2: Garuda di pojok kanan bawah (di atas maskot dan konten)
          FloatingGarudaImage(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('SAPA Ceria menyapamu! 👋'), duration: Duration(seconds: 2)),
              );
            },
          ),
        ],
      ),
    );
  }
}
