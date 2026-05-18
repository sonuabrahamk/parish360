// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'miscellaneous_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MiscellaneousListController)
final miscellaneousListControllerProvider =
    MiscellaneousListControllerFamily._();

final class MiscellaneousListControllerProvider
    extends
        $AsyncNotifierProvider<
          MiscellaneousListController,
          List<MiscellaneousInfo>
        > {
  MiscellaneousListControllerProvider._({
    required MiscellaneousListControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'miscellaneousListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$miscellaneousListControllerHash();

  @override
  String toString() {
    return r'miscellaneousListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MiscellaneousListController create() => MiscellaneousListController();

  @override
  bool operator ==(Object other) {
    return other is MiscellaneousListControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$miscellaneousListControllerHash() =>
    r'85d20c5beacf70453dcf62fd592f04a8d8fec9de';

final class MiscellaneousListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          MiscellaneousListController,
          AsyncValue<List<MiscellaneousInfo>>,
          List<MiscellaneousInfo>,
          FutureOr<List<MiscellaneousInfo>>,
          String
        > {
  MiscellaneousListControllerFamily._()
    : super(
        retry: null,
        name: r'miscellaneousListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MiscellaneousListControllerProvider call(String familyId) =>
      MiscellaneousListControllerProvider._(argument: familyId, from: this);

  @override
  String toString() => r'miscellaneousListControllerProvider';
}

abstract class _$MiscellaneousListController
    extends $AsyncNotifier<List<MiscellaneousInfo>> {
  late final _$args = ref.$arg as String;
  String get familyId => _$args;

  FutureOr<List<MiscellaneousInfo>> build(String familyId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<MiscellaneousInfo>>,
              List<MiscellaneousInfo>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<MiscellaneousInfo>>,
                List<MiscellaneousInfo>
              >,
              AsyncValue<List<MiscellaneousInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
