// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ceremony_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CeremonyListController)
final ceremonyListControllerProvider = CeremonyListControllerProvider._();

final class CeremonyListControllerProvider
    extends $AsyncNotifierProvider<CeremonyListController, List<CeremonyInfo>> {
  CeremonyListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ceremonyListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ceremonyListControllerHash();

  @$internal
  @override
  CeremonyListController create() => CeremonyListController();
}

String _$ceremonyListControllerHash() =>
    r'6744dd7884cadf20f0cfc3e3bc14a3b1000997bf';

abstract class _$CeremonyListController
    extends $AsyncNotifier<List<CeremonyInfo>> {
  FutureOr<List<CeremonyInfo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<CeremonyInfo>>, List<CeremonyInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CeremonyInfo>>, List<CeremonyInfo>>,
              AsyncValue<List<CeremonyInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredCeremonies)
final filteredCeremoniesProvider = FilteredCeremoniesFamily._();

final class FilteredCeremoniesProvider
    extends
        $FunctionalProvider<
          List<CeremonyInfo>,
          List<CeremonyInfo>,
          List<CeremonyInfo>
        >
    with $Provider<List<CeremonyInfo>> {
  FilteredCeremoniesProvider._({
    required FilteredCeremoniesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'filteredCeremoniesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredCeremoniesHash();

  @override
  String toString() {
    return r'filteredCeremoniesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<CeremonyInfo>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<CeremonyInfo> create(Ref ref) {
    final argument = this.argument as String;
    return filteredCeremonies(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CeremonyInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CeremonyInfo>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredCeremoniesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredCeremoniesHash() =>
    r'771abce8696eaf0d71d05b4915d1156e8f92eb24';

final class FilteredCeremoniesFamily extends $Family
    with $FunctionalFamilyOverride<List<CeremonyInfo>, String> {
  FilteredCeremoniesFamily._()
    : super(
        retry: null,
        name: r'filteredCeremoniesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredCeremoniesProvider call(String filter) =>
      FilteredCeremoniesProvider._(argument: filter, from: this);

  @override
  String toString() => r'filteredCeremoniesProvider';
}
