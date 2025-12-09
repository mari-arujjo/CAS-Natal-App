// Importe os pacotes necessários
import 'package:app_cas_natal/src/course/course_provider.dart';
import 'package:app_cas_natal/widgets/cursos/card_cursos_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CursosPage extends ConsumerWidget { 
  const CursosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(courseProvider);

    return Scaffold(
      appBar: AppBar(toolbarHeight: 30),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: coursesAsync.when(
            loading: () => const Center(child: CarregandoWidget()),
            error: (error, stack) => Center(
              child: Text('Erro ao carregar cursos: $error'),
            ),
            data: (courses) {
              if (courses.isEmpty) {
                return const Center(child: Text('Nenhum curso cadastrado.'));
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: courses.map((course) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CourseCardWidget(
                        course: course, 
                        onPressed: () {
                          context.go('/cursos/detalheCurso/${course.id}');
                        },
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}