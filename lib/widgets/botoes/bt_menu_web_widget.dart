import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class MenuBotaoWidget extends StatefulWidget {
  final String titulo;
  final String subtitulo;
  final IconData icone;
  final Color cor;
  final VoidCallback onPressed;

  const MenuBotaoWidget({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.icone,
    required this.cor,
    required this.onPressed,
    
  });
  @override
  State<MenuBotaoWidget> createState() => _MenuBotaoWidgetState();
}

class _MenuBotaoWidgetState extends State<MenuBotaoWidget> {
  @override
  Widget build(BuildContext context) {
    final cores = Cores(); 
    final bool isSair = widget.titulo == 'Sair';

    return SizedBox(
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
            padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
            side: WidgetStatePropertyAll(BorderSide(color: const Color.fromARGB(24, 158, 158, 158),width: 1))
          ),
          onPressed: widget.onPressed,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: widget.cor,
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.icone, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.titulo,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: isSair ? Colors.red[700] : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitulo,
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Seta lateral
              Icon(Icons.chevron_right, color: const Color.fromARGB(255, 0, 0, 0), size: 20),
            ],
          ),
        ),
      )
    );
  }
}