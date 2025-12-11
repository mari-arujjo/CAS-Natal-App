import 'package:app_cas_natal/src/appuser/appuser_provider.dart';
import 'package:app_cas_natal/src/enrollment/enrollment_model.dart';
import 'package:app_cas_natal/src/enrollment/enrollment_repository.dart';
import 'package:app_cas_natal/src/http_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'enrollment_provider.g.dart';

@riverpod
IHttpClient httpClient(Ref ref){
  return HttpClient();
}

@riverpod 
EnrollmentRepository enrollmentRepository(Ref ref){
  final client = ref.watch(httpClientProvider);
  return EnrollmentRepository(client: client);
}

@riverpod
Future<List<EnrollmentModel>> userEnrollments(Ref ref) async {
  final repository = ref.read(enrollmentRepositoryProvider);
  final currentUser = await ref.watch(currentUserProvider.future); 
  if (currentUser == null || currentUser.token == null) return []; 
  return repository.getUserEnrollments(token: currentUser.token!); 
}


@riverpod
class EnrollmentNotifier extends _$EnrollmentNotifier{
  @override
  Future<List<EnrollmentModel>> build() async{
    final repository = ref.read(enrollmentRepositoryProvider);
    return repository.getEnrollments();
  }

  Future<EnrollmentModel> enrollUser(String courseSymbol) async {
    final repository = ref.read(enrollmentRepositoryProvider);
    final currentUser = await ref.read(currentUserProvider.future);
    if (currentUser == null || currentUser.token == null) throw Exception('Falha na matrícula: Usuário não autenticado ou token ausente.');

    try {
      final created = await repository.newEnrollment(courseSymbol: courseSymbol, token: currentUser.token!);
      if (!ref.mounted) return created;
      ref.invalidate(userEnrollmentsProvider);

      return created;
    } catch (e) {
      print('Falha na matrícula: ${e.toString().replaceAll('Exception: ', '')}');
      throw Exception('Falha na matrícula: ${e.toString().replaceAll('Exception: ', '')}');
    }
  }
}