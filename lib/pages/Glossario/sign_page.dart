// sign_page.dart
import 'package:app_cas_natal/src/sign/sign_provider.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart'; // Importação necessária
import 'package:app_cas_natal/src/sign/sign_model.dart'; // Importação para o modelo (opcional se já tiver importado via provider)
import 'package:app_cas_natal/cores.dart'; // Assumindo que você usa Cores

class SignPage extends ConsumerStatefulWidget {
  final String signId;

  const SignPage({super.key, required this.signId});

  @override
  ConsumerState<SignPage> createState() => _SignPageState();
}

class _SignPageState extends ConsumerState<SignPage> {
  YoutubePlayerController? _controller;
  final cor = Cores(); // Inicialização da classe de cores

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

  // Widget para construir o player do YouTube
  Widget _buildYoutubePlayer(SignModel sign) {
    if (sign.url != null && sign.url!.isNotEmpty) {
      final videoId = YoutubePlayer.convertUrlToId(sign.url!);
      
      if (videoId != null && _controller == null) {
        _controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
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
          ],
        );
      }
    }
    
    // Fallback se URL estiver vazia ou não for um link válido
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.lightBlue.shade200),
      ),
      child: Center(
        child: Text(
          sign.url != null && sign.url!.isNotEmpty
              ? 'Erro ao carregar vídeo: URL inválida ou sem conexão.'
              : 'Vídeo do Sinal não disponível (URL vazia).',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncSign = ref.watch(signDetailProvider(widget.signId));

    return Scaffold(
      appBar: AppBar(
        title: asyncSign.maybeWhen(
          data: (sign) => Text('Sinal: ${sign.name}'),
          orElse: () => const Text('Detalhe do Sinal'),
        ),
        actions: asyncSign.maybeWhen(
          data: (sign) => [
            IconButton(
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.orange,
              ),
              onPressed: () {
                // Implementar lógica de favoritar
              },
            ),
            const SizedBox(width: 10),
          ],
          orElse: () => [],
        ),
      ),
      body: asyncSign.when(
        loading: () => const Center(child: CarregandoWidget()),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Erro ao carregar o sinal: $err'),
          ),
        ),
        data: (sign) {
          // Garante que o controller é inicializado/resetado se o ID do sinal mudar
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_controller != null && YoutubePlayer.convertUrlToId(sign.url ?? '') != _controller!.initialVideoId) {
              setState(() {
                _controller?.dispose();
                _controller = null;
              });
            }
          });
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  'Definição:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  sign.description,
                  style: const TextStyle(fontSize: 14),
                ),

                const SizedBox(height: 10),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.lightBlue.shade200),
                  ),
                  child: sign.photo != null && sign.photo!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(
                            sign.photo!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Center(
                          child: Text(
                            'Imagem do Sinal (Photo) não disponível',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                ),


                const SizedBox(height: 50),
                const Text(
                  'Sinal em LIBRAS (Vídeo)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _buildYoutubePlayer(sign),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}