// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_intention_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(serviceIntentionsApi)
final serviceIntentionsApiProvider = ServiceIntentionsApiProvider._();

final class ServiceIntentionsApiProvider
    extends
        $FunctionalProvider<
          ServiceIntentionsApi,
          ServiceIntentionsApi,
          ServiceIntentionsApi
        >
    with $Provider<ServiceIntentionsApi> {
  ServiceIntentionsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serviceIntentionsApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serviceIntentionsApiHash();

  @$internal
  @override
  $ProviderElement<ServiceIntentionsApi> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ServiceIntentionsApi create(Ref ref) {
    return serviceIntentionsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ServiceIntentionsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ServiceIntentionsApi>(value),
    );
  }
}

String _$serviceIntentionsApiHash() =>
    r'6dc6ae6fbb88a2c5c13079c4319a221e8310a71b';

@ProviderFor(serviceIntentionRepository)
final serviceIntentionRepositoryProvider =
    ServiceIntentionRepositoryProvider._();

final class ServiceIntentionRepositoryProvider
    extends
        $FunctionalProvider<
          ServiceIntentionRepository,
          ServiceIntentionRepository,
          ServiceIntentionRepository
        >
    with $Provider<ServiceIntentionRepository> {
  ServiceIntentionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serviceIntentionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serviceIntentionRepositoryHash();

  @$internal
  @override
  $ProviderElement<ServiceIntentionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ServiceIntentionRepository create(Ref ref) {
    return serviceIntentionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ServiceIntentionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ServiceIntentionRepository>(value),
    );
  }
}

String _$serviceIntentionRepositoryHash() =>
    r'18266e259020258cef95099cbc7af5e0ab30e666';
