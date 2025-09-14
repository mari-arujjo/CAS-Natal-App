import 'package:app_cas_natal/widgets/botoes/bt_laranja_modulo.dart';
import 'package:flutter/material.dart';

class ModuloHistoriaSurdaPage extends StatefulWidget {
  const ModuloHistoriaSurdaPage({super.key});

  @override
  State<ModuloHistoriaSurdaPage> createState() => _ModuloHistoriaSurdaPageState();
}

class _ModuloHistoriaSurdaPageState extends State<ModuloHistoriaSurdaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('História e Cultura Surda')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Este curso apresenta aspectos históricos, sociais e identitários da comunidade surda, com foco na valorização da Libras como primeira língua e no reconhecimento da surdez como diferença, e não deficiência.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 150,
                      height: 170,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/modulos/diversidade.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 40),
                BotaoLaranjaModuloWidget(
                  txt: 'Aula 1: Origens da Comunidade Surda no Brasil',
                  onPressed: (){}
                ),

                SizedBox(height: 20, width: 2, child: Container(color: Color(0xFFCA8B26))),
                BotaoLaranjaModuloWidget(
                  txt: 'Aula 2: Cultura Surda como Cultura Visual',
                  onPressed: (){}
                ),

                SizedBox(height: 20, width: 2, child: Container(color: Color(0xFFCA8B26))),
                BotaoLaranjaModuloWidget(
                  txt: 'Aula 3: Lutas e Conquistas ao Longo da História',
                  onPressed: (){}
                ),

                SizedBox(height: 20, width: 2, child: Container(color: Color(0xFFCA8B26))),
                BotaoLaranjaModuloWidget(
                  txt: 'Aula 4: A Cultura Surda nas Regiões do Brasil',
                  onPressed: (){}
                ),

                SizedBox(height: 20, width: 2, child: Container(color: Color(0xFFCA8B26))),
                BotaoLaranjaModuloWidget(
                  txt: 'Aula 5: A Libras como Patrimônio Linguístico e Cultural',
                  onPressed: (){}
                ),

                SizedBox(height: 20, width: 2, child: Container(color: Color(0xFFCA8B26))),
                BotaoLaranjaModuloWidget(
                  txt: 'Aula 6: Representações da Pessoa Surda',
                  onPressed: (){}
                ),

                SizedBox(height: 20, width: 2, child: Container(color: Color(0xFFCA8B26))),
                BotaoLaranjaModuloWidget(
                  txt: 'Aula 7: Vozes da Comunidade Surda',
                  onPressed: (){}
                ),

                SizedBox(height: 20, width: 2, child: Container(color: Color(0xFFCA8B26))),
                BotaoLaranjaModuloWidget(
                  txt: 'Aula 8: Escolas Bilíngues para Surdos',
                  onPressed: (){}
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}