import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TanyaPancasilaAiPage extends StatefulWidget {
  const TanyaPancasilaAiPage({super.key});

  @override
  State<TanyaPancasilaAiPage> createState() => _TanyaPancasilaAiPageState();
}

class _TanyaPancasilaAiPageState extends State<TanyaPancasilaAiPage> {
  late final WebViewController _controller;
  bool _isLoadingPage = true;
  String _errorMessage = '';

  // URL website Gemini yang ingin ditampilkan
  final String _geminiWebsiteUrl = 'https://gemini.google.com/app';
  // Pertimbangkan untuk menambahkan parameter bahasa jika perlu, misal:
  // final String _geminiWebsiteUrl = 'https://gemini.google.com/app?hl=id';

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Izinkan JavaScript
      ..setBackgroundColor(const Color(0x00000000)) // Transparan jika perlu, atau warna lain
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            // Anda bisa menambahkan indikator progres kustom di sini
            print('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                _isLoadingPage = true;
                _errorMessage = ''; // Reset error message
              });
            }
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _isLoadingPage = false;
              });
            }
            print('Page finished loading: $url');
            // Anda bisa mencoba menyuntikkan JavaScript di sini jika perlu
            // _controller.runJavaScript('document.body.style.backgroundColor = "red";');
          },
          onWebResourceError: (WebResourceError error) {
            if (mounted) {
              setState(() {
                _isLoadingPage = false;
                _errorMessage = '''
Page could not be loaded.
Error code: ${error.errorCode}
Description: ${error.description}
URL: ${error.url ?? 'N/A'}
''';
              });
            }
            print('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
  url: ${error.url}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            // Anda bisa memblokir navigasi ke URL tertentu jika perlu
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   print('blocking navigation to $request}');
            //   return NavigationDecision.prevent;
            // }
            print('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_geminiWebsiteUrl)); // Muat URL awal
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asisten AI Gemini'), // Judul lebih relevan
        backgroundColor: theme.colorScheme.primaryContainer,
        actions: [
          // Tombol Refresh untuk WebView
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller.reload();
            },
          ),
          // Tombol untuk kembali dan maju dalam histori WebView (opsional)
          // IconButton(
          //   icon: const Icon(Icons.arrow_back_ios_new), // Ikon yang lebih modern
          //   tooltip: 'Kembali',
          //   onPressed: () async {
          //     if (await _controller.canGoBack()) {
          //       await _controller.goBack();
          //     } else {
          //       if (mounted) {
          //         ScaffoldMessenger.of(context).showSnackBar(
          //           const SnackBar(content: Text('Tidak ada halaman sebelumnya')),
          //         );
          //       }
          //     }
          //   },
          // ),
          // IconButton(
          //   icon: const Icon(Icons.arrow_forward_ios),
          //   tooltip: 'Maju',
          //   onPressed: () async {
          //     if (await _controller.canGoForward()) {
          //       await _controller.goForward();
          //     } else {
          //        if (mounted) {
          //         ScaffoldMessenger.of(context).showSnackBar(
          //           const SnackBar(content: Text('Tidak ada halaman selanjutnya')),
          //         );
          //       }
          //     }
          //   },
          // ),
        ],
      ),
      body: Stack(
        children: [
          if (_errorMessage.isNotEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 50),
                    const SizedBox(height: 16),
                    Text(
                      'Gagal Memuat Halaman',
                      style: theme.textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _errorMessage,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isLoadingPage = true; // Set loading agar indikator muncul
                          _errorMessage = '';
                        });
                        _controller.loadRequest(Uri.parse(_geminiWebsiteUrl)); // Coba muat ulang
                      },
                      child: const Text('Coba Lagi'),
                    )
                  ],
                ),
              ),
            )
          else
            WebViewWidget(controller: _controller), // Widget WebView utama
          if (_isLoadingPage && _errorMessage.isEmpty)
            const Center(
              child: CircularProgressIndicator(), // Indikator loading
            ),
        ],
      ),
    );
  }
}
