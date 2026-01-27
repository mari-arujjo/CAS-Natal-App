import 'package:app_cas_natal/src/sign/sign_provider.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_cas_natal/cores.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class SignPage extends ConsumerStatefulWidget {
  final String signId;

  const SignPage({super.key, required this.signId});

  @override
  ConsumerState<SignPage> createState() => _SignPageState();
}

class _SignPageState extends ConsumerState<SignPage> {
  YoutubePlayerController? _controller;
  final cor = Cores();
  bool _initialized = false;

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  void _initController(String url) {
    final videoId = YoutubePlayerController.convertUrlToId(url);
    if (videoId != null) {
      _controller = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: false,
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          strictRelatedVideos: true,
          mute: false,
        ),
      );
      _initialized = true;
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          letterSpacing: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncSign = ref.watch(signDetailProvider(widget.signId));
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1100;

    return asyncSign.when(
      loading: () => const Scaffold(body: Center(child: CarregandoWidget())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Erro: $err'))),
      data: (sign) {
        if (!_initialized && sign.url != null && sign.url!.isNotEmpty) {
          _initController(sign.url!);
        }

        return YoutubePlayerScaffold(
          controller: _controller ?? YoutubePlayerController(),
          aspectRatio: 16 / 9,
          builder: (context, player) {
            
            Widget photoWidget = ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: Colors.grey.shade100,
                child: sign.photo != null && sign.photo!.isNotEmpty
                    ? Image.memory(sign.photo!, fit: BoxFit.cover)
                    : const AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Center(child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey)),
                      ),
              ),
            );

            Widget videoPlayerWidget = _controller != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: player,
                  )
                : Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Center(child: Text('Vídeo não disponível.')),
                  );

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                title: Text('Sinal: ${sign.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.orange),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 15),
                ],
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: isDesktop
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildSectionTitle('Definição do Sinal'),
                                    Text(
                                      sign.description,
                                      style: const TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
                                    ),
                                    const SizedBox(height: 40),
                                    Divider(color: Colors.grey.shade300),
                                    const SizedBox(height: 20),
                                    _buildInfoCard(),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 40),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildSectionTitle('Demonstração em Vídeo'),
                                    videoPlayerWidget,
                                    const SizedBox(height: 30),
                                    _buildSectionTitle('Referência Visual'),
                                    photoWidget,
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionTitle('Definição'),
                              Text(sign.description, style: const TextStyle(fontSize: 17, height: 1.5)),
                              const SizedBox(height: 24),
                              _buildSectionTitle('Referência Visual'),
                              photoWidget,
                              const SizedBox(height: 32),
                              _buildSectionTitle('Sinal em LIBRAS'),
                              videoPlayerWidget,
                            ],
                          ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cor.laranja.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: cor.laranja),
          const SizedBox(width: 15),
          const Expanded(
            child: Text(
              "Este sinal faz parte do glossário oficial do CAS Natal.",
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
    );
  }
}