import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'dart:io'; // Untuk Platform.isIOS

// --- MODEL UNTUK INFORMASI VIDEO (TETAP DIPERLUKAN UNTUK JUDUL DAN THUMBNAIL) ---
class AssetVideoInfo {
  final String title;
  final String assetPath;
  final String? thumbnailAsset;

  const AssetVideoInfo({
    required this.title,
    required this.assetPath,
    this.thumbnailAsset,
  });
}
// --- BATAS MODEL VIDEOINFO ---

// --- DAFTAR LAGU NASIONAL DARI ASET ---
final List<AssetVideoInfo> _assetNationalSongs = [
  const AssetVideoInfo(
    title: 'Garuda Pancasila',
    assetPath: 'assets/videos/garuda_pancasila.mp4',
    thumbnailAsset: 'assets/images/thumbnail_garuda_pancasila.png', // GANTI JIKA PERLU
  ),
  const AssetVideoInfo(
    title: 'Indonesia Raya',
    assetPath: 'assets/videos/indonesia_raya.mp4',
    thumbnailAsset: 'assets/images/thumbnail_indonesia_raya.png', // GANTI JIKA PERLU
  ),
  const AssetVideoInfo(
    title: 'Hari Merdeka (17 Agustus)',
    assetPath: 'assets/videos/hari_merdeka.mp4',
    thumbnailAsset: 'assets/images/thumbnail_hari_merdeka.png', // GANTI JIKA PERLU
  ),
];
// --- BATAS DAFTAR LAGU NASIONAL ---

class OfflineVideoPlayerPage extends StatefulWidget {
  const OfflineVideoPlayerPage({super.key});

  @override
  State<OfflineVideoPlayerPage> createState() => _OfflineVideoPlayerPageState();
}

class _OfflineVideoPlayerPageState extends State<OfflineVideoPlayerPage> {
  FlickManager? _flickManager;
  AssetVideoInfo? _selectedVideo; // Menggunakan AssetVideoInfo

  bool _isLoadingPlayer = false;
  String? _playerErrorMessage;

  @override
  void dispose() {
    _flickManager?.dispose();
    print("[VideoPlayerPage] FlickManager disposed on page dispose.");
    super.dispose();
  }

  void _initializePlayerForVideo(AssetVideoInfo video) {
    if (!mounted) return;

    _flickManager?.dispose();
    _flickManager = null;

    setState(() {
      _selectedVideo = video;
      _isLoadingPlayer = true;
      _playerErrorMessage = null;
    });

    print("[VideoPlayerPage] Loading video from ASSET: ${video.assetPath}");
    final videoPlayerController = VideoPlayerController.asset(video.assetPath);

    videoPlayerController.addListener(() {
      if (!mounted) return;
      final controllerValue = videoPlayerController.value;

      if (controllerValue.hasError) {
        if (_playerErrorMessage == null) {
          print("[VideoPlayerPage] VideoPlayerController error: ${controllerValue.errorDescription}");
          if (mounted) {
            setState(() {
              _isLoadingPlayer = false;
              _playerErrorMessage = "Gagal memuat video: ${controllerValue.errorDescription ?? 'Kesalahan tidak diketahui'}";
            });
          }
        }
      } else if (controllerValue.isInitialized) {
        if (_isLoadingPlayer) {
          print("[VideoPlayerPage] VideoPlayerController initialized.");
          if (mounted) {
            setState(() {
              _isLoadingPlayer = false;
              _playerErrorMessage = null;
            });
          }
        }
      }
    });

    _flickManager = FlickManager(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      autoInitialize: true,
    );

    // Pengecekan awal
    if (videoPlayerController.value.isInitialized && _isLoadingPlayer) {
      if (mounted) setState(() => _isLoadingPlayer = false);
    } else if (videoPlayerController.value.hasError && _playerErrorMessage == null) {
      if (mounted) {
        setState(() {
          _isLoadingPlayer = false;
          _playerErrorMessage = "Gagal memuat video awal: ${videoPlayerController.value.errorDescription ?? 'Kesalahan tidak diketahui'}";
        });
      }
    }
  }

  void _retryInitialization() {
    if (_selectedVideo != null) {
      print("[VideoPlayerPage] Retrying to load video: ${_selectedVideo!.title}");
      _initializePlayerForVideo(_selectedVideo!);
    } else {
      _clearSelectedVideo();
    }
  }

