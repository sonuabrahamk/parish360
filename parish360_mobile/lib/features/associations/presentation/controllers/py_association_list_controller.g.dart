// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'py_association_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PyAssociationListController)
final pyAssociationListControllerProvider =
    PyAssociationListControllerFamily._();

final class PyAssociationListControllerProvider
    extends
        $AsyncNotifierProvider<
          PyAssociationListController,
          List<PyAssociationResponse>
        > {
  PyAssociationListControllerProvider._({
    required PyAssociationListControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'pyAssociationListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pyAssociationListControllerHash();

  @override
  String toString() {
    return r'pyAssociationListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PyAssociationListController create() => PyAssociationListController();

  @override
  bool operator ==(Object other) {
    return other is PyAssociationListControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pyAssociationListControllerHash() =>
    r'5a4c5db89fd87d2a80a7cde22cefd75ab9cefc44';

final class PyAssociationListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          PyAssociationListController,
          AsyncValue<List<PyAssociationResponse>>,
          List<PyAssociationResponse>,
          FutureOr<List<PyAssociationResponse>>,
          String
        > {
  PyAssociationListControllerFamily._()
    : super(
        retry: null,
        name: r'pyAssociationListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PyAssociationListControllerProvider call(String parishYearId) =>
      PyAssociationListControllerProvider._(argument: parishYearId, from: this);

  @override
  String toString() => r'pyAssociationListControllerProvider';
}

abstract class _$PyAssociationListController
    extends $AsyncNotifier<List<PyAssociationResponse>> {
  late final _$args = ref.$arg as String;
  String get parishYearId => _$args;

  FutureOr<List<PyAssociationResponse>> build(String parishYearId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<PyAssociationResponse>>,
              List<PyAssociationResponse>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<PyAssociationResponse>>,
                List<PyAssociationResponse>
              >,
              AsyncValue<List<PyAssociationResponse>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(filteredpyAssociations)
final filteredpyAssociationsProvider = FilteredpyAssociationsFamily._();

final class FilteredpyAssociationsProvider
    extends
        $FunctionalProvider<
          List<PyAssociationResponse>,
          List<PyAssociationResponse>,
          List<PyAssociationResponse>
        >
    with $Provider<List<PyAssociationResponse>> {
  FilteredpyAssociationsProvider._({
    required FilteredpyAssociationsFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'filteredpyAssociationsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredpyAssociationsHash();

  @override
  String toString() {
    return r'filteredpyAssociationsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<List<PyAssociationResponse>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<PyAssociationResponse> create(Ref ref) {
    final argument = this.argument as (String, String);
    return filteredpyAssociations(ref, argument.$1, argument.$2);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PyAssociationResponse> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PyAssociationResponse>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredpyAssociationsProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredpyAssociationsHash() =>
    r'c7223bd858ad3d03c7faa3d4428eea5ac062228c';

final class FilteredpyAssociationsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          List<PyAssociationResponse>,
          (String, String)
        > {
  FilteredpyAssociationsFamily._()
    : super(
        retry: null,
        name: r'filteredpyAssociationsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredpyAssociationsProvider call(String parishYearId, String filter) =>
      FilteredpyAssociationsProvider._(
        argument: (parishYearId, filter),
        from: this,
      );

  @override
  String toString() => r'filteredpyAssociationsProvider';
}
