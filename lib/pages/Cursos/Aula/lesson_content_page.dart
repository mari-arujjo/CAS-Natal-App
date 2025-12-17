// ignore_for_file: non_constant_identifier_names
import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/src/lesson/lesson_model.dart';
import 'package:flutter/material.dart';
import 'package:app_cas_natal/widgets/botoes/bt_navegacao_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_cas_natal/src/quiz/quiz_provider.dart';
import 'package:app_cas_natal/src/lesson/lesson_provider.dart';

class LessonContentPage extends ConsumerWidget {
  final LessonModel lesson;

  const LessonContentPage({super.key, required this.lesson});

  String? _findNextLessonId(WidgetRef ref, LessonModel currentLesson) {
    final lessonsAsync = ref.watch(lessonProvider);

    return lessonsAsync.maybeWhen(
      data: (allLessons) {
        final courseLessons = allLessons
            .where((l) => l.courseId == currentLesson.courseId)
            .toList();
        
        courseLessons.sort((a, b) => a.name.compareTo(b.name));
        final currentIndex = courseLessons.indexWhere((l) => l.id == currentLesson.id);
        if (currentIndex != -1 && currentIndex < courseLessons.length - 1) {
          return courseLessons[currentIndex + 1].id;
        }
        return null;
      },
      orElse: () => null,
    );
  }

  void QuizConfirmation(BuildContext context, WidgetRef ref) async {
    final cor = Cores();

    try {
      await ref.read(quizQuestionDetailProvider(lesson.id!).future);
      if (!context.mounted) return;
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('Início do Quiz'),
            content: Text( 'Tem certeza de que deseja prosseguir para o Quiz? Certifique-se de que revisou todo o conteúdo da lição.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text('Cancelar', style: TextStyle(color: cor.azulEscuro)),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text('Prosseguir', style: TextStyle(color: cor.azulEscuro)),
              ),
            ],
          );
        },
      );

      if (confirmed == true && context.mounted) {
        context.go('/cursos/detalheCurso/${lesson.courseId}/quiz/${lesson.id}');
      }

    } catch (e) {
      final errorText = e.toString().toLowerCase();

      if (errorText.contains('falha ao buscar a questão do quiz. status: 404') || 
          errorText.contains('falha ao buscar a questão do quiz')) {
        
        final nextLessonId = _findNextLessonId(ref, lesson);
        
        if (!context.mounted) return;
        
        if (nextLessonId != null) {
          context.go('/cursos/detalheCurso/${lesson.courseId}/video/$nextLessonId');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Quiz não encontrado. Prosseguindo para a próxima lição.')),
          );
        } else {
          context.go('/cursos/detalheCurso/${lesson.courseId}'); 
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro inesperado ao verificar o Quiz: ${e.toString()}')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conteúdo: ${lesson.name}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  lesson.content,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BotaoNavegacaoWidget(
                    txt: 'Anterior',
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      context.go('/cursos/detalheCurso/${lesson.courseId}/video/${lesson.id}');
                    },
                  ),
                  BotaoNavegacaoWidget(
                    txt: 'Próximo',
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () =>  QuizConfirmation(context, ref),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}