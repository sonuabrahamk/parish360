// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ceremony_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ceremoniesApi)
final ceremoniesApiProvider = CeremoniesApiProvider._();

final class CeremoniesApiProvider
    extends $FunctionalProvider<CeremoniesApi, CeremoniesApi, CeremoniesApi>
    with $Provider<CeremoniesApi> {
  CeremoniesApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ceremoniesApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ceremoniesApiHash();

  @$internal
  @override
  $ProviderElement<CeremoniesApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CeremoniesApi create(Ref ref) {
    return ceremoniesApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CeremoniesApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CeremoniesApi>(value),
    );
  }
}

String _$ceremoniesApiHash() => r'0d5620c5f452d8643594306281930c49c68c0b33';

@ProviderFor(ceremoniesRepository)
final ceremoniesRepositoryProvider = CeremoniesRepositoryProvider._();

final class CeremoniesRepositoryProvider
    extends
        $FunctionalProvider<
          CeremoniesRepository,
          CeremoniesRepository,
          CeremoniesRepository
        >
    with $Provider<CeremoniesRepository> {
  CeremoniesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ceremoniesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ceremoniesRepositoryHash();

  @$internal
  @override
  $ProviderElement<CeremoniesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CeremoniesRepository create(Ref ref) {
    return ceremoniesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CeremoniesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CeremoniesRepository>(value),
    );
  }
}

String _$ceremoniesRepositoryHash() =>
    r'214d1b8ad00a353ece7520b6e38f5f2ee8124750';
