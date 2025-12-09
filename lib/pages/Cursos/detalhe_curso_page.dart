import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_cas_natal/src/course/course_provider.dart';
import 'package:app_cas_natal/src/course/course_model.dart';

class DetalheCursoPage extends ConsumerWidget {
  final String courseId;

  const DetalheCursoPage({super.key, required this.courseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseAsync = ref.watch(courseDetailProvider(courseId)); 

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
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 20),
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
                            child: Image.memory(course.photo!,fit: BoxFit.cover,)
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}