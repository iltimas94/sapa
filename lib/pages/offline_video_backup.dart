import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart' show kDebugMode; // Untuk debugPrint

class OfflineVideoPlayerPage extends StatefulWidget {
  final String videoPath;
  final bool isAsset;

  const OfflineVideoPlayerPage({
    super.key,
    required this.videoPath,
    this.isAsset = false,
  });

  @override
  State<OfflineVideoPlayerPage> createState() => _OfflineVideoPlayerPageState();
}


class _OfflineVideoPlayerPageState extends State<OfflineVideoPlayerPage> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isInitialized = false;
  bool _hasError = false;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    // Initialize a dummy controller first to avoid late initialization error
    // This is a temporary measure for debugging, the real initialization is in _initializeVideoPlayer
    if (widget.isAsset) {
      _controller = VideoPlayerController.asset(widget.videoPath);
    } else {
      _controller = VideoPlayerController.file(File(widget.videoPath));
    }
    _initializeVideoPlayer(); // Then call the async initialization
  }

  Future<void> _initializeVideoPlayer() async {
    // Reset state untuk kasus coba lagi
    if (!mounted) return;
    setState(() {
      _isInitialized = false;
      _hasError = false;
      _errorMessage = "";
      _isPlaying = false;
    });

    try {
      // **TITIK POTENSI ERROR ADA DI SINI ATAU SEBELUMNYA**
      if (widget.isAsset) {
        _controller = VideoPlayerController.asset(widget.videoPath);
      } else {
        _controller = VideoPlayerController.file(File(widget.videoPath));
      }

      // Jika baris di atas sudah memicu error, .initialize() tidak akan tercapai
      await _controller.initialize();
      await _controller.setLooping(false);

      if (!mounted) return;
      setState(() {
        _isInitialized = true;
        _hasError = false;
        _isPlaying = _controller.value.isPlaying;
      });

      _controller.addListener(_videoPlayerListener);

    } catch (e, stackTrace) { // Tambahkan stackTrace untuk debug
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = "Gagal memuat video: ${e.toString()}";
          _isInitialized = false;
        });
        _showErrorSnackBar(_errorMessage);
        if (kDebugMode) {
          print("Error initializing video player: $e");
          print("StackTrace: $stackTrace"); // Cetak stack trace
        }
      }
    }
  }

  void _videoPlayerListener() {
    if (!mounted || !_controller.value.isInitialized) return;

    if (_controller.value.hasError && !_hasError) {
      setState(() {
        _hasError = true;
        _errorMessage = _controller.value.errorDescription ??
            "Terjadi kesalahan saat memutar video.";
        _isInitialized = false; // Video tidak lagi terinisialisasi dengan benar
      });
      _showErrorSnackBar(_errorMessage);
    } else if (!_controller.value.hasError && _hasError) {
      // Jika error teratasi (misalnya, setelah coba lagi dan berhasil)
      setState(() {
        _hasError = false;
        _errorMessage = "";
      });
    }


    if (_isPlaying != _controller.value.isPlaying) {
      setState(() {
        _isPlaying = _controller.value.isPlaying;
      });
    }

    // Handle video selesai
    if (_isInitialized &&
        !_controller.value.isPlaying &&
        _controller.value.position >= _controller.value.duration &&
        _controller.value.duration > Duration.zero &&
        !_controller.value.isLooping) { // Cek juga isLooping di sini
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Video selesai diputar!")),
        );
        setState(() {
          _isPlaying = false; // Pastikan tombol play/pause update
        });
      }
    }
  }


  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger
          .of(context)
          .removeCurrentSnackBar(); // Hapus snackbar sebelumnya jika ada
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void _togglePlayPause() {
    if (!_isInitialized || _hasError || !_controller.value.isInitialized)
      return;
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        if (_controller.value.position >= _controller.value.duration &&
            !_controller.value.isLooping) {
          _controller.seekTo(Duration.zero).then((_) {
            if (mounted && _controller.value.isInitialized) _controller.play();
          });
        } else {
          _controller.play();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_videoPlayerListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Video Player"), // Judul bisa disesuaikan atau di-pass sebagai parameter
      ),
      body: Center(
        child: _hasError
            ? Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 50),
              const SizedBox(height: 10),
              Text(
                _errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _initializeVideoPlayer,
                child: const Text('Coba Lagi'),
              )
            ],
          ),
        )
            : _isInitialized && _controller.value.isInitialized
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
            VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              colors: const VideoProgressColors(
                playedColor: Colors.amber, // Sesuaikan dengan tema Anda
                bufferedColor: Colors.grey,
                backgroundColor: Colors.black26,
              ),
            ),
            IconButton(
              icon: Icon(
                _controller.value.isPlaying
                    ? Icons.pause_circle_filled_rounded
                    : Icons.play_circle_filled_rounded,
                size: 50,
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
              onPressed: _togglePlayPause,
            ),
          ],
        )
            : const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Memuat video..."),
          ],
        ),
      ),
    );
  }
}
