// File: sample_player.dart (atau di mana pun SamplePlayer didefinisikan)
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'dart:io'; // Diperlukan jika Anda ingin mendukung pemutaran dari file juga

class SamplePlayer extends StatefulWidget {
  final String videoPath;
  final bool isAsset; // Untuk membedakan antara video aset dan file

  const SamplePlayer({
    Key? key,
    required this.videoPath,
    this.isAsset = false, // Default ke false jika tidak ditentukan
  }) : super(key: key);

  @override
  _SamplePlayerState createState() => _SamplePlayerState();
}

class _SamplePlayerState extends State<SamplePlayer> {
  late FlickManager flickManager;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();

    if (widget.isAsset) {
      // Memuat video dari folder assets
      _videoPlayerController = VideoPlayerController.asset('assets/videos/garuda_pancasila.mp4');
    } else if (widget.videoPath.startsWith('https://youtu.be/BoqapEBY29E') || widget.videoPath.startsWith('https://youtu.be/BoqapEBY29E')) {
      // Memuat video dari URL jaringan
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoPath));
    } else {
      // Memuat video dari file storage lokal (jika path bukan URL dan bukan asset)
      // Ini memerlukan izin akses file jika di Android
      _videoPlayerController = VideoPlayerController.file(File(widget.videoPath));
    }

    flickManager = FlickManager(
      videoPlayerController: _videoPlayerController,
      // Tambahkan konfigurasi FlickManager lain di sini jika perlu
      // autoPlay: true,
      // autoInitialize: true,
    );
  }

  @override
  void dispose() {
    flickManager.dispose(); // Ini juga akan men-dispose _videoPlayerController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Menggunakan Scaffold agar ada AppBar dan latar belakang yang benar
      appBar: AppBar(
        title: Text(widget.isAsset ? 'Video dari Aset' : 'Video Player'),
      ),
      body: Center( // Menempatkan video di tengah
        child: FlickVideoPlayer(
          flickManager: flickManager,
          // Anda bisa menambahkan kontrol kustom atau konfigurasi UI lainnya di sini
          // Contoh:
          // flickVideoWithControls: const FlickVideoWithControls(
          //   controls: FlickPortraitControls(),
          // ),
        ),
      ),
    );
  }
}
