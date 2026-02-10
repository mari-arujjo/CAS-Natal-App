import 'package:app_cas_natal/popup.dart';
import 'package:app_cas_natal/src/appuser/appuser_model.dart';
import 'package:app_cas_natal/widgets/botoes/bt_laranja_widget.dart';
import 'package:app_cas_natal/widgets/fotos/avatar_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_widget.dart';
import 'package:app_cas_natal/widgets/listas/lista_role_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPage extends ConsumerStatefulWidget {
  final AppUserModel? user;
  const UserPage({super.key, this.user});

  @override
  ConsumerState<UserPage> createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
  late final TextEditingController nameCtrl;
  late final TextEditingController userCtrl;
  late final TextEditingController emailCtrl;
  late final TextEditingController roleCtrl;
  final PopUp popUp = PopUp();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.user?.fullName);
    userCtrl = TextEditingController(text: widget.user?.userName);
    emailCtrl = TextEditingController(text: widget.user?.email);
    roleCtrl = TextEditingController(text: widget.user?.privateRole);
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    userCtrl.dispose();
    emailCtrl.dispose();
    roleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('@${widget.user?.userName ?? "usuário"}')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  AvatarWidget(
                    tam: 60,
                    imgBytes: widget.user?.avatar, 
                  ),
                  const SizedBox(height: 20),
                  ContainerWidget(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Nome:', style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 5),
                          InputPadraoWidget(
                            maxLength: 50,
                            controller: nameCtrl,
                            readOnly: false,
                          ),
                          const SizedBox(height: 15),
                          const Text('Usuário:', style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 5),
                          InputPadraoWidget(
                            maxLength: 20,
                            controller: userCtrl,
                            readOnly: false,
                          ),
                          const SizedBox(height: 15),
                          const Text('Email:', style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 5),
                          InputPadraoWidget(
                            maxLength: 150,
                            controller: emailCtrl,
                            readOnly: false,
                          ),
                          const SizedBox(height: 15),
                          const Text('Role:', style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 5),
                          ListaRoleWidget(txt: widget.user?.privateRole ?? 'Default'),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BotaoLaranjaWidget(
                        txt: 'Salvar',
                        onPressed: () {
                        },
                        tam: 120,
                      ),
                      const SizedBox(width: 20),
                      BotaoLaranjaWidget(
                        txt: 'Cancelar',
                        onPressed: () => Navigator.pop(context),
                        tam: 120,
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