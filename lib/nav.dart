import 'package:app_cas_natal/cores.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationBarWidget extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const NavigationBarWidget({super.key, required this.navigationShell});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  int _selectedIndex = 0;

  void mudarDeBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cores = Cores();

    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 3),
          NavigationBar(
            backgroundColor: cores.cinzaClaro,
            indicatorColor: cores.azulEscuro,
            selectedIndex: _selectedIndex,
            destinations: const <Widget>[
              /*NavigationDestination(
                icon: Icon(Icons.home, color: Colors.black),
                label: 'Início',
              ),*/
              NavigationDestination(
                icon: Icon(Icons.school, color: Colors.black),
                label: 'Cursos',
              ),
              NavigationDestination(
                icon: Icon(Icons.sign_language, color: Colors.black),
                label: 'Glossário',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings, color: Colors.black),
                label: 'Configurações',
              ),
            ],

            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
              mudarDeBranch(_selectedIndex);
            },
          ),
        ],
      ),

      body: SizedBox(child: widget.navigationShell),
    );
  }
}
