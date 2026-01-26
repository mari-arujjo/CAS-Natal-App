import 'package:flutter/material.dart';
import 'package:app_cas_natal/cores.dart';

class ButtonQuadradoIcon extends StatefulWidget {
  final String txt;
  final VoidCallback onPressed;
  final IconData icon;

  const ButtonQuadradoIcon({
    super.key,
    required this.txt,
    required this.onPressed,
    required this.icon,
  });

  @override
  State<ButtonQuadradoIcon> createState() => _ButtonQuadradoIconState();
}

class _ButtonQuadradoIconState extends State<ButtonQuadradoIcon> {
  bool _isHovered = false;
  bool _isPressed = false;
  final cor = Cores();

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
          transform: Matrix4.translationValues(0, offsetDeslocamento, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: cor.laranjaEscuro,
                offset: Offset(0, offsetSombra),
                blurRadius: 0,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: cor.laranja,
              backgroundColor: cor.laranja,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(50),
            ).copyWith(
              overlayColor: WidgetStatePropertyAll(cor.laranjaEscuro),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon, color: Colors.white, size: 40),
                const SizedBox(height: 8),
                Text(
                  widget.txt.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 15, 
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}