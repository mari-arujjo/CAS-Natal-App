import 'package:app_cas_natal/widgets/botoes/bt_quadrado_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Opções de administrador')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: ConstrainedBox(
            // Opcional: define uma largura máxima para o grid não espalhar 
            // no monitor ultra-wide
            constraints: const BoxConstraints(maxWidth: 1000), 
            child: GridView.builder(
              // Define o tamanho máximo de cada botão
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250, // Tamanho máximo de cada botão
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1, // Mantém o formato quadrado
              ),
              itemCount: _buildButtons(context).length,
              itemBuilder: (context, index) => _buildButtons(context)[index],
            ),
          ),
        ),
      ),
    );
  }

  // Organizei os botões em uma lista para facilitar a manutenção
  List<Widget> _buildButtons(BuildContext context) {
    return [
      ButtonQuadradoIcon(
        txt: 'Gestão de matrículas',
        onPressed: () => context.goNamed('GestaoUsers'),
        icon: Icons.badge,
      ),
      ButtonQuadradoIcon(
        txt: 'Gestão de usuários',
        onPressed: () => context.goNamed('GestaoUsers'),
        icon: Icons.people,
      ),
      ButtonQuadradoIcon(
        txt: 'Gestão de cursos',
        onPressed: () => context.goNamed('GestaoCurso'),
        icon: Icons.school,
      ),
      ButtonQuadradoIcon(
        txt: 'Gestão de aulas',
        onPressed: () => context.goNamed('GestaoAula'),
        icon: Icons.play_circle_fill,
      ),
      ButtonQuadradoIcon(
        txt: 'Gestão do glossário',
        onPressed: () => context.goNamed('GestaoGlossario'),
        icon: Icons.sign_language,
      ),
      ButtonQuadradoIcon(
        txt: 'Estatísticas',
        onPressed: () => context.goNamed('EstatisticasAdmin'),
        icon: Icons.bar_chart,
      ),
    ];
  }
}