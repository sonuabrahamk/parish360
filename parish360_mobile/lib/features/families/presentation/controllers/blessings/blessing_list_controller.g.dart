// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blessing_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BlessingListController)
final blessingListControllerProvider = BlessingListControllerFamily._();

final class BlessingListControllerProvider
    extends $AsyncNotifierProvider<BlessingListController, List<BlessingInfo>> {
  BlessingListControllerProvider._({
    required BlessingListControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'blessingListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$blessingListControllerHash();

  @override
  String toString() {
    return r'blessingListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BlessingListController create() => BlessingListController();

  @override
  bool operator ==(Object other) {
    return other is BlessingListControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$blessingListControllerHash() =>
    r'a45c7fafdc9d3ebebc2437f4a7e82338c2491e8a';

final class BlessingListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          BlessingListController,
          AsyncValue<List<BlessingInfo>>,
          List<BlessingInfo>,
          FutureOr<List<BlessingInfo>>,
          String
        > {
  BlessingListControllerFamily._()
    : super(
        retry: null,
        name: r'blessingListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BlessingListControllerProvider call(String familyId) =>
      BlessingListControllerProvider._(argument: familyId, from: this);

  @override
  String toString() => r'blessingListControllerProvider';
}

abstract class _$BlessingListController
    extends $AsyncNotifier<List<BlessingInfo>> {
  late final _$args = ref.$arg as String;
  String get familyId => _$args;

  FutureOr<List<BlessingInfo>> build(String familyId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<BlessingInfo>>, List<BlessingInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<BlessingInfo>>, List<BlessingInfo>>,
              AsyncValue<List<BlessingInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
