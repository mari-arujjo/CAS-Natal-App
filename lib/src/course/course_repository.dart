import 'dart:convert';
import 'package:app_cas_natal/src/course/course_model.dart';
import 'package:app_cas_natal/src/http_client.dart';

class CourseRepository {
  final IHttpClient client;
  CourseRepository({required this.client});

  Future<List<CourseModel>> getCourses() async {
    final response = await client.get(url:'https://cas-natal-api.onrender.com/CASNatal/courses');
    try{
      final body = jsonDecode(response.body) as List;
      return body.map((item) => CourseModel.fromMap(item)).toList();
    }catch(e){
      throw Exception(e);
    }
  }

  Future<List<CourseModel>> getCoursesLessons() async {
    final response = await client.get(url:'https://cas-natal-api.onrender.com/CASNatal/courses/lessons');
    try{
      final body = jsonDecode(response.body) as List;
      return body.map((item) => CourseModel.fromMap(item)).toList();
    }catch(e){
      throw Exception(e);
    }
  }

  Future<CourseModel> getCourseById(String id) async {
    final response = await client.get(url:'https://cas-natal-api.onrender.com/CASNatal/courses/$id');
  
    if (response.statusCode != 200 && response.statusCode != 201){
        throw Exception("Falha ao buscar curso. Status: ${response.statusCode}");
    }
    try{
      final body = jsonDecode(response.body) as Map<String, dynamic>; 
      return CourseModel.fromMap(body);
    }catch(e){
      throw Exception('Erro ao processar a resposta do curso: $e');
    }
  }

  Future<CourseModel> newCourse(CourseModel course) async {
    final response = await client.post(
      url: 'https://cas-natal-api.onrender.com/CASNatal/courses/create',
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(course.toMap()),
    );
    if (response.statusCode != 200 && response.statusCode != 201){
      final body = jsonDecode(response.body);
      if (body['errors'] != null){
        final erro = body['errors'] as Map<String, dynamic>;
        final key = erro.keys.first;
        final value = (erro[key] as List).first;
        final msg = '$value';
        throw msg;
      }
    }
    try{
      final body = jsonDecode(response.body);
      return CourseModel.fromMap(body);
    }catch(e){
      throw Exception(e);
    }
  }

  Future<CourseModel> updateCourse(CourseModel course, String id) async {
    final response = await client.update(
      url: 'https://cas-natal-api.onrender.com/CASNatal/courses/update/$id',
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
      return CourseModel.fromMap(body);
    }catch(e){
      throw Exception(e);
    }
  }

  Future<void> deleteCourse(String id) async {
    await client.delete(url:'https://cas-natal-api.onrender.com/CASNatal/courses/delete/$id');
    try{
      return;
    }catch(e){
      throw Exception(e);
    }
  }

}