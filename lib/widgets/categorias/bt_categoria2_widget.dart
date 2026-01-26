import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class BotaoCategoria2Widget extends StatefulWidget {
  final IconData ico;
  final VoidCallback onPressed;
  const BotaoCategoria2Widget({
    super.key,
    required this.onPressed,
    required this.ico,
  });

  @override
  State<BotaoCategoria2Widget> createState() => _BotaoCategoria2WidgetState();
}

class _BotaoCategoria2WidgetState extends State<BotaoCategoria2Widget> {
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
                color: cores.azulEscuro,
                offset: Offset(0, offsetSombra),
                blurRadius: 0,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: cores.azulClaro3,
              backgroundColor: cores.azulClaro3,
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
            ),
            child: Icon(
              widget.ico, 
              size: 30, 
              color: cores.preto,
            ),
          ),
        ),
      ),
    );
  }
}