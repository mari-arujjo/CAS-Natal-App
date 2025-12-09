import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class InputDescricaoWidget extends StatefulWidget {
  final String? hintText;
  final int? maxLength;
  final TextEditingController? controller;
  const InputDescricaoWidget({super.key, this.hintText, required this.maxLength, this.controller});

  @override
  State<InputDescricaoWidget> createState() => _InputDescricaoWidgetState();
}

class _InputDescricaoWidgetState extends State<InputDescricaoWidget> {
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: cores.azulEscuro,
      maxLength: widget.maxLength,
      minLines: 3,
      maxLines: 10,
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
