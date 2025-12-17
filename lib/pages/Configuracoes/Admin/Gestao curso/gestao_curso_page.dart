import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/widgets/botoes/bt_lista_widget.dart';
import 'package:app_cas_natal/widgets/botoes/flutuante_widget.dart';
import 'package:app_cas_natal/widgets/inputs/search_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_cas_natal/src/course/course_provider.dart'; 

class GestaoCursoPage extends ConsumerWidget {
  const GestaoCursoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    final cor = Cores();
    final asyncCourses = ref.watch(courseProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gestão de cursos'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SearchBarWidget(),
        ),
      ),

      floatingActionButton: BotaoFlutuanteWidget(
        onPressed: () => context.goNamed('CadastroCurso'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
          child: Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              color: cor.cinzaClaro,
              borderRadius: BorderRadius.circular(10),
            ),
            
            child: asyncCourses.when(
              loading: () => Center(child: CarregandoWidget()),
              error: (error, stackTrace) => Center(
                child: Text('Erro ao carregar cursos: $error'),
              ),
              
              data: (courses) {
                if (courses.isEmpty) {
                  return Center(
                    child: Text(
                      'Nenhum curso cadastrado.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  radius: Radius.circular(10),
                  child: ListView.separated(
                    controller: scrollController,
                    padding: EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 12),
                    separatorBuilder: (_, __) => SizedBox(height: 12),
                    itemCount: courses.length,
                    itemBuilder: (_, index) {
                      final course = courses[index];
                      return ButtonLista(
                        txt: '${course.courseCode} - ${course.name}',
                        onPressed: () {
                          context.goNamed('AlterarCurso', extra: course);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}