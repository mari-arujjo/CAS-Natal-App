import 'package:app_cas_natal/widgets/estatistica/card_estatistica_widget.dart';
import 'package:flutter/material.dart';

class EstatisticasPage extends StatefulWidget {
  const EstatisticasPage({super.key});

  @override
  State<EstatisticasPage> createState() => _EstatisticasPageState();
}

class _EstatisticasPageState extends State<EstatisticasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estatísticas'),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Aulas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const CardEstatisticaWidget(
                  txt: 'Aulas assistidas',
                  dado: '15',
                  ico: Icons.play_circle,
                ),
                const SizedBox(height: 30),

                const Text(
                  'Exercícios',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const CardEstatisticaWidget(
                  txt: 'Exercícios concluídos',
                  dado: '60',
                  ico: Icons.book,
                ),
                const SizedBox(height: 10),
                const CardEstatisticaWidget(
                  txt: 'Acertos',
                  dado: '45',
                  ico: Icons.check_circle,
                ),
                const SizedBox(height: 30),

                const Text(
                  'Notas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const CardEstatisticaWidget(
                  txt: 'Média',
                  dado: '9,00',
                  ico: Icons.bar_chart,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}