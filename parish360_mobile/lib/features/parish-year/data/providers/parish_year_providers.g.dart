// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parish_year_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(parishYearApi)
final parishYearApiProvider = ParishYearApiProvider._();

final class ParishYearApiProvider
    extends $FunctionalProvider<ParishYearApi, ParishYearApi, ParishYearApi>
    with $Provider<ParishYearApi> {
  ParishYearApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parishYearApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parishYearApiHash();

  @$internal
  @override
  $ProviderElement<ParishYearApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ParishYearApi create(Ref ref) {
    return parishYearApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ParishYearApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ParishYearApi>(value),
    );
  }
}

String _$parishYearApiHash() => r'70cf13bafb4bb3df814e13fc6065bbe9bd3fdf11';

@ProviderFor(parishYearRepository)
final parishYearRepositoryProvider = ParishYearRepositoryProvider._();

final class ParishYearRepositoryProvider
    extends
        $FunctionalProvider<
          ParishYearRepository,
          ParishYearRepository,
          ParishYearRepository
        >
    with $Provider<ParishYearRepository> {
  ParishYearRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parishYearRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parishYearRepositoryHash();

  @$internal
  @override
  $ProviderElement<ParishYearRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ParishYearRepository create(Ref ref) {
    return parishYearRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ParishYearRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ParishYearRepository>(value),
    );
  }
}

String _$parishYearRepositoryHash() =>
    r'ebf080689e38f11d13511e5c61337a209b3c9c0d';
