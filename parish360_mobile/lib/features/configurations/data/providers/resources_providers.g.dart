// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resources_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(resourcesApi)
final resourcesApiProvider = ResourcesApiProvider._();

final class ResourcesApiProvider
    extends $FunctionalProvider<ResourcesApi, ResourcesApi, ResourcesApi>
    with $Provider<ResourcesApi> {
  ResourcesApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resourcesApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resourcesApiHash();

  @$internal
  @override
  $ProviderElement<ResourcesApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ResourcesApi create(Ref ref) {
    return resourcesApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResourcesApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResourcesApi>(value),
    );
  }
}

String _$resourcesApiHash() => r'fca466e5ee9d228c27226ba68348d31b9bec0fff';

@ProviderFor(resourceRepository)
final resourceRepositoryProvider = ResourceRepositoryProvider._();

final class ResourceRepositoryProvider
    extends
        $FunctionalProvider<
          ResourceRepository,
          ResourceRepository,
          ResourceRepository
        >
    with $Provider<ResourceRepository> {
  ResourceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resourceRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resourceRepositoryHash();

  @$internal
  @override
  $ProviderElement<ResourceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ResourceRepository create(Ref ref) {
    return resourceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResourceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResourceRepository>(value),
    );
  }
}

String _$resourceRepositoryHash() =>
    r'0c3a5a57c62f335d6b0eeb1ea6f204b68897672a';
