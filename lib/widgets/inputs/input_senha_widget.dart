import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class InputSenhaWidget extends StatefulWidget {
  final TextEditingController? controller;
  final int? maxLength;
  const InputSenhaWidget({super.key, this.maxLength, this.controller});

  @override
  State<InputSenhaWidget> createState() => _InputSenhaWidgetState();
}

class _InputSenhaWidgetState extends State<InputSenhaWidget> {
  bool isObscured = true;
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: isObscured,
      cursorColor: cores.azulEscuro,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          
          icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              isObscured = !isObscured;
            });
          },
        ),

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
