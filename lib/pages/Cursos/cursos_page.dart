import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/src/course/course_provider.dart';
import 'package:app_cas_natal/widgets/cursos/card_cursos_widget.dart';
import 'package:app_cas_natal/widgets/inputs/search_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CursosPage extends ConsumerWidget {
  const CursosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cor = Cores();
    final coursesAsync = ref.watch(courseProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 4,
        shadowColor: Color.fromARGB(83, 0, 0, 0),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10), 
          child: Column(children: [SearchBarWidget(), SizedBox(height: 10,)],)
        ),
      ),

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
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Resultados encontrados: ${courses.length}'),
                    SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isDesktop ? 3 : 1,
                        mainAxisExtent: 180,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
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