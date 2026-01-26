import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class BotaoCategoria1Widget extends StatefulWidget {
  final IconData ico;
  final VoidCallback onPressed;
  const BotaoCategoria1Widget({
    super.key,
    required this.onPressed,
    required this.ico,
  });

  @override
  State<BotaoCategoria1Widget> createState() => _BotaoCategoria1WidgetState();
}

class _BotaoCategoria1WidgetState extends State<BotaoCategoria1Widget> {
  bool _isHovered = false;
  bool _isPressed = false;
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    double offsetDeslocamento = 0;
    double offsetSombra = 5;

    if (_isPressed) {
      offsetDeslocamento = 4;
      offsetSombra = 1;
    } else if (_isHovered) {
      offsetDeslocamento = 2;
      offsetSombra = 3;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          height: 65,
          width: 65,
          transform: Matrix4.translationValues(0, offsetDeslocamento, 0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: cores.laranjaEscuro,
                offset: Offset(0, offsetSombra),
                blurRadius: 0,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: cores.laranja,
              backgroundColor: cores.laranja,
              padding: EdgeInsets.zero,
              elevation: 0,
              shape: const CircleBorder(),
            ),
            child: Icon(
              widget.ico, 
              size: 30, 
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}