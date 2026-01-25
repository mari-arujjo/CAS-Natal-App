import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class BotaoLaranjaWidget extends StatefulWidget {
  final String txt;
  final VoidCallback onPressed;
  final double tam;
  
  const BotaoLaranjaWidget({
    super.key,
    required this.txt,
    required this.onPressed,
    required this.tam,
  });

  @override
  State<BotaoLaranjaWidget> createState() => _BotaoLaranjaWidgetState();
}

class _BotaoLaranjaWidgetState extends State<BotaoLaranjaWidget> {
  bool _isHovered = false;
  bool _isPressed = false;
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    // Definindo as variações de profundidade
    double offsetDeslocamento = 0;
    double offsetSombra = 5;

    if (_isPressed) {
      offsetDeslocamento = 4; // Botão quase no chão
      offsetSombra = 1;       // Sombra quase sumindo
    } else if (_isHovered) {
      offsetDeslocamento = 2; // Botão levemente abaixado
      offsetSombra = 3;       // Sombra diminui um pouco
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
          height: 40,
          width: widget.tam,
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
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}