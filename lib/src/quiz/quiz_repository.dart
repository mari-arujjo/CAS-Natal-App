import 'dart:convert';
import 'package:app_cas_natal/src/http_client.dart';
import 'package:app_cas_natal/src/quiz/quiz_model.dart';

class QuizRepository {
  final IHttpClient client;

  QuizRepository({required this.client});

  Future<QuizQuestionModel> getQuizQuestionByLessonId({required String lessonId}) async {
    print('LOG: Tentando buscar questão do quiz para o lessonId: $lessonId');
    final finalLessonId = lessonId.toLowerCase();
    final url = 'https://cas-natal-api.onrender.com/CASNatal/quizQuestions/byLessonId/$finalLessonId';
    print('LOG: URL da requisição: $url');

    final response = await client.get(
      url: url,
    );
    print('LOG: Resposta recebida. Status Code: ${response.statusCode}');

    if (response.statusCode != 200) {
      print(
        'LOG ERROR: Falha na requisição. Corpo da resposta: ${response.body}',
      );
      throw Exception(
        'Falha ao buscar a questão do quiz. Status: ${response.statusCode}',
      );
    }

    try {
      print(
        'LOG SUCCESS: Resposta 200 OK. Corpo recebido: '
        '${response.body.length > 200 ? response.body.substring(0, 200) + '...' : response.body}',
      );

      final body = jsonDecode(response.body) as Map<String, dynamic>;

      print(
        'LOG SUCCESS: Dados do QuizQuestionModel mapeados com sucesso.',
      );

      return QuizQuestionModel.fromMap(body);
    } catch (e) {
      print(
        'LOG EXCEPTION: Erro ao processar a resposta do quiz: $e',
      );
      throw Exception(
        'Erro ao processar a resposta da questão do quiz: $e',
      );
    }
  }
}
