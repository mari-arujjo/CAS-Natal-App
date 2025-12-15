import 'dart:convert';
import 'package:app_cas_natal/src/enrollment/enrollment_model.dart';
import 'package:app_cas_natal/src/http_client.dart';
import 'package:flutter/foundation.dart'; // Import necessário para debugPrint

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
  
  Future<List<EnrollmentModel>> getCourseUserEnrollments({required String token}) async {
    final response = await client.get(
      url: 'https://cas-natal-api.onrender.com/CASNatal/enrollments/getCourseUserEnrollment',
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

  Future<EnrollmentModel> updateEnrollmentStatus({
    required String enrollmentId, 
    required int newStatus, 
    required String token
  }) async {
    final body = jsonEncode({'status': newStatus});
    
    // Garantindo que o ID não tenha espaços ou caracteres indesejados
    final safeEnrollmentId = enrollmentId.trim(); 
    
    // URL MANTIDA conforme o backend [HttpPatch("update/{id}")]
    final urlFinal = 'https://cas-natal-api.onrender.com/CASNatal/enrollments/update/$safeEnrollmentId';
    
    // Logs de Depuração
    debugPrint('PATCH URL ENVIADA: $urlFinal'); 
    debugPrint('Body ENVIADO: $body');
    
    final response = await client.patch(
      url: urlFinal,
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json', // <--- NOVO HEADER ADICIONADO PARA MAIOR COMPATIBILIDADE
      },
      body: body,
    );

    if (response.statusCode != 200) {
      if (response.body.isNotEmpty) {
        try {
          final responseBody = jsonDecode(response.body);
          if (responseBody is String) {
            throw Exception(responseBody);
          } else if (responseBody is Map && responseBody.containsKey('title')) {
            throw Exception(responseBody['title']);
          }
        } catch (e) {
           debugPrint('Erro ao decodificar JSON do erro: $e');
        }
      }
      throw Exception('Falha ao atualizar o status da matrícula. Status: ${response.statusCode}');
    }
    
    try {
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      return EnrollmentModel.fromMap(responseBody);
    } on FormatException catch(e){
      throw Exception('Erro ao processar a resposta JSON de atualização. Resposta não é JSON válida. Erro: $e.');
    } catch(e){
      throw Exception('Erro inesperado na atualização: $e');
    }
  }
}