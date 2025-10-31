import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/widgets/botoes/bt_icon_widget.dart';
import 'package:app_cas_natal/widgets/botoes/bt_laranja_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/container_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/foto.dart';
import 'package:flutter/material.dart';

class EditarPerfilPage extends StatefulWidget {
  const EditarPerfilPage({super.key});

  @override
  State<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('@mari.arujjo')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    FotoWidget(tam: 60),
                    BotaoIconWidget(icon: Icon(Icons.edit)),
                  ],
                ),
                SizedBox(height: 20),
                ContainerWidget(
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nome:', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 5),
                        InputPadraoWidget(
                          maxLength: 50,
                          hintText: 'Mariana Araújo Silva',
                        ),

                        Text('Usuário:', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 5),
                        InputPadraoWidget(
                          maxLength: 20,
                          hintText: 'mari.arujjo',
                        ),

                        Text('Email:', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 5),
                        InputPadraoWidget(
                          maxLength: 150,
                          hintText: 'mariana.araujo@email.com',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BotaoLaranjaWidget(
                      txt: 'Salvar',
                      onPressed: () {},
                      tam: 120,
                    ),
                    SizedBox(width: 20),
                    BotaoLaranjaWidget(
                      txt: 'Cancelar',
                      onPressed: () {},
                      tam: 120,
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
