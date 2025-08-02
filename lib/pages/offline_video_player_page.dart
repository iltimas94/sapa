// File: lib/pages/offline_video_player_page.dart
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'dart:io'; // Hanya diperlukan jika memuat dari file non-asset

class OfflineVideoPlayerPage extends StatefulWidget { // Nama class diubah
  final String videoPath;
  final bool isAsset;

  const OfflineVideoPlayerPage({ // Konstruktor diubah
    super.key,
    required this.videoPath,
    this.isAsset = false,
  });

  @override
  State<OfflineVideoPlayerPage> createState() => _OfflineVideoPlayerPageState(); // State diubah
}

class _OfflineVideoPlayerPageState extends State<OfflineVideoPlayerPage> { // State diubah
  late FlickManager flickManager;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    VideoPlayerController videoPlayerController;

    if (widget.isAsset) {
      print("[OfflineVideoPlayerPage] Memuat video dari ASET: ${widget.videoPath}");
      videoPlayerController = VideoPlayerController.asset(widget.videoPath);
    } else if (widget.videoPath.startsWith('http://') || widget.videoPath.startsWith('https://')) {
      print("[OfflineVideoPlayerPage] Memuat video dari URL: ${widget.videoPath}");
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoPath));
    } else {
      print("[OfflineVideoPlayerPage] Memuat video dari FILE: ${widget.videoPath}");
      videoPlayerController = VideoPlayerController.file(File(widget.videoPath));
    }

    videoPlayerController.addListener(() {
      if (!mounted) return;

      final controllerValue = videoPlayerController.value;

      if (controllerValue.hasError) {
        if (_errorMessage == null) {
          print("[OfflineVideoPlayerPage] Error pada VideoPlayerController: ${controllerValue.errorDescription}");
          setState(() {
            _isLoading = false;
            _errorMessage = "Gagal memuat video: ${controllerValue.errorDescription}";
          });
        }
      } else if (controllerValue.isInitialized) {
        if (_isLoading) {
          print("[OfflineVideoPlayerPage] VideoPlayerController terinisialisasi.");
          setState(() {
            _isLoading = false;
            _errorMessage = null;
          });
        }
      } else if (!controllerValue.isInitialized && _errorMessage == null) {
        if (!_isLoading) {
          print("[OfflineVideoPlayerPage] VideoPlayerController sedang memuat (dari listener)...");
          setState(() {
            _isLoading = true;
          });
        }
      }
    });

    flickManager = FlickManager(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      autoInitialize: true,
    );

    if (videoPlayerController.value.isInitialized && _isLoading) {
      print("[OfflineVideoPlayerPage] VideoPlayerController sudah terinisialisasi (pengecekan awal).");
      if(mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } else if (videoPlayerController.value.hasError && _errorMessage == null) {
      print("[OfflineVideoPlayerPage] Error pada VideoPlayerController (pengecekan awal): ${videoPlayerController.value.errorDescription}");
      if(mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = "Gagal memuat video: ${videoPlayerController.value.errorDescription}";
        });
      }
    } else if (!videoPlayerController.value.isInitialized && !videoPlayerController.value.hasError && !_isLoading) {
      print("[OfflineVideoPlayerPage] VideoPlayerController sedang memuat (pengecekan awal)...");
      if(mounted) {
        setState(() {
          _isLoading = true;
        });
      }
    }
  }

  void _retryInitialization() {
    print("[OfflineVideoPlayerPage] Mencoba memuat ulang video...");
    if (mounted) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }
    flickManager.dispose();
    _initializePlayer();
  }

  @override
  void dispose() {
    flickManager.dispose();
    print("[OfflineVideoPlayerPage] FlickManager disposed.");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isAsset ? 'Video Lagu Nasional' : 'Video Player'),
      ),
      body: Center(
        child: _errorMessage != null
            ? Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 20),
              Text(
                'Oops! Terjadi Masalah',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                _errorMessage!,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.red.shade700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
                onPressed: _retryInitialization,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
              )
            ],
          ),
        )
            : _isLoading
            ? const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Memuat video...'),
          ],
        )
            : FlickVideoPlayer(
          flickManager: flickManager,
          flickVideoWithControls: const FlickVideoWithControls(
            videoFit: BoxFit.contain, // Agar video tidak terpotong
            controls: FlickPortraitControls(), // Kontrol standar untuk portrait
          ),
          flickVideoWithControlsFullscreen: const FlickVideoWithControls(
            videoFit: BoxFit.contain,
            controls: FlickLandscapeControls(), // Kontrol untuk mode landscape/fullscreen
          ),
        ),
      ),
    );
  }
}
