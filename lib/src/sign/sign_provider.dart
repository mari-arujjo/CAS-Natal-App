// sign_provider.dart
// ignore_for_file: override_on_non_overriding_member
import 'package:app_cas_natal/src/sign/sign_model.dart';
import 'package:app_cas_natal/src/sign/sign_repository.dart';
import 'package:app_cas_natal/src/http_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_provider.g.dart';

@riverpod 
IHttpClient httpClient(Ref ref){
  return HttpClient();
}

@riverpod
SignRepository signRepository(Ref ref){
  final client = ref.watch(httpClientProvider);
  return SignRepository(client: client);
}

@riverpod
Future<SignModel> signDetail(Ref ref, String signId) async {
  final repository = ref.watch(signRepositoryProvider);
  return repository.getSignById(signId);
}

@riverpod 
class SignNotifier extends _$SignNotifier{
  @override
  Future<List<SignModel>> build() async {
    final repository = ref.read(signRepositoryProvider);
    return repository.getSigns();
  }

  @override
  Future<List<SignModel>> getSignsWithLessons() async {
    final repository = ref.read(signRepositoryProvider);
    return repository.getSignsWithLessons();
  }
  
  @override
  Future<void> addSign(SignModel sign) async {
    final repository = ref.read(signRepositoryProvider);
    try{
      await repository.newSign(sign);
      ref.invalidateSelf();
    }catch(e, s){
      state = AsyncValue.error(e, s);
    }
  }

  @override
  Future<void> updateSign(SignModel sign, String id) async {
    final repository = ref.read(signRepositoryProvider);
    try{
      await repository.updateSign(sign, id);
      ref.invalidateSelf();
    }catch(e, s){
      state = AsyncValue.error(e, s);
    }
  }

  @override
  Future<void> deleteSign(String id) async {
    final repository = ref.read(signRepositoryProvider);
    try{
      await repository.deleteSign(id);
      ref.invalidateSelf();
    }catch(e, s){
      state = AsyncValue.error(e, s);
    }
  }
}