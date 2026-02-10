import 'dart:convert';
import 'package:app_cas_natal/src/http_client.dart';
import 'package:app_cas_natal/src/quiz/quiz_model.dart';

class QuizRepository {
  final IHttpClient client;
  static const String _baseUrl = String.fromEnvironment('API_URL');
  QuizRepository({required this.client});

  Future<List<QuizQuestionModel>> getQuizQuestionsByLessonId({required String lessonId}) async {
    print('LOG: Tentando buscar questões do quiz para o lessonId: $lessonId');
    final finalLessonId = lessonId.toLowerCase();
    final url = '$_baseUrl/CASNatal/quizQuestions/byLessonId/$finalLessonId';
    print('LOG: URL da requisição: $url');
    final response = await client.get(url: url);
    print('LOG: Resposta recebida. Status Code: ${response.statusCode}');
    if (response.statusCode != 200) {
      print('LOG ERROR: Falha na requisição. Corpo: ${response.body}');
      throw Exception('Falha ao buscar as questões do quiz. Status: ${response.statusCode}');
    }
    try {
      final List<dynamic> body = jsonDecode(response.body);
      print('LOG SUCCESS: ${body.length} questões encontradas.');
      final quizzes = body.map((e) => QuizQuestionModel.fromMap(e)).toList();
      quizzes.sort((a, b) => a.order.compareTo(b.order));
      return quizzes;
    } catch (e) {
      print('LOG EXCEPTION: Erro ao processar a resposta do quiz: $e');
      throw Exception('Erro ao processar a resposta das questões do quiz: $e');
    }
  }
}
