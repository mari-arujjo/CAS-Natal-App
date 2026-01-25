import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class BotaoLaranjaModuloWidget extends StatefulWidget {
  final String txt;
  final VoidCallback onPressed;
  const BotaoLaranjaModuloWidget({
    super.key,
    required this.txt,
    required this.onPressed,
  });

  @override
  State<BotaoLaranjaModuloWidget> createState() =>
      _BotaoLaranjaModuloWidgetState();
}

class _BotaoLaranjaModuloWidgetState extends State<BotaoLaranjaModuloWidget> {
  bool pressionado = false;
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: cores.laranjaEscuro,
              offset: Offset(0, 4),
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
          ),
          child: Text(
            widget.txt,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
