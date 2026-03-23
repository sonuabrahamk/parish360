// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sacrament_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sacramentApi)
final sacramentApiProvider = SacramentApiProvider._();

final class SacramentApiProvider
    extends $FunctionalProvider<SacramentApi, SacramentApi, SacramentApi>
    with $Provider<SacramentApi> {
  SacramentApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sacramentApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sacramentApiHash();

  @$internal
  @override
  $ProviderElement<SacramentApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SacramentApi create(Ref ref) {
    return sacramentApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SacramentApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SacramentApi>(value),
    );
  }
}

String _$sacramentApiHash() => r'477af4f2a76123501b2ad38cb456759d882b1918';

@ProviderFor(sacramentRepository)
final sacramentRepositoryProvider = SacramentRepositoryProvider._();

final class SacramentRepositoryProvider
    extends
        $FunctionalProvider<
          SacramentRepository,
          SacramentRepository,
          SacramentRepository
        >
    with $Provider<SacramentRepository> {
  SacramentRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sacramentRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sacramentRepositoryHash();

  @$internal
  @override
  $ProviderElement<SacramentRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SacramentRepository create(Ref ref) {
    return sacramentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SacramentRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SacramentRepository>(value),
    );
  }
}

String _$sacramentRepositoryHash() =>
    r'901a78aa4642d48e675b15f045ba23e05d3ebd63';
