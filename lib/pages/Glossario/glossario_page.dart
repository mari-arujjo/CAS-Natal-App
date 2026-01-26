import 'package:app_cas_natal/widgets/botoes/bt_gloss_widget.dart';
import 'package:app_cas_natal/widgets/categorias/bt_categoria1_widget.dart';
import 'package:app_cas_natal/widgets/categorias/bt_categoria2_widget.dart';
import 'package:app_cas_natal/widgets/inputs/search_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_cas_natal/src/sign/sign_provider.dart';
import 'package:go_router/go_router.dart';

class GlossarioPage extends ConsumerWidget {
  const GlossarioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncGlossary = ref.watch(signProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 4,
        shadowColor: const Color.fromARGB(83, 0, 0, 0),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10), 
          child: Column(
            children: [
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: SearchBarWidget(),
                ),
              ), 
              const SizedBox(height: 10),
            ],
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1100), 
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: isDesktop 
                  ? Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: _buildCategories(),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: _buildCategories(withPadding: true)),
                    ),
                ),
                SizedBox(height: 40),

                asyncGlossary.when(
                  loading: () => const Center(child: CarregandoWidget()),
                  error: (err, stack) => Center(child: Text('Erro: $err')),
                  data: (signs) {
                    if (signs.isEmpty) return const Center(child: Text('Nenhum sinal encontrado.'));
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Resultados encontrados: ${signs.length}'),
                        const SizedBox(height: 10),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isDesktop ? 4 : 1,
                            mainAxisExtent: 55,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: signs.length,
                          itemBuilder: (context, index) {
                            final sign = signs[index];
                            return BotaoGlossarioWidget(
                              onPressed: () { 
                                context.goNamed(
                                  'SinalDetalhe',
                                  pathParameters: {'signId': sign.id!},
                                );
                              },
                              txt: sign.name,
                              tam: double.infinity,
                              txt2: sign.description.length > 70
                                  ? '${sign.description.substring(0, 70)}...'
                                  : sign.description,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCategories({bool withPadding = false}) {
    final categorias = [
      {'label': 'Emoções e\nComunicação', 'ico': Icons.chat, 'tipo': 2},
      {'label': 'Sinais\nRegionais', 'ico': Icons.location_on, 'tipo': 1},
      {'label': 'Pessoas e\nProfissões', 'ico': Icons.people, 'tipo': 2},
      {'label': 'Verbos e\nAdjetivos', 'ico': Icons.book, 'tipo': 1},
      {'label': 'Mídia e\nTecnologia', 'ico': Icons.computer, 'tipo': 2},
      {'label': 'Clima e\nNatureza', 'ico': Icons.eco, 'tipo': 1},
    ];

    List<Widget> widgets = categorias.map((cat) {
      return Column(
        children: [
          cat['tipo'] == 1 
            ? BotaoCategoria1Widget(onPressed: () {}, ico: cat['ico'] as IconData)
            : BotaoCategoria2Widget(onPressed: () {}, ico: cat['ico'] as IconData),
          const SizedBox(height: 5),
          Text(
            cat['label'] as String,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      );
    }).toList();

    if (withPadding) {
      return widgets.expand((w) => [w, const SizedBox(width: 20)]).toList();
    }
    return widgets;
  }
}