// ignore_for_file: override_on_non_overriding_member
import 'package:app_cas_natal/src/glossary/glossary_model.dart';
import 'package:app_cas_natal/src/glossary/glossary_repository.dart';
import 'package:app_cas_natal/src/http_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'glossary_provider.g.dart';

@riverpod 
IHttpClient httpClient(Ref ref){
  return HttpClient();
}

@riverpod
GlossaryRepository glossaryRepository(Ref ref){
  final client = ref.watch(httpClientProvider);
  return GlossaryRepository(client: client);
}

@riverpod 
class GlossaryNotifier extends _$GlossaryNotifier{
  @override
  Future<List<GlossaryModel>> build() async {
    final repository = ref.read(glossaryRepositoryProvider);
    return repository.getGlossaries();
  }

  @override
  Future<List<GlossaryModel>> getGlossariesWithLessons() async {
    final repository = ref.read(glossaryRepositoryProvider);
    return repository.getGlossariesWithLessons();
  }
  
  @override
  Future<void> addGlossary(GlossaryModel glossary) async {
    final repository = ref.read(glossaryRepositoryProvider);
    try{
      await repository.newGlossary(glossary);
      ref.invalidateSelf();
    }catch(e, s){
      state = AsyncValue.error(e, s);
    }
  }

  @override
  Future<void> updateGlossary(GlossaryModel glossary, String id) async {
    final repository = ref.read(glossaryRepositoryProvider);
    try{
      await repository.updateGlossary(glossary, id);
      ref.invalidateSelf();
    }catch(e, s){
      state = AsyncValue.error(e, s);
    }
  }

  @override
  Future<void> deleteGlossary(String id) async {
    final repository = ref.read(glossaryRepositoryProvider);
    try{
      await repository.deleteGlossary(id);
      ref.invalidateSelf();
    }catch(e, s){
      state = AsyncValue.error(e, s);
    }
  }
}