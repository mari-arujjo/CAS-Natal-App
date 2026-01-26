// ignore_for_file: use_build_context_synchronously
import 'package:app_cas_natal/src/appuser/appuser_provider.dart';
import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/widgets/fotos/avatar_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:app_cas_natal/widgets/botoes/bt_menu_web_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ConfiguracoesPage extends ConsumerStatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  ConsumerState<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends ConsumerState<ConfiguracoesPage> {
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    final asyncUser = ref.watch(currentUserProvider);
    final larguraTela = MediaQuery.of(context).size.width;
    final isWeb = larguraTela > 1000;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        elevation: 0,
      ),
      body: asyncUser.when(
        data: (user) {
          if (user == null) return const Center(child: Text('Usuário inválido'));

          return SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1100),
                padding: EdgeInsets.symmetric(
                  horizontal: isWeb ? 30 : 20, 
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderPerfil(user, isWeb),
                    const SizedBox(height: 50),
                    
                    _buildSeccaoTitle("CONTA"),
                    const SizedBox(height: 10),
                    _buildMenuLayout(
                      context, 
                      isWeb, 
                      filtrarPor: ['Editar perfil', 'Redefinir senha', 'Sair']
                    ),
                    
                    const SizedBox(height: 40),

                    _buildSeccaoTitle("SISTEMA"),
                    const SizedBox(height: 10),
                    _buildMenuLayout(
                      context, 
                      isWeb, 
                      filtrarPor: ['Estatísticas', 'Opções de administrador', 'Sobre o app', 'Termos de serviço']
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        },
        loading: () => const CarregandoWidget(),
        error: (error, stackTrace) => Center(child: Text('Erro ao carregar usuário: $error')),
      ),
    );
  }

  Widget _buildSeccaoTitle(String titulo) {
    return Text(
      titulo,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Colors.grey[500],
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildHeaderPerfil(dynamic user, bool isWeb) {
    final asyncAvatar = ref.watch(avatarProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        asyncAvatar.maybeWhen(
          data: (imgBytes) => AvatarWidget(tam: isWeb ? 60 : 45, imgBytes: imgBytes),
          orElse: () => AvatarWidget(tam: isWeb ? 60 : 45, imgBytes: null),
        ),
        const SizedBox(width: 25),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.fullName,
                style: TextStyle(
                  fontSize: isWeb ? 28 : 22, 
                  fontWeight: FontWeight.bold, 
                  color: cores.azulEscuro
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 15,
                runSpacing: 5,
                children: [
                  _buildInfoItem("Usuário:", "@${user.userName}"),
                  _buildInfoItem("Email:", user.email),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label ",
            style: TextStyle(color: cores.azulEscuro, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuLayout(BuildContext context, bool isWeb, {required List<String> filtrarPor}) {
    final itens = _listagemItensMenu(context).where((i) => filtrarPor.contains(i['titulo'])).toList();

    if (isWeb) {
      return Container(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 2.8, 
          ),
          itemCount: itens.length,
          itemBuilder: (context, index) => _buildMenuCard(itens[index]),
        )
      );
    }

    return Column(
      children: itens.map((item) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _buildMenuCard(item),
      )).toList(),
    );
  }

  Widget _buildMenuCard(Map<String, dynamic> item) {
    return MenuBotaoWidget(
      titulo: item['titulo'],
      subtitulo: item['subtitulo'],
      icone: item['icone'],
      cor: item['cor'],
      onPressed: item['onPressed'],
    );
  }

  List<Map<String, dynamic>> _listagemItensMenu(BuildContext context) {
    return [
      {'titulo': 'Editar perfil', 'subtitulo': 'Dados pessoais e contato', 'icone': Icons.person_outline, 'cor': cores.laranja, 'onPressed': () => context.goNamed('EditarPerfil')},
      {'titulo': 'Redefinir senha', 'subtitulo': 'Altere sua senha de acesso', 'icone': Icons.lock_open_outlined, 'cor': const Color.fromARGB(255, 108, 82, 255), 'onPressed': () => context.goNamed('RedefinirSenha')},
      {'titulo': 'Sair', 'subtitulo': 'Encerrar sessão atual', 'icone': Icons.logout_rounded, 'cor': Colors.red[400], 'onPressed': () => _dialogSair(context)},
      {'titulo': 'Estatísticas', 'subtitulo': 'Visualizar uso e progresso', 'icone': Icons.auto_graph_outlined, 'cor': const Color.fromARGB(255, 5, 173, 157), 'onPressed': () => context.goNamed('Estatisticas')},
      {'titulo': 'Opções de administrador', 'subtitulo': 'Gestão de usuários e sistema', 'icone': Icons.admin_panel_settings_outlined, 'cor': const Color.fromARGB(255, 239, 0, 179), 'onPressed': () => context.goNamed('Admin')},
      {'titulo': 'Sobre o app', 'subtitulo': 'Versão e informações', 'icone': Icons.help_outline, 'cor': Colors.indigo, 'onPressed': () => context.goNamed('Sobre')},
      {'titulo': 'Termos de serviço', 'subtitulo': 'Regras e privacidade', 'icone': Icons.assignment_outlined, 'cor': Colors.blueGrey, 'onPressed': () => context.goNamed('Termos')},
    ];
  }

  Future<void> _dialogSair(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sair'),
        content: Text('Tem certeza que deseja sair? Você terá que fazer login novamente.'),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: Text('Cancelar', style: TextStyle(color: cores.azulEscuro)),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(secureStorageProvider).deleteAll();
              if (!mounted) return;
              context.pop(true);
              context.goNamed('LoginRegister');
            },
            child: Text('Sim', style: TextStyle(color: cores.azulEscuro)),
          ),
        ],
      )
    );
  }
}