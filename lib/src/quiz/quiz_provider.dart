import 'package:app_cas_natal/src/quiz/quiz_model.dart';
import 'package:app_cas_natal/src/quiz/quiz_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app_cas_natal/src/enrollment/enrollment_provider.dart'; 

part 'quiz_provider.g.dart';

@riverpod
QuizRepository quizRepository(Ref ref){
  final client = ref.watch(httpClientProvider); 
  return QuizRepository(client: client);
}

@riverpod
Future<List<QuizQuestionModel>> quizQuestionDetail(
  Ref ref, String lessonId
) async {
  final repository = ref.watch(quizRepositoryProvider);
  return repository.getQuizQuestionsByLessonId(lessonId: lessonId);
}