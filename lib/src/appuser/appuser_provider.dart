import 'dart:typed_data';

import 'package:app_cas_natal/src/appuser/appuser_model.dart';
import 'package:app_cas_natal/src/appuser/appuser_repository.dart';
import 'package:app_cas_natal/src/http_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

part 'appuser_provider.g.dart'; 

@riverpod
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

@riverpod
IHttpClient httpClient(Ref ref){
  return HttpClient();
}

@riverpod 
AppUserRepository userRepository(Ref ref){
  final client = ref.watch(httpClientProvider);
  return AppUserRepository(client: client);
}

@riverpod
class AppUserNotifier extends _$AppUserNotifier{
  @override
  Future<List<AppUserModel>> build() async{
    final repository = ref.read(userRepositoryProvider);
    final currentUser = await ref.watch(currentUserProvider.future);
    
    if (currentUser == null || currentUser.token == null) {
        return []; 
    }
    return repository.fetchUsers(token: currentUser.token!);
  }
}

@riverpod
Future<AppUserModel?> currentUser(Ref ref) async {
  final storage = ref.watch(secureStorageProvider);
  final token = await storage.read(key: 'token');
  if (token == null || token.isEmpty) return null;

  bool isExpired = JwtDecoder.isExpired(token);
  if (isExpired){
    await storage.deleteAll();
    return null;
  }

  Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  final name = decodedToken['name'] 
               ?? decodedToken['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'] 
               ?? decodedToken['unique_name'] 
               ?? 'Usuário';
  final email = decodedToken['email'] 
                ?? decodedToken['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress']
                ?? '';
  final userName = decodedToken['unique_name'] ?? '';
  final privateRole = decodedToken['privateRole'] ?? 'Default';

  return AppUserModel(
    id: decodedToken['jti'], 
    fullName: name,
    email: email,
    userName: userName,
    token: token, 
    privateRole: privateRole,
  );
}

@riverpod
Future<Uint8List?> avatar(Ref ref) async {
  final user = await ref.watch(currentUserProvider.future);
  
  if (user == null || user.token == null) {
    return null;
  }
  try {
    final repository = ref.read(userRepositoryProvider);
    return await repository.fetchAvatar(token: user.token!);
  } catch (e) {
    return null;
  }
}