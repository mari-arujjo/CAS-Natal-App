import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Para ícones de marcas
import 'package:url_launcher/url_launcher.dart'; // Para abrir os links

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

  // Função para abrir os links
  Future<void> _abrirLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Não foi possível abrir $url');
    }
  }

  // Widget do Footer Customizado com Redes Sociais
  Widget _buildFooter(Cores cores, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: cores.branco,
        border: Border(top: BorderSide(color: Colors.black.withOpacity(0.05))),
      ),
      child: Wrap( // Wrap ajuda a não quebrar em telas muito pequenas
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            "© 2026 CAS Natal + IFRN",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: cores.preto),
          ),
          
          // Seção de Ícones Sociais
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _socialIcon(FontAwesomeIcons.instagram, "https://www.instagram.com/cas_natal/", cores),
              _socialIcon(FontAwesomeIcons.facebook, "https://www.facebook.com/casnatalrn/", cores),
              const SizedBox(width: 8),
              Container(height: 15, width: 1, color: Colors.grey.withOpacity(0.5)),
              const SizedBox(width: 8),
              _socialIcon(FontAwesomeIcons.instagram, "https://www.instagram.com/ifrnzonaleste/", cores),
              _socialIcon(FontAwesomeIcons.facebook, "https://www.facebook.com/ifrnzonaleste/", cores),
              const SizedBox(width: 8),
              Container(height: 15, width: 1, color: Colors.grey.withOpacity(0.5)),
              const SizedBox(width: 8),
              _socialIcon(FontAwesomeIcons.userAstronaut, "https://www.instagram.com/mari.arujjo/", cores), // Ícone dev
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

    final destinations = <NavigationDestination>[
      NavigationDestination(
        icon: Icon(Icons.school, color: selectedIndex == 0 ? Colors.white : Colors.black),
        label: 'Cursos',
      ),
      NavigationDestination(
        icon: Icon(Icons.sign_language, color: selectedIconColor(selectedIndex, 1)),
        label: 'Glossário',
      ),
      NavigationDestination(
        icon: Icon(Icons.settings, color: selectedIconColor(selectedIndex, 2)),
        label: 'Configurações',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < breakpoint) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(child: widget.navigationShell),
              ],
            ),
            bottomNavigationBar: NavigationBar(
              height: 65,
              backgroundColor: cores.cinzaClaro,
              indicatorColor: cores.azulEscuro,
              selectedIndex: selectedIndex,
              destinations: destinations,
              onDestinationSelected: mudarDeBranch,
            ),
          );
        } else {
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
                      'assets/logo_cas_transparente2.png',
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
                      _buildFooter(cores, false),
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

  Color selectedIconColor(int selectedIndex, int targetIndex) {
    return selectedIndex == targetIndex ? Colors.white : Colors.black;
  }
}