import 'package:app_cas_natal/widgets/vizualizacao/card_estatistica_widget.dart';
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
      appBar: AppBar(title: Text('Estatísticas')),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aulas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            CardEstatisticaWidget(
              txt: 'Aulas assistidas',
              dado: '15',
              ico: Icons.play_circle,
            ),
            SizedBox(height: 30),

            Text(
              'Exercícios',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            CardEstatisticaWidget(
              txt: 'Exercícios concluídos',
              dado: '60',
              ico: Icons.book,
            ),
            SizedBox(height: 10),
            CardEstatisticaWidget(
              txt: 'Acertos',
              dado: '45',
              ico: Icons.check_circle,
            ),
            SizedBox(height: 30),

            Text(
              'Notas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            CardEstatisticaWidget(
              txt: 'Média',
              dado: '9,00',
              ico: Icons.bar_chart,
            ),
          ],
        ),
      ),
    );
  }
}
