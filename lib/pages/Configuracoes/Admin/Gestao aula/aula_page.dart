import 'package:app_cas_natal/src/lesson/lesson_model.dart';
import 'package:app_cas_natal/popup.dart';
import 'package:app_cas_natal/src/lesson/lesson_provider.dart'; // Import necessário
import 'package:app_cas_natal/widgets/botoes/bt_laranja_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_content_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_widget.dart';
import 'package:app_cas_natal/widgets/listas/lista_curso_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/container_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/dg_loading_widget.dart'; // Import necessário
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  String? _selectedCourseId;
  final popUp = PopUp();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    codeCtrl = TextEditingController(text: widget.aula.lessonCode);
    nameCtrl = TextEditingController(text: widget.aula.name);
    urlCtrl = TextEditingController(text: widget.aula.url);
    contentCtrl = TextEditingController(text: widget.aula.content);
    _selectedCourseId = widget.aula.courseId;
  }
  
  void _asyncDeleteLesson() async {
    DialogLoadingWidget.showLoading(context);
    try {
      await ref.read(lessonProvider.notifier).deleteLesson(widget.aula.id!);
      if (context.mounted) {
        DialogLoadingWidget.dismiss(context);
        popUp.PopUpExcluido(context);
      }
    } catch (e) {
      if (context.mounted) {
        DialogLoadingWidget.dismiss(context);
        popUp.PopUpAlert(context, 'Erro ao excluir aula: $e');
      }
    }
  }

  void _asyncUpdateLesson() async {
    if (nameCtrl.text == widget.aula.name && 
        urlCtrl.text == widget.aula.url && 
        contentCtrl.text == widget.aula.content &&
        _selectedCourseId == widget.aula.courseId) {
      popUp.PopUpAlert(context, 'Nenhum dado foi alterado.');
      return;
    }
    
    if (nameCtrl.text.isEmpty || urlCtrl.text.isEmpty || contentCtrl.text.isEmpty || _selectedCourseId == null) {
      popUp.PopUpAlert(context, 'Preencha os campos obrigatórios.');
      return;
    }
    
    final lessonAtualizada = LessonModel(
      id: widget.aula.id, 
      lessonCode: widget.aula.lessonCode,
      name: nameCtrl.text, 
      completed: widget.aula.completed, 
      url: urlCtrl.text, 
      content: contentCtrl.text,
    );

    DialogLoadingWidget.showLoading(context);
    try{
      await ref.read(lessonProvider.notifier).updateLesson(lessonAtualizada, widget.aula.id!);
      
      if (context.mounted) {
        DialogLoadingWidget.dismiss(context);
        popUp.PopUpAlterado(context);
      }
    } catch(e){
      if (context.mounted) {
        DialogLoadingWidget.dismiss(context);
        popUp.PopUpAlert(context, 'Erro ao atualizar aula: $e');
      }
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.aula.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: Column(
            children: [
              ContainerWidget(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///
                      const Text('Código:', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 5),
                      InputPadraoWidget(maxLength: 50, readOnly: true, controller: codeCtrl),
                      ///
                      const Text('Nome:', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 5),
                      InputPadraoWidget(maxLength: 100, readOnly: false, controller: nameCtrl),
                      ///
                      const Text('Curso:', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 5),
                      ListaCursoWidget(
                        initialCourseId: _selectedCourseId,
                        onChanged: (newId) {
                          setState(() {
                            _selectedCourseId = newId;
                          });
                        },
                      ), 
                      const SizedBox(height: 25),
                      ///
                      const Text('Sinais do glossário:', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 5),
                      InputPadraoWidget(maxLength: 50, readOnly: false),
                      ///
                      const Text('URL Vídeo:', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 5),
                      InputPadraoWidget(maxLength: 50, readOnly: false, controller: urlCtrl),
                      ///
                      const Text('Conteúdo escrito:', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 5),
                      InputContentWidget(maxLength: 10000, controller: contentCtrl,),                        
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    onPressed: (){
                      Navigator.of(context).pop();
                    }
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}