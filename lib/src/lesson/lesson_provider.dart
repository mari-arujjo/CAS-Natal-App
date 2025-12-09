import 'package:app_cas_natal/src/lesson/lesson_model.dart';
import 'package:app_cas_natal/src/lesson/lesson_repository.dart';
import 'package:app_cas_natal/src/http_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lesson_provider.g.dart';

@riverpod
IHttpClient httpClient(Ref ref){
  return HttpClient();
}

@riverpod 
LessonRepository lessonRepository(Ref ref){
  final client = ref.watch(httpClientProvider);
  return LessonRepository(client: client);
}

@riverpod
class LessonNotifier extends _$LessonNotifier{
  @override
  Future<List<LessonModel>> build() async{
    final repository = ref.read(lessonRepositoryProvider);
    return repository.getLessons();
  }

  Future<void> addLesson(LessonModel lesson) async {
    final repository = ref.read(lessonRepositoryProvider);
    try{
      await repository.newLesson(lesson);
      ref.invalidateSelf();
    } catch(e, s){
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> updateLesson(LessonModel lesson, String id) async {
    final repository = ref.read(lessonRepositoryProvider);
    try {
      await repository.updateLesson(lesson, id);
      ref.invalidateSelf();
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> deleteLesson(String id) async {
    final repository = ref.read(lessonRepositoryProvider);
    try {
      await repository.deleteLesson(id);
      ref.invalidateSelf();
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}