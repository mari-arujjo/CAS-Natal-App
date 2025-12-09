import 'package:flutter/material.dart';
import 'package:app_cas_natal/cores.dart';


class ButtonQuadrado extends StatefulWidget {
  final String txt;
  final VoidCallback onPressed;
  final IconData icon;

  const ButtonQuadrado({
    super.key,
    required this.txt,
    required this.onPressed,
    required this.icon,
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
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: Colors.white, size: 40),
              const SizedBox(height: 8),
              Text(
                widget.txt,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
        ),
      )
    );
  }
}
