// sign_repository.dart
import 'dart:convert';
import 'package:app_cas_natal/src/sign/sign_model.dart';
import 'package:app_cas_natal/src/http_client.dart';

class SignRepository {
  final IHttpClient client;
  SignRepository({required this.client});

  Future<List<SignModel>> getSigns() async {
    final response = await client.get(url: 'https://cas-natal-api.onrender.com/CASNatal/signs');
    try{
      final body = jsonDecode(response.body) as List;
      return body.map((item) => SignModel.fromMap(item)).toList();
    }catch(e){
      throw Exception(e);
    }
  }

  Future<SignModel> getSignById(String id) async {
    final response = await client.get(url: 'https://cas-natal-api.onrender.com/CASNatal/signs/$id');
    try{
      final body = jsonDecode(response.body);
      return SignModel.fromMap(body);
    }catch(e){
      throw Exception(e);
    }
  }

  Future<List<SignModel>> getSignsWithLessons() async {
    final response = await client.get(url: 'https://cas-natal-api.onrender.com/CASNatal/signs/lessons');
    try{
      final body = jsonDecode(response.body) as List;
      return body.map((item) => SignModel.fromMap(item)).toList();
    }catch(e){
      throw Exception(e);
    }
  }

  Future<SignModel> newSign(SignModel sign) async {
    final response = await client.post(
      url: 'https://cas-natal-api.onrender.com/CASNatal/signs/create',
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(sign.toMap()),
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
      return SignModel.fromMap(body);
    }catch(e){
      throw Exception(e);
    }
  }

  Future<SignModel> updateSign(SignModel sign, String id) async {
    final response = await client.update(
      url: 'https://cas-natal-api.onrender.com/CASNatal/signs/update/$id',
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(sign.toMap()),
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
      return SignModel.fromMap(body);
    }catch(e){
      throw Exception(e);
    }
  }

  Future<void> deleteSign(String id) async {
    await client.delete(url: 'https://cas-natal-api.onrender.com/CASNatal/signs/delete/$id');
    try{
      return;
    } catch(e){
      throw Exception(e);
    }
  }
}