  void _clearSelectedVideo() {
    _flickManager?.dispose();
    _flickManager = null;
    if (mounted) {
      setState(() {
        _selectedVideo = null;
        _playerErrorMessage = null;
        _isLoadingPlayer = false;
      });
    }
  }

  Widget _buildVideoPlayerScreen(BuildContext context) {
    final theme = Theme.of(context);

    if (_playerErrorMessage != null) {
      return _buildErrorWidget(theme, _playerErrorMessage!);
    }
    if (_isLoadingPlayer) {
      return _buildLoadingWidget(theme, _selectedVideo?.title ?? 'Lagu');
    }
    if (_flickManager != null) {
      return FlickVideoPlayer(
        flickManager: _flickManager!,
        flickVideoWithControls: const FlickVideoWithControls(
          videoFit: BoxFit.contain,
          controls: FlickPortraitControls(),
        ),
        flickVideoWithControlsFullscreen: const FlickVideoWithControls(
          videoFit: BoxFit.contain,
          controls: FlickLandscapeControls(),
        ),
      );
    }
    // Fallback jika terjadi kondisi tidak terduga
    WidgetsBinding.instance.addPostFrameCallback((_) => _clearSelectedVideo());
    return const Center(child: Text("Silakan pilih video."));
  }

  Widget _buildVideoSelectionScreen(BuildContext context) {
    final theme = Theme.of(context);

    if (_assetNationalSongs.isEmpty) {
      return _buildEmptyStateWidget(theme);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      itemCount: _assetNationalSongs.length,
      itemBuilder: (context, index) {
        final video = _assetNationalSongs[index];
        bool hasThumbnail = video.thumbnailAsset != null && video.thumbnailAsset!.isNotEmpty;

        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            borderRadius: BorderRadius.circular(12.0),
            onTap: () => _initializePlayerForVideo(video),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 60,
                    margin: const EdgeInsets.only(right: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: hasThumbnail ? Colors.transparent : Colors.grey.shade200,
                      image: hasThumbnail
                          ? DecorationImage(
                        image: AssetImage(video.thumbnailAsset!),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {
                          print("Error loading thumbnail: ${video.thumbnailAsset} - $exception");
                        },
                      )
                          : null,
                    ),
                    child: !hasThumbnail
                        ? Center(child: Icon(Icons.music_video_rounded, size: 30, color: theme.colorScheme.primary.withOpacity(0.8)))
                        : null,
                  ),
                  Expanded(
                    child: Text(
                      video.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.play_circle_fill_rounded, color: theme.colorScheme.primary, size: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyStateWidget(ThemeData theme) {
    // ... (fungsi ini bisa tetap sama atau disederhanakan jika Anda yakin daftar tidak akan pernah kosong)
    // Untuk saat ini, saya biarkan sama untuk menangani kasus jika daftar _assetNationalSongs dikosongkan secara tidak sengaja.
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/maskot_bingung.png', height: 100),
            const SizedBox(height: 20),
            Text(
              'Oops! Belum Ada Video Lagu',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Daftar lagu nasional belum tersedia saat ini.',
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingWidget(ThemeData theme, String videoTitle) {
    // ... (fungsi ini tetap sama)
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Sedang memuat video "$videoTitle"...',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(ThemeData theme, String errorMessage) {
    // ... (fungsi ini tetap sama)
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/maskot_sedih.png',
              height: 100,
              errorBuilder: (ctx, err, st) => const Icon(Icons.error_outline_rounded, color: Colors.red, size: 70),
            ),
            const SizedBox(height: 20),
            Text(
              'Oops! Video Gagal Dimuat',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              errorMessage,
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.red.shade700, height: 1.4),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('COBA LAGI'),
              onPressed: _retryInitialization,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                textStyle: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedVideo == null ? 'Pilih Lagu Nasional' : _selectedVideo!.title),
        leading: _selectedVideo != null
            ? IconButton(
          icon: Icon(Platform.isIOS ? Icons.arrow_back_ios_new_rounded : Icons.arrow_back_rounded),
          tooltip: 'Kembali ke Daftar Lagu',
          onPressed: _clearSelectedVideo,
        )
            : null,
      ),
      body: _selectedVideo == null
          ? _buildVideoSelectionScreen(context)
          : _buildVideoPlayerScreen(context),
    );
  }
}
