import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class CardMenorEstatisticaWidget extends StatefulWidget {
  final String txt;
  final String dado;
  final IconData ico;
  final Color cor;
  const CardMenorEstatisticaWidget({
    super.key,
    required this.txt,
    required this.dado,
    required this.ico,
    required this.cor,
  });

  @override
  State<CardMenorEstatisticaWidget> createState() =>
      _CardMenorEstatisticaWidgetState();
}

class _CardMenorEstatisticaWidgetState
    extends State<CardMenorEstatisticaWidget> {
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
            bottom: 5,
            left: 15,
            right: 10,
          ),
          decoration: BoxDecoration(
            color: widget.cor,
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
                  Icon(widget.ico, size: 40),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
