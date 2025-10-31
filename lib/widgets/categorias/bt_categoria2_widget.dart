import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class BotaoCategoria2Widget extends StatefulWidget {
  final IconData ico;
  final VoidCallback onPressed;
  const BotaoCategoria2Widget({
    super.key,
    required this.onPressed,
    required this.ico,
  });

  @override
  State<BotaoCategoria2Widget> createState() => _BotaoCategoria2WidgetState();
}

class _BotaoCategoria2WidgetState extends State<BotaoCategoria2Widget> {
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
              color: cores.azulEscuro,
              offset: const Offset(0, 4),
              blurRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(100),
        ),

        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
            backgroundColor: WidgetStatePropertyAll(cores.azulClaro3),
            overlayColor: WidgetStatePropertyAll(cores.azulEscuro),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            ),
            shadowColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          child: Icon(widget.ico, size: 30, color: cores.preto),
        ),
      ),
    );
  }
}
