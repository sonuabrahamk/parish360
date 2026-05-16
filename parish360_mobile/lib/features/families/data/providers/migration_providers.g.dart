// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'migration_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(migrationApi)
final migrationApiProvider = MigrationApiProvider._();

final class MigrationApiProvider
    extends $FunctionalProvider<MigrationApi, MigrationApi, MigrationApi>
    with $Provider<MigrationApi> {
  MigrationApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'migrationApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$migrationApiHash();

  @$internal
  @override
  $ProviderElement<MigrationApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MigrationApi create(Ref ref) {
    return migrationApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MigrationApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MigrationApi>(value),
    );
  }
}

String _$migrationApiHash() => r'ea91dd66a0b97b086b74e4fc97b2b10ade591a55';

@ProviderFor(migrationRepository)
final migrationRepositoryProvider = MigrationRepositoryProvider._();

final class MigrationRepositoryProvider
    extends
        $FunctionalProvider<
          MigrationRepository,
          MigrationRepository,
          MigrationRepository
        >
    with $Provider<MigrationRepository> {
  MigrationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'migrationRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$migrationRepositoryHash();

  @$internal
  @override
  $ProviderElement<MigrationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MigrationRepository create(Ref ref) {
    return migrationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MigrationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MigrationRepository>(value),
    );
  }
}

String _$migrationRepositoryHash() =>
    r'7cab086e812082ed85a2616a474a2ca7a07d5db6';
