import 'package:app_cas_natal/src/http_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app_cas_natal/src/course/course_model.dart';
import 'package:app_cas_natal/src/course/course_repository.dart';

part 'course_provider.g.dart';

@riverpod
IHttpClient httpClient(Ref ref){
  return HttpClient();
}

@riverpod 
CourseRepository courseRepository(Ref ref){
  final client = ref.watch(httpClientProvider);
  return CourseRepository(client: client);
}

@riverpod
class CourseNotifier extends _$CourseNotifier{
  @override
  Future<List<CourseModel>> build() async{
    final repository = ref.read(courseRepositoryProvider);
    return repository.getCourses();
  }

  Future<void> addCourse(CourseModel course) async {
    final repository = ref.read(courseRepositoryProvider);
    try{
      await repository.newCourse(course);
      ref.invalidateSelf();
    } catch(e, s){
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> updateCourse(CourseModel course, String id) async {
    final repository = ref.read(courseRepositoryProvider);
    try {
      await repository.updateCourse(course, id);
      ref.invalidateSelf();
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> deleteCourse(String id) async {
    final repository = ref.read(courseRepositoryProvider);
    try {
      await repository.deleteCourse(id);
      ref.invalidateSelf();
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

@riverpod
Future<CourseModel> courseDetail(Ref ref, String courseId) async {
  final repository = ref.read(courseRepositoryProvider);
  final course = await repository.getCourseById(courseId);

  if (course.lessons != null && course.lessons!.isNotEmpty) {
    course.lessons!.sort(
      (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
    );
  }

  return course;
}
