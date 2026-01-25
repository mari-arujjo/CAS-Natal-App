// ignore_for_file: non_constant_identifier_names
import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/src/lesson/lesson_model.dart';
import 'package:app_cas_natal/src/quiz/quiz_model.dart';
import 'package:app_cas_natal/src/quiz/quiz_provider.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LessonQuizPage extends ConsumerStatefulWidget {
  final LessonModel lesson;

  const LessonQuizPage({super.key, required this.lesson});

  @override
  ConsumerState<LessonQuizPage> createState() => _LessonQuizPageState();
}

class _LessonQuizPageState extends ConsumerState<LessonQuizPage> {
  String? _selectedAnswer;
  bool _isAnswerChecked = false;
  bool _isCorrect = false;
  QuizQuestionModel? _quizQuestion;
  QuizOptionModel? _correctOption;
  final cor = Cores();

  void _initializeQuizData(QuizQuestionModel question) {
    if (_quizQuestion == null) {
      _quizQuestion = question;
      _correctOption = question.quizOptions.firstWhere(
        (option) => option.isCorrect,
        orElse: () => throw Exception('Opção correta não encontrada para o Quiz.'),
      );
    }
  }

  void _checkAnswerAndShowDialog() {
    if (_selectedAnswer == null || _quizQuestion == null || _correctOption == null) return;

    setState(() {
      _isAnswerChecked = true;
      _isCorrect = _selectedAnswer == _correctOption!.optionText;
    });

    _showResultDialog(context);
  }

  Widget _buildOptionButton(String optionText, bool isWide) {
    final isSelected = _selectedAnswer == optionText;
    final buttonColor = isSelected ? cor.azulEscuro : cor.azulClaro;
    final textColor = isSelected ? Colors.white : cor.azulEscuro;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: isWide ? 70 : 60,
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
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            side: isSelected
                ? BorderSide(color: cor.azulEscuro, width: 2)
                : BorderSide.none,
          ),
          child: Text(
            optionText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isWide ? 20 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _showResultDialog(BuildContext context) {
    if (_quizQuestion == null || _correctOption == null) return;

    final dialogColor = _isCorrect ? Colors.green : Colors.red;
    final icon = _isCorrect
        ? Icon(Icons.check_circle, color: dialogColor, size: 80)
        : Icon(Icons.cancel, color: dialogColor, size: 80);
    final title = _isCorrect ? 'Alternativa correta!' : 'Alternativa incorreta!';

    final feedbackText = _isCorrect
        ? null
        : 'Resposta correta: ${_correctOption!.optionText}. \n ${_quizQuestion!.feedback}';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.all(30),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              icon,
              const SizedBox(height: 20),
              if (feedbackText != null) ...[
                Text(
                  feedbackText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
              ],
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    final courseId = widget.lesson.courseId;
                    if (courseId != null && mounted) {
                      context.go('/cursos/detalheCurso/$courseId');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dialogColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Continuar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
    final quizAsync = ref.watch(quizQuestionDetailProvider(widget.lesson.id!));
    final isVerifyEnabled = _selectedAnswer != null && !_isAnswerChecked;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth > 900;

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: 1.0,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(cor.azulEscuro),
          ),
        ),
        title: Text('${widget.lesson.name}: Atividade'),
      ),
      body: quizAsync.when(
        loading: () => Center(child: CarregandoWidget()),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Erro ao carregar Quiz: ${error.toString()}'),
          ),
        ),
        data: (quizQuestion) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _initializeQuizData(quizQuestion);
          });

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(isWide ? 40.0 : 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recurso interativo',
                            style: TextStyle(color: cor.azulEscuro, fontSize: 16),
                          ),
                          Text(
                            'Quiz Rápido',
                            style: TextStyle(
                              color: cor.azulEscuro,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            quizQuestion.questionText,
                            style: TextStyle(
                              fontSize: isWide ? 28 : 24,
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 40),
                          ...quizQuestion.quizOptions.map((option) {
                            return _buildOptionButton(option.optionText, isWide);
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                  
                  _buildBottomBar(isVerifyEnabled),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomBar(bool isEnabled) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: isEnabled ? _checkAnswerAndShowDialog : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: cor.laranja,
            foregroundColor: Colors.white,
            disabledBackgroundColor: cor.laranja.withOpacity(0.4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text(
            'Verificar Resposta',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}