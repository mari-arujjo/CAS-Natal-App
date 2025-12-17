import 'package:app_cas_natal/cores.dart';
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
    final cor = Cores();
    final coursesAsync = ref.watch(courseProvider);

    return Scaffold(
      appBar: AppBar(toolbarHeight: 30),
      body: RefreshIndicator(
        color: cor.laranja,
        backgroundColor: Colors.white,
        onRefresh: () async {
          ref.invalidate(courseProvider);
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: coursesAsync.when(
              loading: () => Padding(
                padding: EdgeInsets.only(top: 100),
                child: Center(child: CarregandoWidget()),
              ),
              error: (error, stack) => Padding(
                padding: EdgeInsets.only(top: 100),
                child: Center(
                  child: Text('Erro ao carregar cursos: $error'),
                ),
              ),
              data: (courses) {
                if (courses.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Center(
                      child: Text('Nenhum curso cadastrado.'),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),

                    Image.asset(
                      'assets/logo_cas_transparente.png',
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                    
                    SizedBox(height: 50),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: courses.map((course) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: CourseCardWidget(
                            course: course,
                            onPressed: () {
                              context.go(
                                '/cursos/detalheCurso/${course.id}',
                              );
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
