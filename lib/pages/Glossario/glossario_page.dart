import 'package:app_cas_natal/widgets/botoes/bt_gloss_widget.dart';
import 'package:app_cas_natal/widgets/categorias/bt_categoria1_widget.dart';
import 'package:app_cas_natal/widgets/categorias/bt_categoria2_widget.dart';
import 'package:app_cas_natal/widgets/inputs/search_widget.dart';
import 'package:flutter/material.dart';

class GlossarioPage extends StatefulWidget {
  const GlossarioPage({super.key});

  @override
  State<GlossarioPage> createState() => _GlossarioPageState();
}

class _GlossarioPageState extends State<GlossarioPage> {
  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    BotaoGlossarioWidget(
                      onPressed: () {},
                      txt: 'Obrigado',
                      tam: 350,
                      iconInicio: Icons.chat,
                      txt2: 'Saudação utilizada pap...',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
