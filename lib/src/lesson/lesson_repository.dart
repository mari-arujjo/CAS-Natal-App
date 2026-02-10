import 'dart:convert';
import 'package:app_cas_natal/src/lesson/lesson_model.dart';
import 'package:app_cas_natal/src/http_client.dart';

class LessonRepository {
  final IHttpClient client;
  static const String _baseUrl = String.fromEnvironment('API_URL');
  LessonRepository({required this.client});

  Future<List<LessonModel>> getLessons() async {
    final response = await client.get(url:'$_baseUrl/CASNatal/lessons');
    try{
      final body = jsonDecode(response.body) as List;
      return body.map((item) => LessonModel.fromMap(item)).toList();
    }catch(e){
      throw Exception(e);
    }
  }

  Future<LessonModel> getLessonById(String id) async {
    final response = await client.get(url:'$_baseUrl/CASNatal/lessons/$id');
    
    if (response.statusCode != 200 && response.statusCode != 201){
        throw Exception("Falha ao buscar lição. Status: ${response.statusCode}");
    }
    
    try{
      final body = jsonDecode(response.body) as Map<String, dynamic>; 
      return LessonModel.fromMap(body);
    }catch(e){
      throw Exception('Erro ao processar a resposta da lição: $e');
    }
  }

  Future<LessonModel> newLesson(LessonModel lesson) async {
    if (lesson.courseId == null) {
      throw Exception('O ID do curso não pode ser nulo ao cadastrar uma aula.');
    }
    final String bodyData = jsonEncode(lesson.toCreateMap());
    final response = await client.post(
      url: '$_baseUrl/CASNatal/lessons/create/${lesson.courseId}',
      headers: {'Content-type': 'application/json'},
      body: bodyData, 
    );
    if (response.statusCode != 200 && response.statusCode != 201){
      final body = jsonDecode(response.body);
      if (body['errors'] != null){
        final erro = body['errors'] as Map<String, dynamic>;
        final key = erro.keys.first;
        final value = (erro[key] as List).first;
        throw Exception('Campo: $key \n($value)');
      } 
      throw Exception('Erro ${response.statusCode}: ${body['error'] ?? 'Falha na requisição.'}');
    }
    try{
      final body = jsonDecode(response.body);
      return LessonModel.fromMap(body);
    } catch(e){
      throw Exception('Erro ao processar resposta da API: $e');
    }
  }

  Future<LessonModel> updateLesson(LessonModel lesson, String id) async {
    print('--- Enviando Update de Aula ---');
    print('ID da Aula na URL: $id');
    print('Tópicos sendo enviados:');
    for (var topic in lesson.topics) {
      print('  - ID: ${topic.id} | Título: ${topic.title} | Ordem: ${topic.order}');
    }
    final response = await client.patch(
      url: '$_baseUrl/CASNatal/lessons/update/$id',
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(lesson.toMap()),
    );
    if (response.statusCode != 200 && response.statusCode != 201){
      final body = jsonDecode(response.body);
      if (body['errors'] != null){
        final erro = body['errors'] as Map<String, dynamic>;
        final key = erro.keys.first;
        final value = (erro[key] as List).first;
        final msg = 'Campo: $key \n($value)';
        throw Exception(msg);
      }
    }
    try{
      final body = jsonDecode(response.body);
      return LessonModel.fromMap(body);
    }catch(e){
      throw Exception(e);
    }
  }

  Future<void> deleteLesson(String id) async {
    await client.delete(url:'$_baseUrl/CASNatal/lessons/delete/$id');
    try{
      return;
    }catch(e){
      throw Exception(e);
    }
  }

}