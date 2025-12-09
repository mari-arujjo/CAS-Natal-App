import 'dart:convert';
import 'package:app_cas_natal/src/lesson/lesson_model.dart';
import 'package:app_cas_natal/src/http_client.dart';

class LessonRepository {
  final IHttpClient client;
  LessonRepository({required this.client});

  Future<List<LessonModel>> getLessons() async {
    final response = await client.get(url:'https://cas-natal-api.onrender.com/CASNatal/lessons');
    try{
      final body = jsonDecode(response.body) as List;
      return body.map((item) => LessonModel.fromMap(item)).toList();
    }catch(e){
      throw Exception(e);
    }
  }

  Future<List<LessonModel>> getLessonById(String id) async {
    final response = await client.get(url:'https://cas-natal-api.onrender.com/CASNatal/lessons/$id');
    try{
      final body = jsonDecode(response.body) as List;
      return body.map((item) => LessonModel.fromMap(item)).toList();
    }catch(e){
      throw Exception(e);
    }
  }

  Future<LessonModel> newLesson(LessonModel lesson) async {
    final response = await client.post(
      url: 'https://cas-natal-api.onrender.com/CASNatal/lessons/create',
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

  Future<LessonModel> updateLesson(LessonModel course, String id) async {
    final response = await client.update(
      url: 'https://cas-natal-api.onrender.com/CASNatal/lessons/update/$id',
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(course.toMap()),
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
    await client.delete(url:'https://cas-natal-api.onrender.com/CASNatal/lessons/delete/$id');
    try{
      return;
    }catch(e){
      throw Exception(e);
    }
  }

}