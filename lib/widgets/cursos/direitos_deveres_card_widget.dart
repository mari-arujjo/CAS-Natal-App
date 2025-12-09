import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/widgets/botoes/bt_laranja_modulo.dart';
import 'package:app_cas_natal/widgets/vizualizacao/progess_bar_widget.dart';
import 'package:flutter/material.dart';

class CardModuloDireitosDeveresWidget extends StatefulWidget {
  final VoidCallback onPressed;
  const CardModuloDireitosDeveresWidget({super.key, required this.onPressed});

  @override
  State<CardModuloDireitosDeveresWidget> createState() => _CardModuloDireitosDeveresWidgetState();
}

class _CardModuloDireitosDeveresWidgetState extends State<CardModuloDireitosDeveresWidget> {
  final cores = Cores();
  double progresso = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 150,
          width: constraints.maxWidth, // pega a largura disponível do grid
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: cores.azulClaro,
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
                      'assets/modulos/inclusao.jpg',
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
                          'Direitos e Deveres para Prática Inclusiva ',
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
                txt: 'Iniciar módulo',
                onPressed: widget.onPressed,
              ),
            ],
          ),
        );
      },
    );
  }
}
