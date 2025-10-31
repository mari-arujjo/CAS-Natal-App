import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class BotaoGlossarioWidget extends StatefulWidget {
  final String txt;
  final String txt2;
  final VoidCallback onPressed;
  final double tam;
  final IconData iconInicio;
  const BotaoGlossarioWidget({
    super.key,
    required this.onPressed,
    required this.txt,
    required this.tam,
    required this.iconInicio,
    required this.txt2,
  });

  @override
  State<BotaoGlossarioWidget> createState() => _BotaoGlossarioWidgetState();
}

class _BotaoGlossarioWidgetState extends State<BotaoGlossarioWidget> {
  final cores = Cores();
  bool pressionado = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: widget.tam,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.transparent,
              offset: const Offset(0, 4),
              blurRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            shadowColor: WidgetStatePropertyAll(Colors.transparent),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            overlayColor: WidgetStatePropertyAll(cores.cinzaClaro),

            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ), // margem interna
            ),
          ),
          onPressed: widget.onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: cores.laranja,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.iconInicio,
                      size: 20,
                      color: cores.preto,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.txt,
                    style: TextStyle(color: cores.preto, fontSize: 16),
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.txt2,
                    style: TextStyle(color: cores.laranjaEscuro, fontSize: 12),
                  ),
                ],
              ),

              Icon(Icons.arrow_forward_ios, size: 20, color: cores.preto),
            ],
          ),
        ),
      ),
    );
  }
}
