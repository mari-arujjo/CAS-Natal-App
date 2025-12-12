import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/widgets/botoes_padrao/bt_lista_widget.dart';
import 'package:app_cas_natal/widgets/botoes_padrao/flutuante_widget.dart';
import 'package:app_cas_natal/widgets/inputs/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GestaoGlossarioPage extends StatefulWidget {
  const GestaoGlossarioPage({super.key});

  @override
  State<GestaoGlossarioPage> createState() => _GestaoGlossarioPageState();
}

class _GestaoGlossarioPageState extends State<GestaoGlossarioPage> {
  final ScrollController scrollController = ScrollController(); // adicionado
  final cor = Cores();

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão do glossário'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SearchBarWidget(),
        ),
      ),

      floatingActionButton: BotaoFlutuanteWidget(
        onPressed: () => context.goNamed('CadastroGlossario'),
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
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              radius: const Radius.circular(10),
              child: ListView.separated(
                controller: scrollController,
                padding: const EdgeInsets.only(right: 15,left: 15,top: 10,bottom: 12),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemCount: 1,
                itemBuilder: (_, index) {
                  return ButtonLista(
                    txt: 'Obrigado - Emoções e comunicação',
                    onPressed: () {
                      context.goNamed('AlterarGlossario');
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