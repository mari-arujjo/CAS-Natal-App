import 'package:app_cas_natal/cores.dart';
//import 'package:app_cas_natal/widgets/botoes/bt_avatar_widget.dart';
import 'package:app_cas_natal/widgets/botoes/bt_menu2_widget.dart';
import 'package:flutter/material.dart';

class PreferenciasPage extends StatefulWidget {
  const PreferenciasPage({super.key});

  @override
  State<PreferenciasPage> createState() => _PreferenciasPageState();
}

class _PreferenciasPageState extends State<PreferenciasPage> {
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Preferências')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personalização da leitura',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              BotaoMenu2Widget(
                onPressed: () {},
                txt: 'Fonte',
                tam: 350,
                iconInicio: Icons.font_download,
                txt2: 'Inter',
                corIcon: cores.preto,
              ),
              BotaoMenu2Widget(
                onPressed: () {},
                txt: 'Tamanho da fonte',
                tam: 350,
                iconInicio: Icons.font_download,
                txt2: '14',
                corIcon: cores.preto,
              ),
              BotaoMenu2Widget(
                onPressed: () {},
                txt: 'Cor da página',
                tam: 350,
                iconInicio: Icons.color_lens,
                txt2: 'Branco',
                corIcon: cores.preto,
              ),

              SizedBox(height: 30),

              /*Text(
                'Tela inicial',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              BotaoMenu2Widget(
                onPressed: () {},
                txt: 'Exibição de estatísticas',
                tam: 350,
                iconInicio: Icons.bar_chart,
                txt2: 'ok',
                corIcon: cores.preto,
              ),

              SizedBox(height: 30),

              Text(
                'Avatar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BotaoAvatarWidget(
                    onPressed: () {},
                    tam: 168,
                    img: 'lib/assets/menina.png',
                  ),
                  SizedBox(width: 15),
                  BotaoAvatarWidget(
                    onPressed: () {},
                    tam: 168,
                    img: 'lib/assets/menino.png',
                  ),
                ],
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
