// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'associations_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(associationsApi)
final associationsApiProvider = AssociationsApiProvider._();

final class AssociationsApiProvider
    extends
        $FunctionalProvider<AssociationsApi, AssociationsApi, AssociationsApi>
    with $Provider<AssociationsApi> {
  AssociationsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'associationsApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$associationsApiHash();

  @$internal
  @override
  $ProviderElement<AssociationsApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AssociationsApi create(Ref ref) {
    return associationsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssociationsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssociationsApi>(value),
    );
  }
}

String _$associationsApiHash() => r'e29a2483a457c513a591031dbfa3e13f46189c70';

@ProviderFor(associationRepository)
final associationRepositoryProvider = AssociationRepositoryProvider._();

final class AssociationRepositoryProvider
    extends
        $FunctionalProvider<
          AssociationRepository,
          AssociationRepository,
          AssociationRepository
        >
    with $Provider<AssociationRepository> {
  AssociationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'associationRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$associationRepositoryHash();

  @$internal
  @override
  $ProviderElement<AssociationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AssociationRepository create(Ref ref) {
    return associationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssociationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssociationRepository>(value),
    );
  }
}

String _$associationRepositoryHash() =>
    r'b3d70053952caa8f18849a7be97b565f0ca0a4e8';
