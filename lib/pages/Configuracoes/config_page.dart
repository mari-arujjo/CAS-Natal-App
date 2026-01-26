// ignore_for_file: use_build_context_synchronously
import 'package:app_cas_natal/src/appuser/appuser_provider.dart';
import 'package:app_cas_natal/cores.dart';
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
    final larguraTela = MediaQuery.of(context).size.width;
    final isWeb = larguraTela > 1000;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: cores.azulEscuro),
      ),
      body: asyncUser.when(
        data: (user) {
          if (user == null) return const Center(child: Text('Usuário inválido'));

          return SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWeb ? 30 : 20, 
                  vertical: 0
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- CABEÇALHO DE PERFIL ---
                    _buildHeaderPerfil(user, isWeb),
                    
                    const SizedBox(height: 50),
                    
                    // --- SEÇÃO: CONTA ---
                    _buildSeccaoTitle("CONTA"),
                    const SizedBox(height: 16),
                    _buildMenuLayout(
                      context, 
                      isWeb, 
                      filtrarPor: ['Editar perfil', 'Redefinir senha', 'Sair']
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // --- SEÇÃO: SISTEMA ---
                    _buildSeccaoTitle("SISTEMA"),
                    const SizedBox(height: 16),
                    _buildMenuLayout(
                      context, 
                      isWeb, 
                      filtrarPor: ['Estatísticas', 'Opções de administrador', 'Sobre o app', 'Termos de serviço']
                    ),
                    const SizedBox(height: 40),
                  ],
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
    // RESOLUÇÃO DO ERRO: Movendo o watch do avatar para dentro do builder ou tratando o nulo
    final asyncAvatar = ref.watch(avatarProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Tratamento seguro do AsyncValue<Uint8List?>
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
    final bool isSair = item['titulo'] == 'Sair';
    
    return InkWell(
      onTap: item['onPressed'],
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (item['cor'] as Color).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(item['icone'], color: item['cor'], size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['titulo'], 
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 15,
                      color: isSair ? Colors.red[700] : Colors.black87
                    )
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item['subtitulo'], 
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[300], size: 20),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _listagemItensMenu(BuildContext context) {
    return [
      {'titulo': 'Editar perfil', 'subtitulo': 'Dados pessoais e contato', 'icone': Icons.person_outline, 'cor': Colors.blue, 'onPressed': () => context.goNamed('EditarPerfil')},
      {'titulo': 'Estatísticas', 'subtitulo': 'Visualizar uso e progresso', 'icone': Icons.auto_graph_outlined, 'cor': Colors.teal, 'onPressed': () => context.goNamed('Estatisticas')},
      {'titulo': 'Opções de administrador', 'subtitulo': 'Gestão de usuários e sistema', 'icone': Icons.admin_panel_settings_outlined, 'cor': Colors.orange[800], 'onPressed': () => context.goNamed('Admin')},
      {'titulo': 'Redefinir senha', 'subtitulo': 'Altere sua senha de acesso', 'icone': Icons.lock_open_outlined, 'cor': Colors.redAccent, 'onPressed': () => context.goNamed('RedefinirSenha')},
      {'titulo': 'Sobre o app', 'subtitulo': 'Versão e informações', 'icone': Icons.help_outline, 'cor': Colors.indigo, 'onPressed': () => context.goNamed('Sobre')},
      {'titulo': 'Termos de serviço', 'subtitulo': 'Regras e privacidade', 'icone': Icons.assignment_outlined, 'cor': Colors.blueGrey, 'onPressed': () => context.goNamed('Termos')},
      {'titulo': 'Sair', 'subtitulo': 'Encerrar sessão atual', 'icone': Icons.logout_rounded, 'cor': Colors.red[400], 'onPressed': () => _dialogSair(context)},
    ];
  }

  Future<void> _dialogSair(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('Sair'),
        content: const Text('Tem certeza que deseja sair do CAS Natal?'),
        actions: [
          TextButton(onPressed: () => context.pop(false), child: Text('Cancelar', style: TextStyle(color: Colors.grey[600]))),
          TextButton(
            onPressed: () async {
              context.pop(true);
              context.goNamed('LoginRegister');
            }, 
            child: const Text('Sim, Sair', style: TextStyle(color: Colors.red))
          ),
        ],
      ),
    );
  }
}