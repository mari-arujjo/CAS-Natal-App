import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class BotaoGoogleWidget extends StatefulWidget {
  final String txt;
  final VoidCallback onPressed;
  final double tam;

  const BotaoGoogleWidget({
    super.key,
    required this.txt,
    required this.onPressed,
    this.tam = 1000,
  });

  @override
  State<BotaoGoogleWidget> createState() => _BotaoGoogleWidgetState();
}

class _BotaoGoogleWidgetState extends State<BotaoGoogleWidget> {
  bool _isHovered = false;
  bool _isPressed = false;

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
          duration: Duration(milliseconds: 100),
          curve: Curves.easeOut,
          height: 35,
          width: widget.tam,
          transform: Matrix4.translationValues(0, offsetDeslocamento, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color:  Cores().azulEscuro,
                offset: Offset(0, offsetSombra),
                blurRadius: 0,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: Colors.white,
              elevation: 0,
              side: BorderSide(color:  Cores().azulEscuro,),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.zero,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logos/google_logo.png',
                  height: 18,
                ),
                SizedBox(width: 10),
                Text(
                  widget.txt,
                  style: TextStyle(
                    color: Cores().azulEscuro,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
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