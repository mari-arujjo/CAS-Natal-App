import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class BotaoIconWidget extends StatefulWidget {
  final Icon icon;
  final VoidCallback? onPressed;
  const BotaoIconWidget({super.key, required this.icon, this.onPressed});

  @override
  State<BotaoIconWidget> createState() => _BotaoIconWidgetState();
}

class _BotaoIconWidgetState extends State<BotaoIconWidget> {
  final cores = Cores();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: widget.icon,
      color: Colors.white,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(cores.laranja),
        overlayColor: WidgetStateProperty.all(cores.laranjaEscuro),
      ),
    );
  }
}
