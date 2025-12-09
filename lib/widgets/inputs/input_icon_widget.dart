import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class InputOutline extends StatefulWidget {
  final TextEditingController? controller;
  final String txt;
  final Icon ico;

  const InputOutline({
    super.key,
    required this.txt,
    required this.ico,
    this.controller,
  });

  @override
  State<InputOutline> createState() => _Input2State();
}

class _Input2State extends State<InputOutline> {
  @override
  Widget build(BuildContext context) {
    final cor = Cores();

    return TextFormField(
      controller: widget.controller,
      cursorColor: cor.azulEscuro,
      
      decoration: InputDecoration(
        labelText: widget.txt,
        labelStyle: TextStyle(color: cor.azulEscuro),
        prefixIcon: widget.ico,
        filled: true,
        fillColor: Colors.white,
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //enabledBorder: OutlineInputBorder(
          //borderRadius: BorderRadius.circular(10),
          //borderSide: BorderSide(color: cor.gray),
        //),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: cor.azulEscuro),
        ),
      ),
    );
  }
}
