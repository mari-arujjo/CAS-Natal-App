import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/src/course/course_model.dart';
import 'package:app_cas_natal/widgets/botoes/bt_laranja_modulo.dart';
import 'package:app_cas_natal/widgets/vizualizacao/progess_bar_widget.dart';
import 'package:flutter/material.dart';

class CourseCardWidget extends StatefulWidget {
  final CourseModel course;
  final VoidCallback onPressed;

  const CourseCardWidget({
    super.key,
    required this.course,
    required this.onPressed,
  });

  @override
  State<CourseCardWidget> createState() => _CourseCardWidgetState();
}

class _CourseCardWidgetState extends State<CourseCardWidget> {
  final cores = Cores();
  double progresso = 1.0;

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: cores.cinzaClaro,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      course.photo!,
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
                          course.name,
                          style: TextStyle(
                            fontSize: 16,
                            color: cores.preto,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '0% concluído',
                          style: TextStyle(
                            fontSize: 12,
                            color: cores.preto,
                          ),
                        ),
                        ProgressBarWidget(progress: 0),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              BotaoLaranjaModuloWidget(
                txt: 'Acessar',
                onPressed: widget.onPressed,
              ),
            ],
          ),
        );
      },
    );
  }
}
