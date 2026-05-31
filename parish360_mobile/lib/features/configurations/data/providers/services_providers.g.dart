// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(servicesApi)
final servicesApiProvider = ServicesApiProvider._();

final class ServicesApiProvider
    extends $FunctionalProvider<ServicesApi, ServicesApi, ServicesApi>
    with $Provider<ServicesApi> {
  ServicesApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'servicesApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$servicesApiHash();

  @$internal
  @override
  $ProviderElement<ServicesApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ServicesApi create(Ref ref) {
    return servicesApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ServicesApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ServicesApi>(value),
    );
  }
}

String _$servicesApiHash() => r'29c0a2fdac4ccfdb4aed85547f51bf6f1cabbf29';

@ProviderFor(serviceRepository)
final serviceRepositoryProvider = ServiceRepositoryProvider._();

final class ServiceRepositoryProvider
    extends
        $FunctionalProvider<
          ServiceRepository,
          ServiceRepository,
          ServiceRepository
        >
    with $Provider<ServiceRepository> {
  ServiceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serviceRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serviceRepositoryHash();

  @$internal
  @override
  $ProviderElement<ServiceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ServiceRepository create(Ref ref) {
    return serviceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ServiceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ServiceRepository>(value),
    );
  }
}

String _$serviceRepositoryHash() => r'7a70c0ad6df438686519570a54f681acbbaaf3f7';
