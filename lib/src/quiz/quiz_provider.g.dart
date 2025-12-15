// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(quizRepository)
const quizRepositoryProvider = QuizRepositoryProvider._();

final class QuizRepositoryProvider
    extends $FunctionalProvider<QuizRepository, QuizRepository, QuizRepository>
    with $Provider<QuizRepository> {
  const QuizRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quizRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quizRepositoryHash();

  @$internal
  @override
  $ProviderElement<QuizRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  QuizRepository create(Ref ref) {
    return quizRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QuizRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QuizRepository>(value),
    );
  }
}

String _$quizRepositoryHash() => r'c737dfe255cca786533c5225f52515a62a3e0e8b';

@ProviderFor(quizQuestionDetail)
const quizQuestionDetailProvider = QuizQuestionDetailFamily._();

final class QuizQuestionDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<QuizQuestionModel>,
          QuizQuestionModel,
          FutureOr<QuizQuestionModel>
        >
    with
        $FutureModifier<QuizQuestionModel>,
        $FutureProvider<QuizQuestionModel> {
  const QuizQuestionDetailProvider._({
    required QuizQuestionDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'quizQuestionDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$quizQuestionDetailHash();

  @override
  String toString() {
    return r'quizQuestionDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<QuizQuestionModel> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<QuizQuestionModel> create(Ref ref) {
    final argument = this.argument as String;
    return quizQuestionDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is QuizQuestionDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$quizQuestionDetailHash() =>
    r'8b4370db04c8fa38927e6805976a6144be19aa63';

final class QuizQuestionDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<QuizQuestionModel>, String> {
  const QuizQuestionDetailFamily._()
    : super(
        retry: null,
        name: r'quizQuestionDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  QuizQuestionDetailProvider call(String lessonId) =>
      QuizQuestionDetailProvider._(argument: lessonId, from: this);

  @override
  String toString() => r'quizQuestionDetailProvider';
}
