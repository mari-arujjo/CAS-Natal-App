import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationBarWidget extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const NavigationBarWidget({super.key, required this.navigationShell});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {

  void mudarDeBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cores = Cores();
    final int selectedIndex = widget.navigationShell.currentIndex; 
    const double breakpoint = 600.0; 

    final destinations = <NavigationDestination>[
      NavigationDestination(
        icon: Icon(
          Icons.school, 
          color: selectedIndex == 0 ? Colors.white : Colors.black,
        ),
        label: 'Cursos',
      ),
      NavigationDestination(
        icon: Icon(
          Icons.sign_language, 
          color: selectedIndex == 1 ? Colors.white : Colors.black,
        ),
        label: 'Glossário',
      ),
      NavigationDestination(
        icon: Icon(
          Icons.settings, 
          color: selectedIndex == 2 ? Colors.white : Colors.black,
        ),
        label: 'Configurações',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < breakpoint) {
          // --- LAYOUT MOBILE/TELA PEQUENA (Bottom Navigation Bar) ---
          return Scaffold(
            body: widget.navigationShell,
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 3),
                NavigationBar(
                  height: 65,
                  backgroundColor: cores.cinzaClaro, 
                  indicatorColor: cores.azulEscuro,
                  selectedIndex: selectedIndex,
                  destinations: destinations,
                  onDestinationSelected: (int index) {
                    mudarDeBranch(index);
                  },
                ),
              ],
            ),
          );
        } else {
          // --- LAYOUT DESKTOP/TELA GRANDE (Navigation Rail/Side Bar) ---
          return Scaffold(
            body: Row(
              children: <Widget>[
                NavigationRail(
                  extended: true,
                  minExtendedWidth: 220,
                  backgroundColor: cores.branco,
                  indicatorColor: cores.azulEscuro,
                  selectedIndex: selectedIndex,
                  unselectedIconTheme: const IconThemeData(color: Colors.black),
                  selectedIconTheme: const IconThemeData(color: Colors.white),
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Image.asset(
                      'assets/logo_cas_transparente2.png',
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  groupAlignment: -1.0,
                  onDestinationSelected: (int index) {
                    mudarDeBranch(index);
                  },
                  labelType: null, 
                  destinations: destinations.map((destination) {
                    return NavigationRailDestination(
                      icon: destination.icon,
                      selectedIcon: destination.selectedIcon ?? destination.icon,
                      label: Text(destination.label),
                    );
                  }).toList(),
                ),
                const VerticalDivider(thickness: 1, width: 1,color: Color.fromARGB(30, 0, 0, 0),),
                Expanded(
                  child: widget.navigationShell,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}