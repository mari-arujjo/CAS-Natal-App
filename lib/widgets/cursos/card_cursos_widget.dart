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
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 1,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: course.photo != null
                          ? Image.memory(
                              course.photo!,
                              width: constraints.maxWidth * 0.4,
                              height: 90,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: constraints.maxWidth * 0.4,
                              height: 90,
                              color: Colors.grey[200],
                              child: const Icon(Icons.image, size: 50),
                            ),
                    ),
                    SizedBox(width: 10),
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
                          SizedBox(height: 5),
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
                SizedBox(height: 10),
                BotaoLaranjaModuloWidget(
                  txt: 'Acessar curso',
                  onPressed: widget.onPressed,
                ),
              ],
            ),
          )
        );
      },
    );
  }
}
