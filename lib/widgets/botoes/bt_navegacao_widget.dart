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
          width: 120,
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
          child: ElevatedButton.icon(
            onPressed: null,
            icon: Icon(
              widget.icon.icon,
              color: Colors.white,
              size: 18,
            ),
            label: Text(
              widget.txt,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing:1.5,
              ),
            ),
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: cores.laranja,
              backgroundColor: cores.laranja,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
        ),
      ),
    );
  }
}