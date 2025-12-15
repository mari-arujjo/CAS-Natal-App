// glossario_page.dart
import 'package:app_cas_natal/widgets/botoes/bt_gloss_widget.dart';
import 'package:app_cas_natal/widgets/categorias/bt_categoria1_widget.dart';
import 'package:app_cas_natal/widgets/categorias/bt_categoria2_widget.dart';
import 'package:app_cas_natal/widgets/inputs/search_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_cas_natal/src/sign/sign_provider.dart';
import 'package:go_router/go_router.dart'; // Import para navegação

class GlossarioPage extends ConsumerWidget {
  const GlossarioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncGlossary = ref.watch(signProvider);

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10), 
          child: SearchBarWidget(),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BotaoCategoria2Widget(
                          onPressed: () {},
                          ico: Icons.chat,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Emoções e\nComunicação',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),

                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BotaoCategoria1Widget(
                          onPressed: () {},
                          ico: Icons.location_on,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Sinais\nRegionais',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BotaoCategoria2Widget(
                          onPressed: () {},
                          ico: Icons.people,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Pessoas e\nProfissões',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),

                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BotaoCategoria1Widget(
                          onPressed: () {},
                          ico: Icons.book,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Verbos e\nAdjetivos',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BotaoCategoria2Widget(
                          onPressed: () {},
                          ico: Icons.computer,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Mídia e\nTecnologia',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),

                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BotaoCategoria1Widget(onPressed: () {}, ico: Icons.eco),
                        const SizedBox(height: 5),
                        const Text(
                          'Clima e\nNatureza',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),

                    const SizedBox(width: 30),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: asyncGlossary.when(
                  loading: () => const Center(child: CarregandoWidget()),
                  
                  error: (err, stack) => Center(
                      child: Text('Erro ao carregar sinais: $err')),
                      
                  data: (glossaries) {
                    if (glossaries.isEmpty) {
                      return const Center(
                          child: Text('Nenhum sinal encontrado.'));
                    }
                    
                    return Column(
                      children: glossaries.map((sign) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: BotaoGlossarioWidget(
                            onPressed: () {
                              // Navegação para a página de detalhes do sinal
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
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}