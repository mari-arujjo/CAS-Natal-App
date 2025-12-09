import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class ButtonLista extends StatefulWidget {
  final String txt;
  final VoidCallback onPressed;

  const ButtonLista({super.key, required this.txt, required this.onPressed});

  @override
  State<ButtonLista> createState() => _ButtonListaState();
}

class _ButtonListaState extends State<ButtonLista> {
  bool pressionado = false;

  @override
  Widget build(BuildContext context) {
    final cor = Cores();

    return SizedBox(
      height: 45,

      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(3),
          shadowColor: const WidgetStatePropertyAll(Colors.black),
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          overlayColor: WidgetStatePropertyAll(cor.azulEscuro),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),

        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.txt,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),

            Icon(Icons.edit, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
