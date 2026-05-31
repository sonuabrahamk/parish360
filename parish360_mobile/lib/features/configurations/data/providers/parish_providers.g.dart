// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parish_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(parishApi)
final parishApiProvider = ParishApiProvider._();

final class ParishApiProvider
    extends $FunctionalProvider<ParishApi, ParishApi, ParishApi>
    with $Provider<ParishApi> {
  ParishApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parishApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parishApiHash();

  @$internal
  @override
  $ProviderElement<ParishApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ParishApi create(Ref ref) {
    return parishApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ParishApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ParishApi>(value),
    );
  }
}

String _$parishApiHash() => r'129ce170654d36330c358fbc07a0f2b10b11724d';

@ProviderFor(parishRepository)
final parishRepositoryProvider = ParishRepositoryProvider._();

final class ParishRepositoryProvider
    extends
        $FunctionalProvider<
          ParishRepository,
          ParishRepository,
          ParishRepository
        >
    with $Provider<ParishRepository> {
  ParishRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parishRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parishRepositoryHash();

  @$internal
  @override
  $ProviderElement<ParishRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ParishRepository create(Ref ref) {
    return parishRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ParishRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ParishRepository>(value),
    );
  }
}

String _$parishRepositoryHash() => r'b07b90a07cd58cfea836f233bf8723a3ae078737';
