// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glossary_provider.dart';

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

@ProviderFor(glossaryRepository)
const glossaryRepositoryProvider = GlossaryRepositoryProvider._();

final class GlossaryRepositoryProvider
    extends
        $FunctionalProvider<
          GlossaryRepository,
          GlossaryRepository,
          GlossaryRepository
        >
    with $Provider<GlossaryRepository> {
  const GlossaryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'glossaryRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$glossaryRepositoryHash();

  @$internal
  @override
  $ProviderElement<GlossaryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GlossaryRepository create(Ref ref) {
    return glossaryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GlossaryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GlossaryRepository>(value),
    );
  }
}

String _$glossaryRepositoryHash() =>
    r'd1ab120509d21f6c1f8d56f7c2a42e6bbac0b871';

@ProviderFor(GlossaryNotifier)
const glossaryProvider = GlossaryNotifierProvider._();

final class GlossaryNotifierProvider
    extends $AsyncNotifierProvider<GlossaryNotifier, List<GlossaryModel>> {
  const GlossaryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'glossaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$glossaryNotifierHash();

  @$internal
  @override
  GlossaryNotifier create() => GlossaryNotifier();
}

String _$glossaryNotifierHash() => r'd2d594828045fa618719be8d11c51ffa1ffdce49';

abstract class _$GlossaryNotifier extends $AsyncNotifier<List<GlossaryModel>> {
  FutureOr<List<GlossaryModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<GlossaryModel>>, List<GlossaryModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<GlossaryModel>>, List<GlossaryModel>>,
              AsyncValue<List<GlossaryModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
