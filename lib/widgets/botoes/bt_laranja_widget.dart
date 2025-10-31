import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class BotaoLaranjaWidget extends StatefulWidget {
  final String txt;
  final VoidCallback onPressed;
  final double tam;
  const BotaoLaranjaWidget({
    super.key,
    required this.txt,
    required this.onPressed,
    required this.tam,
  });

  @override
  State<BotaoLaranjaWidget> createState() => _BotaoLaranjaWidgetState();
}

class _BotaoLaranjaWidgetState extends State<BotaoLaranjaWidget> {
  bool pressionado = false;
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: widget.tam,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: cores.laranjaEscuro,
              offset: const Offset(0, 4),
              blurRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),

        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(cores.laranja),
            overlayColor: WidgetStatePropertyAll(cores.laranjaEscuro),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            shadowColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          child: Text(
            widget.txt,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
