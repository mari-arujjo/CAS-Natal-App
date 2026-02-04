import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app_cas_natal/src/appuser/appuser_provider.dart';
import 'package:app_cas_natal/widgets/vizualizacao/dg_loading_widget.dart';
import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/popup.dart';
import 'package:app_cas_natal/widgets/botoes/bt_laranja_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_icon_widget.dart';
import 'package:app_cas_natal/widgets/inputs/ipt_senha_outline_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/container_widget.dart';

class LoginRegisterPage extends ConsumerStatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  ConsumerState<LoginRegisterPage> createState() => _LoginState();
}

class _LoginState extends ConsumerState<LoginRegisterPage> {
  final TextEditingController usernameLoginCtrl = TextEditingController();
  final TextEditingController passwordLoginCtrl = TextEditingController();
  final TextEditingController nameCadastroCtrl = TextEditingController();
  final TextEditingController usernameCadastroCtrl = TextEditingController();
  final TextEditingController emailCadastroCtrl = TextEditingController();
  final TextEditingController passwordCadastroCtrl = TextEditingController();
  final TextEditingController password2CadastroCtrl = TextEditingController();
  
  final cor = Cores();
  final PopUp popUp = PopUp();

  void asyncLogin() async {
    final username = usernameLoginCtrl.text;
    final password = passwordLoginCtrl.text;
    if (username.isEmpty || password.isEmpty) {
      popUp.PopUpAlert(context, "Preencha usuário e senha.");
      return;
    }

    DialogLoadingWidget.showLoading(context);
    try {
      final user = await ref.read(userRepositoryProvider).login(userName: username, password: password);
      if (!mounted) return;
      DialogLoadingWidget.dismiss(context);
      if (user.token != null && user.token!.isNotEmpty) {
        await ref.read(secureStorageProvider).write(key: 'token', value: user.token!);
        if (!mounted) return;
        context.pushReplacement('/cursos');
      }
    } catch (e) {
      if (!mounted) return;
      DialogLoadingWidget.dismiss(context);
      popUp.PopUpAlert(context, e.toString());
    }
  }

  void asyncRegisterLogin() async {
    final name = nameCadastroCtrl.text;
    final username = usernameCadastroCtrl.text;
    final email = emailCadastroCtrl.text;
    final pass1 = passwordCadastroCtrl.text;
    final pass2 = password2CadastroCtrl.text;

    if (pass1 != pass2) {
      popUp.PopUpAlert(context, "As senhas não conferem.");
      return;
    }
    if (name.isEmpty || username.isEmpty || email.isEmpty || pass1.isEmpty) {
      popUp.PopUpAlert(context, "Preencha todos os campos.");
      return;
    }

    DialogLoadingWidget.showLoading(context);
    try {
      await ref.read(userRepositoryProvider).register(fullName: name, userName: username, email: email, password: pass1);
      final user = await ref.read(userRepositoryProvider).login(userName: username, password: pass1);
      if (!mounted) return;
      DialogLoadingWidget.dismiss(context);
      if (user.token != null && user.token!.isNotEmpty) {
        await ref.read(secureStorageProvider).write(key: 'token', value: user.token!);
        if (!mounted) return;
        context.pushReplacement('/cursos');
      }
    } catch (e) {
      if (!mounted) return;
      DialogLoadingWidget.dismiss(context);
      popUp.PopUpAlert(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    const double maxContentWidth = 400;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 5,
          bottom: TabBar(
            indicatorColor: cor.azulEscuro,
            labelColor: cor.azulEscuro,
            unselectedLabelColor: Colors.grey,
            tabs: const [Tab(text: 'Login'), Tab(text: 'Cadastro')],
          ),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxContentWidth),
            child: TabBarView(
              children: [
                _buildLoginForm(cor),
                _buildRegisterForm(cor)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(Cores cor) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.enter): () => asyncLogin(),
        const SingleActivator(LogicalKeyboardKey.numpadEnter): () => asyncLogin(),
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Image.asset('assets/avatar/menino2.png', height: 150),
            const SizedBox(height: 20),
            const Text('Bem vindo de volta!', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ContainerWidget(
              child: Column(
                children: [
                  InputOutline(
                    txt: "Usuário",
                    ico: const Icon(Icons.person),
                    controller: usernameLoginCtrl,
                  ),
                  const SizedBox(height: 15),
                  InputOutlineSenha(
                    txt: "Senha",
                    controller: passwordLoginCtrl,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            BotaoLaranjaWidget(
              txt: 'Entrar',
              onPressed: asyncLogin,
              tam: 1000,
            ),
            SizedBox(height: 50),
            Text(
              'CAS Natal/RN + IFRN\nDesenvolvido por Mariana Araújo',
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterForm(Cores cor) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.enter): () => asyncRegisterLogin(),
        const SingleActivator(LogicalKeyboardKey.numpadEnter): () => asyncRegisterLogin(),
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Image.asset('assets/avatar/menina2.png', height: 130),
            const SizedBox(height: 20),
            const Text('Crie agora a sua conta!', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ContainerWidget(
              child: Column(
                children: [
                  InputOutline(txt: "Nome", ico: const Icon(Icons.person), controller: nameCadastroCtrl),
                  const SizedBox(height: 15),
                  InputOutline(txt: "Username", ico: const Icon(Icons.alternate_email), controller: usernameCadastroCtrl),
                  const SizedBox(height: 15),
                  InputOutline(txt: "Email", ico: const Icon(Icons.email), controller: emailCadastroCtrl),
                  const SizedBox(height: 15),
                  InputOutlineSenha(txt: "Senha", controller: passwordCadastroCtrl),
                  const SizedBox(height: 15),
                  InputOutlineSenha(txt: "Confirmar senha", controller: password2CadastroCtrl),
                ],
              ),
            ),
            const SizedBox(height: 20),
            BotaoLaranjaWidget(
              txt: 'Cadastrar',
              onPressed: asyncRegisterLogin,
              tam: 1000,
            ),
            SizedBox(height: 50),
            Text(
              'CAS Natal/RN + IFRN\nDesenvolvido por Mariana Araújo',
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}