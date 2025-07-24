// File: offline_video_player_page.dart
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class SamplePlayer extends StatefulWidget {
  final String videoPath;
  final bool isAsset;

  const SamplePlayer({
    super.key,
    required this.videoPath,
    this.isAsset = false,
  });

  @override
  State<SamplePlayer> createState() => _SamplePlayerState();
}

class _SamplePlayerState extends State<SamplePlayer> {
  late FlickManager flickManager;
  // VideoPlayerController akan dikelola oleh FlickManager karena autoInitialize = true

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
      print("[SamplePlayer] Memuat video dari ASET: ${widget.videoPath}");
      videoPlayerController = VideoPlayerController.asset(widget.videoPath);
    } else if (widget.videoPath.startsWith('http://') || widget.videoPath.startsWith('https://')) {
      print("[SamplePlayer] Memuat video dari URL: ${widget.videoPath}");
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoPath));
    } else {
      print("[SamplePlayer] Memuat video dari FILE: ${widget.videoPath}");
      videoPlayerController = VideoPlayerController.file(File(widget.videoPath));
    }

    // Pasang listener SEBELUM membuat FlickManager dengan autoInitialize: true
    videoPlayerController.addListener(() {
      if (!mounted) return; // Selalu cek mounted di dalam listener async

      final controllerValue = videoPlayerController.value;

      if (controllerValue.hasError) {
        if (_errorMessage == null) { // Hanya set error jika belum ada (mencegah rebuild berlebih)
          print("[SamplePlayer] Error pada VideoPlayerController: ${controllerValue.errorDescription}");
          setState(() {
            _isLoading = false;
            _errorMessage = "Gagal memuat video: ${controllerValue.errorDescription}";
          });
        }
      } else if (controllerValue.isInitialized) {
        if (_isLoading) { // Jika berhasil inisialisasi dan sebelumnya loading
          print("[SamplePlayer] VideoPlayerController terinisialisasi.");
          setState(() {
            _isLoading = false;
            _errorMessage = null; // Pastikan error message di-clear jika berhasil setelah retry
          });
        }
      } else if (!controllerValue.isInitialized && _errorMessage == null) {
        // Jika belum terinisialisasi, belum ada error, dan belum loading
        if (!_isLoading) {
          print("[SamplePlayer] VideoPlayerController sedang memuat (dari listener)...");
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
      // Tidak ada errorCallback di FlickManager, error ditangani via listener controller di atas
    );

    // Initial check (meskipun listener ada, kadang state awal perlu di-set)
    // Jika controller sudah sync isInitialized atau hasError (jarang terjadi untuk video baru)
    if (videoPlayerController.value.isInitialized && _isLoading) {
      print("[SamplePlayer] VideoPlayerController sudah terinisialisasi (pengecekan awal).");
      setState(() {
        _isLoading = false;
      });
    } else if (videoPlayerController.value.hasError && _errorMessage == null) {
      print("[SamplePlayer] Error pada VideoPlayerController (pengecekan awal): ${videoPlayerController.value.errorDescription}");
      setState(() {
        _isLoading = false;
        _errorMessage = "Gagal memuat video: ${videoPlayerController.value.errorDescription}";
      });
    } else if (!videoPlayerController.value.isInitialized && !videoPlayerController.value.hasError && !_isLoading) {
      // Jika belum siap dan tidak error, pastikan _isLoading true
      print("[SamplePlayer] VideoPlayerController sedang memuat (pengecekan awal)...");
      setState(() {
        _isLoading = true;
      });
    }
  }

  void _retryInitialization() {
    print("[SamplePlayer] Mencoba memuat ulang video...");
    if (mounted) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }
    // Penting: Dispose FlickManager lama sebelum membuat yang baru untuk menghindari kebocoran resource
    // dan memastikan controller video baru yang digunakan.
    // flickManager.dispose() akan otomatis men-dispose videoPlayerController yang terkait dengannya.
    flickManager.dispose();
    _initializePlayer(); // Panggil lagi untuk membuat controller dan FlickManager baru
  }

  @override
  void dispose() {
    // FlickManager akan men-dispose VideoPlayerController yang di-pass ke dalamnya.
    // Tidak perlu dispose videoPlayerController secara manual di sini jika sudah di-pass ke FlickManager.
    flickManager.dispose();
    print("[SamplePlayer] FlickManager disposed.");
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
            ? const Column( // Membuat tampilan loading lebih baik
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Memuat video...'),
          ],
        )
            : FlickVideoPlayer(
          flickManager: flickManager,
          // Anda bisa menambahkan UI kustom di sini jika perlu
          // flickVideoWithControls: FlickVideoWithControls(
          //   controls: FlickPortraitControls(),
          //   videoFit: BoxFit.contain,
          // ),
        ),
      ),
    );
  }
}

