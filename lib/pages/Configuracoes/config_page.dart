// ignore_for_file: use_build_context_synchronously
import 'package:app_cas_natal/src/appuser/appuser_provider.dart';
import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/widgets/botoes_padrao/bt_laranja_widget.dart';
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
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: Column(
              children: [
                asyncUser.when(
                  data: (user) {
                    if (user == null) return const Text('Usuário inválido');
                    final avatarWidget = asyncAvatar.when(
                      data: (imgBytes) => AvatarWidget(
                        tam: 40,
                        imgBytes: imgBytes,
                      ),
                      loading: () => const AvatarWidget(tam: 40, imgBytes: null),
                      error: (e, s) => const AvatarWidget(tam: 40, imgBytes: null),
                    );

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 15),
                            avatarWidget,
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.fullName,
                                    style: const TextStyle(
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
                        const SizedBox(height: 15),
                        BotaoLaranjaWidget(
                          txt: 'Editar perfil',
                          onPressed: () {
                            context.goNamed('EditarPerfil');
                          },
                          tam: 360,
                        ),
                        const SizedBox(height: 30),
                        BotaoMenuWidget(
                          onPressed: () {
                            context.goNamed('RedefinirSenha');
                          },
                          txt: 'Redefinir senha',
                          tam: 360,
                          iconInicio: Icons.lock,
                        ),
                        const SizedBox(height: 5),
                        BotaoMenuWidget(
                          onPressed: () async {
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
