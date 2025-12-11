import 'dart:convert';
import 'package:app_cas_natal/src/enrollment/enrollment_model.dart';
import 'package:app_cas_natal/src/http_client.dart';

class EnrollmentRepository {
  final IHttpClient client;
  EnrollmentRepository({required this.client});

  Future<List<EnrollmentModel>> getEnrollments() async {
    final response = await client.get(url: 'https://cas-natal-api.onrender.com/CASNatal/enrollments');
    try{
      final body = jsonDecode(response.body) as List;
      return body.map((item) => EnrollmentModel.fromMap(item)).toList();
    }catch(e){
      throw Exception(e);
    }
  }
  
  Future<List<EnrollmentModel>> getUserEnrollments({required String token}) async {
    final response = await client.get(
      url: 'https://cas-natal-api.onrender.com/CASNatal/enrollments/getUserEnrollment',
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token', 
      },
    );
    if (response.statusCode != 200) {
      throw Exception("Falha ao buscar matrículas do usuário. Status: ${response.statusCode}");
    }
    try{
      final body = jsonDecode(response.body) as List;
      return body.map((item) => EnrollmentModel.fromMap(item)).toList();
    }catch(e){
      throw Exception('Erro ao processar a resposta de matrículas do usuário: $e');
    }
  }
  
  Future<EnrollmentModel> newEnrollment({required String courseSymbol, required String token}) async {
    final response = await client.post(
      url: 'https://cas-natal-api.onrender.com/CASNatal/enrollments/create?symbol=$courseSymbol',
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    
    if (response.statusCode != 200 && response.statusCode != 201) {
      if (response.body.isNotEmpty) {
        try {
          final body = jsonDecode(response.body);
          if (body is String) {
            throw Exception(body);
          } else if (body is Map && body.containsKey('title')) {
            throw Exception(body['title']);
          }
        } catch (e) {
          rethrow;
        }
      }
      throw Exception('Falha ao criar matrícula. Status: ${response.statusCode}');
    }

    if (response.body.isEmpty) {
        throw Exception('Sucesso na API (Status ${response.statusCode}), mas o servidor retornou um corpo de resposta vazio inesperado.');
    }
    
    try{
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return EnrollmentModel.fromMap(body);
    } on FormatException catch(e){
      throw Exception('Erro ao processar a resposta JSON de matrícula. Resposta não é JSON válida. Erro: $e.');
    } catch(e){
      throw Exception('Erro inesperado na matrícula: $e');
    }
  }
}