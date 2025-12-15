// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_provider.dart';

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

@ProviderFor(signRepository)
const signRepositoryProvider = SignRepositoryProvider._();

final class SignRepositoryProvider
    extends $FunctionalProvider<SignRepository, SignRepository, SignRepository>
    with $Provider<SignRepository> {
  const SignRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signRepositoryHash();

  @$internal
  @override
  $ProviderElement<SignRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignRepository create(Ref ref) {
    return signRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignRepository>(value),
    );
  }
}

String _$signRepositoryHash() => r'015399e808ba5be50745baa4deffa949f4bcd398';

@ProviderFor(signDetail)
const signDetailProvider = SignDetailFamily._();

final class SignDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<SignModel>,
          SignModel,
          FutureOr<SignModel>
        >
    with $FutureModifier<SignModel>, $FutureProvider<SignModel> {
  const SignDetailProvider._({
    required SignDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'signDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$signDetailHash();

  @override
  String toString() {
    return r'signDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SignModel> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<SignModel> create(Ref ref) {
    final argument = this.argument as String;
    return signDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SignDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$signDetailHash() => r'714f1f3beb8d59326597f79e2573c377513ddb85';

final class SignDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SignModel>, String> {
  const SignDetailFamily._()
    : super(
        retry: null,
        name: r'signDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SignDetailProvider call(String signId) =>
      SignDetailProvider._(argument: signId, from: this);

  @override
  String toString() => r'signDetailProvider';
}

@ProviderFor(SignNotifier)
const signProvider = SignNotifierProvider._();

final class SignNotifierProvider
    extends $AsyncNotifierProvider<SignNotifier, List<SignModel>> {
  const SignNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signNotifierHash();

  @$internal
  @override
  SignNotifier create() => SignNotifier();
}

String _$signNotifierHash() => r'28bc702129456db6bf4a8af8ef22e33e04d12900';

abstract class _$SignNotifier extends $AsyncNotifier<List<SignModel>> {
  FutureOr<List<SignModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<SignModel>>, List<SignModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<SignModel>>, List<SignModel>>,
              AsyncValue<List<SignModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
