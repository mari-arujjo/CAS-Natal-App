import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/widgets/modulos/historia_cultura_card_widget.dart';
import 'package:app_cas_natal/widgets/modulos/letramento_card_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/card_menor_estatistica_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo!'),
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed('Configuracoes');
            },
            icon: Icon(Icons.settings, size: 30),
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(cores.azulClaro),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Image.asset(
                  'lib/assets/images/logo_cas_transparente.png',
                  width: 150,
                  height: 100,
                ),
                SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Módulos em andamento',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    CardModuloLetramentoWidget(onPressed: () {}),
                    SizedBox(height: 10),
                    CardModuloHistoriaCulturaWidget(onPressed: () {context.goNamed('HistoriaECulturaSurda');}),

                    SizedBox(height: 30),
                    Text(
                      'Estatísticas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: CardMenorEstatisticaWidget(
                            txt: 'Aulas assistidas',
                            dado: '15',
                            ico: Icons.play_circle,
                            cor: cores.cinzaClaro,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: CardMenorEstatisticaWidget(
                            txt: 'Média',
                            dado: '9,00',
                            ico: Icons.bar_chart,
                            cor: cores.azulClaro2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: CardMenorEstatisticaWidget(
                            txt: 'Exerc. concluídos',
                            dado: '60',
                            ico: Icons.book,
                            cor: cores.azulClaro2,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: CardMenorEstatisticaWidget(
                            txt: 'Acertos',
                            dado: '45',
                            ico: Icons.check_circle,
                            cor: cores.cinzaClaro,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
