import 'package:app_cas_natal/src/sign/sign_provider.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:app_cas_natal/src/sign/sign_model.dart';
import 'package:app_cas_natal/cores.dart';

class SignPage extends ConsumerStatefulWidget {
  final String signId;

  const SignPage({super.key, required this.signId});

  @override
  ConsumerState<SignPage> createState() => _SignPageState();
}

class _SignPageState extends ConsumerState<SignPage> {
  YoutubePlayerController? _controller;
  final cor = Cores();

  @override
  void deactivate() {
    _controller?.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey[500],
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildYoutubePlayer(SignModel sign) {
    if (sign.url != null && sign.url!.isNotEmpty) {
      final videoId = YoutubePlayer.convertUrlToId(sign.url!);
      
      if (videoId != null && _controller == null) {
        _controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
            disableDragSeek: false,
            loop: false,
            isLive: false,
            forceHD: false,
            enableCaption: true,
          ),
        );
      }

      if (_controller != null) {
        return YoutubePlayer(
          controller: _controller!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: cor.laranja,
          bottomActions: [
            CurrentPosition(),
            ProgressBar(isExpanded: true),
            const PlaybackSpeedButton(),
            FullScreenButton(),
          ],
        );
      }
    }
    
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Center(
        child: Text('Vídeo não disponível para este sinal.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncSign = ref.watch(signDetailProvider(widget.signId));
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1100;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: asyncSign.maybeWhen(
          data: (sign) => Text('Sinal: ${sign.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
          orElse: () => const Text('Detalhe do Sinal'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.orange),
            onPressed: () {},
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: asyncSign.when(
        loading: () => const Center(child: CarregandoWidget()),
        error: (err, stack) => Center(child: Text('Erro ao carregar: $err')),
        data: (sign) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_controller != null && 
                YoutubePlayer.convertUrlToId(sign.url ?? '') != _controller!.initialVideoId) {
              setState(() {
                _controller?.dispose();
                _controller = null;
              });
            }
          });

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

          return SingleChildScrollView(
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
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.6,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 40),
                              Divider(color: Colors.grey.shade300),
                              SizedBox(height: 20),
                              Container(
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
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 40),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionTitle('Demonstração em Vídeo'),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: _buildYoutubePlayer(sign),
                              ),
                              const SizedBox(height: 30),
                              _buildSectionTitle('Referência Visual'),
                              photoWidget,
                            ],
                          ),
                        ),
                        
                      ],
                    )
                  : Column( // VERSÃO MOBILE (EMPILHADO)
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Definição'),
                        Text(sign.description, style: const TextStyle(fontSize: 17, height: 1.5)),
                        const SizedBox(height: 24),
                        _buildSectionTitle('Referência Visual'),
                        photoWidget,
                        const SizedBox(height: 32),
                        _buildSectionTitle('Sinal em LIBRAS'),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _buildYoutubePlayer(sign),
                        ),
                      ],
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}