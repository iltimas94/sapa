import 'package:flutter/material.dart';
import '../models/quiz_question.dart'; // Pastikan path ini benar

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  // Daftar 10 pertanyaan Kuis Pancasila yang disesuaikan dengan materi Search Pancasila
  final List<QuizQuestion> _basicQuestions = [
    const QuizQuestion(
      questionText: 'Bunyi sila pertama Pancasila adalah...',
      options: [
        'Kemanusiaan yang Adil dan Beradab',
        'Persatuan Indonesia',
        'Ketuhanan Yang Maha Esa',
        'Keadilan Sosial bagi Seluruh Rakyat Indonesia'
      ],
      correctAnswerIndex: 2, // Ketuhanan Yang Maha Esa
    ),
    const QuizQuestion(
      questionText: 'Lambang sila kedua Pancasila, yang melambangkan hubungan antarmanusia yang kuat, adalah...',
      options: ['Bintang Tunggal', 'Pohon Beringin', 'Kepala Banteng', 'Rantai Emas'],
      correctAnswerIndex: 3, // Rantai Emas
    ),
    const QuizQuestion(
      questionText: 'Sikap "Mengikuti upacara bendera dengan khidmat" adalah contoh pengamalan sila ke...',
      options: ['Sila ke-1', 'Sila ke-2', 'Sila ke-3', 'Sila ke-4'],
      correctAnswerIndex: 2, // Sila ke-3 (Persatuan Indonesia)
    ),
    const QuizQuestion(
      questionText: 'Menyelesaikan masalah bersama dengan berdiskusi atau musyawarah sesuai dengan sila keempat yang berlambang...',
      options: ['Padi dan Kapas', 'Kepala Banteng', 'Bintang Tunggal', 'Rantai Emas'],
      correctAnswerIndex: 1, // Kepala Banteng
    ),
    const QuizQuestion(
      questionText: 'Padi dan Kapas sebagai lambang sila kelima melambangkan...',
      options: [
        'Kekuatan dan Keberanian',
        'Persatuan dan Kesatuan',
        'Makanan dan Pakaian (Kesejahteraan)',
        'Cahaya Tuhan dan Harapan'
      ],
      correctAnswerIndex: 2, // Makanan dan Pakaian (Kesejahteraan)
    ),
    const QuizQuestion(
      questionText: 'Bekerja bersama-sama membersihkan kelas (piket kelas) adalah contoh dari sikap...',
      options: ['Jujur', 'Disiplin', 'Gotong Royong', 'Menghargai Perbedaan'],
      correctAnswerIndex: 2, // Gotong Royong
    ),
    const QuizQuestion(
      questionText: 'Tidak mengejek teman yang berbeda warna kulit atau bahasa adalah cerminan dari sikap...',
      options: [
        'Cinta Tanah Air',
        'Menghargai Perbedaan Teman',
        'Jujur dan Bertanggung Jawab',
        'Disiplin Waktu'
      ],
      correctAnswerIndex: 1, // Menghargai Perbedaan Teman
    ),
    const QuizQuestion(
      questionText: 'Mengakui kesalahan jika berbuat salah dan tidak menyontek saat ujian adalah contoh sikap...',
      options: ['Gotong Royong', 'Cinta Tanah Air', 'Saling Memaafkan', 'Jujur dan Bertanggung Jawab'],
      correctAnswerIndex: 3, // Jujur dan Bertanggung Jawab
    ),
    const QuizQuestion(
      questionText: 'Lambang "Bendera Merah Putih" sering dikaitkan dengan sikap...',
      options: [
        'Menjaga Kebersihan Lingkungan',
        'Cinta Tanah Air Indonesia',
        'Menghormati Orang yang Lebih Tua',
        'Rajin Belajar'
      ],
      correctAnswerIndex: 1, // Cinta Tanah Air Indonesia
    ),
    const QuizQuestion(
      questionText: 'Datang ke sekolah tepat waktu dan mengerjakan tugas sesuai jadwal adalah contoh dari sikap...',
      options: ['Tidak Mudah Putus Asa', 'Berani Mengakui Kesalahan', 'Disiplin', 'Menjaga Fasilitas Umum'],
      correctAnswerIndex: 2, // Disiplin
    ),
  ];

  List<QuizQuestion> _currentQuestions = [];
  String _quizTitle = 'Kuis Pancasila';

  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;
  bool _answered = false;
  bool _quizStarted = false;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    // Animasi progres diinisialisasi di sini, tetapi akan diupdate nilainya saat kuis dimulai
    _progressAnimation = Tween<double>(begin: 0, end: 0).animate(_progressController);
  }

  void _startQuiz() {
    if (!mounted) return;
    // Mengacak urutan pertanyaan setiap kali kuis dimulai (opsional)
    // List<QuizQuestion> shuffledQuestions = List.from(_basicQuestions)..shuffle();

    setState(() {
      _currentQuestions = List.from(_basicQuestions); // Gunakan _basicQuestions yang sudah diperbarui
      // _currentQuestions = shuffledQuestions; // Jika ingin pertanyaan diacak
      _quizTitle = 'Kuis Pancasila';
      _currentQuestionIndex = 0;
      _score = 0;
      _selectedOptionIndex = null;
      _answered = false;
      _quizStarted = true;
      _progressController.reset();
      _updateProgressAnimation();
    });
  }

  void _updateProgressAnimation() {
    if (_currentQuestions.isEmpty || !_quizStarted) return;
    double progressTarget = (_currentQuestionIndex + 1) / _currentQuestions.length;
    // Pastikan _progressAnimation diinisialisasi ulang jika target berubah
    _progressAnimation = Tween<double>(
      begin: _progressController.value, // Mulai dari nilai progres saat ini
      end: progressTarget,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));
    _progressController.forward(from: 0.0); // Selalu mulai animasi dari awal untuk progres baru
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
            // _progressController.reset(); // Reset sebelum update berikutnya agar animasi berjalan mulus
            _updateProgressAnimation();
          });
        } else {
          // Panggil _updateProgressAnimation sekali lagi untuk memastikan progress bar penuh
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

    double scorePercentage = _currentQuestions.isNotEmpty ? (_score / _currentQuestions.length) : 0.0;

    if (scorePercentage >= 0.8) {
      titleMessage = '🎉 Luar Biasa, Kamu Hebat! 🎉';
      subMessage = 'Pemahamanmu tentang Pancasila sangat baik!';
      maskotImage = 'assets/images/maskot.png';
      titleColor = Colors.green.shade700;
    } else if (scorePercentage >= 0.6) {
      titleMessage = '👍 Bagus, Tingkatkan Lagi! 👍';
      subMessage = 'Sudah cukup baik, teruslah belajar!';
      maskotImage = 'assets/images/happy.png';
      titleColor = Colors.blue.shade700;
    } else {
      titleMessage = '🤔 Coba Lagi Yuk!';
      subMessage = 'Jangan menyerah, ayo pelajari lagi!';
      maskotImage = 'assets/images/maskot_semangat.png';
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
                    horizontal: 30, vertical: 12),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text('COBA LAGI'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (mounted) {
                  setState(() {
                    _quizStarted = false;
                    _currentQuestions = []; // Kosongkan agar _buildStartQuizScreen yang muncul
                    _currentQuestionIndex = 0;
                    _score = 0;
                    _selectedOptionIndex = null;
                    _answered = false;
                    _progressController.reset();
                  });
                }
              },
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(
                    horizontal: 35, vertical: 12),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text('SELESAI'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Color _getOptionColor(int optionIndex) {
    if (!_answered) {
      return Colors.white; // Warna default sebelum menjawab
    }
    if (optionIndex == _currentQuestions[_currentQuestionIndex].correctAnswerIndex) {
      return Colors.green.shade100; // Jawaban benar
    }
    if (optionIndex == _selectedOptionIndex) {
      return Colors.red.shade100; // Jawaban salah yang dipilih
    }
    return Colors.white; // Opsi lain yang tidak dipilih setelah menjawab
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

  Widget _buildStartQuizScreen(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'assets/images/maskot_bertanya.png',
              height: 150,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.quiz_rounded, size: 100, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Text(
              'Selamat Datang di Kuis Pancasila!',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Uji pemahamanmu tentang dasar negara kita.',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Mulai Kuis'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _startQuiz,
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildQuizInterface(BuildContext context) {
    final theme = Theme.of(context);
    if (_currentQuestions.isEmpty || _currentQuestionIndex >= _currentQuestions.length) {
      if (!_quizStarted) {
        return _buildStartQuizScreen(context);
      }
      return const Center(child: Text("Memuat pertanyaan..."));
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
                    'Pertanyaan ${_currentQuestionIndex + 1}/${_currentQuestions.length}:', // Menampilkan jumlah total pertanyaan
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
            'assets/images/maskot_ceria.png',
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
                                  : Colors.black87,
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
        title: Text(!_quizStarted || _currentQuestions.isEmpty
            ? 'Kuis Pancasila'
        // Menampilkan nomor pertanyaan saat ini dan total pertanyaan di AppBar jika kuis sudah dimulai
            : '$_quizTitle (${_currentQuestionIndex + 1}/${_currentQuestions.length})'),
        bottom: _quizStarted && _currentQuestions.isNotEmpty
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
            : null,
      ),
      body: !_quizStarted
          ? _buildStartQuizScreen(context)
          : _buildQuizInterface(context),
    );
  }
}
