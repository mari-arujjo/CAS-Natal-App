import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class CarregandoWidget extends StatefulWidget {
  const CarregandoWidget({super.key});

  @override
  State<CarregandoWidget> createState() => _CarregandoWidgetState();
}

class _CarregandoWidgetState extends State<CarregandoWidget> {
  @override
  Widget build(BuildContext context) {
    final cor = Cores();

    return CircularProgressIndicator(color: cor.azulEscuro);
  }
}
