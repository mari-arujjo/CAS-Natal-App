import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/widgets/botoes/bt_lista_widget.dart';
import 'package:app_cas_natal/widgets/botoes/flutuante_widget.dart';
import 'package:app_cas_natal/widgets/inputs/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GestaoUsersPage extends StatefulWidget {
  const GestaoUsersPage({super.key});

  @override
  State<GestaoUsersPage> createState() => _GestaoUsersPageState();
}

class _GestaoUsersPageState extends State<GestaoUsersPage> {
  final ScrollController scrollController = ScrollController(); // adicionado
  final cor = Cores();

  @override
  Widget build(BuildContext context) {
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
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              radius: Radius.circular(10),
              child: ListView.separated(
                controller: scrollController,
                padding: EdgeInsets.only(right: 15,left: 15,top: 10,bottom: 12),
                separatorBuilder: (_, __) => SizedBox(height: 12),
                itemCount: 1,
                itemBuilder: (_, index) {
                  return ButtonLista(
                    txt: '@marujo - Mariana Araújo Silva',
                    onPressed: () {
                      context.goNamed('AlterarUser');
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
