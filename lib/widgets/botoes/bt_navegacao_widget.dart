import 'package:flutter/material.dart';
import 'package:app_cas_natal/cores.dart';

class BotaoNavegacaoWidget extends StatefulWidget {
  final String txt;
  final VoidCallback onPressed;
  final Icon icon;
  const BotaoNavegacaoWidget({
    super.key,
    required this.txt,
    required this.onPressed,
    required this.icon,
  });

  @override
  State<BotaoNavegacaoWidget> createState() => _BotaoNavegacaoWidgetState();
}

class _BotaoNavegacaoWidgetState extends State<BotaoNavegacaoWidget> {
  bool pressionado = false;
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 120,
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

        child: ElevatedButton.icon(
          onPressed: widget.onPressed,
          icon: widget.icon,
          label: Text(widget.txt),
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            backgroundColor: WidgetStatePropertyAll(cores.laranja),
            overlayColor: WidgetStatePropertyAll(cores.laranjaEscuro),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            shadowColor: WidgetStatePropertyAll(Colors.transparent),
          ),
        ),
      ),
    );
  }
}