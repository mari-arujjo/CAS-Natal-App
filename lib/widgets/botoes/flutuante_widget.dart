import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class BotaoFlutuanteWidget extends StatefulWidget {
  final VoidCallback onPressed;
  const BotaoFlutuanteWidget({super.key, required this.onPressed});

  @override
  State<BotaoFlutuanteWidget> createState() => _FlutuanteState();
}

class _FlutuanteState extends State<BotaoFlutuanteWidget> {
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
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: cor.laranjaEscuro,
                offset: Offset(0, offsetSombra),
                blurRadius: 0,
              ),
            ],
          ),
          child: FloatingActionButton.extended(
            onPressed: null,
            foregroundColor: Colors.white,
            backgroundColor: cor.laranja,
            elevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            disabledElevation: 0,
            label: const Text(
              'Novo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            icon: const Icon(Icons.add),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}