import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class InputOutlineSenha extends StatefulWidget {
  final TextEditingController? controller;
  final String txt;

  const InputOutlineSenha({super.key, required this.txt, this.controller});

  @override
  State<InputOutlineSenha> createState() => _Input4State();
}

class _Input4State extends State<InputOutlineSenha> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    final cor = Cores();

    return TextFormField(
      controller: widget.controller,
      obscureText: isObscured,
      cursorColor: cor.azulEscuro,
      decoration: InputDecoration(
        labelText: widget.txt,
        labelStyle: TextStyle(color: cor.azulEscuro),
        prefixIcon: Icon(Icons.password),
        suffixIcon: IconButton(
          icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              isObscured = !isObscured;
            });
          },
        ),

        filled: true,
        fillColor: Colors.white,
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //enabledBorder: OutlineInputBorder(
          //borderRadius: BorderRadius.circular(10),
          //borderSide: BorderSide(color: cor.azulEscuro),
        //),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: cor.azulEscuro),
        ),
      ),
    );
  }
}
