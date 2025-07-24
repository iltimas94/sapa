import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart'; // Pastikan package sudah ditambahkan

class TanyaPancasilaAiPage extends StatefulWidget {
  const TanyaPancasilaAiPage({super.key});

  @override
  State<TanyaPancasilaAiPage> createState() => _TanyaPancasilaAiPageState();
}

class _TanyaPancasilaAiPageState extends State<TanyaPancasilaAiPage> {
  final TextEditingController _textController = TextEditingController();
  String _searchResult = '';
  bool _isLoading = false;
  GenerativeModel? _model;

  // Ganti dengan API Key Anda atau cara aman untuk mengambilnya
  // PENTING: Jangan hardcode API Key di kode produksi.
  // Gunakan environment variables: flutter run --dart-define=GEMINI_API_KEY=YOUR_API_KEY
  static const String _apiKey = String.fromEnvironment('GEMINI_API_KEY');


  @override
  void initState() {
    super.initState();
    if (_apiKey.isEmpty) {
      print(
          'API Key Gemini tidak ditemukan. Set GEMINI_API_KEY environment variable.');
      // Pertimbangkan untuk menampilkan pesan di UI jika API Key tidak ada
      _searchResult =
      'Konfigurasi AI tidak ditemukan. Fitur ini mungkin tidak berfungsi.';
    } else {
      _model = GenerativeModel(model: 'gemini-pro', apiKey: _apiKey);
    }
  }

  Future<void> _askGemini(String query) async {
    if (_model == null) {
      setState(() {
        _searchResult =
        'Fitur AI tidak tersedia (API Key tidak dikonfigurasi).';
        _isLoading = false;
      });
      return;
    }
    if (query
        .trim()
        .isEmpty) {
      setState(() {
        _searchResult = 'Silakan masukkan pertanyaan Anda.';
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _searchResult = '';
    });

    final String fullPrompt = """
Anda adalah asisten AI yang berpengetahuan luas tentang Pancasila, dasar negara Republik Indonesia.
Tugas Anda adalah menjawab pertanyaan pengguna HANYA jika pertanyaan tersebut berkaitan dengan sila-sila Pancasila, butir-butir pengamalan Pancasila, sejarah Pancasila, atau implementasi nilai-nilai Pancasila.
Berikan jawaban yang jelas, ringkas, dan mudah dipahami.

Jika pertanyaan pengguna di luar topik Pancasila, jawablah dengan sopan:
"Maaf, saat ini saya hanya dapat membantu dengan pertanyaan seputar Pancasila."

Pertanyaan Pengguna: "$query"

Jawaban Anda (terkait Pancasila atau pesan penolakan):
""";

    try {
      final content = [Content.text(fullPrompt)];
      final response = await _model!.generateContent(content);

      setState(() {
        _searchResult =
            response.text ?? 'Tidak ada jawaban atau terjadi kesalahan.';
      });
    } catch (e) {
      setState(() {
        _searchResult =
        'Terjadi kesalahan saat menghubungi AI: ${e.toString()}';
      });
      print('Error calling Gemini API: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tanya AI Pancasila'),
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Ajukan pertanyaan Anda seputar Pancasila kepada Asisten AI kami!',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Contoh: Apa makna sila pertama?',
                labelText: 'Pertanyaan Anda',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: _isLoading
                      ? const SizedBox(width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2.0))
                      : const Icon(Icons.send),
                  onPressed: _isLoading ? null : () {
                    _askGemini(_textController.text);
                    FocusScope.of(context).unfocus(); // Sembunyikan keyboard
                  },
                ),
              ),
              onSubmitted: _isLoading ? null : _askGemini,
              textInputAction: TextInputAction.send,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _isLoading && _searchResult
                  .isEmpty // Hanya tampilkan loading utama jika belum ada hasil
                  ? const Center(child: CircularProgressIndicator())
                  : _searchResult.isNotEmpty
                  ? Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _searchResult,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              )
                  : Center(
                  child: Text(
                    'Jawaban AI akan muncul di sini.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
