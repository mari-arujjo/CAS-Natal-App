// ignore_for_file: use_build_context_synchronously
import 'package:app_cas_natal/src/appuser/appuser_provider.dart';
import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/widgets/botoes/bt_laranja_widget.dart';
import 'package:app_cas_natal/widgets/botoes/bt_menu_widget.dart'; // Seu botão original
import 'package:app_cas_natal/widgets/fotos/avatar_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:app_cas_natal/widgets/botoes/bt_menu_web_widget.dart'; // O novo componente
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
    final asyncAvatar = ref.watch(avatarProvider);
    final larguraTela = MediaQuery.of(context).size.width;
    final isWeb = larguraTela > 850;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: asyncUser.when(
        data: (user) {
          if (user == null) return const Center(child: Text('Usuário inválido'));

          final avatarWidget = asyncAvatar.when(
            data: (imgBytes) => AvatarWidget(
              tam: 50,
              imgBytes: imgBytes,
            ),
            loading: () => AvatarWidget(tam: 50, imgBytes: null),
            error: (e, s) => AvatarWidget(tam: 50, imgBytes: null),
          );

          return SingleChildScrollView(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: isWeb ? 30 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        avatarWidget,
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.fullName,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                user.email,
                                style: TextStyle(
                                  color: cores.azulEscuro,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    BotaoLaranjaWidget(
                      txt: 'Editar perfil',
                      onPressed: () => context.goNamed('EditarPerfil'),
                      tam: isWeb ? 220 : double.infinity,
                    ),
                    SizedBox(height: 40),
                    isWeb 
                      ? _buildGridMenu(context) 
                      : _buildListaMenu(context),
                  ],
                ),
              ),
            ),
          );
        },
        loading: () => const CarregandoWidget(),
        error: (error, stackTrace) => Center(child: Text('Erro: $error')),
      ),
    );
  }

  // Layout para Web/Telas Grandes
  Widget _buildGridMenu(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 2.2,
      children: _listagemItensMenu(context).map((item) {
        return BotaoMenuWebWidget(
          titulo: item['titulo'],
          subtitulo: item['subtitulo'],
          icone: item['icone'],
          onPressed: item['onPressed'],
        );
      }).toList(),
    );
  }

  Widget _buildListaMenu(BuildContext context) {
    return Column(
      children: _listagemItensMenu(context).map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: BotaoMenuWidget(
            onPressed: item['onPressed'],
            txt: item['titulo'],
            tam: double.infinity,
            iconInicio: item['icone'],
          ),
        );
      }).toList(),
    );
  }

  List<Map<String, dynamic>> _listagemItensMenu(BuildContext context) {
    return [
      {
        'titulo': 'Estatísticas',
        'subtitulo': 'Acompanhe seu progresso',
        'icone': Icons.bar_chart,
        'onPressed': () => context.goNamed('Estatisticas'),
      },
      {
        'titulo': 'Opções de administrador',
        'subtitulo': 'Gerencie configurações avançadas',
        'icone': Icons.admin_panel_settings,
        'onPressed': () => context.goNamed('Admin'),
      },
      {
        'titulo': 'Redefinir senha',
        'subtitulo': 'Altere sua senha de acesso',
        'icone': Icons.lock,
        'onPressed': () => context.goNamed('RedefinirSenha'),
      },
      {
        'titulo': 'Sobre o app',
        'subtitulo': 'Saiba mais sobre o aplicativo',
        'icone': Icons.info,
        'onPressed': () => context.goNamed('Sobre'),
      },
      {
        'titulo': 'Termos de serviço',
        'subtitulo': 'Leia os termos e condições',
        'icone': Icons.description,
        'onPressed': () => context.goNamed('Termos'),
      },
      {
        'titulo': 'Sair',
        'subtitulo': 'Desconectar da sua conta',
        'icone': Icons.logout,
        'onPressed': () => _dialogSair(context),
      },
    ];
  }

  Future<void> _dialogSair(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sair'),
          content: const Text(
            'Tem certeza que deseja sair? Você terá que fazer login novamente.',
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(false),
              child: Text('Não', style: TextStyle(color: cores.azulEscuro)),
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
        );
      },
    );
  }
}