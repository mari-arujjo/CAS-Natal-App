// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appuser_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(secureStorage)
const secureStorageProvider = SecureStorageProvider._();

final class SecureStorageProvider
    extends
        $FunctionalProvider<
          FlutterSecureStorage,
          FlutterSecureStorage,
          FlutterSecureStorage
        >
    with $Provider<FlutterSecureStorage> {
  const SecureStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'secureStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$secureStorageHash();

  @$internal
  @override
  $ProviderElement<FlutterSecureStorage> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FlutterSecureStorage create(Ref ref) {
    return secureStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlutterSecureStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlutterSecureStorage>(value),
    );
  }
}

String _$secureStorageHash() => r'273dc403a965c1f24962aaf4d40776611a26f8b8';

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

@ProviderFor(userRepository)
const userRepositoryProvider = UserRepositoryProvider._();

final class UserRepositoryProvider
    extends
        $FunctionalProvider<
          AppUserRepository,
          AppUserRepository,
          AppUserRepository
        >
    with $Provider<AppUserRepository> {
  const UserRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userRepositoryHash();

  @$internal
  @override
  $ProviderElement<AppUserRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppUserRepository create(Ref ref) {
    return userRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppUserRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppUserRepository>(value),
    );
  }
}

String _$userRepositoryHash() => r'4cdb9fc0218c7928559ca61f682565d39cd975dd';

@ProviderFor(AppUserNotifier)
const appUserProvider = AppUserNotifierProvider._();

final class AppUserNotifierProvider
    extends $AsyncNotifierProvider<AppUserNotifier, List<AppUserModel>> {
  const AppUserNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appUserNotifierHash();

  @$internal
  @override
  AppUserNotifier create() => AppUserNotifier();
}

String _$appUserNotifierHash() => r'e3f95767d4e0d7f7171174244057a87b64ea60c6';

abstract class _$AppUserNotifier extends $AsyncNotifier<List<AppUserModel>> {
  FutureOr<List<AppUserModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<AppUserModel>>, List<AppUserModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<AppUserModel>>, List<AppUserModel>>,
              AsyncValue<List<AppUserModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(currentUser)
const currentUserProvider = CurrentUserProvider._();

final class CurrentUserProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppUserModel?>,
          AppUserModel?,
          FutureOr<AppUserModel?>
        >
    with $FutureModifier<AppUserModel?>, $FutureProvider<AppUserModel?> {
  const CurrentUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  $FutureProviderElement<AppUserModel?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AppUserModel?> create(Ref ref) {
    return currentUser(ref);
  }
}

String _$currentUserHash() => r'3a5e32e063db51b309964851e9f8930326178f71';

@ProviderFor(avatar)
const avatarProvider = AvatarProvider._();

final class AvatarProvider
    extends
        $FunctionalProvider<
          AsyncValue<Uint8List?>,
          Uint8List?,
          FutureOr<Uint8List?>
        >
    with $FutureModifier<Uint8List?>, $FutureProvider<Uint8List?> {
  const AvatarProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'avatarProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$avatarHash();

  @$internal
  @override
  $FutureProviderElement<Uint8List?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Uint8List?> create(Ref ref) {
    return avatar(ref);
  }
}

String _$avatarHash() => r'5fbd7230ad28ca73556878db754a7104b43c022e';
