import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cores = Cores();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 1,
        shadowColor: const Color.fromARGB(115, 0, 0, 0),
        title: Row(
          children: [
            Icon(Icons.school, color: cores.azulEscuro, size: 30),
            SizedBox(width: 8),
            Text('CAS Natal + IFRN', style: TextStyle(color: cores.azulEscuro, fontWeight: FontWeight.bold)),
            
            Spacer(),
            _navItem("Sobre"),
            _navItem("Recursos"),
            _navItem("Contato"),
            SizedBox(width: 10),
            
            SizedBox(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.transparent,
                      offset: Offset(0, 0),
                      blurRadius: 0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    context.goNamed('LoginRegister');
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(cores.laranja),
                    shadowColor: WidgetStatePropertyAll(cores.laranjaEscuro),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    overlayColor: WidgetStatePropertyAll(cores.laranjaEscuro),
                    elevation: WidgetStatePropertyAll(0),
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ), 
                    ),
                  ),
                  child: Text("Acessar Plataforma", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(),
            _buildFooter(cores),
          ],
        ),
      ),
    );
  }

  Widget _navItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(text, style: const TextStyle(color: Colors.grey, fontSize: 14)),
    );
  }

  // --- SEÇÃO HERO ---
  Widget _buildHeroSection() {
    return Container(
      padding: EdgeInsets.all(40),
      child: Row(
        children: [
        ],
      ),
    );
  }

  // --- RODAPÉ ---
  Widget _buildFooter(Cores cores) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black.withOpacity(0.05))),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        runSpacing: 10,
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
              _socialIcon(FontAwesomeIcons.github, "https://mari-arujjo.github.io/", cores),
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

  Future<void> _abrirLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Não foi possível abrir o link");
    }
  }
}