import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class BotaoMenuWebWidget extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final IconData icone;
  final VoidCallback onPressed;

  const BotaoMenuWebWidget({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.icone,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final cores = Cores();
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: cores.laranja,
                  shape: BoxShape.circle,
                ),
                child: Icon(icone, color: Colors.black87, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}