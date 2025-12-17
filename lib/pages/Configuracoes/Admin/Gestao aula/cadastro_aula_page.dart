import 'package:app_cas_natal/popup.dart';
import 'package:app_cas_natal/src/lesson/lesson_model.dart';
import 'package:app_cas_natal/src/lesson/lesson_provider.dart';
import 'package:app_cas_natal/widgets/botoes/bt_laranja_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_content_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_widget.dart';
import 'package:app_cas_natal/widgets/listas/lista_curso_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/container_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/dg_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CadastroAulaPage extends ConsumerStatefulWidget {
  const CadastroAulaPage({super.key});

  @override
  ConsumerState<CadastroAulaPage> createState() => _CadastroAulaPageState();
}

class _CadastroAulaPageState extends ConsumerState<CadastroAulaPage> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController glossaryCtrl = TextEditingController();
  final TextEditingController urlCtrl = TextEditingController();
  final TextEditingController contentCtrl = TextEditingController();
  final PopUp popUp = PopUp();
  String? _selectedCourseId;

  void asyncSaveLesson() async {
    if (nameCtrl.text.isEmpty || 
        urlCtrl.text.isEmpty || 
        contentCtrl.text.isEmpty ||
        _selectedCourseId == null) {
      if (mounted) {
        popUp.PopUpAlert(context, 'Preencha todos os campos obrigatórios (Nome, URL, Conteúdo e Curso).');
      }
      return;
    }

    final lesson = LessonModel(
      name: nameCtrl.text,
      completed: false, 
      url: urlCtrl.text,
      content: contentCtrl.text,
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
      appBar: AppBar(title: Text('Cadastro de aulas')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
          child: Column(
            children: [
              ContainerWidget(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///
                      Text('Nome:', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      InputPadraoWidget(maxLength: 100, controller: nameCtrl, readOnly: false),
                      ///
                      Text('Curso:', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      ListaCursoWidget(
                        onChanged: (newId) {
                          _selectedCourseId = newId;
                        },
                      ), 
                      SizedBox(height: 20),
                      ///
                      Text('Sinais do glossário:', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      InputPadraoWidget(maxLength: 50, controller: glossaryCtrl, readOnly: false),
                      ///
                      Text('URL Vídeo:', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      InputPadraoWidget(maxLength: 50, controller: urlCtrl, readOnly: false),
                      ///
                      Text('Conteúdo escrito:', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      InputContentWidget(maxLength: 10000, controller: contentCtrl),                        
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
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
    );
  }
}