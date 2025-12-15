import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/src/lesson/lesson_provider.dart';
import 'package:app_cas_natal/widgets/botoes/bt_lista_widget.dart';
import 'package:app_cas_natal/widgets/botoes/flutuante_widget.dart';
import 'package:app_cas_natal/widgets/inputs/search_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GestaoAulaPage extends ConsumerWidget {
  const GestaoAulaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    final cor = Cores();
    final asyncLessons = ref.watch(lessonProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão de aulas'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SearchBarWidget(),
        ),
      ),

      floatingActionButton: BotaoFlutuanteWidget(
        onPressed: () => context.goNamed('CadastroAula'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10,bottom: 20,left: 20,right: 20),
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.only(right: 5, top: 5, bottom: 5),
            decoration: BoxDecoration(
              color: cor.cinzaClaro,
              borderRadius: BorderRadius.circular(10),
            ),

            child: asyncLessons.when(
              loading: () => const Center(child: CarregandoWidget()),
              error: (error, stackTrace) => Center(
                child: Text('Erro ao carregar aulas: $error'),
              ),

              data: (lessons) {
                if(lessons.isEmpty){
                  return const Center(
                    child: Text(
                      'Nenhuma aula cadastrada.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  radius: const Radius.circular(10),
                  child: ListView.separated(
                    controller: scrollController,
                    padding: const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 12),
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemCount: lessons.length,
                    itemBuilder: (_, index) {
                      final lesson = lessons[index];
                      return ButtonLista(
                        txt: '${lesson.lessonCode} - ${lesson.name}',
                        onPressed: () {
                          context.goNamed('AlterarAula', extra: lesson);
                        },
                      );
                    },
                  ),
                );
              } 
            )
          ),
        ),
      ),
    );
  }
}