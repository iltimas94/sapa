import 'package:flutter/material.dart';
import '../../../models/quiz_question.dart'; // Sesuaikan path jika berbeda

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<QuizQuestion> _questions = [
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
      correctAnswerIndex: 1, // Seharusnya index 1 (Menghormati teman yang berbeda suku) atau sesuaikan
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

  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;
  bool _answered = false;

  void _answerQuestion(int selectedIndex) {
    if (_answered) return;
    if (!mounted) return;

    setState(() {
      _selectedOptionIndex = selectedIndex;
      _answered = true;
      if (selectedIndex ==
          _questions[_currentQuestionIndex].correctAnswerIndex) {
        _score++;
      }
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        if (_currentQuestionIndex < _questions.length - 1) {
          setState(() {
            _currentQuestionIndex++;
            _selectedOptionIndex = null;
            _answered = false;
          });
        } else {
          _showResultDialog();
        }
      }
    });
  }

  void _showResultDialog() {
    String maskotImage;
    String titleMessage;
    // Tentukan threshold berdasarkan persentase, misal 60% benar
    double thresholdPercentage = 0.6;
    int correctAnswersToPass = (_questions.length * thresholdPercentage)
        .round();

    if (_score >= correctAnswersToPass) {
      titleMessage = '🎉 Hore, Kamu Hebat! 🎉';
      maskotImage =
      'assets/images/maskot_senang.png'; // Pastikan path asset benar
    } else {
      titleMessage = '🤔 Coba Lagi Yuk!';
      maskotImage =
      'assets/images/maskot_semangat.png'; // Pastikan path asset benar
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          title: Text(
            titleMessage,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _score >= correctAnswersToPass ? Colors.green[700] : Colors
                  .orange[700],
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
                      _score >= correctAnswersToPass ? Icons
                          .sentiment_very_satisfied_rounded : Icons
                          .sentiment_neutral_rounded,
                      size: 80,
                      color: _score >= correctAnswersToPass
                          ? Colors.green
                          : Colors.orange,
                    ),
              ),
              const SizedBox(height: 15),
              Text('Skor Kamu:',
                  style: TextStyle(fontSize: 18, color: Colors.grey[800])),
              const SizedBox(height: 10),
              Text(
                '$_score / ${_questions.length}',
                style: TextStyle(
                    fontSize: 36, fontWeight: FontWeight.bold, color: Theme
                    .of(context)
                    .primaryColor),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme
                    .of(context)
                    .primaryColor,
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 12),
              ),
              child: const Text(
                  'OK', style: TextStyle(fontSize: 16, color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                Navigator
                    .of(context)
                    .pop(); // Kembali ke halaman sebelumnya (HomePage)
              },
            ),
          ],
        );
      },
    );
  }

  Color _getOptionColor(int optionIndex) {
    if (!_answered) return Colors.white; // Warna default sebelum menjawab
    if (optionIndex == _questions[_currentQuestionIndex].correctAnswerIndex)
      return Colors.green.shade100.withOpacity(0.8);
    if (optionIndex == _selectedOptionIndex)
      return Colors.red.shade100.withOpacity(0.8);
    return Colors.white;
  }

  IconData _getOptionIcon(int optionIndex) {
    if (!_answered) return Icons.radio_button_unchecked_rounded;
    if (optionIndex == _questions[_currentQuestionIndex].correctAnswerIndex)
      return Icons.check_circle_rounded;
    if (optionIndex == _selectedOptionIndex) return Icons.cancel_rounded;
    return Icons.radio_button_unchecked_rounded;
  }

  Color _getOptionIconColor(int optionIndex) {
    if (!_answered) return Colors.grey.shade400;
    if (optionIndex == _questions[_currentQuestionIndex].correctAnswerIndex)
      return Colors.green.shade700;
    if (optionIndex == _selectedOptionIndex) return Colors.red.shade700;
    return Colors.grey.shade400;
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
          appBar: AppBar(title: const Text('Kuis Pancasila')),
          body: const Center(child: Text('Tidak ada soal kuis saat ini.')));
    }
    final currentQuestion = _questions[_currentQuestionIndex];
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      appBar: AppBar(
        title: Text('Kuis Seru! (Soal ${_currentQuestionIndex + 1}/${_questions
            .length})'),
        // automaticallyImplyLeading: false, // Biarkan default agar ada tombol back
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/maskot_ceria.png', height: 60,
                      errorBuilder: (context, error,
                          stackTrace) => const SizedBox.shrink()),
                  const SizedBox(width: 10),
                  const Text("Ayo, kamu pasti bisa!", style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  currentQuestion.questionText,
                  style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[850],
                      height: 1.4),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 25),
            ...currentQuestion.options
                .asMap()
                .entries
                .map((entry) {
              int idx = entry.key;
              String optionText = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: InkWell(
                  onTap: () => _answerQuestion(idx),
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: _getOptionColor(idx),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selectedOptionIndex == idx && _answered
                            ? (_getOptionColor(idx) ==
                            Colors.green.shade100.withOpacity(0.8) ? Colors
                            .green.shade400 : Colors.red.shade400)
                            : Colors.grey.shade300,
                        width: 1.5,
                      ),
                      boxShadow: _answered && _selectedOptionIndex == idx
                          ? [
                        BoxShadow(color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2))
                      ]
                          : [],
                    ),
                    child: Row(
                      children: [
                        Icon(_getOptionIcon(idx),
                            color: _getOptionIconColor(idx), size: 26),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            optionText,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: _selectedOptionIndex == idx &&
                                    _answered ? FontWeight.w600 : FontWeight
                                    .normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_questions.length, (index) {
                return Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == _currentQuestionIndex
                        ? Theme
                        .of(context)
                        .primaryColor
                        : (index < _currentQuestionIndex
                        ? Colors.grey[600]
                        : Colors.grey[300]),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
