import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/widgets/botoes/bt_laranja_modulo.dart';
import 'package:app_cas_natal/widgets/vizualizacao/progess_bar_widget.dart';
import 'package:flutter/material.dart';

class CardModuloHistoriaCASWidget extends StatefulWidget {
  final VoidCallback onPressed;
  const CardModuloHistoriaCASWidget({super.key, required this.onPressed});

  @override
  State<CardModuloHistoriaCASWidget> createState() => _CardModuloHistoriaCASWidgetState();
}

class _CardModuloHistoriaCASWidgetState extends State<CardModuloHistoriaCASWidget> {
  final cores = Cores();
  double progresso = 1.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 150,
          width: constraints.maxWidth, // pega a largura disponível do grid
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: cores.cinzaClaro,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/modulos/cas.jpg',
                      width:
                          constraints.maxWidth * 0.35, // proporcional à largura
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'História do CAS\nNatal/RN',
                          style: TextStyle(
                            fontSize: 14,
                            color: cores.preto,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${(progresso * 100).toStringAsFixed(0)}% concluído',
                          style: TextStyle(fontSize: 12, color: cores.preto),
                        ),
                        ProgressBarWidget(progress: progresso),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              BotaoLaranjaModuloWidget(
                txt: 'Continuar',
                onPressed: widget.onPressed,
              ),
            ],
          ),
        );
      },
    );
  }
}
