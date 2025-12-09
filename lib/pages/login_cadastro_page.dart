import 'package:app_cas_natal/src/appuser/appuser_provider.dart';
import 'package:app_cas_natal/widgets/vizualizacao/dg_loading_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/popup.dart';
import 'package:app_cas_natal/widgets/botoes_padrao/bt_laranja_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_icon_widget.dart';
import 'package:app_cas_natal/widgets/inputs/ipt_senha_outline_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    if(username.isEmpty || password.isEmpty) {
      popUp.PopUpAlert(context, "Preencha usuário e senha.");
      return;
    }

    DialogLoadingWidget.showLoading(context);

    try {
      final user = await ref.read(userRepositoryProvider).login(userName: username,password: password);
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
      popUp.PopUpAlert(context, e);
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
    if(name.isEmpty || username.isEmpty || email.isEmpty || pass1.isEmpty) {
      popUp.PopUpAlert(context, "Preencha todos os campos.");
      return;
    }

    DialogLoadingWidget.showLoading(context);

    try {
      await ref.read(userRepositoryProvider).register(fullName: name, userName: username, email: email, password: pass1);
      final user = await ref.read(userRepositoryProvider).login(userName: username,password: pass1);
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
      popUp.PopUpAlert(context, e);
      rethrow;
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
            tabs: [Tab(text: 'Login'), Tab(text: 'Cadastro')],
          ),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxContentWidth),
            child: TabBarView(
              children: [_buildLoginForm(cor), _buildRegisterForm(cor)],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(Cores cor) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset('assets/avatar/menino2.png', height: 150),
            SizedBox(height: 20),
            Text('Bem vindo de volta!', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ContainerWidget(
              child: Form(
                child: Column(
                  children: [
                    InputOutline(txt: "Usuário", ico: Icon(Icons.person), controller: usernameLoginCtrl),
                    SizedBox(height: 15),
                    InputOutlineSenha(txt: "Senha", controller: passwordLoginCtrl),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            BotaoLaranjaWidget(
              txt: 'Entrar',
              onPressed: () async { 
                asyncLogin();
              },
              tam: 1000,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterForm(Cores cor) {
     return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset('assets/avatar/menina2.png', height: 130),
            SizedBox(height: 20),
            Text('Crie agora a sua conta!', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ContainerWidget(
              child: Form(
                child: Column(
                  children: [
                    InputOutline(txt: "Nome", ico: Icon(Icons.person), controller: nameCadastroCtrl),
                    SizedBox(height: 15),
                    InputOutline(txt: "Username", ico: Icon(Icons.alternate_email), controller: usernameCadastroCtrl),
                    SizedBox(height: 15),
                    InputOutline(txt: "Email", ico: Icon(Icons.email), controller: emailCadastroCtrl),
                    SizedBox(height: 15),
                    InputOutlineSenha(txt: "Senha", controller: passwordCadastroCtrl),
                    SizedBox(height: 15),
                    InputOutlineSenha(txt: "Confirmar senha", controller: password2CadastroCtrl),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            BotaoLaranjaWidget(
              txt: 'Cadastrar',
              onPressed: () async {
                  asyncRegisterLogin();
                },
              tam: 1000,
            ),
          ],
        ),
      ),
    );
  }
}