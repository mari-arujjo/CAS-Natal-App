import 'package:app_cas_natal/widgets/botoes_padrao/bt_quadrado_icon_widget.dart';
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
      appBar: AppBar(title: Text('Opções de administrador')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: [
              ButtonQuadradoIcon(
                txt: 'Gestão de matrículas',
                onPressed: () {
                  context.goNamed('GestaoUsers');
                },
                icon: Icons.badge,
              ),
              ButtonQuadradoIcon(
                txt: 'Gestão de usuários',
                onPressed: () {
                  context.goNamed('GestaoUsers');
                },
                icon: Icons.people,
              ),
              ButtonQuadradoIcon(
                txt: 'Gestão de cursos',
                onPressed: () {
                  context.goNamed('GestaoCurso');
                },
                icon: Icons.school,
              ),
              ButtonQuadradoIcon(
                txt: 'Gestão de aulas',
                onPressed: () {
                  context.goNamed('GestaoAula');
                },
                icon: Icons.play_circle_fill,
              ),
              ButtonQuadradoIcon(
                txt: 'Gestão do glossário',
                onPressed: () {
                  context.goNamed('GestaoGlossario');
                },
                icon: Icons.sign_language,
              ),
              ButtonQuadradoIcon(
                txt: 'Estatísticas',
                onPressed: () {
                  context.goNamed('EstatisticasAdmin');
                },
                icon: Icons.bar_chart,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
