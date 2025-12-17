import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class InputPadraoWidget extends StatefulWidget {
  final String? hintText;
  final int? maxLength;
  final TextEditingController? controller;
  final bool readOnly;
  const InputPadraoWidget({super.key, this.hintText, this.maxLength, this.controller, required this.readOnly});

  @override
  State<InputPadraoWidget> createState() => _InputPadraoWidgetState();
}

class _InputPadraoWidgetState extends State<InputPadraoWidget> {
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    final Color fillColor = widget.readOnly ? Color.fromARGB(157, 255, 255, 255) : Colors.white;

    return TextFormField(
      controller: widget.controller,
      cursorColor: cores.azulEscuro,
      maxLength: widget.maxLength,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: cores.azulEscuro),
        filled: true,
        fillColor: fillColor,
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: cores.azulEscuro),
        ),
      ),
    );
  }
}
