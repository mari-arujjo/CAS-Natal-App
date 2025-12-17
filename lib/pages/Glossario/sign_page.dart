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

  Widget _buildYoutubePlayer(SignModel sign) {
    if (sign.url != null && sign.url!.isNotEmpty) {
      final videoId = YoutubePlayer.convertUrlToId(sign.url!);
      
      if (videoId != null && _controller == null) {
        _controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: YoutubePlayerFlags(
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
          orElse: () => Text('Detalhe do Sinal'),
        ),
        actions: asyncSign.maybeWhen(
          data: (sign) => [
            IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.orange,
              ),
              onPressed: () {
                // Implementar lógica de favoritar
              },
            ),
            SizedBox(width: 10),
          ],
          orElse: () => [],
        ),
      ),
      body: asyncSign.when(
        loading: () => Center(child: CarregandoWidget()),
        error: (err, stack) => Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Erro ao carregar o sinal: $err'),
          ),
        ),
        data: (sign) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_controller != null && YoutubePlayer.convertUrlToId(sign.url ?? '') != _controller!.initialVideoId) {
              setState(() {
                _controller?.dispose();
                _controller = null;
              });
            }
          });
          
          return SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  'Definição:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  sign.description,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 10),
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
                      : Center(
                          child: Text(
                            'Imagem do Sinal (Photo) não disponível',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                ),


                SizedBox(height: 50),
                Text(
                  'Sinal em LIBRAS (Vídeo)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
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