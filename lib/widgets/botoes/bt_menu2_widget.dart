import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class BotaoMenu2Widget extends StatefulWidget {
  final String txt;
  final String txt2;
  final VoidCallback onPressed;
  final double tam;
  final IconData iconInicio;
  final Color corIcon;
  const BotaoMenu2Widget({
    super.key,
    required this.onPressed,
    required this.txt,
    required this.tam,
    required this.iconInicio,
    required this.txt2,
    required this.corIcon,
  });

  @override
  State<BotaoMenu2Widget> createState() => _BotaoMenu2WidgetState();
}

class _BotaoMenu2WidgetState extends State<BotaoMenu2Widget> {
  final cores = Cores();
  bool pressionado = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: widget.tam,
      child: OutlinedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          side: WidgetStatePropertyAll(
            BorderSide(color: Colors.transparent, width: 1),
          ),
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 0, vertical: 5), // margem interna
          ),
        ),
        onPressed: widget.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(widget.iconInicio, size: 20, color: widget.corIcon),

                SizedBox(width: 10),
                Text(
                  widget.txt,
                  style: TextStyle(color: cores.preto, fontSize: 16),
                ),
              ],
            ),
            Text(
              widget.txt2,
              style: TextStyle(color: cores.laranja, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
