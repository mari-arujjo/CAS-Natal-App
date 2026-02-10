import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/src/appuser/appuser_provider.dart';
import 'package:app_cas_natal/widgets/botoes/bt_lista_widget.dart';
import 'package:app_cas_natal/widgets/botoes/flutuante_widget.dart';
import 'package:app_cas_natal/widgets/inputs/search_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GestaoUsersPage extends ConsumerWidget {
  const GestaoUsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    final cor = Cores();
    final asyncUsers = ref.watch(appUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gestão de usuários'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SearchBarWidget(),
        ),
      ),

      floatingActionButton: BotaoFlutuanteWidget(
        onPressed: () => context.goNamed('CadastroUser'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 10,bottom: 20,left: 20,right: 20),
          child: Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(right: 5, top: 5, bottom: 5),
            decoration: BoxDecoration(
              color: cor.cinzaClaro,
              borderRadius: BorderRadius.circular(10),
            ),

            child: asyncUsers.when(
              loading: () => Center(child: CarregandoWidget()),
              error: (error, stackTrace) => Center(
                child: Text('Erro ao carregar usuários: $error'),
              ),
              data: (users) {
                if (users.isEmpty){
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
                    padding: EdgeInsets.only(right: 15,left: 15,top: 10,bottom: 12),
                    separatorBuilder: (_, __) => SizedBox(height: 12),
                    itemCount: 1,
                    itemBuilder: (_, index) {
                      final user = users[index];
                      return ButtonLista(
                        txt: '@${user.userName} - ${user.fullName}',
                        onPressed: () {
                          context.goNamed('AlterarUser', pathParameters: {'userId': user.id!});
                        },
                      );
                    },
                  ),
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
