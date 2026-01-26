import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/src/lesson/lesson_model.dart';
import 'package:app_cas_natal/widgets/botoes/bt_navegacao_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

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
    final videoId = YoutubePlayerController.convertUrlToId(widget.lesson.url);

    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId ?? '',
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        strictRelatedVideos: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  Widget _buildVideoPlayer(Widget player) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 900,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: player,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWebWide = screenWidth > 900;

    return YoutubePlayerScaffold(
      controller: _controller,
      aspectRatio: 16 / 9,
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Vídeo: ${widget.lesson.name}'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: isWebWide
                      ? _buildWideLayout(player)
                      : _buildMobileLayout(player),
                ),
                _buildBottomBar(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWideLayout(Widget player) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildVideoPlayer(player),
          SizedBox(height: 30),
          _buildDescription(),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(Widget player) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVideoPlayer(player),
          SizedBox(height: 20),
          _buildDescription(),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sobre esta lição:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[500],
            letterSpacing: 1,
          ),
        ),
        Text(
          'Assista ao vídeo da lição antes de prosseguir para a leitura do conteúdo técnico.',
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[800],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BotaoNavegacaoWidget(
            txt: 'Próximo',
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              context.go('/cursos/detalheCurso/${widget.lesson.courseId}/content/${widget.lesson.id}');
            },
          ),
        ],
      ),
    );
  }
}