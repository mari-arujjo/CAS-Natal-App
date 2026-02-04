import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _abrirLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Não foi possível abrir $url');
    }
  }

  bool _deveMostrarFooter(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    const telasPrincipais = [
      '/cursos', 
      '/glossario', 
      '/configuracoes'
    ];

    return telasPrincipais.contains(location);
  }

  Widget _buildFooter(Cores cores) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: cores.branco,
        border: Border(top: BorderSide(color: Colors.black.withOpacity(0.05))),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        runSpacing: 5,
        children: [
          Text(
            "© 2026 CAS Natal + IFRN",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[600]),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _socialIcon(FontAwesomeIcons.instagram, "https://www.instagram.com/cas_natal/", cores),
              _socialIcon(FontAwesomeIcons.facebook, "https://www.facebook.com/casnatalrn/", cores),
              const SizedBox(width: 8),
              Container(height: 15, width: 1, color: Colors.grey),
              const SizedBox(width: 8),
              _socialIcon(FontAwesomeIcons.instagram, "https://www.instagram.com/ifrnzonaleste/", cores),
              _socialIcon(FontAwesomeIcons.facebook, "https://www.facebook.com/ifrnzonaleste/", cores),
              const SizedBox(width: 8),
              Container(height: 15, width: 1, color: Colors.grey),
              const SizedBox(width: 8),
              _socialIcon(FontAwesomeIcons.globe, "https://mari-arujjo.github.io/", cores),
            ],
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon, String url, Cores cores) {
    return IconButton(
      onPressed: () => _abrirLink(url),
      icon: FaIcon(icon, size: 18),
      color: cores.preto.withOpacity(0.7),
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      tooltip: url,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cores = Cores();
    final int selectedIndex = widget.navigationShell.currentIndex;
    const double breakpoint = 600.0;
    final bool mostrarFooter = _deveMostrarFooter(context);

    final destinations = <NavigationDestination>[
      NavigationDestination(
        icon: Icon(Icons.school, color: selectedIndex == 0 ? Colors.white : Colors.black),
        label: 'Cursos',
      ),
      NavigationDestination(
        icon: Icon(Icons.sign_language, color: selectedIndex == 1 ? Colors.white : Colors.black),
        label: 'Glossário',
      ),
      NavigationDestination(
        icon: Icon(Icons.settings, color: selectedIndex == 2 ? Colors.white : Colors.black),
        label: 'Configurações',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < breakpoint) {
          // --- LAYOUT MOBILE ---
          return Scaffold(
            body: Column(
              children: [
                Expanded(child: widget.navigationShell),
              ],
            ),
            bottomNavigationBar: NavigationBar(
              height: 60,
              backgroundColor: cores.cinzaClaro,
              indicatorColor: cores.azulEscuro,
              selectedIndex: selectedIndex,
              destinations: destinations,
              onDestinationSelected: mudarDeBranch,
            ),
          );
        } else {
          // --- LAYOUT DESKTOP/WEB ---
          return Scaffold(
            body: Row(
              children: [
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
                      'assets/logos/logo_cas_transparente2.png',
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                  onDestinationSelected: mudarDeBranch,
                  destinations: destinations.map((d) => NavigationRailDestination(
                    icon: d.icon,
                    label: Text(d.label),
                  )).toList(),
                ),
                const VerticalDivider(thickness: 1, width: 1, color: Color(0x1E000000)),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(child: widget.navigationShell),
                      if (mostrarFooter) _buildFooter(cores),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}