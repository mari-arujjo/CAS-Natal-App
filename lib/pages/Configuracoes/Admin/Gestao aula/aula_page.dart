import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/src/lesson/lesson_model.dart';
import 'package:app_cas_natal/popup.dart';
import 'package:app_cas_natal/src/lesson/lesson_provider.dart';
import 'package:app_cas_natal/widgets/botoes/bt_laranja_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_content_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_topic_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_widget.dart';
import 'package:app_cas_natal/widgets/listas/lista_aula_widget.dart';
import 'package:app_cas_natal/widgets/listas/lista_curso_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/container_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/dg_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopicControllerGroup {
  final String? id;
  final TextEditingController title;
  final TextEditingController textContent;

  TopicControllerGroup({this.id, String? titleText, String? contentText})
    : title = TextEditingController(text: titleText),
      textContent = TextEditingController(text: contentText);

  void dispose() {
    title.dispose();
    textContent.dispose();
  }
}

class AulaPage extends ConsumerStatefulWidget {
  final LessonModel aula;
  const AulaPage({super.key, required this.aula});

  @override
  ConsumerState<AulaPage> createState() => _AulaPageState();
}

class _AulaPageState extends ConsumerState<AulaPage> {
  late final TextEditingController codeCtrl;
  late final TextEditingController nameCtrl;
  late final TextEditingController urlCtrl;
  late final TextEditingController contentCtrl;
  late int _selectedOrder;
  final List<TopicControllerGroup> _topicControllers = [];
  String? _selectedCourseId;
  final popUp = PopUp();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    codeCtrl = TextEditingController(text: widget.aula.lessonCode);
    nameCtrl = TextEditingController(text: widget.aula.name);
    urlCtrl = TextEditingController(text: widget.aula.url);
    contentCtrl = TextEditingController(text: widget.aula.content);
    _selectedOrder = widget.aula.order;
    _selectedCourseId = widget.aula.courseId;

    for (var topic in widget.aula.topics) {
      _topicControllers.add(
        TopicControllerGroup(
          id: topic.id,
          titleText: topic.title,
          contentText: topic.textContent,
        ),
      );
    }
  }

  @override
  void dispose() {
    codeCtrl.dispose();
    nameCtrl.dispose();
    urlCtrl.dispose();
    contentCtrl.dispose();
    for (var topic in _topicControllers) {
      topic.dispose();
    }
    super.dispose();
  }

  void _addTopic() {
    setState(() {
      _topicControllers.add(TopicControllerGroup());
    });
  }

  void _removeTopic(int index) {
    setState(() {
      _topicControllers[index].dispose();
      _topicControllers.removeAt(index);
    });
  }

  void _asyncDeleteLesson() async {
    DialogLoadingWidget.showLoading(context);
    try {
      await ref.read(lessonProvider.notifier).deleteLesson(widget.aula.id!);
      if (mounted) {
        DialogLoadingWidget.dismiss(context);
        popUp.PopUpExcluido(context);
      }
    } catch (e) {
      if (mounted) {
        DialogLoadingWidget.dismiss(context);
        popUp.PopUpAlert(context, 'Erro ao excluir aula: $e');
      }
    }
  }

  void _asyncUpdateLesson() async {
    if (nameCtrl.text.isEmpty || urlCtrl.text.isEmpty || contentCtrl.text.isEmpty || _selectedCourseId == null) {
      popUp.PopUpAlert(context, 'Preencha os campos obrigatórios.');
      return;
    }

    List<LessonTopicModel> topicsAtualizados = _topicControllers.asMap().entries.map((entry) {
      int index = entry.key;
      var ctrls = entry.value;
      return LessonTopicModel(
        id: ctrls.id ?? "00000000-0000-0000-0000-000000000000",
        order: index + 1,
        title: ctrls.title.text,
        textContent: ctrls.textContent.text,
      );
    }).toList();

    final lessonAtualizada = LessonModel(
      id: widget.aula.id,
      lessonCode: widget.aula.lessonCode,
      name: nameCtrl.text,
      order: _selectedOrder,
      completed: widget.aula.completed,
      url: urlCtrl.text,
      content: contentCtrl.text,
      topics: topicsAtualizados,
      courseId: _selectedCourseId,
    );

    DialogLoadingWidget.showLoading(context);
    try {
      await ref.read(lessonProvider.notifier).updateLesson(lessonAtualizada, widget.aula.id!);
      if (mounted) {
        DialogLoadingWidget.dismiss(context);
        popUp.PopUpAlterado(context);
      }
    } catch (e) {
      if (mounted) {
        DialogLoadingWidget.dismiss(context);
        popUp.PopUpAlert(context, 'Erro ao atualizar aula: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.aula.name)),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 10),
              child: Column(
                children: [
                  ContainerWidget(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Código:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          InputPadraoWidget(maxLength: 50, readOnly: true, controller: codeCtrl),
                          
                          const Text('Nome:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          InputPadraoWidget(maxLength: 100, readOnly: false, controller: nameCtrl),

                          const SizedBox(height: 15),
                          Text('Ordem da Aula:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          ListaOrdemAulaWidget(
                            initialOrder: _selectedOrder,
                            onChanged: (newOrder) {
                              setState(() {
                                _selectedOrder = newOrder!;
                              });
                            },
                          ),
                          
                          const SizedBox(height: 15),
                          const Text('Curso:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          ListaCursoWidget(
                            initialCourseId: _selectedCourseId,
                            onChanged: (newId) {
                              setState(() {
                                _selectedCourseId = newId;
                              });
                            },
                          ),
                          const SizedBox(height: 20),

                          const Text('URL Vídeo:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          InputPadraoWidget(maxLength: 255, readOnly: false, controller: urlCtrl),
                          
                          const Text('Introdução / Conteúdo Principal:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          InputContentWidget(maxLength: 10000, controller: contentCtrl),

                          const Divider(height: 40, thickness: 1),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Tópicos de Leitura:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              IconButton(
                                onPressed: _addTopic,
                                icon: Icon(Icons.add_circle, color: Cores().laranja, size: 30),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          if (_topicControllers.isEmpty)
                            const Center(
                              child: Text(
                                "Nenhum tópico cadastrado.", 
                                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                              ),
                            ),

                          ..._topicControllers.asMap().entries.map((entry) {
                            int index = entry.key;
                            var ctrls = entry.value;

                            return TopicInputWidget(
                              index: index, 
                              titleCtrl: ctrls.title, 
                              contentCtrl: ctrls.textContent, 
                              onRemove: () => _removeTopic(index),
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BotaoLaranjaWidget(
                            txt: 'Excluir', 
                            tam: 150, 
                            onPressed: _asyncDeleteLesson,
                          ),
                          const SizedBox(width: 20),
                          BotaoLaranjaWidget(
                            txt: 'Salvar', 
                            tam: 150, 
                            onPressed: _asyncUpdateLesson,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      BotaoLaranjaWidget(
                        txt: 'Cancelar', 
                        tam: 150, 
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}