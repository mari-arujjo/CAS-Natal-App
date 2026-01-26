import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class BotaoGlossarioWidget extends StatefulWidget {
  final String txt;
  final String txt2;
  final VoidCallback onPressed;
  final double tam;

  const BotaoGlossarioWidget({
    super.key,
    required this.onPressed,
    required this.txt,
    required this.tam,
    required this.txt2,
  });

  @override
  State<BotaoGlossarioWidget> createState() => _BotaoGlossarioWidgetState();
}

class _BotaoGlossarioWidgetState extends State<BotaoGlossarioWidget> {
  final cores = Cores(); 
  bool pressionado = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: widget.tam,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        color: Colors.white,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            shadowColor: WidgetStatePropertyAll(Colors.transparent),
            overlayColor: WidgetStatePropertyAll(cores.cinzaClaro),
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ), 
            ),
          ),
          onPressed: widget.onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center, 
                  children: [
                    Flexible( 
                      child: Text(
                        widget.txt,
                        style: TextStyle(color: cores.preto, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1, 
                      ),
                    ),
                    SizedBox(width: 10),
                    
                    Expanded(
                      child: Text(
                        widget.txt2,
                        style: TextStyle(color: cores.laranjaEscuro, fontSize: 12),
                        overflow: TextOverflow.ellipsis, 
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 20, color: cores.preto),
            ],
          ),
        ),
      ),
    );
  }
}