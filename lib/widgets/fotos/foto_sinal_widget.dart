import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class FotoSinalWidget extends StatefulWidget {
  final double height;
  const FotoSinalWidget({super.key, required this.height});

  @override
  State<FotoSinalWidget> createState() => _FotoSinalWidgetState();
}

class _FotoSinalWidgetState extends State<FotoSinalWidget> {
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,  
      height: widget.height,
      decoration: BoxDecoration(
        color: cores.azulEscuro,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.sign_language,
        size: 40,
        color: Colors.white,
      ),
    );
  }
}
