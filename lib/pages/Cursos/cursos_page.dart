import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/src/course/course_provider.dart';
import 'package:app_cas_natal/widgets/cursos/card_cursos_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CursosPage extends ConsumerWidget {
  const CursosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cor = Cores();
    final coursesAsync = ref.watch(courseProvider);
    final double larguraTela = MediaQuery.of(context).size.width;
    final int colunas = larguraTela > 900 ? 3 : 1;

    return Scaffold(
      appBar: AppBar(toolbarHeight: 30),
      body: RefreshIndicator(
        color: cor.laranja,
        backgroundColor: Colors.white,
        onRefresh: () async {
          ref.invalidate(courseProvider);
        },
        child: coursesAsync.when(
          loading: () => const Center(child: CarregandoWidget()),
          error: (error, stack) => Center(
            child: Text('Erro ao carregar cursos: $error'),
          ),
          data: (courses) {
            if (courses.isEmpty) {
              return const Center(
                child: Text('Nenhum curso cadastrado.'),
              );
            }

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    MasonryGridView.count(
                      crossAxisCount: colunas,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index];
                        return CourseCardWidget(
                          course: course,
                          onPressed: () {
                            context.go('/cursos/detalheCurso/${course.id}');
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}