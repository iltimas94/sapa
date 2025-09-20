import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

// Impor halaman-halaman yang sebenarnya
import 'quiz_page.dart'; // Pastikan path ini benar jika file ada
import 'offline_video_player_page.dart'; // Pastikan path ini benar
import 'tanya_pancasila_ai_page.dart'; // Pastikan path ini benar
// SearchPancasilaPage dihandle via named routes di main.dart

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
        height: 100, // Ukuran Garuda sedikit diperbesar
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.flag_circle_rounded, size: 100, color: Colors.grey[350]),
      ),
    );
  }
}

// --- Widget Animasi Maskot Memantul ---
class BouncingMascotImage extends StatefulWidget {
  // ... (Kode BouncingMascotImage tetap sama)
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
            title: Row(children: [
              Icon(Icons.lightbulb_outline_rounded, color: theme.colorScheme.primary, size: 28),
              const SizedBox(width: 10),
              Text('Tahukah Kamu?', style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
            ]),
            content: Text(fact, style: theme.textTheme.bodyLarge?.copyWith(height: 1.4)),
            actions: <Widget>[
              TextButton(
                child: Text('Menarik!', style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.of(dialogContext).pop(),
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
            if (mounted) _initializePositionAndStart(constraints);
          });
        }
        if (!_hasInitialized) return const SizedBox.shrink();
        return Stack(children: [
          Positioned(
            left: dx,
            top: dy,
            child: GestureDetector(
              onTap: _showRandomFunFactDialog,
              child: Image.asset(
                widget.imagePath,
                height: widget.mascotHeight,
                width: widget.mascotWidth,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.mood_bad_rounded, size: widget.mascotHeight, color: Colors.grey),
              ),
            ),
          ),
        ]);
      },
    );
  }
}


