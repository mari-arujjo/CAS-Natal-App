import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class BotaoGlossarioWidget extends StatefulWidget {
  final String txt;
  final String txt2;
  final VoidCallback onPressed;
  final double tam;

  const BotaoGlossarioWidget({
    super.key,
    required this.onPressed,
    required this.txt,
    required this.tam,
    required this.txt2,
  });

  @override
  State<BotaoGlossarioWidget> createState() => _BotaoGlossarioWidgetState();
}

class _BotaoGlossarioWidgetState extends State<BotaoGlossarioWidget> {
  final cores = Cores();
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // Lógica de profundidade (estilo 3D)
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
          height: 50,
          width: widget.tam,
          transform: Matrix4.translationValues(0, offsetDeslocamento, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(43, 0, 0, 0),
                offset: Offset(0, offsetSombra),
                blurRadius: 0,
              ),
            ],
          ),
          child: ElevatedButton(
            // onPressed null para o GestureDetector assumir o controle do clique
            onPressed: null,
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: Colors.white,
              backgroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          widget.txt,
                          style: TextStyle(color: cores.preto, fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.txt2,
                          style: TextStyle(color: cores.laranjaEscuro, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 20, color: cores.preto),
              ],
            ),
          ),
        ),
      ),
    );
  }
}