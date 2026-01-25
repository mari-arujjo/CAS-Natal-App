import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class BotaoMenuWidget extends StatefulWidget {
  final String txt;
  final VoidCallback onPressed;
  final double tam;
  final IconData iconInicio;
  const BotaoMenuWidget({
    super.key,
    required this.onPressed,
    required this.txt,
    required this.tam,
    required this.iconInicio,
  });

  @override
  State<BotaoMenuWidget> createState() => _BotaoMenuWidgetState();
}

class _BotaoMenuWidgetState extends State<BotaoMenuWidget> {
  final cores = Cores();
  bool pressionado = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: widget.tam,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        color: Colors.white,
        child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          shadowColor: WidgetStatePropertyAll(Colors.transparent),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          overlayColor: WidgetStatePropertyAll(cores.cinzaClaro),
          side: WidgetStatePropertyAll(
            BorderSide(color: Colors.transparent, width: 1),
          ),
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 5, vertical: 5), // margem interna
          ),
        ),
        onPressed: widget.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: cores.laranja,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(widget.iconInicio, size: 20, color: cores.preto),
                ),
                SizedBox(width: 10),
                Text(
                  widget.txt,
                  style: TextStyle(color: cores.preto, fontSize: 16),
                ),
              ],
            ),

            Icon(Icons.arrow_forward_ios, size: 20, color: cores.preto),
          ],
        ),
      ),
      )
    );
  }
}
