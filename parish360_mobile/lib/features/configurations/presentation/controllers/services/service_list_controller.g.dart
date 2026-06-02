// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ServiceListController)
final serviceListControllerProvider = ServiceListControllerProvider._();

final class ServiceListControllerProvider
    extends $AsyncNotifierProvider<ServiceListController, List<ServiceInfo>> {
  ServiceListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serviceListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serviceListControllerHash();

  @$internal
  @override
  ServiceListController create() => ServiceListController();
}

String _$serviceListControllerHash() =>
    r'6cd77487f96ef8af2fb480f9b12f529a5e8d6d8a';

abstract class _$ServiceListController
    extends $AsyncNotifier<List<ServiceInfo>> {
  FutureOr<List<ServiceInfo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ServiceInfo>>, List<ServiceInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ServiceInfo>>, List<ServiceInfo>>,
              AsyncValue<List<ServiceInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredServicesInfoList)
final filteredServicesInfoListProvider = FilteredServicesInfoListFamily._();

final class FilteredServicesInfoListProvider
    extends
        $FunctionalProvider<
          List<ServiceInfo>,
          List<ServiceInfo>,
          List<ServiceInfo>
        >
    with $Provider<List<ServiceInfo>> {
  FilteredServicesInfoListProvider._({
    required FilteredServicesInfoListFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'filteredServicesInfoListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredServicesInfoListHash();

  @override
  String toString() {
    return r'filteredServicesInfoListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<ServiceInfo>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<ServiceInfo> create(Ref ref) {
    final argument = this.argument as String;
    return filteredServicesInfoList(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ServiceInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ServiceInfo>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredServicesInfoListProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredServicesInfoListHash() =>
    r'dc1aceb0610169279dd0b7a6b6457fc0f37ce936';

final class FilteredServicesInfoListFamily extends $Family
    with $FunctionalFamilyOverride<List<ServiceInfo>, String> {
  FilteredServicesInfoListFamily._()
    : super(
        retry: null,
        name: r'filteredServicesInfoListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredServicesInfoListProvider call(String filter) =>
      FilteredServicesInfoListProvider._(argument: filter, from: this);

  @override
  String toString() => r'filteredServicesInfoListProvider';
}

@ProviderFor(ServiceSearchQuery)
final serviceSearchQueryProvider = ServiceSearchQueryProvider._();

final class ServiceSearchQueryProvider
    extends $NotifierProvider<ServiceSearchQuery, String> {
  ServiceSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serviceSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serviceSearchQueryHash();

  @$internal
  @override
  ServiceSearchQuery create() => ServiceSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$serviceSearchQueryHash() =>
    r'd40c95d6c2772604bc842ef91590b6489b7c2354';

abstract class _$ServiceSearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
