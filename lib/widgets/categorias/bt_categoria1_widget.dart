import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class BotaoCategoria1Widget extends StatefulWidget {
  final IconData ico;
  final VoidCallback onPressed;
  const BotaoCategoria1Widget({
    super.key,
    required this.onPressed,
    required this.ico,
  });

  @override
  State<BotaoCategoria1Widget> createState() => _BotaoCategoria1WidgetState();
}

class _BotaoCategoria1WidgetState extends State<BotaoCategoria1Widget> {
  bool pressionado = false;
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      width: 65,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: cores.laranjaEscuro,
              offset: Offset(0, 4),
              blurRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(100),
        ),

        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
            backgroundColor: WidgetStatePropertyAll(cores.laranja),
            overlayColor: WidgetStatePropertyAll(cores.laranjaEscuro),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            ),
          ),
          child: Icon(widget.ico, size: 30, color: cores.preto),
        ),
      ),
    );
  }
}
