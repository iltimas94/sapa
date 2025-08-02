import 'package:flutter/material.dart';
import '../models/quiz_question.dart'; // Pastikan path ini benar

// Enum untuk merepresentasikan mode kuis
enum QuizMode { none, basic, advanced }

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  // Daftar pertanyaan untuk Kuis Biasa
  final List<QuizQuestion> _basicQuestions = [
    const QuizQuestion(
      questionText: 'Apa bunyi sila pertama Pancasila?',
      options: [
        'Kemanusiaan yang Adil dan Beradab',
        'Ketuhanan Yang Maha Esa',
        'Persatuan Indonesia',
        'Keadilan Sosial bagi Seluruh Rakyat Indonesia'
      ],
      correctAnswerIndex: 1,
    ),
    const QuizQuestion(
      questionText: 'Lambang sila kedua Pancasila adalah...',
      options: ['Bintang', 'Rantai Emas', 'Pohon Beringin', 'Padi dan Kapas'],
      correctAnswerIndex: 1,
    ),
    const QuizQuestion(
      questionText: 'Sikap yang sesuai dengan sila ketiga Pancasila adalah...',
      options: [
        'Rajin beribadah',
        'Menghormati teman yang berbeda suku',
        'Suka menolong korban bencana',
        'Bermusyawarah memilih ketua kelas'
      ],
      correctAnswerIndex: 1,
    ),
    const QuizQuestion(
      questionText: 'Berapa jumlah sila dalam Pancasila?',
      options: ['3', '4', '5', '6'],
      correctAnswerIndex: 2,
    ),
    const QuizQuestion(
      questionText: 'Hari lahir Pancasila diperingati setiap tanggal...',
      options: ['17 Agustus', '1 Juni', '2 Mei', '28 Oktober'],
      correctAnswerIndex: 1,
    ),
  ];

  // Daftar pertanyaan untuk Kuis Lanjutan (buatlah pertanyaan yang lebih sulit)
  final List<QuizQuestion> _advancedQuestions = [
    const QuizQuestion(
      questionText: 'Siapakah tokoh yang pertama kali mengusulkan nama "Pancasila" dalam sidang BPUPKI?',
      options: ['Mohammad Yamin', 'Soepomo', 'Soekarno', 'Sutan Sjahrir'],
      correctAnswerIndex: 2,
    ),
    const QuizQuestion(
      questionText: 'Dalam Piagam Jakarta, sila pertama berbunyi "Ketuhanan dengan kewajiban menjalankan syariat Islam bagi pemeluk-pemeluknya". Kapan dan mengapa sila ini diubah?',
      options: [
        '17 Agustus 1945, atas usul golongan nasionalis',
        '18 Agustus 1945, demi persatuan nasional setelah konsultasi dengan tokoh Indonesia Timur',
        '22 Juni 1945, saat perumusan Piagam Jakarta itu sendiri',
        '1 Juni 1945, saat pidato Soekarno'
      ],
      correctAnswerIndex: 1,
    ),
    const QuizQuestion(
      questionText: 'Tap MPR manakah yang mencabut Tap MPR No. II/MPR/1978 tentang P4 (Pedoman Penghayatan dan Pengamalan Pancasila)?',
      options: ['Tap MPR No. XVIII/MPR/1998', 'Tap MPR No. II/MPR/1999', 'Tap MPR No. VI/MPR/2000', 'Tap MPR No. I/MPR/2003'],
      correctAnswerIndex: 0,
    ),
    const QuizQuestion(
      questionText: 'Jumlah bulu pada masing-masing sayap Garuda Pancasila melambangkan...',
      options: ['Tanggal proklamasi kemerdekaan (17)', 'Bulan proklamasi kemerdekaan (8)', 'Tahun proklamasi kemerdekaan (45)', 'Jumlah sila Pancasila (5)'],
      correctAnswerIndex: 0,
    ),
    const QuizQuestion(
      questionText: 'Pancasila sebagai "Philosophische Grondslag" berarti Pancasila sebagai...',
      options: ['Dasar negara yang dinamis', 'Pandangan hidup bangsa', 'Filsafat dasar negara', 'Perjanjian luhur bangsa'],
      correctAnswerIndex: 2,
    ),
  ];

  List<QuizQuestion> _currentQuestions = []; // Akan diisi berdasarkan mode
  QuizMode _quizMode = QuizMode.none; // Mode kuis saat ini
  String _quizTitle = 'Kuis Pancasila';

  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    // _updateProgressAnimation akan dipanggil setelah mode dipilih
  }

  void _selectQuizMode(QuizMode mode) {
    if (!mounted) return;
    setState(() {
      _quizMode = mode;
      if (mode == QuizMode.basic) {
        _currentQuestions = _basicQuestions;
        _quizTitle = 'Kuis Pancasila (Biasa)';
      } else if (mode == QuizMode.advanced) {
        _currentQuestions = _advancedQuestions;
        _quizTitle = 'Kuis Pancasila (Lanjutan)';
      }
      // Reset state kuis jika ada
      _currentQuestionIndex = 0;
      _score = 0;
      _selectedOptionIndex = null;
      _answered = false;
      _progressController.reset(); // Reset progress bar
      _updateProgressAnimation(); // Mulai animasi progress bar
    });
  }

  void _updateProgressAnimation() {
    if (_currentQuestions.isEmpty) return; // Jangan update jika belum ada pertanyaan
    double progressTarget = (_currentQuestionIndex + 1) / _currentQuestions.length;
    _progressAnimation = Tween<double>(
      begin: _progressController.value,
      end: progressTarget,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));
    _progressController.forward(from: 0.0);
  }

  void _answerQuestion(int selectedIndex) {
    if (_answered) return;
    if (!mounted) return;

    setState(() {
      _selectedOptionIndex = selectedIndex;
      _answered = true;
      if (selectedIndex ==
          _currentQuestions[_currentQuestionIndex].correctAnswerIndex) {
        _score++;
      }
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        if (_currentQuestionIndex < _currentQuestions.length - 1) {
          setState(() {
            _currentQuestionIndex++;
            _selectedOptionIndex = null;
            _answered = false;
            _updateProgressAnimation();
          });
        } else {
          _updateProgressAnimation();
          _showResultDialog();
        }
      }
    });
  }

  void _showResultDialog() {
    String maskotImage;
    String titleMessage;
    String subMessage;
    Color titleColor;

    double scorePercentage = _currentQuestions.isNotEmpty ? _score / _currentQuestions.length : 0.0;

    if (scorePercentage >= 0.8) {
      titleMessage = '🎉 Luar Biasa, Kamu Hebat! 🎉';
      subMessage = 'Pemahamanmu tentang Pancasila sangat baik!';
      maskotImage = 'assets/images/maskot_ceria.png'; // Pastikan path benar
      titleColor = Colors.green.shade700;
    } else if (scorePercentage >= 0.6) {
      titleMessage = '👍 Bagus, Tingkatkan Lagi! 👍';
      subMessage = 'Sudah cukup baik, teruslah belajar!';
      maskotImage = 'assets/images/happy.png'; // Pastikan path benar
      titleColor = Colors.blue.shade700;
    } else {
      titleMessage = '🤔 Coba Lagi Yuk!';
      subMessage = 'Jangan menyerah, ayo pelajari lagi!';
      maskotImage = 'assets/images/maskot_semangat.png'; // Pastikan path benar
      titleColor = Colors.orange.shade700;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
          actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          title: Text(
            titleMessage,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: titleColor,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                maskotImage,
                height: 100,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(
                      _score >= (_currentQuestions.length * 0.6).round() ? Icons
                          .sentiment_very_satisfied_rounded : Icons
                          .sentiment_neutral_rounded,
                      size: 80,
                      color: titleColor,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                subMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),
              Text('Skor Kamu:',
                  style: TextStyle(fontSize: 18, color: Colors.grey[850], fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Text(
                '$_score / ${_currentQuestions.length}',
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(dialogContext).primaryColor),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(dialogContext).primaryColor,
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 12), // Sedikit disesuaikan
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text('COBA LAGI'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Tutup dialog
                // Kembali ke pemilihan mode
                if (mounted) {
                  setState(() {
                    _quizMode = QuizMode.none;
                    _currentQuestions = [];
                    _currentQuestionIndex = 0;
                    _score = 0;
                    _selectedOptionIndex = null;
                    _answered = false;
                    _progressController.reset();
                  });
                }
              },
            ),
            const SizedBox(width: 8), // Jarak antara tombol
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300], // Warna berbeda untuk Selesai
                foregroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(
                    horizontal: 35, vertical: 12),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text('SELESAI'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Tutup dialog
                Navigator.of(context).pop(); // Kembali ke halaman sebelumnya (HomePage)
              },
            ),
          ],
        );
      },
    );
  }

  Color _getOptionColor(int optionIndex) {
    if (!_answered) {
      return Colors.white;
    }
    if (optionIndex == _currentQuestions[_currentQuestionIndex].correctAnswerIndex) {
      return Colors.green.shade100;
    }
    if (optionIndex == _selectedOptionIndex) {
      return Colors.red.shade100;
    }
    return Colors.white;
  }

  Border? _getOptionBorder(int optionIndex) {
    if (!_answered) {
      return Border.all(color: Colors.grey.shade300);
    }
    if (optionIndex == _currentQuestions[_currentQuestionIndex].correctAnswerIndex) {
      return Border.all(color: Colors.green.shade400, width: 2);
    }
    if (optionIndex == _selectedOptionIndex) {
      return Border.all(color: Colors.red.shade400, width: 2);
    }
    return Border.all(color: Colors.grey.shade300);
  }

  Icon? _getOptionIcon(int optionIndex) {
    if (!_answered) {
      return null;
    }
    if (optionIndex == _currentQuestions[_currentQuestionIndex].correctAnswerIndex) {
      return Icon(Icons.check_circle_outline_rounded, color: Colors.green.shade700);
    }
    if (optionIndex == _selectedOptionIndex) {
      return Icon(Icons.highlight_off_rounded, color: Colors.red.shade700);
    }
    return null;
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  Widget _buildQuizModeSelection(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'assets/images/maskot_bertanya.png', // Ganti dengan gambar maskot yang relevan
              height: 150,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.quiz_rounded, size: 100, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Text(
              'Pilih Tingkat Kesulitan Kuis',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.school_outlined),
              label: const Text('Kuis Biasa'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => _selectQuizMode(QuizMode.basic),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.star_outline_rounded),
              label: const Text('Kuis Lanjutan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.secondary,
                foregroundColor: theme.colorScheme.onSecondary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => _selectQuizMode(QuizMode.advanced),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizInterface(BuildContext context) {
    final theme = Theme.of(context);
    if (_currentQuestions.isEmpty) {
      // Ini seharusnya tidak terjadi jika _quizMode bukan none,
      // tapi sebagai fallback.
      return const Center(child: Text("Memuat kuis..."));
    }
    final currentQuestion = _currentQuestions[_currentQuestionIndex];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Pertanyaan ${_currentQuestionIndex + 1}:',
                    style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    currentQuestion.questionText,
                    style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w500, height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          Image.asset(
            // Ganti gambar maskot sesuai kebutuhan, mungkin berdasarkan jenis pertanyaan atau kesulitan
            _quizMode == QuizMode.advanced ? 'assets/images/maskot_berpikir.png' : 'assets/images/maskot_ceria.png',
            height: 100,
            errorBuilder: (context, error, stackTrace) =>
            const SizedBox(height: 100),
          ),
          const SizedBox(height: 24.0),
          Text(
            'Pilih Jawaban:',
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12.0),
          ...List.generate(currentQuestion.options.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: InkWell(
                onTap: _answered ? null : () => _answerQuestion(index),
                borderRadius: BorderRadius.circular(10.0),
                child: Ink(
                  decoration: BoxDecoration(
                    color: _getOptionColor(index),
                    borderRadius: BorderRadius.circular(10.0),
                    border: _getOptionBorder(index),
                    boxShadow: _answered
                        ? []
                        : [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          currentQuestion.options[index],
                          style: theme.textTheme.bodyLarge?.copyWith(
                              color: _answered &&
                                  _selectedOptionIndex == index &&
                                  index != currentQuestion.correctAnswerIndex
                                  ? Colors.red.shade900
                                  : _answered && index == currentQuestion.correctAnswerIndex
                                  ? Colors.green.shade900
                                  : Colors.black87, // Atau theme.textTheme.bodyLarge?.color
                              fontSize: 16
                          ),
                        ),
                      ),
                      if (_getOptionIcon(index) != null) ...[
                        const SizedBox(width: 10),
                        _getOptionIcon(index)!,
                      ]
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 30),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_quizMode == QuizMode.none ? 'Pilih Kuis' : '$_quizTitle (${_currentQuestionIndex + 1}/${_currentQuestions.length})'),
        bottom: _quizMode != QuizMode.none && _currentQuestions.isNotEmpty
            ? PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: _progressAnimation.value,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
              );
            },
          ),
        )
            : null, // Tidak ada progress bar jika belum memilih mode
      ),
      body: _quizMode == QuizMode.none
          ? _buildQuizModeSelection(context)
          : _buildQuizInterface(context),
    );
  }
}
