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
      'titulo': 'CAS Natal: O Encontro entre línguas, Educação, cultura e Comunidade Surda',
      'imagem': 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=500', 
    },
    {
      'tipo': 'conteudo',
      'titulo': '',
      'texto': 'O calor de Natal nos convida a refletir sobre as formas como nos conectamos. Nesta cidade vibrante, a comunicação nunca se limita a uma única língua ou a um só jeito de enxergar o mundo. Existe um lugar, um ponto de encontro, onde a educação se ergue como uma ponte sólida: o CAS Natal.',
      'imagem': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRznRjY3ynYwN6JBYvx9VTG3Yi0Icwzx4pzw&s',
    },
    {
      'tipo': 'conteudo',
      'titulo': 'APRESENTAÇÃO: QUEM SOMOS?',
      'texto': ' O Centro de Atendimento às Pessoas Surdas (CAS Natal) foi fundado com um propósito claro e amparado pela lei. Criado pelo Decreto Nº 19.131, de 2 de junho de 2006, ele visou atender às diretrizes estabelecidas pelo Decreto Federal Nº 5.626, de 22 de dezembro de 2005, que regulamentou a Lei nº 10.436/2002: a Lei da Libras.',
      'imagem': 'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?q=80&w=500',
    },
    {
      'tipo': 'conteudo',
      'titulo': '',
      'texto': 'Essa perspectiva transcende o simples atendimento: o CAS Natal se consolida como um eixo de formação e fortalecimento da rede pública de ensino. Nossa atuação se fundamenta em uma proposta educacional bilíngue, que reconhece a Libras como primeira língua (L1) e o Português escrito como segunda (L2). Essa concepção assegura o desenvolvimento linguístico, cognitivo e identitário de cada estudante surdo, reafirmando o compromisso com uma educação inclusiva e culturalmente significativa.',
      'imagem': 'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?q=80&w=500',
    },
    {
      'tipo': 'conteudo',
      'titulo': 'INTRODUÇÃO: O QUE FAZEMOS?',
      'texto': 'Nossa Missão: Promover a autonomia, o desenvolvimento integral e a inclusão social dos estudantes surdos em todo o Rio Grande do Norte. Fazemos isso por meio do Atendimento Educacional Especializado (AEE), da produção e socialização de materiais e recursos didáticos bilíngues, e da capacitação contínua de profissionais da educação. Nosso objetivo é garantir que cada estudante surdo alcance o aprendizado contínuo e atue com plenitude na construção de uma sociedade mais justa e igualitária.',
      'imagem': 'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?q=80&w=500',
    },
    {
      'tipo': 'conteudo',
      'titulo': '',
      'texto': 'Nossa Visão: Nosso compromisso é ser o Centro de Referência na Educação de Surdos no RN. Sustentamos este pioneirismo através da inovação pedagógica, concentrada na criação e divulgação de materiais didáticos que respeitam rigorosamente a estrutura da Libras. Nossa visão é consolidada pelo desenvolvimento contínuo de profissionais e pela pesquisa do contexto linguístico e social da comunidade surda, garantindo uma rede de apoio integral que inclui desde o Atendimento Educacional Especializado (AEE) até o atendimento às famílias desses estudantes.',
      'imagem': 'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?q=80&w=500',
    },
    {
      'tipo': 'conteudo',
      'titulo': 'COMO FAZEMOS?',
      'texto': 'O CAS Natal opera em uma estrutura de quatro vertentes interconectadas, que formam uma robusta rede de apoio essencial para o Atendimento Educacional Especializado (AEE) e para a promoção de uma perspectiva verdadeiramente bilíngue.',
      'imagem': 'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?q=80&w=500',
    },
    {
      'tipo': 'conteudo',
      'titulo': '',
      'texto': '3. Núcleo de Produção de Material Didático (Adaptação e Criação de Recursos): É responsável por produzir e adaptar materiais físicos e virtuais alinhados à perspectiva bilíngue, fornecendo ferramentas essenciais para o AEE e o aprendizado autônomo. 4. Núcleo da Família (Comunicação e Vínculos Familiares): Atua como ponte, promovendo a comunicação efetiva e estreitando os vínculos entre a família e o estudante surdo, reconhecendo o papel crucial do ambiente familiar no processo de inclusão e desenvolvimento.',
      'imagem': 'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?q=80&w=500',
    },
    {
      'tipo': 'conteudo',
      'titulo': '',
      'texto': 'O CAS Natal não é apenas um centro; é o ponto de partida para um futuro onde todas as vozes e todos os sinais têm espaço, onde a diversidade linguística é celebrada. A educação, a cultura e a comunidade se entrelaçam para construir um Rio Grande do Norte mais justo, acessível e inclusivo para todos. A conexão é a nossa força.',
      'imagem': 'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?q=80&w=500',
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
    final isMobile = MediaQuery.of(context).size.width < 600;

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
                          : _CardLivroComImagem(dados: dados, cor: cor, isMobile: isMobile),
                    );
                  },
                ),
                // SETAS REINSERIDAS: Aparecem apenas se NÃO for mobile
                if (!isMobile) _buildSetas(),
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
      backgroundColor: Colors.white.withOpacity(0.1),
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
            height: 4, width: ativa ? 24 : 8,
            decoration: BoxDecoration(
              color: ativa ? corAtiva : Colors.white24, 
              borderRadius: BorderRadius.circular(2)
            ),
          );
        }),
      ),
    );
  }
}

// Widget da Capa
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
          image: NetworkImage(dados['imagem']!),
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

// Widget do Conteúdo
class _CardLivroComImagem extends StatelessWidget {
  final Map<String, String> dados;
  final Cores cor;
  final bool isMobile;
  const _CardLivroComImagem({required this.dados, required this.cor, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    String texto = dados['texto']!;
    String primeiraLetra = texto.substring(0, 1);
    String restoTexto = texto.substring(1);

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
            Expanded(flex: 3, child: Image.network(dados['imagem']!, fit: BoxFit.cover)),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 25 : 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dados['titulo']!.toUpperCase(),
                        style: TextStyle(letterSpacing: 2, fontSize: 12, color: cor.laranja, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: const TextStyle(color: Color(0xFF2D2D2D), fontSize: 18, height: 1.7, fontFamily: 'serif'),
                            children: [
                              TextSpan(
                                text: primeiraLetra,
                                style: const TextStyle(fontSize: 60, height: 0.8, fontWeight: FontWeight.w300),
                              ),
                              TextSpan(text: restoTexto),
                            ],
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