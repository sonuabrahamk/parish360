// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'associate_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AssociateListController)
final associateListControllerProvider = AssociateListControllerFamily._();

final class AssociateListControllerProvider
    extends $AsyncNotifierProvider<AssociateListController, dynamic> {
  AssociateListControllerProvider._({
    required AssociateListControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'associateListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$associateListControllerHash();

  @override
  String toString() {
    return r'associateListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AssociateListController create() => AssociateListController();

  @override
  bool operator ==(Object other) {
    return other is AssociateListControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$associateListControllerHash() =>
    r'c5653d96370b67009270c6a5afb9de4290168520';

final class AssociateListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          AssociateListController,
          AsyncValue<dynamic>,
          dynamic,
          FutureOr<dynamic>,
          String
        > {
  AssociateListControllerFamily._()
    : super(
        retry: null,
        name: r'associateListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AssociateListControllerProvider call(String pyAssociationId) =>
      AssociateListControllerProvider._(argument: pyAssociationId, from: this);

  @override
  String toString() => r'associateListControllerProvider';
}

abstract class _$AssociateListController extends $AsyncNotifier<dynamic> {
  late final _$args = ref.$arg as String;
  String get pyAssociationId => _$args;

  FutureOr<dynamic> build(String pyAssociationId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<dynamic>, dynamic>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<dynamic>, dynamic>,
              AsyncValue<dynamic>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(filteredAssociates)
final filteredAssociatesProvider = FilteredAssociatesFamily._();

final class FilteredAssociatesProvider
    extends $FunctionalProvider<dynamic, dynamic, dynamic>
    with $Provider<dynamic> {
  FilteredAssociatesProvider._({
    required FilteredAssociatesFamily super.from,
    required (String, String, String) super.argument,
  }) : super(
         retry: null,
         name: r'filteredAssociatesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredAssociatesHash();

  @override
  String toString() {
    return r'filteredAssociatesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<dynamic> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  dynamic create(Ref ref) {
    final argument = this.argument as (String, String, String);
    return filteredAssociates(ref, argument.$1, argument.$2, argument.$3);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(dynamic value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<dynamic>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredAssociatesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredAssociatesHash() =>
    r'321964c3ff9ad9e129f361e853eef0ad6135d934';

final class FilteredAssociatesFamily extends $Family
    with $FunctionalFamilyOverride<dynamic, (String, String, String)> {
  FilteredAssociatesFamily._()
    : super(
        retry: null,
        name: r'filteredAssociatesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredAssociatesProvider call(
    String pyAssociationId,
    String associationType,
    String filter,
  ) => FilteredAssociatesProvider._(
    argument: (pyAssociationId, associationType, filter),
    from: this,
  );

  @override
  String toString() => r'filteredAssociatesProvider';
}
