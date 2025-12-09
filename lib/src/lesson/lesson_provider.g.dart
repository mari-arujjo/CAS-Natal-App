// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(httpClient)
const httpClientProvider = HttpClientProvider._();

final class HttpClientProvider
    extends $FunctionalProvider<IHttpClient, IHttpClient, IHttpClient>
    with $Provider<IHttpClient> {
  const HttpClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'httpClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$httpClientHash();

  @$internal
  @override
  $ProviderElement<IHttpClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IHttpClient create(Ref ref) {
    return httpClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IHttpClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IHttpClient>(value),
    );
  }
}

String _$httpClientHash() => r'd4a03ed2eaa7aff98bc929aaf5f3836914037efa';

@ProviderFor(lessonRepository)
const lessonRepositoryProvider = LessonRepositoryProvider._();

final class LessonRepositoryProvider
    extends
        $FunctionalProvider<
          LessonRepository,
          LessonRepository,
          LessonRepository
        >
    with $Provider<LessonRepository> {
  const LessonRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lessonRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lessonRepositoryHash();

  @$internal
  @override
  $ProviderElement<LessonRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LessonRepository create(Ref ref) {
    return lessonRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LessonRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LessonRepository>(value),
    );
  }
}

String _$lessonRepositoryHash() => r'a00c547c77e54585a275d0a0692c437eec284c25';

@ProviderFor(LessonNotifier)
const lessonProvider = LessonNotifierProvider._();

final class LessonNotifierProvider
    extends $AsyncNotifierProvider<LessonNotifier, List<LessonModel>> {
  const LessonNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lessonProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lessonNotifierHash();

  @$internal
  @override
  LessonNotifier create() => LessonNotifier();
}

String _$lessonNotifierHash() => r'3ce710613267d866033b269a0f9da9301820b11e';

abstract class _$LessonNotifier extends $AsyncNotifier<List<LessonModel>> {
  FutureOr<List<LessonModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<LessonModel>>, List<LessonModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<LessonModel>>, List<LessonModel>>,
              AsyncValue<List<LessonModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
