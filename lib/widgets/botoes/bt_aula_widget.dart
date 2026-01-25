import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class AulaTile extends StatefulWidget {
  final int index;
  final String title;
  final VoidCallback onTap;

  const AulaTile({
    super.key,
    required this.index,
    required this.title,
    required this.onTap,
  });

  @override
  State<AulaTile> createState() => _AulaTileState();
}

class _AulaTileState extends State<AulaTile> {
  bool _isHovered = false;
  bool _isPressed = false;
  final Color corFundoCard = Colors.white;
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    // Lógica de profundidade
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
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          margin: const EdgeInsets.only(bottom: 12),
          transform: Matrix4.translationValues(0, offsetDeslocamento, 0),
          decoration: BoxDecoration(
            color: corFundoCard,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: cores.azulEscuro2,
                offset: Offset(0, offsetSombra),
                blurRadius: 0,
              ),
            ],
          ),
          child: InkWell(
            onTap: null,
            borderRadius: BorderRadius.circular(12),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: cores.azulEscuro,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(11),
                        bottomLeft: Radius.circular(11),
                      ),
                    ),
                    child: Text(
                      widget.index.toString().padLeft(2, '0'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        widget.title.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: cores.azulEscuro2.withOpacity(0.5),
                    size: 18,
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}