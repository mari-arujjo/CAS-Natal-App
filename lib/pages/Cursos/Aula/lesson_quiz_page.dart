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
  late PageController _pageController;
  int _currentIndex = 0;
  String? _selectedAnswer;
  bool _isAnswerChecked = false;
  List<QuizQuestionModel> _allQuestions = [];
  final cor = Cores();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentIndex < _allQuestions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _isAnswerChecked = false;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      final courseId = widget.lesson.courseId;
      if (courseId != null) {
        context.go('/cursos/detalheCurso/$courseId');
      }
    }
  }

  void _checkAnswerAndShowDialog() {
    if (_selectedAnswer == null) return;

    final currentQuestion = _allQuestions[_currentIndex];
    final correctOption = currentQuestion.quizOptions.firstWhere(
      (option) => option.isCorrect,
      orElse: () => currentQuestion.quizOptions.first,
    );

    final isCorrect = _selectedAnswer == correctOption.optionText;

    setState(() {
      _isAnswerChecked = true;
    });

    _showResultDialog(context, isCorrect, correctOption, currentQuestion);
  }

  void _showResultDialog(BuildContext context, bool isCorrect, QuizOptionModel correctOption, QuizQuestionModel question) {
    final dialogColor = isCorrect ? Colors.green : Colors.red;
    final icon = isCorrect
        ? Icon(Icons.check_circle, color: dialogColor, size: 80)
        : Icon(Icons.cancel, color: dialogColor, size: 80);
    
    final title = isCorrect ? 'Alternativa correta!' : 'Alternativa incorreta!';
    final feedbackText = isCorrect
        ? null
        : 'Resposta correta: ${correctOption.optionText}. \n\n ${question.feedback}';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.all(30),
          content: ConstrainedBox(
            // Define o limite de largura aqui
            constraints: const BoxConstraints(maxWidth: 500), 
            child: Column(
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
                      _nextStep();
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
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizAsync = ref.watch(quizQuestionDetailProvider(widget.lesson.id!));
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth > 900;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.lesson.name}: Atividade'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: LinearProgressIndicator(
            value: _allQuestions.isEmpty ? 0 : (_currentIndex + 1) / _allQuestions.length,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(cor.azulEscuro),
            minHeight: 6,
          ),
        ),
      ),
      body: quizAsync.when(
        loading: () => Center(child: CarregandoWidget()),
        error: (error, stack) => Center(child: Text('Erro ao carregar Quiz: $error')),
        data: (questions) {
          if (_allQuestions.isEmpty && questions.isNotEmpty) {
            _allQuestions = questions;
          }

          if (_allQuestions.isEmpty) {
            return const Center(child: Text('Nenhuma questão disponível para esta aula.'));
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _allQuestions.length,
                      itemBuilder: (context, index) {
                        final question = _allQuestions[index];
                        return _buildQuestionContent(question, isWide);
                      },
                    ),
                  ),
                  _buildBottomBar(_selectedAnswer != null && !_isAnswerChecked),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuestionContent(QuizQuestionModel question, bool isWide) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isWide ? 40.0 : 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Questão ${_currentIndex + 1} de ${_allQuestions.length}',
            style: TextStyle(color: cor.azulEscuro, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            question.questionText,
            style: TextStyle(
              fontSize: isWide ? 28 : 24,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 40),
          ...question.quizOptions.map((option) {
            final isSelected = _selectedAnswer == option.optionText;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: isWide ? 70 : 60,
                child: ElevatedButton(
                  onPressed: _isAnswerChecked 
                    ? null 
                    : () => setState(() => _selectedAnswer = option.optionText),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? cor.azulEscuro : cor.azulClaro,
                    foregroundColor: isSelected ? Colors.white : cor.azulEscuro,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: isSelected ? BorderSide(color: cor.azulEscuro, width: 2) : BorderSide.none,
                    elevation: 0,
                  ),
                  child: Text(
                    option.optionText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: isWide ? 20 : 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          })
        ],
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