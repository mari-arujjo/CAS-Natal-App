// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously
import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/src/lesson/lesson_model.dart';
import 'package:flutter/material.dart';
import 'package:app_cas_natal/widgets/botoes/bt_navegacao_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_cas_natal/src/quiz/quiz_provider.dart';
import 'package:app_cas_natal/src/lesson/lesson_provider.dart';

class LessonContentPage extends ConsumerStatefulWidget {
  final LessonModel lesson;

  const LessonContentPage({super.key, required this.lesson});

  @override
  ConsumerState<LessonContentPage> createState() => _LessonContentPageState();
}

class _LessonContentPageState extends ConsumerState<LessonContentPage> {
  late PageController _pageController;
  int _currentIndex = 0;
  late List<LessonTopicModel> _sortedTopics;
  final cor = Cores();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    // Ordena os tópicos para exibição sequencial
    _sortedTopics = List<LessonTopicModel>.from(widget.lesson.topics)
      ..sort((a, b) => a.order.compareTo(b.order));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Calcula o total de páginas (1 da introdução + N tópicos)
  int get _totalPages => 1 + _sortedTopics.length;

  // Lógica para encontrar a próxima aula (baseada no seu código de exemplo)
  String? _findNextLessonId(WidgetRef ref, LessonModel currentLesson) {
    final lessonsAsync = ref.watch(lessonProvider);
    return lessonsAsync.maybeWhen(
      data: (allLessons) {
        final courseLessons = allLessons
            .where((l) => l.courseId == currentLesson.courseId)
            .toList();
        // Ordena as aulas para saber qual é a sequência correta
        courseLessons.sort((a, b) => a.order.compareTo(b.order));
        
        final currentIndex = courseLessons.indexWhere((l) => l.id == currentLesson.id);
        
        if (currentIndex != -1 && currentIndex < courseLessons.length - 1) {
          return courseLessons[currentIndex + 1].id;
        }
        return null;
      },
      orElse: () => null,
    );
  }

  // Lógica principal de navegação ao final do conteúdo
  void _handleFinalStep() async {
    try {
      // Tenta buscar o quiz
      final quizList = await ref.read(quizQuestionDetailProvider(widget.lesson.id!).future);
      
      if (!mounted) return;

      if (quizList.isNotEmpty) {
        // SE EXISTIR QUIZ: Mostra confirmação
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Início do Quiz'),
              content: const Text(
                  'Tem certeza de que deseja prosseguir para o Quiz? Certifique-se de que revisou todo o conteúdo da lição.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: Text('Cancelar', style: TextStyle(color: cor.azulEscuro)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  child: Text('Prosseguir', style: TextStyle(color: cor.azulEscuro)),
                ),
              ],
            );
          },
        );

        if (confirmed == true && mounted) {
          context.go('/cursos/detalheCurso/${widget.lesson.courseId}/quiz/${widget.lesson.id}');
        }
      } else {
        // Se a lista vier vazia, trata como sem quiz
        _goToNextLessonOrFinish();
      }
    } catch (e) {
      // SE DER ERRO (ex: 404 ou falha de conexão), assume que não tem quiz e avança
      if (!mounted) return;
      _goToNextLessonOrFinish();
    }
  }

  void _goToNextLessonOrFinish() {
    final nextLessonId = _findNextLessonId(ref, widget.lesson);
    
    if (nextLessonId != null) {
      // Vai para a próxima aula
      context.go('/cursos/detalheCurso/${widget.lesson.courseId}/video/$nextLessonId');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quiz não disponível. Avançando para a próxima aula.')),
      );
    } else {
      // Volta para o menu do curso
      context.go('/cursos/detalheCurso/${widget.lesson.courseId}');
    }
  }

  void _nextStep() {
    if (_currentIndex < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // Se for a última página, tenta ir para o quiz ou próxima aula
      _handleFinalStep();
    }
  }

  void _previousStep() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // Se estiver na primeira página, volta para o vídeo (tela anterior)
      context.go('/cursos/detalheCurso/${widget.lesson.courseId}/video/${widget.lesson.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWebWide = MediaQuery.of(context).size.width > 900;
    // Calcula o progresso (0.0 a 1.0)
    double progress = (_currentIndex + 1) / _totalPages;

    return Scaffold(
      appBar: AppBar(
        title: Text('Conteúdo: ${widget.lesson.name}'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(cor.azulEscuro),
            minHeight: 6,
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  itemCount: _totalPages,
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: isWebWide ? 40.0 : 20.0,
                        vertical: 30.0,
                      ),
                      child: SelectionArea(
                        child: _buildPageContent(index),
                      ),
                    );
                  },
                ),
              ),
              _buildBottomNavigation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent(int index) {
    // Página 0 é sempre a introdução/conteúdo principal da aula
    if (index == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Introdução", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: cor.azulEscuro)),
          const SizedBox(height: 20),
          Text(widget.lesson.content, style: const TextStyle(fontSize: 18, height: 1.6)),
        ],
      );
    }

    // Páginas 1 em diante são os tópicos
    final topic = _sortedTopics[index - 1];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(topic.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: cor.azulEscuro)),
        const SizedBox(height: 20),
        Text(topic.textContent, style: const TextStyle(fontSize: 18, height: 1.6)),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    bool isLastPage = _currentIndex == _totalPages - 1;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BotaoNavegacaoWidget(
            txt: 'Anterior',
            icon: const Icon(Icons.arrow_back),
            onPressed: _previousStep,
          ),
          Text('${_currentIndex + 1} / $_totalPages', style: const TextStyle(fontWeight: FontWeight.bold)),
          BotaoNavegacaoWidget(
            txt: isLastPage ? 'Concluir' : 'Próximo',
            icon: Icon(isLastPage ? Icons.check_circle : Icons.arrow_forward),
            onPressed: _nextStep,
          ),
        ],
      ),
    );
  }
}