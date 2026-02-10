import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_cas_natal/cores.dart';

class HistoriaCASPage extends StatefulWidget {
  const HistoriaCASPage({super.key});

  @override
  State<HistoriaCASPage> createState() => _HistoriaCASPageState();
}

class _HistoriaCASPageState extends State<HistoriaCASPage> {
  final PageController _pageController = PageController();
  double _paginaAtualDouble = 0.0;

  final List<Map<String, String>> _paginas = [
    {
      'tipo': 'capa',
      'titulo': 'CAS Natal: O encontro entre línguas, educação, cultura e comunidade surda',
      'imagem': 'assets/storybook/capa.png',
    },
    {
      'tipo': 'conteudo',
      'titulo': '',
      'texto': 'O calor de Natal nos convida a refletir sobre as formas como nos conectamos.\nNesta cidade vibrante, a comunicação nunca se limita a uma única língua ou a um só jeito de enxergar o mundo.\n\nExiste um lugar, um ponto de encontro, onde a educação se ergue como uma ponte sólida: o CAS Natal.',
      'imagem': 'assets/storybook/foto1.png',
    },
    {
      'tipo': 'conteudo',
      'titulo': 'QUEM SOMOS?',
      'texto': 'O Centro de Atendimento às Pessoas Surdas (CAS Natal) foi fundado com um propósito claro e amparado pela lei. Criado pelo Decreto Nº 19.131, de 2 de junho de 2006, ele visou atender às diretrizes estabelecidas pelo Decreto Federal Nº 5.626, de 22 de dezembro de 2005, que regulamentou a Lei nº 10.436/2002: a Lei da Libras.',
      'imagem': 'assets/storybook/foto2.png',
    },
    {
      'tipo': 'conteudo',
      'titulo': '',
      'texto': 'Essa perspectiva transcende o simples atendimento: o CAS Natal se consolida como um eixo de formação e fortalecimento da rede pública de ensino.\n\nNossa atuação se fundamenta em uma proposta educacional bilíngue, que reconhece a Libras como primeira língua (L1) e o Português escrito como segunda (L2).\n\nEssa concepção assegura o desenvolvimento linguístico, cognitivo e identitário de cada estudante surdo, reafirmando o compromisso com uma educação inclusiva e culturalmente significativa.',
      'imagem': 'assets/storybook/foto3.png',
    },
    {
      'tipo': 'conteudo',
      'titulo': 'NOSSA MISSÃO',
      'texto': 'Promover a autonomia, o desenvolvimento integral e a inclusão social dos estudantes surdos em todo o Rio Grande do Norte. Fazemos isso por meio do Atendimento Educacional Especializado (AEE), da produção e socialização de materiais e recursos didáticos bilíngues, e da capacitação contínua de profissionais da educação.\n\nNosso objetivo é garantir que cada estudante surdo alcance o aprendizado contínuo e atue com plenitude na construção de uma sociedade mais justa e igualitária.',
      'imagem': 'assets/storybook/foto4.png',
    },
    {
      'tipo': 'conteudo',
      'titulo': 'NOSSA VISÃO',
      'texto': 'Nosso compromisso é ser o Centro de Referência na Educação de Surdos no RN. Sustentamos este pioneirismo através da inovação pedagógica, concentrada na criação e divulgação de materiais didáticos que respeitam rigorosamente a estrutura da Libras.\n\nNossa visão é consolidada pelo desenvolvimento contínuo de profissionais e pela pesquisa do contexto linguístico e social da comunidade surda, garantindo uma rede de apoio integral que inclui desde o Atendimento Educacional Especializado (AEE) até o atendimento às famílias desses estudantes.',
      'imagem': 'assets/storybook/foto5.png',
    },
    {
      'tipo': 'conteudo',
      'titulo': 'NOSSOS VALORES',
      'texto': 'Nossas ações são guiadas por três Valores inegociáveis, representados pelo aperto de mãos.\n1. Integridade e Transparência: Atuar com a mais alta ética profissional, garantindo clareza e honestidade irrestritas em todas as ações e processos.\n\n2. Respeito e Credibilidade: Construir a confiança mútua por meio de um atendimento empático e do profundo respeito à dignidade e às necessidades singulares do nosso público-alvo.\n\n3. Compromisso com a Educação Bilíngue: Manter fidelidade aos princípios e metodologias das propostas educacionais específicas para estudantes surdos, assegurando a excelência e a inclusão efetiva.',
      'imagem': 'assets/storybook/foto6.png',
    },
    {
      'tipo': 'conteudo',
      'titulo': 'COMO FAZEMOS?',
      'texto': 'O CAS Natal opera em uma estrutura de quatro vertentes interconectadas, que formam uma robusta rede de apoio essencial para o Atendimento Educacional Especializado (AEE) e para a promoção de uma perspectiva verdadeiramente bilíngue.',
      'imagem': 'assets/storybook/foto7.png',
    },
    {
      'tipo': 'conteudo',
      'titulo': '',
      'texto': '1. Núcleo de Capacitação (Acesso e Difusão da Libras): Promove a fluência e a proficiência em Libras entre os profissionais da educação, elevando a qualidade do ensino e a comunicação inclusiva na rede.\n\n2. Núcleo de Pesquisa e Extensão (Estudos e Discussões na Área): Fomenta a produção de conhecimento e o debate acadêmico sobre a Surdez, garantindo que as práticas pedagógicas do CAS Natal estejam sempre na vanguarda da ciência e da inclusão.',
      'imagem': 'assets/storybook/foto8.png',
    },
    {
      'tipo': 'conteudo',
      'titulo': '',
      'texto': '3. Núcleo de Produção de Material Didático (Adaptação e Criação de Recursos): É responsável por produzir e adaptar materiais físicos e virtuais alinhados à perspectiva bilíngue, fornecendo ferramentas essenciais para o AEE e o aprendizado autônomo.\n\n4. Núcleo da Família (Comunicação e Vínculos Familiares): Atua como ponte, promovendo a comunicação efetiva e estreitando os vínculos entre a família e o estudante surdo, reconhecendo o papel crucial do ambiente familiar no processo de inclusão e desenvolvimento.',
      'imagem': 'assets/storybook/foto9.png',
    },
    {
      'tipo': 'conteudo',
      'titulo': '',
      'texto': 'O CAS Natal não é apenas um centro; é o ponto de partida para um futuro onde todas as vozes e todos os sinais têm espaço, onde a diversidade linguística é celebrada. A educação, a cultura e a comunidade se entrelaçam para construir um Rio Grande do Norte mais justo, acessível e inclusivo para todos.\nA conexão é a nossa força.',
      'imagem': 'assets/storybook/foto10.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() => setState(() => _paginaAtualDouble = _pageController.page ?? 0));
  }

  void _navegar(int direcao) {
    _pageController.animateToPage(
      _paginaAtualDouble.round() + direcao,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cor = Cores();
    final isMobile = MediaQuery.of(context).size.width < 1000;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1C1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white70),
          onPressed: () => context.go('/cursos'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: _paginas.length,
                  itemBuilder: (context, index) {
                    final dados = _paginas[index];
                    double delta = index - _paginaAtualDouble;
                    double escala = (1 - (delta.abs() * 0.1)).clamp(0.9, 1.0);

                    return Transform.scale(
                      scale: escala,
                      child: dados['tipo'] == 'capa'
                          ? _CapaHistoria(dados: dados, isMobile: isMobile)
                          : _CardLivroComImagem(
                              dados: dados,
                              cor: cor,
                              isMobile: isMobile,
                            ),
                    );
                  },
                ),
                _buildSetas(),
              ],
            ),
          ),
          _buildIndicadores(cor.laranja),
        ],
      ),
    );
  }

  Widget _buildSetas() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _paginaAtualDouble > 0.1
              ? _botaoSeta(Icons.arrow_back_ios_new, () => _navegar(-1))
              : const SizedBox(width: 48),
          _paginaAtualDouble < _paginas.length - 1.1
              ? _botaoSeta(Icons.arrow_forward_ios, () => _navegar(1))
              : const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _botaoSeta(IconData icon, VoidCallback tap) => IconButton(
        onPressed: tap,
        icon: CircleAvatar(
          backgroundColor: Cores().laranja.withOpacity(0.3),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
      );

  Widget _buildIndicadores(Color corAtiva) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_paginas.length, (i) {
          bool ativa = _paginaAtualDouble.round() == i;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 4,
            width: ativa ? 24 : 8,
            decoration: BoxDecoration(
                color: ativa ? corAtiva : Colors.white24, borderRadius: BorderRadius.circular(2)),
          );
        }),
      ),
    );
  }
}

class _CapaHistoria extends StatelessWidget {
  final Map<String, String> dados;
  final bool isMobile;
  const _CapaHistoria({required this.dados, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 25 : 60, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(dados['imagem']!),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
          ),
        ),
        padding: const EdgeInsets.all(30),
        alignment: Alignment.bottomCenter,
        child: Text(
          dados['titulo']!,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 20 : 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _CardLivroComImagem extends StatelessWidget {
  final Map<String, String> dados;
  final Cores cor;
  final bool isMobile;

  const _CardLivroComImagem({
    required this.dados,
    required this.cor,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 25 : 60, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFCF9),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: isMobile ? 2 : 1,
              child: Image.asset(
                dados['imagem']!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                ),
              ),
            ),
            Expanded(
              flex: isMobile ? 4 : 1,
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 25 : 45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (dados['titulo']!.isNotEmpty) ...[
                      Text(
                        dados['titulo']!.toUpperCase(),
                        style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 14,
                          color: cor.laranja,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                    Flexible(
                      child: SingleChildScrollView(
                        child: Text(
                          dados['texto']!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: const Color(0xFF2D2D2D),
                            fontSize: isMobile ? 18 : 22,
                            height: 1.7,
                            fontFamily: 'serif',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}