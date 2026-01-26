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
          height: 35,
          width: double.infinity,
          transform: Matrix4.translationValues(0, offsetDeslocamento, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.zero,
            ),
            child: Text(
              widget.txt.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}