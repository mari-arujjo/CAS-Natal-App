// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrollment_provider.dart';

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

@ProviderFor(enrollmentRepository)
const enrollmentRepositoryProvider = EnrollmentRepositoryProvider._();

final class EnrollmentRepositoryProvider
    extends
        $FunctionalProvider<
          EnrollmentRepository,
          EnrollmentRepository,
          EnrollmentRepository
        >
    with $Provider<EnrollmentRepository> {
  const EnrollmentRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'enrollmentRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$enrollmentRepositoryHash();

  @$internal
  @override
  $ProviderElement<EnrollmentRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EnrollmentRepository create(Ref ref) {
    return enrollmentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EnrollmentRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EnrollmentRepository>(value),
    );
  }
}

String _$enrollmentRepositoryHash() =>
    r'66686a0500f423a0814259cf281a2df3bd110c75';

@ProviderFor(EnrollmentNotifier)
const enrollmentProvider = EnrollmentNotifierProvider._();

final class EnrollmentNotifierProvider
    extends $AsyncNotifierProvider<EnrollmentNotifier, List<EnrollmentModel>> {
  const EnrollmentNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'enrollmentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$enrollmentNotifierHash();

  @$internal
  @override
  EnrollmentNotifier create() => EnrollmentNotifier();
}

String _$enrollmentNotifierHash() =>
    r'1512a86b9da7348379a948636204aa3844cb9f4c';

abstract class _$EnrollmentNotifier
    extends $AsyncNotifier<List<EnrollmentModel>> {
  FutureOr<List<EnrollmentModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<EnrollmentModel>>, List<EnrollmentModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<EnrollmentModel>>,
                List<EnrollmentModel>
              >,
              AsyncValue<List<EnrollmentModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
