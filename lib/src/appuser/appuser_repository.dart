import 'dart:convert';
import 'dart:typed_data';
import 'package:app_cas_natal/src/appuser/appuser_model.dart';
import 'package:app_cas_natal/src/http_client.dart';

class AppUserRepository {
  final IHttpClient client;
  static const String _baseUrl = String.fromEnvironment('API_URL');
  AppUserRepository({required this.client});

  Future<List<AppUserModel>> fetchUsers({required String token}) async {
    final response = await client.get(
      url: '$_baseUrl/CASNatal/account/users',
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token', 
      },
    );
    try{
      final body = jsonDecode(response.body) as List;
      return body.map((item) => AppUserModel.fromMap(item)).toList();
    }catch(e){
      throw Exception(e);
    }
  }

  Future<Uint8List?> fetchAvatar({required String token}) async {
    final response = await client.get(
      url: '$_baseUrl/CASNatal/account/avatar',
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token', 
      },
    );

    if (response.statusCode == 204) return null;
    
    if (response.statusCode != 200 ){
       throw Exception('Erro ao buscar o avatar. Status: ${response.statusCode}');
    }

    final avatarBase64 = response.body;
    if (avatarBase64.isNotEmpty) {
      try {
        return base64Decode(avatarBase64); 
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<AppUserModel> register({required String fullName, required String userName, required String email, required String password}) async {
    final Map<String, dynamic> requestBody ={
      'name': fullName,
      'username': userName,
      'email': email,
      'password': password,
    };

    final response = await client.post(
      url: '$_baseUrl/CASNatal/account/register',
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(requestBody),
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
      return AppUserModel.fromMap(body);
    }catch(e){
      throw Exception(e);
    }
  }

  Future<AppUserModel> login({ required String userName, required String password}) async {
    final Map<String, dynamic> requestBody ={
      'username': userName,
      'password': password,
    };

    final response = await client.post(
      url: '$_baseUrl/CASNatal/account/login',
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 401) throw response.body; 
    
    if (response.statusCode != 200 ){
      final body = jsonDecode(response.body);
      if (body['errors'] != null){
        final erro = body['errors'] as Map<String, dynamic>;
        final key = erro.keys.first;
        final value = (erro[key] as List).first;
        final msg = 'Campo: $key \n($value)';
        throw msg;
      }
      throw Exception('Erro desconhecido no login.');
    }
    try{
      final body = jsonDecode(response.body);
      return AppUserModel.fromMap(body);
    }catch(e){
      throw Exception(e);
    }
  }

  Future<AppUserModel> update({
    required String token,
    String? fullName,
    String? userName,
    String? email,
    bool? active,
   }) async {

    final Map<String, dynamic> requestBody = {};
    if (fullName!=null) requestBody['name'] = fullName;
    if (userName!=null) requestBody['username'] = userName;
    if (email!=null) requestBody['email'] = email;
    if (active!=null) requestBody['active'] = active;
    if (requestBody.isEmpty){
      throw Exception('Nenhum dado fornecido para atualização.');
    }

    final response = await client.patch(
      url: '$_baseUrl/CASNatal/account/update',
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token', 
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 401) throw response.body; 
    
    if (response.statusCode != 200 ){
      final body = jsonDecode(response.body);
      if (body['errors'] != null){
        final erro = body['errors'] as Map<String, dynamic>;
        final key = erro.keys.first;
        final value = (erro[key] as List).first;
        final msg = 'Campo: $key \n($value)';
        throw msg;
      }
      throw Exception('Erro desconhecido na atualização dos dados.');
    }
    try{
      final body = jsonDecode(response.body);
      return AppUserModel.fromMap(body);
    }catch(e){
      throw Exception(e);
    }
  }

  Future<AppUserModel> updateAvatar({required String token,String? avatar}) async {
    final Map<String, dynamic> requestBody = {};
    requestBody['avatar'] = avatar;
    if (requestBody.isEmpty){
      throw Exception('Nenhum dado fornecido para atualização.');
    }

    final response = await client.patch(
      url: '$_baseUrl/CASNatal/account/updateAvatar',
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token', 
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 401) throw response.body; 
    
    if (response.statusCode != 200 ){
      final body = jsonDecode(response.body);
      if (body['errors'] != null){
        final erro = body['errors'] as Map<String, dynamic>;
        final key = erro.keys.first;
        final value = (erro[key] as List).first;
        final msg = 'Campo: $key \n($value)';
        throw msg;
      }
      throw Exception('Erro desconhecido na atualização dos dados.');
      
    }
    if (response.body.isEmpty) {
      throw Exception('O servidor retornou sucesso, mas sem dados de usuário para atualização.');
    }
    try{
      final body = jsonDecode(response.body);
      return AppUserModel.fromMap(body);
    }catch(e){
      throw Exception(e);
    }
  }


}