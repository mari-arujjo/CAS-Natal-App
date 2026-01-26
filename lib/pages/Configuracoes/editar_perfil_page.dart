// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/popup.dart';
import 'package:app_cas_natal/snackbar.dart';
import 'package:app_cas_natal/src/appuser/appuser_model.dart';
import 'package:app_cas_natal/src/appuser/appuser_provider.dart';
import 'package:app_cas_natal/widgets/botoes/bt_icon_widget.dart';
import 'package:app_cas_natal/widgets/botoes/bt_laranja_widget.dart';
import 'package:app_cas_natal/widgets/fotos/avatar_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/container_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/dg_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';

class EditarPerfilPage extends ConsumerStatefulWidget {
  const EditarPerfilPage({super.key});

  @override
  ConsumerState<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends ConsumerState<EditarPerfilPage> {
  late TextEditingController nameCtrl;
  late TextEditingController userNameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController roleCtrl;
  final cores = Cores();
  final PopUp popUp = PopUp();
  File? img;
  bool changePhoto = false;
  Uint8List? imgBytes;
  final picker = ImagePicker();
  bool _isInitialized = false;

  void _initializeControllers(AppUserModel user, Uint8List? loadedAvatar) {
    if (!_isInitialized) {
      nameCtrl = TextEditingController(text: user.fullName);
      userNameCtrl = TextEditingController(text: user.userName);
      emailCtrl = TextEditingController(text: user.email);
      roleCtrl = TextEditingController(text: user.privateRole);

      if (img == null && loadedAvatar != null) {
        imgBytes = loadedAvatar;
      }
      _isInitialized = true;
    }
    if (nameCtrl.text != user.fullName) {
      nameCtrl.text = user.fullName;
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    userNameCtrl.dispose();
    emailCtrl.dispose();
    roleCtrl.dispose();
    super.dispose();
  }

  pickImageGallery() async {
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

  void asyncUpdate(AppUserModel user) async {
    final newFullName = nameCtrl.text;
    final newUserName = userNameCtrl.text;
    final newEmail = emailCtrl.text;

    final dataChanged = newFullName != user.fullName ||
        newUserName != user.userName ||
        newEmail != user.email;

    if (newFullName.isEmpty) {
      if (!mounted) return;
      popUp.PopUpAlert(context, "O campo 'Nome' não pode ser vazio.");
      return;
    }
    if (!dataChanged && !changePhoto) {
      if (!mounted) return;
      popUp.PopUpAlert(context, "Nenhuma alteração detectada.");
      return;
    }

    DialogLoadingWidget.showLoading(context);

    try {
      final repository = ref.read(userRepositoryProvider);
      AppUserModel updatedUser = user;
      final token = user.token!;
      final storage = ref.read(secureStorageProvider);

      if (changePhoto) {
        String? base64Avatar;
        if (imgBytes != null) {
          base64Avatar = base64Encode(imgBytes!);
        }
        updatedUser =
            await repository.updateAvatar(token: token, avatar: base64Avatar);
        if (updatedUser.token != null && updatedUser.token!.isNotEmpty) {
          await storage.write(key: 'token', value: updatedUser.token!);
        }
        ref.invalidate(avatarProvider);
      }

      if (dataChanged) {
        final latestToken = updatedUser.token!;
        updatedUser = await repository.update(
          token: latestToken,
          fullName: newFullName,
          userName: newUserName,
          email: newEmail,
        );

        if (updatedUser.token != null && updatedUser.token!.isNotEmpty) {
          await storage.write(key: 'token', value: updatedUser.token!);
        }
      }

      ref.invalidate(currentUserProvider);

      if (!mounted) return;
      DialogLoadingWidget.dismiss(context);

      context.pop();

      SnackBarUtils.showCustomSnackbar(
        context,
        "Perfil atualizado com sucesso!",
        cores.azulEscuro,
      );
    } catch (e) {
      if (!mounted) return;
      DialogLoadingWidget.dismiss(context);
      popUp.PopUpAlert(context, 'Erro ao atualizar: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncUser = ref.watch(currentUserProvider);
    final asyncAvatar = ref.watch(avatarProvider);

    if (asyncUser.isLoading || asyncAvatar.isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Carregando...')),
        body: const Center(child: CarregandoWidget()),
      );
    }

    if (asyncUser.hasError || asyncAvatar.hasError) {
      return Scaffold(
        appBar: AppBar(title: const Text('Erro')),
        body: Center(
            child: Text('Erro ao carregar dados: ${asyncUser.error ?? asyncAvatar.error}')),
      );
    }

    final user = asyncUser.value;
    final loadedAvatar = asyncAvatar.value;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Erro')),
        body: const Center(child: Text('Dados do usuário não encontrados.')),
      );
    }

    _initializeControllers(user, loadedAvatar);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar perfil'),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      AvatarWidget(
                        tam: 60,
                        imgFile: img,
                        imgBytes: imgBytes,
                      ),
                      BotaoIconWidget(
                        icon: const Icon(Icons.edit),
                        onPressed: pickImageGallery,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ContainerWidget(
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Nome:', style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          InputPadraoWidget(
                            maxLength: 50,
                            readOnly: false,
                            controller: nameCtrl,
                          ),
                          const SizedBox(height: 15),
                          const Text('Usuário:', style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          InputPadraoWidget(
                            maxLength: 20,
                            readOnly: false,
                            controller: userNameCtrl,
                          ),
                          const SizedBox(height: 15),
                          const Text('Email:', style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          InputPadraoWidget(
                            maxLength: 150,
                            readOnly: false,
                            controller: emailCtrl,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BotaoLaranjaWidget(
                        txt: 'Salvar',
                        onPressed: () => asyncUpdate(user),
                        tam: 150,
                      ),
                      const SizedBox(width: 20),
                      BotaoLaranjaWidget(
                        txt: 'Cancelar',
                        onPressed: () => context.pop(),
                        tam: 150,
                      ),
                    ],
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