// ignore_for_file: non_constant_identifier_names
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
  bool _hasQuiz = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _sortedTopics = List<LessonTopicModel>.from(widget.lesson.topics)
      ..sort((a, b) => a.order.compareTo(b.order));
    _checkQuizExistence();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _checkQuizExistence() async {
    try {
      await ref.read(quizQuestionDetailProvider(widget.lesson.id!).future);
      if (mounted) setState(() => _hasQuiz = true);
    } catch (e) {
      if (mounted) setState(() => _hasQuiz = false);
    }
  }

  int get _totalPages => 1 + _sortedTopics.length;

  String? _findNextLessonId(WidgetRef ref, LessonModel currentLesson) {
    final lessonsAsync = ref.watch(lessonProvider);
    return lessonsAsync.maybeWhen(
      data: (allLessons) {
        final courseLessons = allLessons
            .where((l) => l.courseId == currentLesson.courseId)
            .toList();
        courseLessons.sort((a, b) => a.name.compareTo(b.name));
        final currentIndex =
            courseLessons.indexWhere((l) => l.id == currentLesson.id);
        if (currentIndex != -1 && currentIndex < courseLessons.length - 1) {
          return courseLessons[currentIndex + 1].id;
        }
        return null;
      },
      orElse: () => null,
    );
  }

  void _handleFinalStep() async {
    if (_hasQuiz) {
      _showQuizConfirmation();
    } else {
      _goToNextLessonOrFinish();
    }
  }

  void _goToNextLessonOrFinish() {
    final nextId = _findNextLessonId(ref, widget.lesson);
    if (nextId != null) {
      context.go('/cursos/detalheCurso/${widget.lesson.courseId}/video/$nextId');
    } else {
      context.go('/cursos/detalheCurso/${widget.lesson.courseId}');
    }
  }

  void _showQuizConfirmation() async {
    final cor = Cores();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Início do Quiz'),
        content: const Text('Deseja prosseguir para o Quiz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancelar', style: TextStyle(color: cor.azulEscuro)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Prosseguir', style: TextStyle(color: cor.azulEscuro)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      context.go('/cursos/detalheCurso/${widget.lesson.courseId}/quiz/${widget.lesson.id}');
    }
  }

  void _nextStep() {
    if (_currentIndex < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
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
      context.go('/cursos/detalheCurso/${widget.lesson.courseId}/video/${widget.lesson.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cor = Cores();
    final isWebWide = MediaQuery.of(context).size.width > 900;
    double progress = (_currentIndex + 1) / _totalPages;

    String finalBtnText = _hasQuiz ? 'Quiz' : 'Próximo';
    IconData finalBtnIcon = _hasQuiz ? Icons.quiz : Icons.arrow_forward;

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
                      child: _buildPageContent(index),
                    );
                  },
                ),
              ),
              _buildBottomNavigation(finalBtnText, finalBtnIcon),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent(int index) {
    if (index == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Introdução", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Text(widget.lesson.content, style: const TextStyle(fontSize: 18, height: 1.6)),
        ],
      );
    }

    final topic = _sortedTopics[index - 1];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(topic.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Text(topic.textContent, style: const TextStyle(fontSize: 18, height: 1.6)),
      ],
    );
  }

  Widget _buildBottomNavigation(String finalBtnText, IconData finalBtnIcon) {
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
            txt: isLastPage ? finalBtnText : 'Próximo',
            icon: Icon(isLastPage ? finalBtnIcon : Icons.arrow_forward),
            onPressed: _nextStep,
          ),
        ],
      ),
    );
  }
}