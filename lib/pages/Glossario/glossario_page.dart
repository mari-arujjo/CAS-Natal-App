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

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10), 
          child: SearchBarWidget(),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BotaoCategoria2Widget(
                          onPressed: () {},
                          ico: Icons.chat,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Emoções e\nComunicação',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),

                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BotaoCategoria1Widget(
                          onPressed: () {},
                          ico: Icons.location_on,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Sinais\nRegionais',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BotaoCategoria2Widget(
                          onPressed: () {},
                          ico: Icons.people,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Pessoas e\nProfissões',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BotaoCategoria1Widget(
                          onPressed: () {},
                          ico: Icons.book,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Verbos e\nAdjetivos',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BotaoCategoria2Widget(
                          onPressed: () {},
                          ico: Icons.computer,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Mídia e\nTecnologia',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BotaoCategoria1Widget(onPressed: () {}, ico: Icons.eco),
                        SizedBox(height: 5),
                        Text(
                          'Clima e\nNatureza',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    
                    SizedBox(width: 30),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20),
                child: asyncGlossary.when(
                  loading: () => Center(child: CarregandoWidget()),
                  
                  error: (err, stack) => Center(
                      child: Text('Erro ao carregar sinais: $err')),
                      
                  data: (glossaries) {
                    if (glossaries.isEmpty) return Center(child: Text('Nenhum sinal encontrado.'));
                    
                    return Column(
                      children: glossaries.map((sign) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: BotaoGlossarioWidget(
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