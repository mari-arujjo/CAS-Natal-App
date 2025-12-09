import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/src/course/course_model.dart'; // Importe o CourseModel
import 'package:app_cas_natal/widgets/botoes/bt_laranja_modulo.dart';
import 'package:app_cas_natal/widgets/vizualizacao/progess_bar_widget.dart';
import 'package:flutter/material.dart';

// Renomeado para maior clareza e flexibilidade
class CourseCardWidget extends StatefulWidget { 
  // Alteramos para receber um CourseModel
  final CourseModel course; 
  final VoidCallback onPressed;

  const CourseCardWidget({
    super.key,
    required this.course, // O curso a ser exibido
    required this.onPressed,
  });

  @override
  State<CourseCardWidget> createState() => _CourseCardWidgetState();
}

class _CourseCardWidgetState extends State<CourseCardWidget> {
  final cores = Cores();
  // Este valor deve vir de algum lugar (ex: estado do usuário), 
  // mas usaremos um valor fixo/exemplo por agora.
  double progresso = 1.0; 

  @override
  Widget build(BuildContext context) {
    // Acessa o objeto CourseModel
    final course = widget.course; 
    // Usaremos um ícone temporário ou a foto se estiver disponível.
    final imageAsset = 'assets/modulos/cas.jpg'; 

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 150,
          width: constraints.maxWidth,
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
                    child: course.photo != null
                        ? Image.memory(
                            course.photo!,
                            width: constraints.maxWidth * 0.35,
                            height: 70,
                            fit: BoxFit.cover,
                          )
                        : Image.asset( // Se não houver foto, use o asset padrão
                            imageAsset,
                            width: constraints.maxWidth * 0.35,
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
                          // **USANDO DADOS DINÂMICOS:** Nome do curso
                          course.name, 
                          style: TextStyle(
                            fontSize: 14,
                            color: cores.preto,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '0% concluído',
                          style: TextStyle(fontSize: 12, color: cores.preto),
                        ),
                        ProgressBarWidget(progress: 0),
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