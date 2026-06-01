// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'association_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AssociationListController)
final associationListControllerProvider = AssociationListControllerProvider._();

final class AssociationListControllerProvider
    extends
        $AsyncNotifierProvider<
          AssociationListController,
          List<AssociationInfo>
        > {
  AssociationListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'associationListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$associationListControllerHash();

  @$internal
  @override
  AssociationListController create() => AssociationListController();
}

String _$associationListControllerHash() =>
    r'e409d38b884297cde0580696e862185e7086a4a5';

abstract class _$AssociationListController
    extends $AsyncNotifier<List<AssociationInfo>> {
  FutureOr<List<AssociationInfo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<AssociationInfo>>, List<AssociationInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AssociationInfo>>,
                List<AssociationInfo>
              >,
              AsyncValue<List<AssociationInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredAssociationsInfoList)
final filteredAssociationsInfoListProvider =
    FilteredAssociationsInfoListFamily._();

final class FilteredAssociationsInfoListProvider
    extends
        $FunctionalProvider<
          List<AssociationInfo>,
          List<AssociationInfo>,
          List<AssociationInfo>
        >
    with $Provider<List<AssociationInfo>> {
  FilteredAssociationsInfoListProvider._({
    required FilteredAssociationsInfoListFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'filteredAssociationsInfoListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredAssociationsInfoListHash();

  @override
  String toString() {
    return r'filteredAssociationsInfoListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<AssociationInfo>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<AssociationInfo> create(Ref ref) {
    final argument = this.argument as String;
    return filteredAssociationsInfoList(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<AssociationInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<AssociationInfo>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredAssociationsInfoListProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredAssociationsInfoListHash() =>
    r'a7c7c1cd5c5757ade776e30bcf69678b06343abf';

final class FilteredAssociationsInfoListFamily extends $Family
    with $FunctionalFamilyOverride<List<AssociationInfo>, String> {
  FilteredAssociationsInfoListFamily._()
    : super(
        retry: null,
        name: r'filteredAssociationsInfoListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredAssociationsInfoListProvider call(String filter) =>
      FilteredAssociationsInfoListProvider._(argument: filter, from: this);

  @override
  String toString() => r'filteredAssociationsInfoListProvider';
}

@ProviderFor(AssociationSearchQuery)
final associationSearchQueryProvider = AssociationSearchQueryProvider._();

final class AssociationSearchQueryProvider
    extends $NotifierProvider<AssociationSearchQuery, String> {
  AssociationSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'associationSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$associationSearchQueryHash();

  @$internal
  @override
  AssociationSearchQuery create() => AssociationSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$associationSearchQueryHash() =>
    r'b2d27361e3a65158391d79475f7b8b882a9d4dc2';

abstract class _$AssociationSearchQuery extends $Notifier<String> {
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
