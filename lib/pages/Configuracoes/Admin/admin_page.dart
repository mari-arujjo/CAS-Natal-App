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
            constraints: const BoxConstraints(maxWidth: 700), 
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1,
              ),
              itemCount: _buildButtons(context).length,
              itemBuilder: (context, index) => _buildButtons(context)[index],
            ),
          ),
        ),
      ),
    );
  }
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