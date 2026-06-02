// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dashboardApi)
final dashboardApiProvider = DashboardApiProvider._();

final class DashboardApiProvider
    extends $FunctionalProvider<DashboardApi, DashboardApi, DashboardApi>
    with $Provider<DashboardApi> {
  DashboardApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardApiHash();

  @$internal
  @override
  $ProviderElement<DashboardApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DashboardApi create(Ref ref) {
    return dashboardApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DashboardApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DashboardApi>(value),
    );
  }
}

String _$dashboardApiHash() => r'c8a0979b12173d88e64051f8cc460b3b7c185d16';

@ProviderFor(dashboardRepository)
final dashboardRepositoryProvider = DashboardRepositoryProvider._();

final class DashboardRepositoryProvider
    extends
        $FunctionalProvider<
          DashboardRepository,
          DashboardRepository,
          DashboardRepository
        >
    with $Provider<DashboardRepository> {
  DashboardRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardRepositoryHash();

  @$internal
  @override
  $ProviderElement<DashboardRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DashboardRepository create(Ref ref) {
    return dashboardRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DashboardRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DashboardRepository>(value),
    );
  }
}

String _$dashboardRepositoryHash() =>
    r'0c8f01157cdbcc819a99a3d046ca6512b414cd56';
