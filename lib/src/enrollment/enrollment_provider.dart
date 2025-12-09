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
class EnrollmentNotifier extends _$EnrollmentNotifier{
  @override
  Future<List<EnrollmentModel>> build() async{
    final repository = ref.read(enrollmentRepositoryProvider);
    return repository.getEnrollments();
  }
}