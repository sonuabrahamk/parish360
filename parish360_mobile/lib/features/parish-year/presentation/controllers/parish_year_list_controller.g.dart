// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parish_year_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ParishYearListController)
final parishYearListControllerProvider = ParishYearListControllerProvider._();

final class ParishYearListControllerProvider
    extends
        $AsyncNotifierProvider<ParishYearListController, List<ParishYearInfo>> {
  ParishYearListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parishYearListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parishYearListControllerHash();

  @$internal
  @override
  ParishYearListController create() => ParishYearListController();
}

String _$parishYearListControllerHash() =>
    r'108acb10376724b7f0ff36174d550c3a562258be';

abstract class _$ParishYearListController
    extends $AsyncNotifier<List<ParishYearInfo>> {
  FutureOr<List<ParishYearInfo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ParishYearInfo>>, List<ParishYearInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ParishYearInfo>>,
                List<ParishYearInfo>
              >,
              AsyncValue<List<ParishYearInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredParishYearList)
final filteredParishYearListProvider = FilteredParishYearListFamily._();

final class FilteredParishYearListProvider
    extends
        $FunctionalProvider<
          List<ParishYearInfo>,
          List<ParishYearInfo>,
          List<ParishYearInfo>
        >
    with $Provider<List<ParishYearInfo>> {
  FilteredParishYearListProvider._({
    required FilteredParishYearListFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'filteredParishYearListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredParishYearListHash();

  @override
  String toString() {
    return r'filteredParishYearListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<ParishYearInfo>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<ParishYearInfo> create(Ref ref) {
    final argument = this.argument as String;
    return filteredParishYearList(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ParishYearInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ParishYearInfo>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredParishYearListProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredParishYearListHash() =>
    r'b2572e4d6ac755fb25b46dc5f34783c77663e39a';

final class FilteredParishYearListFamily extends $Family
    with $FunctionalFamilyOverride<List<ParishYearInfo>, String> {
  FilteredParishYearListFamily._()
    : super(
        retry: null,
        name: r'filteredParishYearListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredParishYearListProvider call(String filter) =>
      FilteredParishYearListProvider._(argument: filter, from: this);

  @override
  String toString() => r'filteredParishYearListProvider';
}
