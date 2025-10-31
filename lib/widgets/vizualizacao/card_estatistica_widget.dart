import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class CardEstatisticaWidget extends StatefulWidget {
  final String txt;
  final String dado;
  final IconData ico;
  const CardEstatisticaWidget({
    super.key,
    required this.txt,
    required this.dado,
    required this.ico,
  });

  @override
  State<CardEstatisticaWidget> createState() => _CardEstatisticaWidgetState();
}

class _CardEstatisticaWidgetState extends State<CardEstatisticaWidget> {
  final cores = Cores();
  double progresso = 1.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 80,
          width: constraints.maxWidth, // pega a largura disponível do grid
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 15,
            left: 25,
            right: 25,
          ),
          decoration: BoxDecoration(
            color: cores.azulClaro,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.txt,
                          style: TextStyle(fontSize: 13, color: cores.preto),
                        ),
                        Text(
                          widget.dado,
                          style: TextStyle(
                            fontSize: 28,
                            color: cores.preto,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(widget.ico, size: 50),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
