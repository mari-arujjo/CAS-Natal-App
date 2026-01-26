import 'package:app_cas_natal/widgets/botoes/bt_laranja_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/container_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_widget.dart';
import 'package:flutter/material.dart';

class RedefinirSenhaPage extends StatefulWidget {
  const RedefinirSenhaPage({super.key});

  @override
  State<RedefinirSenhaPage> createState() => _RedefinirSenhaPageState();
}

class _RedefinirSenhaPageState extends State<RedefinirSenhaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redefinir senha'),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  ContainerWidget(
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Nova senha:', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          InputPadraoWidget(
                            maxLength: 20,
                            readOnly: false,
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Confirmar nova senha:',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          InputPadraoWidget(
                            maxLength: 20,
                            readOnly: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BotaoLaranjaWidget(
                        txt: 'Salvar',
                        onPressed: () {},
                        tam: 140,
                      ),
                      const SizedBox(width: 20),
                      BotaoLaranjaWidget(
                        txt: 'Cancelar',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        tam: 140,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}