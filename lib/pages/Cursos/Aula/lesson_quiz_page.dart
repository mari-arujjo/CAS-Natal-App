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

  Widget _buildOptionButton(String optionText) {
    final isSelected = _selectedAnswer == optionText;
    final buttonColor = isSelected ? cor.azulEscuro : cor.azulClaro;
    final textColor = isSelected ? Colors.white : cor.azulEscuro;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
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
            style: TextStyle(
              fontSize: 18,
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

    final String incorrectFeedbackText = _quizQuestion!.feedback;
    final String correctAnswerText = _correctOption!.optionText;

    final feedbackText = _isCorrect
        ? null
        : 'Resposta correta: $correctAnswerText. \n $incorrectFeedbackText';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.all(30),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              icon,
              SizedBox(height: 20),
              if (feedbackText != null)
                Column(
                  children: [
                    Text(
                      feedbackText,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
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
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
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
    final quizAsync = ref.watch(quizQuestionDetailProvider(widget.lesson.id!));
    
    final isVerifyEnabled = _selectedAnswer != null && !_isAnswerChecked;

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: 1.0 / 1.0,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(cor.azulEscuro),
          ),
        ),
        title: Text('${widget.lesson.name}: Atividade'),
        centerTitle: false,
      ),
      body: quizAsync.when(
        loading: () => Center(child: CarregandoWidget()),
        error: (error, stack) => Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Erro ao carregar Quiz: ${error.toString().replaceAll('Exception: ', '')}'),
          ),
        ),
        data: (quizQuestion) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _initializeQuizData(quizQuestion);
          });
          
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.0),
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40),

                      Text(
                        quizQuestion.questionText,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 50),

                      ...quizQuestion.quizOptions.map((option) {
                        return _buildOptionButton(option.optionText);
                      }).toList(),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: isVerifyEnabled ? _checkAnswerAndShowDialog : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cor.laranja,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: cor.laranja.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
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
          );
        },
      ),
    );
  }
}