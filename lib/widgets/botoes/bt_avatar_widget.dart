import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class BotaoAvatarWidget extends StatefulWidget {
  final VoidCallback onPressed;
  final String img;
  final double tam;
  const BotaoAvatarWidget({
    super.key,
    required this.onPressed,
    required this.tam,
    required this.img,
  });

  @override
  State<BotaoAvatarWidget> createState() => _BotaoAvatarWidgetState();
}

class _BotaoAvatarWidgetState extends State<BotaoAvatarWidget> {
  final cores = Cores();
  bool pressionado = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: widget.tam,
      child: OutlinedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          overlayColor: WidgetStatePropertyAll(cores.azulEscuro),
          side: WidgetStatePropertyAll(
            BorderSide(color: cores.azulEscuro, width: 1),
          ),
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 5, vertical: 5), // margem interna
          ),
          backgroundColor: WidgetStatePropertyAll(cores.azulClaro),
        ),
        onPressed: widget.onPressed,
        child: Image.asset(widget.img, width: 250, height: 200),
      ),
    );
  }
}
