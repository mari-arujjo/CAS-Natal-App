import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/src/course/course_provider.dart';
import 'package:app_cas_natal/widgets/cursos/card_cursos_widget.dart';
import 'package:app_cas_natal/widgets/inputs/search_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CursosPage extends ConsumerWidget {
  const CursosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cor = Cores();
    final coursesAsync = ref.watch(courseProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 1,
        shadowColor: const Color.fromARGB(115, 0, 0, 0),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Column(
            children: [
              SearchBarWidget(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        color: cor.laranja,
        backgroundColor: Colors.white,
        onRefresh: () async {
          ref.invalidate(courseProvider);
        },
        child: coursesAsync.when(
          loading: () => const Center(child: CarregandoWidget()),
          error: (error, stack) => Center(
            child: Text('Erro ao carregar cursos: $error'),
          ),
          data: (courses) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- OPÇÃO 1: BANNER DE HISTÓRIA ---
                    _BannerHistoria(isDesktop: isDesktop, cor: cor),
                    const SizedBox(height: 30),
                    
                    Text(
                      'Resultados encontrados: ${courses.length}',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    if (courses.isEmpty)
                      const Center(child: Text('Nenhum curso cadastrado.'))
                    else
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isDesktop ? 3 : 1,
                          mainAxisExtent: 180,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          final course = courses[index];
                          return CourseCardWidget(
                            course: course,
                            onPressed: () {
                              context.go('/cursos/detalheCurso/${course.id}');
                            },
                          );
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BannerHistoria extends StatelessWidget {
  final bool isDesktop;
  final dynamic cor;

  const _BannerHistoria({required this.isDesktop, required this.cor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: isDesktop ? 250 : 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: const AssetImage('assets/storybook/cas.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4), 
            BlendMode.darken,
          ),
        ),
      ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Nossa Jornada: A História do CAS Natal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isDesktop ? 28 : 18, 
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black45,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
                softWrap: true, 
                maxLines: 3,
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    context.goNamed('Historia');
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    foregroundColor: cor.azulEscuro,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Descobrir',
                    style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}