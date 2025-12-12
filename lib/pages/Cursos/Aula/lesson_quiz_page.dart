import 'package:app_cas_natal/src/lesson/lesson_model.dart';
import 'package:flutter/material.dart';

class LessonQuizPage extends StatefulWidget {
  final LessonModel lesson;

  const LessonQuizPage({super.key, required this.lesson});

  @override
  State<LessonQuizPage> createState() => _LessonQuizPageState();
}

class _LessonQuizPageState extends State<LessonQuizPage> {
  String? _selectedAnswer;
  bool _isAnswerChecked = false;
  bool _isCorrect = false;

  final String _question = 'A surdez é sempre uma deficiência?';
  final String _correctAnswer = 'Falso';
  final String _correctFeedback = 'Alternativa correta!';
  final String _incorrectFeedback =
      'Resposta correta: Falso, é uma diferença linguística e cultural na visão socioantropológica.';

  final Cores cor = Cores();

  void _checkAnswerAndShowDialog() {
    if (_selectedAnswer == null) return;

    setState(() {
      _isAnswerChecked = true;
      _isCorrect = _selectedAnswer == _correctAnswer;
    });

    _showResultDialog(context);
  }

  Widget _buildOptionButton(String optionText) {
    final isSelected = _selectedAnswer == optionText;
    final buttonColor = isSelected ? cor.azulEscuro : cor.azulClaro;
    final textColor = isSelected ? Colors.white : cor.azulEscuro;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: _isAnswerChecked
              ? null
              : () {
                  setState(() {
                    _selectedAnswer = optionText;
                  });
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            side: isSelected
                ? BorderSide(color: cor.azulEscuro, width: 2)
                : BorderSide.none,
          ),
          child: Text(
            optionText,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _showResultDialog(BuildContext context) {
    final dialogColor = _isCorrect ? cor.verde : cor.vermelho;
    final icon = _isCorrect
        ? Icon(Icons.check_circle, color: dialogColor, size: 80)
        : Icon(Icons.cancel, color: dialogColor, size: 80);
    final title = _isCorrect ? 'Alternativa correta!' : 'Alternativa incorreta!';
    final feedbackText = _isCorrect ? null : _incorrectFeedback;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(30),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              icon,
              const SizedBox(height: 20),
              if (feedbackText != null)
                Column(
                  children: [
                    const Text(
                      'Resposta correta:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      feedbackText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dialogColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Continuar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final isVerifyEnabled = _selectedAnswer != null && !_isAnswerChecked;

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: 1.0 / 1.0,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(cor.azulEscuro),
          ),
        ),
        title: const Text('Aula 7: Atividade'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recurso interativo',
                    style: TextStyle(color: cor.azulEscuro, fontSize: 16),
                  ),
                  Text(
                    'Quiz Rápido: Verdadeiro/falso',
                    style: TextStyle(
                      color: cor.azulEscuro,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),

                  Text(
                    _question,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 50),

                  _buildOptionButton('Verdadeiro'),
                  _buildOptionButton('Falso'),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: isVerifyEnabled ? _checkAnswerAndShowDialog : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: cor.amarelo,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: cor.amarelo.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Verificar',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Cores {
  final Color azulEscuro = const Color(0xFF0D47A1);
  final Color azulClaro = const Color(0xFFE3F2FD);
  final Color amarelo = const Color(0xFFFFB300);
  final Color verde = const Color(0xFF4CAF50);
  final Color vermelho = const Color(0xFFFF5252);
}