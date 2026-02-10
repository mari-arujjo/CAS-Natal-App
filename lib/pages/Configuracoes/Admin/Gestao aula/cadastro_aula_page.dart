import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/popup.dart';
import 'package:app_cas_natal/src/lesson/lesson_model.dart';
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
  final TextEditingController title = TextEditingController();
  final TextEditingController textContent = TextEditingController();

  void dispose() {
    title.dispose();
    textContent.dispose();
  }
}

class CadastroAulaPage extends ConsumerStatefulWidget {
  const CadastroAulaPage({super.key});

  @override
  ConsumerState<CadastroAulaPage> createState() => _CadastroAulaPageState();
}

class _CadastroAulaPageState extends ConsumerState<CadastroAulaPage> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController urlCtrl = TextEditingController();
  final TextEditingController contentCtrl = TextEditingController();
  final List<TopicControllerGroup> _topicControllers = [];
  int _selectedOrder = 1;
  final PopUp popUp = PopUp();
  String? _selectedCourseId;

  @override
  void dispose() {
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

  void asyncSaveLesson() async {
    if (nameCtrl.text.isEmpty || urlCtrl.text.isEmpty || contentCtrl.text.isEmpty || _selectedCourseId == null) {
      if (mounted) {
        popUp.PopUpAlert(context, 'Preencha todos os campos obrigatórios.');
      }
      return;
    }

    List<LessonTopicModel> topics = _topicControllers.asMap().entries.map((entry) {
      int index = entry.key;
      var ctrls = entry.value;
      return LessonTopicModel(
        order: index + 1,
        title: ctrls.title.text,
        textContent: ctrls.textContent.text,
      );
    }).toList();

    final lesson = LessonModel(
      name: nameCtrl.text,
      order: _selectedOrder,
      completed: false, 
      url: urlCtrl.text,
      content: contentCtrl.text,
      topics: topics,
      courseId: _selectedCourseId,
    );

    DialogLoadingWidget.showLoading(context);
    try {
      await ref.read(lessonProvider.notifier).addLesson(lesson);
      if (mounted) {
        DialogLoadingWidget.dismiss(context);
        popUp.PopUpSalvar(context);
      }
    } catch (e) {
      if (mounted) {
        DialogLoadingWidget.dismiss(context);
        popUp.PopUpAlert(context, 'Erro ao cadastrar aula: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de aulas'), centerTitle: true),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ContainerWidget(
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nome da Aula:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          InputPadraoWidget(maxLength: 100, controller: nameCtrl, readOnly: false),
                          
                          SizedBox(height: 15),
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

                          SizedBox(height: 15),
                          Text('Curso:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          ListaCursoWidget(onChanged: (newId) => _selectedCourseId = newId), 
                          
                          SizedBox(height: 20),
                          Text('URL Vídeo:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          InputPadraoWidget(maxLength: 255, controller: urlCtrl, readOnly: false),
                          
                          Text('Introdução:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          InputContentWidget(maxLength: 5000, controller: contentCtrl),

                          Divider(height: 40, thickness: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tópicos de Leitura:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              IconButton(
                                onPressed: _addTopic,
                                icon: Icon(Icons.add_circle, color: Cores().laranja, size: 30),
                              ),
                            ],
                          ),
                          ..._topicControllers.asMap().entries.map((entry) {
                            return TopicInputWidget(
                              index: entry.key, 
                              titleCtrl: entry.value.title, 
                              contentCtrl: entry.value.textContent, 
                              onRemove: () => _removeTopic(entry.key),
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BotaoLaranjaWidget(txt: 'Cancelar', onPressed: () => Navigator.of(context).pop(), tam: 150),
                      SizedBox(width: 20),
                      BotaoLaranjaWidget(txt: 'Salvar', onPressed: asyncSaveLesson, tam: 150),
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