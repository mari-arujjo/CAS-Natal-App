import 'dart:io';
import 'dart:typed_data';
import 'package:app_cas_natal/widgets/vizualizacao/dg_loading_widget.dart';
import 'package:app_cas_natal/src/course/course_model.dart';
import 'package:app_cas_natal/popup.dart';
import 'package:app_cas_natal/src/course/course_provider.dart';
import 'package:app_cas_natal/widgets/botoes/bt_icon_widget.dart';
import 'package:app_cas_natal/widgets/botoes_padrao/bt_laranja_widget.dart';
import 'package:app_cas_natal/widgets/fotos/foto_curso_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_descricao_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CadastroCursoPage extends ConsumerStatefulWidget {
  const CadastroCursoPage({super.key});

  @override
  ConsumerState<CadastroCursoPage> createState() => _CadastroCursoPageState();
}

class _CadastroCursoPageState extends ConsumerState<CadastroCursoPage> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController symbolCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();
  final PopUp popUp = PopUp();
  File? img;
  bool changePhoto = false;
  Uint8List? imgBytes;
  final picker = ImagePicker();

  void pickImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        img = File(pickedFile.path);
        imgBytes = bytes;
        changePhoto = true;
      });
    }
  }

  void asyncSaveCourse() async {
    if (nameCtrl.text.isEmpty || symbolCtrl.text.isEmpty || descriptionCtrl.text.isEmpty) {
      if (mounted) {
        popUp.PopUpAlert(context, 'Preencha os campos obrigatórios.');
      }
      return;
    }

    final course = CourseModel(
      name: nameCtrl.text,
      symbol: symbolCtrl.text,
      description: descriptionCtrl.text,
      photo: imgBytes,
    );

    DialogLoadingWidget.showLoading(context);

    try {
      await ref.read(courseProvider.notifier).addCourse(course);

      if (mounted) {
        DialogLoadingWidget.dismiss(context);
        popUp.PopUpSalvar(context);
      }
    } catch (e) {
      if (mounted) {
        DialogLoadingWidget.dismiss(context);
        popUp.PopUpAlert(context, 'Erro: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de cursos')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ContainerWidget(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          FotoCursoWidget(
                            height: 100,
                            imgFile: img,
                            imgBytes: imgBytes,
                          ),
                          BotaoIconWidget(
                            icon: const Icon(Icons.edit),
                            onPressed: pickImageGallery,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      const Text('Nome:', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 5),
                      InputPadraoWidget(maxLength: 50, controller: nameCtrl, readOnly: false),
                      
                      const Text('Abreviação:', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 5),
                      InputPadraoWidget(maxLength: 4, controller: symbolCtrl, readOnly: false),
                      
                      const Text('Descrição:', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 5),
                      InputDescricaoWidget(maxLength: 150, controller: descriptionCtrl),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BotaoLaranjaWidget(txt: 'Cancelar', tam: 150, onPressed: () => Navigator.of(context).pop()),
                  const SizedBox(width: 20),
                  BotaoLaranjaWidget(
                    txt: 'Salvar',
                    tam: 150,
                    onPressed: asyncSaveCourse,
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