// --- Model Menu ---
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
    "Pancasila dirumuskan oleh BPUPKI.",
    "Hari Lahir Pancasila adalah 1 Juni.",
    "Lambang Garuda Pancasila dirancang oleh Sultan Hamid II.",
    "Sila ke-3 dilambangkan pohon beringin.",
    "Butir pengamalan Pancasila pertama kali ditetapkan oleh Tap MPR No. II/MPR/1978.",
    "Pancasila adalah dasar ideologi Indonesia.",
    "Nama 'Pancasila' dari bahasa Sansekerta: 'pañca' (lima) dan 'śīla' (prinsip).",
    "Mohammad Yamin, Soepomo, dan Soekarno adalah tokoh utama perumus dasar negara.",
    "Piagam Jakarta memuat rumusan awal Pancasila.",
    "Sila ke-5 dilambangkan padi dan kapas."
  ];

  Future<bool?> _showTanyaAiConfirmationDialog(BuildContext context) async {
    // ... (Fungsi ini tetap sama)
    final theme = Theme.of(context);
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Row(children: [
            Icon(Icons.help_outline_rounded, color: theme.colorScheme.primary),
            const SizedBox(width: 10),
            const Text('Konfirmasi Akses AI'),
          ]),
          content: const Text(
            'Anda akan membuka fitur Tanya AI yang menggunakan layanan eksternal (Google Gemini) dan memerlukan koneksi internet. Lanjutkan?',
            style: TextStyle(fontSize: 15, height: 1.4),
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: <Widget>[
            TextButton(
              child: Text('Batal', style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500)),
              onPressed: () => Navigator.of(dialogContext).pop(false),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              child: const Text('Lanjutkan', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMenuButton(
      BuildContext context, {
        required String title,
        // String description, // Deskripsi tidak lagi ditampilkan di bawah ikon untuk layout 2x2
        String? imageAssetPath,
        IconData? iconData,
        Color? backgroundColor,
        required VoidCallback onTap,
        required double circleDiameter, // Diameter lingkaran ikon
        required double imageSize, // Ukuran gambar/ikon di dalam lingkaran
        required double fontSize, // Ukuran font judul
      }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color iconContentColor = Colors.white;
    if (backgroundColor != null) {
      iconContentColor = backgroundColor.computeLuminance() > 0.45
          ? Colors.black.withOpacity(0.8)
          : Colors.white.withOpacity(0.95);
    } else {
      iconContentColor = isDark ? Colors.white.withOpacity(0.95) : Colors.black.withOpacity(0.8);
    }

    final textColor = isDark ? Colors.white.withOpacity(0.95) : Colors.black.withOpacity(0.85);
    final effectiveBgColor = backgroundColor ?? theme.colorScheme.primaryContainer.withOpacity(0.9);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0), // Radius lebih besar untuk area tap
      splashColor: theme.colorScheme.primary.withOpacity(0.2),
      highlightColor: theme.colorScheme.primary.withOpacity(0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Pusatkan konten di kolom
        children: [
          Container(
            width: circleDiameter,
            height: circleDiameter,
            decoration: BoxDecoration(
              color: effectiveBgColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 6,
                    offset: const Offset(0, 3))
              ],
            ),
            child: Center(
              child: imageAssetPath != null
                  ? Padding(
                padding: EdgeInsets.all(imageSize * 0.1), // Padding relatif
                child: Image.asset(
                  imageAssetPath,
                  width: imageSize,  // Gunakan imageSize
                  height: imageSize, // Gunakan imageSize
                  fit: BoxFit.contain,
                  errorBuilder: (ctx, err, st) => Icon(
                    Icons.broken_image_outlined,
                    size: imageSize * 0.8,
                    color: iconContentColor.withOpacity(0.7),
                  ),
                ),
              )
                  : Icon(
                iconData,
                size: imageSize, // Gunakan imageSize
                color: iconContentColor,
              ),
            ),
          ),
          const SizedBox(height: 10.0), // Jarak lebih besar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith( // Gunakan bodyLarge untuk ukuran font
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize, // Gunakan fontSize
                  color: textColor,
                  shadows: [
                    Shadow(
                      blurRadius: 1.0,
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0.5, 0.5),
                    ),
                  ]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Hanya 4 menu yang akan ditampilkan
    final List<MenuButtonInfo> menuButtons = [
      MenuButtonInfo(
          title: 'Cari Sila',
          description: 'Info sila & butir.', // Deskripsi tetap ada di model, tapi tidak ditampilkan
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
          onTap: () async {
            final bool? confirm = await _showTanyaAiConfirmationDialog(context);
            if (confirm == true && context.mounted) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TanyaPancasilaAiPage()));
            }
          }),
      MenuButtonInfo(
          title: 'Lagu',
          description: 'Pilih Lagu Nasional.',
          imageAssetPath: 'assets/images/menu_music.png',
          backgroundColor: const Color(0xFFFFA726), // Oranye
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OfflineVideoPlayerPage()))),
      // Menu "Tentang" dihilangkan
    ];

    // Tentukan ukuran berdasarkan lebar layar untuk responsivitas
    final screenWidth = MediaQuery.of(context).size.width;
    // Ukuran item menu (diameter lingkaran ikon dan font) akan lebih besar
    // Kita ingin 2 item per baris, dengan sedikit spasi
    final double itemPadding = 20.0;
    final double circleMenuDiameter = (screenWidth - (itemPadding * 5)) / 2.5; // Diameter lingkaran ikon yang lebih besar
    final double imageIconSize = circleMenuDiameter * 0.65; // Ukuran ikon/gambar di dalam lingkaran
    final double titleFontSize = circleMenuDiameter * 0.15; // Ukuran font judul relatif terhadap lingkaran

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
                  fontSize: 22, // Font AppBar sedikit lebih besar
                  shadows: [
                    Shadow(
                      blurRadius: 1.5,
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(1, 1),
                    ),
                  ]),
            ),
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
            image: AssetImage("assets/images/app_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 92), // Padding atas ditambah
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: kToolbarHeight + 10), // Ruang untuk AppBar transparan
                    Container( // Kontainer Header
                      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0), // Padding vertikal ditambah
                      decoration: BoxDecoration(
                        color: theme.cardColor.withOpacity(0.9), // Opacity disesuaikan
                        borderRadius: BorderRadius.circular(18), // Radius lebih besar
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(children: [
                        const AnimatedHeaderGarudaImage(), // Ukuran sudah disesuaikan di widgetnya
                        const SizedBox(height: 20),
                        Text('Pendidikan Pancasila',
                            style: theme.textTheme.headlineMedium?.copyWith( // Ukuran font lebih besar
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                                shadows: [
                                  Shadow(blurRadius: 1.0, color: Colors.black.withOpacity(0.15), offset: const Offset(0.5,0.5)),
                                ]),
                            textAlign: TextAlign.center),
                        const SizedBox(height: 10),
                        Text(
                            'Yuk, belajar Pancasila dengan seru bersama Sahabat Pancasila!',
                            style: theme.textTheme.titleMedium?.copyWith( // Ukuran font sedikit lebih besar
                                color: (isDark ? Colors.white.withOpacity(0.9) : Colors.black.withOpacity(0.75)),
                                fontSize: 16,
                                height: 1.35,
                                shadows: [
                                  Shadow(blurRadius: 1.0, color: Colors.black.withOpacity(0.1), offset: const Offset(0.5,0.5)),
                                ]),
                            textAlign: TextAlign.center),
                      ]),
                    ),
                    const SizedBox(height: 32), // Jarak ke menu ditambah

                    // --- MENGGUNAKAN GridView UNTUK LAYOUT 2x2 ---
                    GridView.builder(
                      shrinkWrap: true, // Penting di dalam SingleChildScrollView
                      physics: const NeverScrollableScrollPhysics(), // Nonaktifkan scroll GridView
                      padding: EdgeInsets.symmetric(horizontal: itemPadding, vertical: itemPadding),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 kolom
                        crossAxisSpacing: itemPadding, // Spasi antar kolom
                        mainAxisSpacing: itemPadding,   // Spasi antar baris
                        childAspectRatio: 0.85, // Rasio aspek item (lebar/tinggi), sesuaikan agar pas
                      ),
                      itemCount: menuButtons.length,
                      itemBuilder: (context, index) {
                        final item = menuButtons[index];
                        return _buildMenuButton(
                          context,
                          title: item.title,
                          // description: item.description, // Deskripsi tidak ditampilkan
                          imageAssetPath: item.imageAssetPath,
                          iconData: item.iconData,
                          backgroundColor: item.backgroundColor,
                          onTap: item.onTap,
                          circleDiameter: circleMenuDiameter, // Ukuran lingkaran lebih besar
                          imageSize: imageIconSize,           // Ukuran ikon/gambar di dalamnya
                          fontSize: titleFontSize,            // Ukuran font judul
                        );
                      },
                    ),
                    // --- BATAS GridView ---

                    const SizedBox(height: 80), // Ruang ekstra di bawah menu
                  ],
                ),
              ),
              const BouncingMascotImage( // Pastikan maskot tidak menutupi menu secara signifikan
                imagePath: 'assets/images/maskot.png',
                mascotHeight: 60, // Ukuran maskot disesuaikan jika perlu
                mascotWidth: 60,
                funFacts: _pancasilaFunFacts,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

