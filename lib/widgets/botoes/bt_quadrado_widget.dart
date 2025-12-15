import 'package:flutter/material.dart';
import 'package:app_cas_natal/cores.dart';


class ButtonQuadrado extends StatefulWidget {
  final String txt;
  final VoidCallback onPressed;

  const ButtonQuadrado({
    super.key,
    required this.txt,
    required this.onPressed,
  });

  @override
  State<ButtonQuadrado> createState() => _ButtonQuadradoState();
}

class _ButtonQuadradoState extends State<ButtonQuadrado> {
  bool pressionado = false;

  @override
  Widget build(BuildContext context) {
    final cor = Cores();

    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: cor.laranjaEscuro,
              offset: const Offset(0, 4),
              blurRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(cor.laranja),
            overlayColor: WidgetStatePropertyAll(cor.laranjaEscuro),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            ),
          ),
          child: Text(
            widget.txt,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        )
      )
    );
  }
}
