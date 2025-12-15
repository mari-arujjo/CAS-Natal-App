// ignore_for_file: use_build_context_synchronously
import 'package:app_cas_natal/src/appuser/appuser_provider.dart';
import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/widgets/botoes/bt_laranja_widget.dart';
import 'package:app_cas_natal/widgets/botoes/bt_menu_widget.dart';
import 'package:app_cas_natal/widgets/fotos/avatar_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
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

    return Scaffold(
      appBar: AppBar(toolbarHeight: 40),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: Column(
              children: [
                asyncUser.when(
                  data: (user) {
                    if (user == null) return Text('Usuário inválido');
                    final avatarWidget = asyncAvatar.when(
                      data: (imgBytes) => AvatarWidget(
                        tam: 40,
                        imgBytes: imgBytes,
                      ),
                      loading: () => AvatarWidget(tam: 40, imgBytes: null),
                      error: (e, s) => AvatarWidget(tam: 40, imgBytes: null),
                    );

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 15),
                            avatarWidget,
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.fullName,
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                  ),
                                  Text(
                                    user.email,
                                    style: TextStyle(
                                      color: cores.azulEscuro,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),
                        BotaoLaranjaWidget(
                          txt: 'Editar perfil',
                          onPressed: () {
                            context.goNamed('EditarPerfil');
                          },
                          tam: 360,
                        ),

                        SizedBox(height: 30),
                        BotaoMenuWidget(
                          onPressed: () {
                            context.goNamed('Estatisticas');
                          },
                          txt: 'Estatísticas',
                          tam: 360,
                          iconInicio: Icons.bar_chart,
                        ),

                        SizedBox(height: 5),
                        BotaoMenuWidget(
                          onPressed: () {
                            context.goNamed('Admin');
                          },
                          txt: 'Opções de administrador',
                          tam: 360,
                          iconInicio: Icons.admin_panel_settings,
                        ),

                        SizedBox(height: 5),
                        BotaoMenuWidget(
                          onPressed: () {
                            context.goNamed('RedefinirSenha');
                          },
                          txt: 'Redefinir senha',
                          tam: 360,
                          iconInicio: Icons.lock,
                        ),

                        SizedBox(height: 5),
                        BotaoMenuWidget(
                          onPressed: () {
                            context.goNamed('Sobre');
                          },
                          txt: 'Sobre o app',
                          tam: 360,
                          iconInicio: Icons.info,
                        ),

                        SizedBox(height: 5),
                        BotaoMenuWidget(
                          onPressed: () {
                            context.goNamed('Termos');
                          },
                          txt: 'Termos de serviço',
                          tam: 360,
                          iconInicio: Icons.description,
                        ),

                        SizedBox(height: 5),
                        BotaoMenuWidget(
                          onPressed: () async {
                            return await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Sair'),
                                  content: Text(
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
                          },
                          txt: 'Sair',
                          tam: 360,
                          iconInicio: Icons.logout,
                        ),
                      ],
                    );
                  },
                  loading: () => CarregandoWidget(),
                  error: (error, stackTrace) => Text('Erro: $error'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
