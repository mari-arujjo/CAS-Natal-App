import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class SobrePage extends StatefulWidget {
  const SobrePage({super.key});

  @override
  State<SobrePage> createState() => _SobrePageState();
}

class _SobrePageState extends State<SobrePage> {
  bool _isHovering = false;
  final String email = 'araujo.mariana1@escolar.ifrn.edu.br';

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'Feedback - App Alfabetização'},
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: email));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('E-mail copiado!'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o app'),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Este aplicativo foi desenvolvido com o propósito de auxiliar professores '
                    'da rede pública estadual e municipal no processo de alfabetização de alunos '
                    'surdos na língua portuguesa.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Text(
                        'Versão atual: ',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text('1.0', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Créditos de desenvolvimento:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Text('Uma parceria CAS Natal/RN + IFRN', style: TextStyle(fontSize: 16)),
                  const Text('Desenvolvido por Mariana Araújo', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  const Text(
                    'Contato para suporte ou feedback:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  
                  // Link Interativo com mudança de cor e sublinhado
                  MouseRegion(
                    onEnter: (_) => setState(() => _isHovering = true),
                    onExit: (_) => setState(() => _isHovering = false),
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: _launchEmail,
                      onLongPress: () => _copyToClipboard(context),
                      child: Text(
                        email,
                        style: TextStyle(
                          fontSize: 16,
                          color: _isHovering ? Cores().azulEscuro : Colors.black,
                          decoration: _isHovering 
                              ? TextDecoration.underline 
                              : TextDecoration.none,
                          decorationColor: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '(Clique para enviar ou segure para copiar)',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}