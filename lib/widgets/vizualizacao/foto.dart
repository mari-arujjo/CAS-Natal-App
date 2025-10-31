import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class FotoWidget extends StatefulWidget {
  final double tam;
  const FotoWidget({super.key, required this.tam});

  @override
  State<FotoWidget> createState() => _FotoWidgetState();
}

class _FotoWidgetState extends State<FotoWidget> {
  final cores = Cores();
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget.tam,
      backgroundColor: cores.azulEscuro,
      child: Icon(Icons.person, size: 40, color: Colors.white),
    );
  }
}
