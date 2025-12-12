import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/widgets/botoes_padrao/bt_laranja_widget.dart';
import 'package:app_cas_natal/widgets/botoes_padrao/bt_quadrado_widget.dart';
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

  Future<bool> _showEnrollmentConfirmationDialog(BuildContext context, String courseName) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirmar Matrícula'),
              content: Text('Você confirma a matrícula no curso "$courseName"?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancelar', style: TextStyle(color: cor.azulEscuro)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Confirmar', style: TextStyle(color: cor.azulEscuro)),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<void> _enrollUser(BuildContext context, WidgetRef ref, String courseSymbol, String courseName) async {
    final confirmed = await _showEnrollmentConfirmationDialog(context, courseName);
    if (!confirmed) return;

    final enrollmentNotifier = ref.read(enrollmentProvider.notifier);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Matriculando...'), duration: Duration(seconds: 1)),
    );

    try {
      await enrollmentNotifier.enrollUser(courseSymbol);

      ref.invalidate(courseDetailProvider(widget.courseId));

      await ref.refresh(userEnrollmentsProvider.future);

      if (mounted) setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Matrícula em "$courseName" realizada com sucesso!')),
      );
    } catch (e) {
      final msg = e.toString().replaceAll('Exception: Falha na matrícula: Exception: ', '');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Colors.red,
        ),
      );
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
          orElse: () => const Text('Detalhes do Curso'),
        ),
      ),
      body: courseAsync.when(
        loading: () => const Center(child: CarregandoWidget()),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text('Erro ao carregar detalhes do curso: $error'),
          ),
        ),
        data: (CourseModel course) {
          final List<LessonModel> lessons = course.lessons ?? [];

          return userEnrollmentsAsync.when(
            loading: () => const Center(child: CarregandoWidget()),
            error: (error, stack) => Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text('Erro ao carregar matrículas: $error'),
              ),
            ),
            data: (enrollments) {
              final isEnrolled = enrollments.any((e) => e.symbol?.toLowerCase() == course.symbol.toLowerCase());

              return SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                course.description,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 150,
                              height: 170,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: course.photo != null ? Image.memory(course.photo!, fit: BoxFit.cover) : Container(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        if (isEnrolled)
                          lessons.isEmpty
                          ? const Text('Nenhuma lição cadastrada para este curso.')
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: lessons.length,
                                separatorBuilder: (context, index) => const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  final lesson = lessons[index];
                                  return SizedBox(
                                    width: double.infinity,
                                    child: ButtonQuadrado(
                                      txt: lesson.name,
                                      onPressed: () {
                                        if (lesson.id == null || lesson.id!.isEmpty) {
                                            debugPrint('ERRO: lesson.id é nulo ou vazio!');
                                            return;
                                        }
                                        context.go(
                                          '/cursos/detalheCurso/${course.id}/video/${lesson.id}' 
                                        );
                                      },
                                    ),
                                  );
                                },
                              )
                        else
                          Column(
                            children: [
                              const Text(
                                'Você não está matriculado neste curso. Matricule-se para acessar as aulas.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              const SizedBox(height: 20),
                              BotaoLaranjaWidget(
                                txt: 'Matricular-se agora!',
                                onPressed: () => _enrollUser(context, ref, course.symbol, course.name),
                                tam: 300,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
