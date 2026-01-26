import 'package:app_cas_natal/src/appuser/appuser_provider.dart';
import 'package:app_cas_natal/src/course/course_provider.dart';
import 'package:app_cas_natal/src/enrollment/enrollment_provider.dart';
import 'package:app_cas_natal/src/sign/sign_provider.dart';
import 'package:app_cas_natal/src/lesson/lesson_provider.dart';
import 'package:app_cas_natal/widgets/estatistica/card_estatistica_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EstatisticasAdminPage extends ConsumerStatefulWidget {
  const EstatisticasAdminPage({super.key});

  @override
  ConsumerState<EstatisticasAdminPage> createState() => _EstatisticasPageState();
}

class _EstatisticasPageState extends ConsumerState<EstatisticasAdminPage> {
  @override
  Widget build(BuildContext context) {
    final courseState = ref.watch(courseProvider);
    final String courseCount = courseState.when(
      data: (courses) => courses.length.toString(),
      loading: () => '...',
      error: (err, stack) => '?',
    );
    final lessonState = ref.watch(lessonProvider);
    final String lessonCount = lessonState.when(
      data: (lessons) => lessons.length.toString(),
      loading: () => '...',
      error: (err, stack) => '?',
    );
    final signState = ref.watch(signProvider);
    final String signCount = signState.when(
      data: (glossaries) => glossaries.length.toString(),
      loading: () => '...',
      error: (err, stack) => '?',
    );
    final userState = ref.watch(appUserProvider);
    final String userCount = userState.when(
      data: (users) => users.length.toString(),
      loading: () => '...',
      error: (err, stack) => '?',
    );
    final enrollmentState = ref.watch(enrollmentProvider);
    final String enrollmentCount = enrollmentState.when(
      data: (enrollments) => enrollments.length.toString(),
      loading: () => '...',
      error: (err, stack) => '?',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estatísticas'),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardEstatisticaWidget(
                    txt: 'Usuários cadastrados',
                    dado: userCount,
                    ico: Icons.people,
                  ),
                  const SizedBox(height: 15),
                  CardEstatisticaWidget(
                    txt: 'Usuários matriculados',
                    dado: enrollmentCount,
                    ico: Icons.check,
                  ),
                  const SizedBox(height: 15),
                  CardEstatisticaWidget(
                    txt: 'Cursos cadastrados',
                    dado: courseCount,
                    ico: Icons.school,
                  ),
                  const SizedBox(height: 15),
                  CardEstatisticaWidget(
                    txt: 'Aulas cadastradas',
                    dado: lessonCount,
                    ico: Icons.play_circle_fill,
                  ),
                  const SizedBox(height: 15),
                  CardEstatisticaWidget(
                    txt: 'Sinais cadastrados no glossário',
                    dado: signCount,
                    ico: CupertinoIcons.book_solid,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}