// lesson_content_page.dart
import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/src/lesson/lesson_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LessonContentPage extends StatelessWidget {
  final LessonModel lesson;

  const LessonContentPage({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final cor = Cores();
    return Scaffold(
      appBar: AppBar(
        title: Text('Conteúdo: ${lesson.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  lesson.content,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      context.go('/cursos/detalheCurso/${lesson.courseId}/video/${lesson.id}');
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Anterior'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cor.azulEscuro,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.go('/cursos/detalheCurso/${lesson.courseId}/quiz/${lesson.id}');
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Próximo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cor.azulEscuro,
                      foregroundColor: Colors.white,
                    ),
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