// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(usersApi)
final usersApiProvider = UsersApiProvider._();

final class UsersApiProvider
    extends $FunctionalProvider<UsersApi, UsersApi, UsersApi>
    with $Provider<UsersApi> {
  UsersApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usersApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usersApiHash();

  @$internal
  @override
  $ProviderElement<UsersApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UsersApi create(Ref ref) {
    return usersApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UsersApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UsersApi>(value),
    );
  }
}

String _$usersApiHash() => r'20a53abcc5ed4a84cb0d0bd5ad300c5e700046fb';

@ProviderFor(usersRepository)
final usersRepositoryProvider = UsersRepositoryProvider._();

final class UsersRepositoryProvider
    extends
        $FunctionalProvider<UsersRepository, UsersRepository, UsersRepository>
    with $Provider<UsersRepository> {
  UsersRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usersRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usersRepositoryHash();

  @$internal
  @override
  $ProviderElement<UsersRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UsersRepository create(Ref ref) {
    return usersRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UsersRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UsersRepository>(value),
    );
  }
}

String _$usersRepositoryHash() => r'8f843bfbe2bb1fc779c841a7f9fa30681fd1bc05';
