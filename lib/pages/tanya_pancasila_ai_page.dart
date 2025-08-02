import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TanyaPancasilaAiPage extends StatefulWidget {
  const TanyaPancasilaAiPage({super.key});

  @override
  State<TanyaPancasilaAiPage> createState() => _TanyaPancasilaAiPageState();
}

class _TanyaPancasilaAiPageState extends State<TanyaPancasilaAiPage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _loadError;

  // URL dasar Gemini, tambahkan parameter untuk bahasa Indonesia jika diinginkan
  // Contoh: https://gemini.google.com/?hl=id (untuk bahasa Indonesia)
  final String _geminiWebsiteUrl = 'https://gemini.google.com/app?hl=id';
  // Atau jika Anda ingin langsung ke prompt tertentu:
  // final String _geminiWebsiteUrl = 'https://gemini.google.com/app/new-chat?q=Jelaskan%20tentang%20Pancasila&hl=id';

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000)) // Transparan jika diinginkan
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            // Tidak perlu setState jika tidak ada UI progress bar khusus di sini
            if (progress == 100 && _isLoading && mounted) {
              setState(() {
                _isLoading = false;
                _loadError = null; // Hapus error jika berhasil load
              });
            }
          },
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = true;
                _loadError = null;
              });
            }
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            if (mounted) {
              setState(() {
                _isLoading = false;
                _loadError = "Gagal memuat halaman: ${error.description} (Kode: ${error.errorCode})";
                // Anda bisa lebih spesifik menangani error di sini
                // Misalnya, jika error.errorCode == -2 (host lookup), itu berarti tidak ada internet
                if (error.errorCode == -2 || error.errorCode == -6) { // -2 (NAME_NOT_RESOLVED), -6 (CONNECTION_REFUSED)
                  _loadError = "Tidak dapat terhubung ke server. Pastikan Anda memiliki koneksi internet yang stabil dan coba lagi.";
                }
              });
              print("WebView Error: ${error.description}, Code: ${error.errorCode}, URL: ${error.url}");
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            // Anda bisa membatasi navigasi ke domain tertentu jika perlu
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_geminiWebsiteUrl));
  }

  Future<void> _reloadWebView() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _loadError = null;
      });
    }
    await _controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tanya AI Pancasila'),
        actions: [
          if (!_isLoading && _loadError == null) // Tampilkan tombol refresh hanya jika tidak loading dan tidak ada error
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: _reloadWebView,
              tooltip: 'Muat Ulang',
            ),
        ],
      ),
      body: Stack(
        children: [
          if (_loadError != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/maskot_bingung.png',
                      height: 100,
                      errorBuilder: (ctx, err, st) =>
                      const Icon(Icons.signal_wifi_off_rounded, size: 70, color: Colors.orangeAccent),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Oops! Terjadi Kesalahan',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _loadError!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.red.shade700),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Coba Lagi'),
                      onPressed: _reloadWebView,
                    ),
                  ],
                ),
              ),
            )
          else
          // Hanya tampilkan WebView jika tidak ada error
            WebViewWidget(controller: _controller),

          if (_isLoading)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Memuat AI Asisten...')
                ],
              ),
            ),
        ],
      ),
    );
  }
}
