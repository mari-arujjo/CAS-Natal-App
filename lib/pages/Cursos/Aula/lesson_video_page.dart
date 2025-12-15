import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/src/lesson/lesson_model.dart';
import 'package:app_cas_natal/widgets/botoes/bt_navegacao_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonVideoPage extends StatefulWidget {
  final LessonModel lesson;

  const LessonVideoPage({super.key, required this.lesson});

  @override
  State<LessonVideoPage> createState() => _LessonVideoPageState();
}

class _LessonVideoPageState extends State<LessonVideoPage> {
  late YoutubePlayerController _controller;
  final cor = Cores();

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.lesson.url);
    
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vídeo: ${widget.lesson.name}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: cor.laranja,
          ),

          ValueListenableBuilder<YoutubePlayerValue>(
            valueListenable: _controller,
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _controller.metadata.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Assista ao vídeo da lição antes de prosseguir para a leitura do conteúdo.',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BotaoNavegacaoWidget(
                  txt: 'Próximo',
                  icon:  Icon(Icons.arrow_forward),
                  onPressed: () {
                    context.go('/cursos/detalheCurso/${widget.lesson.courseId}/content/${widget.lesson.id}');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}