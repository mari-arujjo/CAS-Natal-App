import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class InputPadraoWidget extends StatefulWidget {
  final String? hintText;
  final int? maxLength;
  const InputPadraoWidget({super.key, this.hintText, this.maxLength});

  @override
  State<InputPadraoWidget> createState() => _InputPadraoWidgetState();
}

class _InputPadraoWidgetState extends State<InputPadraoWidget> {
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: cores.azulEscuro,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: cores.azulEscuro),
        filled: true,
        fillColor: Colors.white,
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: cores.azulEscuro),
        ),
      ),
    );
  }
}
