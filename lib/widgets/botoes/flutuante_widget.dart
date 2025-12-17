import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class BotaoFlutuanteWidget extends StatefulWidget {
  final VoidCallback onPressed;
  const BotaoFlutuanteWidget({super.key, required this.onPressed});

  @override
  State<BotaoFlutuanteWidget> createState() => _FlutuanteState();
}

class _FlutuanteState extends State<BotaoFlutuanteWidget> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    final cor = Cores();

    return FloatingActionButton.extended(
      foregroundColor: Colors.white,
      backgroundColor: cor.laranja,
      elevation: 2,

      onPressed: () {
        setState(() {
          pressed = true;
        });
        Future.delayed(Duration(milliseconds: 100), () {
          widget.onPressed();
          setState(() {
            pressed = false;
          });
        });
      },

      label: Text('Novo', style: TextStyle(fontWeight: FontWeight.bold),),
      icon: Icon(Icons.add),
    );
  }
}
