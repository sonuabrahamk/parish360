// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_intention_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ServiceIntentionListController)
final serviceIntentionListControllerProvider =
    ServiceIntentionListControllerProvider._();

final class ServiceIntentionListControllerProvider
    extends
        $AsyncNotifierProvider<
          ServiceIntentionListController,
          List<ServiceIntentionInfo>
        > {
  ServiceIntentionListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serviceIntentionListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serviceIntentionListControllerHash();

  @$internal
  @override
  ServiceIntentionListController create() => ServiceIntentionListController();
}

String _$serviceIntentionListControllerHash() =>
    r'e252d0ab8ca856ce52fda48bef61f18144c35949';

abstract class _$ServiceIntentionListController
    extends $AsyncNotifier<List<ServiceIntentionInfo>> {
  FutureOr<List<ServiceIntentionInfo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<ServiceIntentionInfo>>,
              List<ServiceIntentionInfo>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ServiceIntentionInfo>>,
                List<ServiceIntentionInfo>
              >,
              AsyncValue<List<ServiceIntentionInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredServiceIntentionsList)
final filteredServiceIntentionsListProvider =
    FilteredServiceIntentionsListFamily._();

final class FilteredServiceIntentionsListProvider
    extends
        $FunctionalProvider<
          List<ServiceIntentionInfo>,
          List<ServiceIntentionInfo>,
          List<ServiceIntentionInfo>
        >
    with $Provider<List<ServiceIntentionInfo>> {
  FilteredServiceIntentionsListProvider._({
    required FilteredServiceIntentionsListFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'filteredServiceIntentionsListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredServiceIntentionsListHash();

  @override
  String toString() {
    return r'filteredServiceIntentionsListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<ServiceIntentionInfo>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<ServiceIntentionInfo> create(Ref ref) {
    final argument = this.argument as String;
    return filteredServiceIntentionsList(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ServiceIntentionInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ServiceIntentionInfo>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredServiceIntentionsListProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredServiceIntentionsListHash() =>
    r'cb1dd17b33107af53b355a940195e82c8bfe7389';

final class FilteredServiceIntentionsListFamily extends $Family
    with $FunctionalFamilyOverride<List<ServiceIntentionInfo>, String> {
  FilteredServiceIntentionsListFamily._()
    : super(
        retry: null,
        name: r'filteredServiceIntentionsListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredServiceIntentionsListProvider call(String filter) =>
      FilteredServiceIntentionsListProvider._(argument: filter, from: this);

  @override
  String toString() => r'filteredServiceIntentionsListProvider';
}

@ProviderFor(ServiceIntentionSearchQuery)
final serviceIntentionSearchQueryProvider =
    ServiceIntentionSearchQueryProvider._();

final class ServiceIntentionSearchQueryProvider
    extends $NotifierProvider<ServiceIntentionSearchQuery, String> {
  ServiceIntentionSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serviceIntentionSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serviceIntentionSearchQueryHash();

  @$internal
  @override
  ServiceIntentionSearchQuery create() => ServiceIntentionSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$serviceIntentionSearchQueryHash() =>
    r'c6c1952c396f447c3df5c27288c7d77eff4c9535';

abstract class _$ServiceIntentionSearchQuery extends $Notifier<String> {
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
