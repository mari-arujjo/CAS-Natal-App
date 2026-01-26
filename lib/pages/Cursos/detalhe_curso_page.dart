// ignore_for_file: use_build_context_synchronously, unused_result
import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/popup.dart';
import 'package:app_cas_natal/snackbar.dart';
import 'package:app_cas_natal/widgets/botoes/bt_aula_widget.dart';
import 'package:app_cas_natal/widgets/botoes/bt_laranja_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_cas_natal/src/course/course_provider.dart';
import 'package:app_cas_natal/src/course/course_model.dart';
import 'package:app_cas_natal/src/lesson/lesson_model.dart';
import 'package:app_cas_natal/src/enrollment/enrollment_provider.dart';
import 'package:go_router/go_router.dart';

class DetalheCursoPage extends ConsumerStatefulWidget {
  final String courseId;
  const DetalheCursoPage({super.key, required this.courseId});

  @override
  ConsumerState<DetalheCursoPage> createState() => _DetalheCursoPageState();
}

class _DetalheCursoPageState extends ConsumerState<DetalheCursoPage> {
  final cor = Cores();
  final popUp = PopUp();

  Future<void> fazerMatricula(BuildContext context, WidgetRef ref, String courseSymbol, String courseName) async {
    final confirmed = await popUp.PopUpFazerMatricula(context, courseName);
    if (!confirmed) return;
    final enrollmentNotifier = ref.read(enrollmentProvider.notifier);
    SnackBarUtils.showCustomSnackbar(context, 'Matriculando...', cor.azulEscuro);
    try {
      await enrollmentNotifier.enrollUser(courseSymbol);
      ref.invalidate(courseDetailProvider(widget.courseId));
      await ref.refresh(userEnrollmentsProvider.future);
      SnackBarUtils.showCustomSnackbar(context, 'Matrícula realizada com sucesso!', cor.azulEscuro);
    } catch (e) {
      SnackBarUtils.showCustomSnackbar(context, e.toString(), Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final courseAsync = ref.watch(courseDetailProvider(widget.courseId));
    final userEnrollmentsAsync = ref.watch(userEnrollmentsProvider);

    return Scaffold(
      
      appBar: AppBar(
        title: courseAsync.maybeWhen(
          data: (course) => Text(course.name),
          orElse: () => Text('Curso'),
        ),
      ),
      body: courseAsync.when(
        loading: () => Center(child: CarregandoWidget()),
        error: (error, stack) => Center(child: Text('Erro: $error')),
        data: (CourseModel course) {
          final List<LessonModel> lessons = course.lessons ?? [];
          return userEnrollmentsAsync.when(
            loading: () => Center(child: CarregandoWidget()),
            error: (error, stack) => Center(child: Text('Erro nas matrículas')),
            data: (enrollments) {
              final isEnrolled = enrollments.any((e) => e.symbol?.toLowerCase() == course.symbol.toLowerCase());
              
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1000), 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                  child: course.photo != null
                                      ? Image.memory(
                                          course.photo!,
                                          width: double.infinity,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          width: double.infinity,
                                          height: 200,
                                          color: Colors.grey[200],
                                          child: const Icon(Icons.image, size: 50),
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      _infoItem(Icons.access_time, "Carga horária:", "3 horas"),
                                      _infoItem(Icons.group_outlined, "Público-alvo:", "Professores, Estudantes, Profissionais"),
                                      _infoItem(Icons.track_changes, "Objetivo:", course.description),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),
                          
                          const Text(
                            "Aulas",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15),

                          if (isEnrolled)
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: lessons.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final lesson = lessons[index];
                              return AulaTile(
                                index: index + 1,
                                title: lesson.name,
                                onTap: () {
                                  context.go('/cursos/detalheCurso/${course.id}/video/${lesson.id}');
                                },
                              );
                            },
                          )
                        else
                          _buildLockedState(course),
                      ],
                    ),
                  ),
                )
              );
            },
          );
        },
      ),
    );
  }

  Widget _infoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 15, color: Colors.black87),
                children: [
                  TextSpan(text: "$label ", style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


    Widget _buildLockedState(CourseModel course) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        color: Colors.white,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Matricule-se para acessar as aulas.",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              BotaoLaranjaWidget(
                txt: 'Matricular-se agora!',
                onPressed: () => fazerMatricula(context, ref, course.symbol, course.name),
                tam: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}