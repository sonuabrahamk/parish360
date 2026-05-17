// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blessings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(blessingsApi)
final blessingsApiProvider = BlessingsApiProvider._();

final class BlessingsApiProvider
    extends $FunctionalProvider<BlessingsApi, BlessingsApi, BlessingsApi>
    with $Provider<BlessingsApi> {
  BlessingsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'blessingsApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$blessingsApiHash();

  @$internal
  @override
  $ProviderElement<BlessingsApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BlessingsApi create(Ref ref) {
    return blessingsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BlessingsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BlessingsApi>(value),
    );
  }
}

String _$blessingsApiHash() => r'6072bdd35a63d4c68bb6fbae7caa553b90f93845';

@ProviderFor(blessingRepository)
final blessingRepositoryProvider = BlessingRepositoryProvider._();

final class BlessingRepositoryProvider
    extends
        $FunctionalProvider<
          BlessingRepository,
          BlessingRepository,
          BlessingRepository
        >
    with $Provider<BlessingRepository> {
  BlessingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'blessingRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$blessingRepositoryHash();

  @$internal
  @override
  $ProviderElement<BlessingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BlessingRepository create(Ref ref) {
    return blessingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BlessingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BlessingRepository>(value),
    );
  }
}

String _$blessingRepositoryHash() =>
    r'15416930daf4be6195f8653493ae7ba7af408664';
