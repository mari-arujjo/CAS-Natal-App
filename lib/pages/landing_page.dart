import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cores = Cores();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.school, color: Colors.blue, size: 30),
            const SizedBox(width: 8),
            const Text('LibrasEduca', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            const Spacer(),
            _navItem("Início"),
            _navItem("Sobre"),
            _navItem("Recursos"),
            _navItem("Contato"),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text("Acessar Plataforma", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(),
            _buildFeaturesSection(),
            _buildWhyChooseSection(), // O Footer saiu daqui de dentro e foi para baixo
            _buildFooter(cores),      // Chamada corrigida aqui
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
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade50, Colors.white],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Capacitação em Libras\npara Professores",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
                ),
                const SizedBox(height: 16),
                const Text("Aprenda, pratique e ensine com confiança.", style: TextStyle(fontSize: 18, color: Colors.blueGrey)),
                const SizedBox(height: 30),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                      child: const Text("Comece Agora"),
                    ),
                    const SizedBox(width: 15),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.blue)),
                      child: const Text("Saiba Mais"),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(child: Icon(Icons.laptop_mac, size: 200, color: Colors.blue.shade200)),
        ],
      ),
    );
  }

  // --- SEÇÃO CARACTERÍSTICAS ---
  Widget _buildFeaturesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _featureCard(Icons.play_circle_fill, "Aulas Interativas", "Vídeos e conteúdos completos."),
          _featureCard(Icons.assignment_turned_in, "Quizzes e Exercícios", "Teste seus conhecimentos."),
          _featureCard(Icons.bar_chart, "Progresso Salvo", "Acompanhe seu desempenho."),
        ],
      ),
    );
  }

  Widget _featureCard(IconData icon, String title, String sub) {
    return Column(
      children: [
        CircleAvatar(radius: 30, backgroundColor: Colors.blue.shade50, child: Icon(icon, color: Colors.blue, size: 30)),
        const SizedBox(height: 10),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  // --- SEÇÃO POR QUE ESCOLHER ---
  Widget _buildWhyChooseSection() {
    return Container(
      width: double.infinity,
      color: Colors.blue.shade600,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          const Text("Por que escolher o LibrasEduca?", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _infoBox("Conteúdo de Qualidade", "Material didático atualizado."),
              _infoBox("Plataforma Acessível", "Compatível com todos os dispositivos."),
              _infoBox("Certificação Garantida", "Receba seu certificado ao concluir."),
            ],
          )
        ],
      ),
    );
  }

  Widget _infoBox(String title, String desc) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          const Icon(Icons.school, color: Colors.orange, size: 40),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          const SizedBox(height: 5),
          Text(desc, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: Colors.grey)),
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