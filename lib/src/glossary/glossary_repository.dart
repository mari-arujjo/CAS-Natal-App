import 'dart:convert';
import 'package:app_cas_natal/src/glossary/glossary_model.dart';
import 'package:app_cas_natal/src/http_client.dart';

class GlossaryRepository {
  final IHttpClient client;
  GlossaryRepository({required this.client});

  Future<List<GlossaryModel>> getGlossaries() async {
    final response = await client.get(url: 'https://cas-natal-api.onrender.com/CASNatal/glossaries');
    try{
      final body = jsonDecode(response.body) as List;
      return body.map((item) => GlossaryModel.fromMap(item)).toList();
    }catch(e){
      throw Exception(e);
    }
  }

  Future<List<GlossaryModel>> getGlossariesWithLessons() async {
    final response = await client.get(url: 'https://cas-natal-api.onrender.com/CASNatal/glossaries/lessons');
    try{
      final body = jsonDecode(response.body) as List;
      return body.map((item) => GlossaryModel.fromMap(item)).toList();
    }catch(e){
      throw Exception(e);
    }
  }

  Future<GlossaryModel> newGlossary(GlossaryModel glossary) async {
    final response = await client.post(
      url: 'https://cas-natal-api.onrender.com/CASNatal/glossaries/create',
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(glossary.toMap()),
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
      return GlossaryModel.fromMap(body);
    }catch(e){
      throw Exception(e);
    }
  }

  Future<GlossaryModel> updateGlossary(GlossaryModel glossary, String id) async {
    final response = await client.update(
      url: 'https://cas-natal-api.onrender.com/CASNatal/glossaries/update/$id',
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(glossary.toMap()),
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
      return GlossaryModel.fromMap(body);
    }catch(e){
      throw Exception(e);
    }
  }

  Future<void> deleteGlossary(String id) async {
    await client.delete(url: 'https://cas-natal-api.onrender.com/CASNatal/glossaries/delete/$id');
    try{
      return;
    } catch(e){
      throw Exception(e);
    }
  }
}