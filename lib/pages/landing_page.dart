import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/widgets/botoes/bt_laranja_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cores = Cores();
    final bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 1,
        shadowColor: const Color.fromARGB(115, 0, 0, 0),
        automaticallyImplyLeading: false, 
        title: Row(
          children: [
            Icon(Icons.school, color: cores.azulEscuro, size: isMobile ? 24 : 30),
            const SizedBox(width: 8),
            Text(
              'CAS Natal + IFRN', 
              style: TextStyle(
                color: cores.azulEscuro, 
                fontWeight: FontWeight.bold, 
                fontSize: isMobile ? 14 : 18
              )
            ),
            Spacer(),
            _botaoAcesso(context, cores, isMobile),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context, isMobile),
            _buildFooter(cores, isMobile),
          ],
        ),
      ),
    );
  }

  Widget _botaoAcesso(BuildContext context, Cores cores, bool isMobile) {
    return ElevatedButton(
      onPressed: () => context.goNamed('LoginRegister'),
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(cores.laranja),
        shadowColor: WidgetStatePropertyAll(cores.laranjaEscuro),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        overlayColor: WidgetStatePropertyAll(cores.laranjaEscuro),
        elevation: WidgetStatePropertyAll(0),
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 10,vertical: 5)),
      ),
      child: Text(
        isMobile ? "Acessar" : "Acessar Plataforma", 
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5)
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isMobile) {
    final cores = Cores();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, cores.laranja.withOpacity(0.05)],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: isMobile ? 40 : 80,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: isMobile ? 0 : 1,
                child: Column(
                  crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Capacitação em Libras e Acessibilidade em um só lugar",
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                      style: TextStyle(
                        fontSize: isMobile ? 32 : 48,
                        fontWeight: FontWeight.w900,
                        color: cores.azulEscuro,
                        height: 1.1,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Uma iniciativa conjunta entre o CAS Natal e o IFRN para promover o ensino e a inclusão da comunidade surda no RN.",
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 18,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 40),
                    BotaoLaranjaWidget(
                      txt: "Ver Cursos", 
                      onPressed: () => context.goNamed('Cursos'), 
                      tam: isMobile ? 200 : 250
                    ),
                  ],
                ),
              ),

              if (!isMobile) const SizedBox(width: 50),
              if (isMobile) const SizedBox(height: 50),

              Flexible(
                flex: isMobile ? 0 : 1,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/placeholder.png',
                      fit: BoxFit.cover,
                      width: isMobile ? double.infinity : 900,
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(Cores cores, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(top: BorderSide(color: Colors.black.withOpacity(0.05))),
      ),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: isMobile ? 30 : 80,
            runSpacing: 30,
            children: [
              _buildFooterColumn(
                "CAS Natal",
                [
                  _socialLink(FontAwesomeIcons.instagram, "Instagram", "https://www.instagram.com/cas_natal/", cores),
                  _socialLink(FontAwesomeIcons.facebook, "Facebook", "https://www.facebook.com/casnatalrn/", cores),
                ],
                cores,
              ),
              _buildFooterColumn(
                "IFRN Zona Leste",
                [
                  _socialLink(FontAwesomeIcons.instagram, "Instagram", "https://www.instagram.com/ifrnzonaleste/", cores),
                  _socialLink(FontAwesomeIcons.facebook, "Facebook", "https://www.facebook.com/ifrnzonaleste/", cores),
                ],
                cores,
              ),
              _buildFooterColumn(
                "Desenvolvido por",
                [
                  _socialLink(FontAwesomeIcons.globe, "Portfólio", "https://mari-arujjo.github.io/", cores),
                ],
                cores,
              ),
            ],
          ),
          const Divider(height: 60, thickness: 0.5, indent: 40, endIndent: 40),
          Text(
            "© 2026 CAS Natal + IFRN • Todos os direitos reservados",
            style: TextStyle(fontSize: 12, color: Colors.grey[600], letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterColumn(String title, List<Widget> items, Cores cores) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: cores.azulEscuro,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 15),
        ...items,
      ],
    );
  }

  Widget _socialLink(IconData icon, String label, String url, Cores cores) {
    return InkWell(
      onTap: () => _abrirLink(url),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(icon, size: 16, color: cores.laranja),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _abrirLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Não foi possível abrir o link");
    }
  }
}