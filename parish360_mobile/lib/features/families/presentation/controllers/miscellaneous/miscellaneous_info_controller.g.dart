// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'miscellaneous_info_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MiscellaneousInfoController)
final miscellaneousInfoControllerProvider =
    MiscellaneousInfoControllerFamily._();

final class MiscellaneousInfoControllerProvider
    extends
        $AsyncNotifierProvider<MiscellaneousInfoController, MiscellaneousInfo> {
  MiscellaneousInfoControllerProvider._({
    required MiscellaneousInfoControllerFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'miscellaneousInfoControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$miscellaneousInfoControllerHash();

  @override
  String toString() {
    return r'miscellaneousInfoControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  MiscellaneousInfoController create() => MiscellaneousInfoController();

  @override
  bool operator ==(Object other) {
    return other is MiscellaneousInfoControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$miscellaneousInfoControllerHash() =>
    r'debfce53de0e5c73f6ad1692d8030791aa8524d5';

final class MiscellaneousInfoControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          MiscellaneousInfoController,
          AsyncValue<MiscellaneousInfo>,
          MiscellaneousInfo,
          FutureOr<MiscellaneousInfo>,
          (String, String)
        > {
  MiscellaneousInfoControllerFamily._()
    : super(
        retry: null,
        name: r'miscellaneousInfoControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MiscellaneousInfoControllerProvider call(
    String familyId,
    String miscellaneousId,
  ) => MiscellaneousInfoControllerProvider._(
    argument: (familyId, miscellaneousId),
    from: this,
  );

  @override
  String toString() => r'miscellaneousInfoControllerProvider';
}

abstract class _$MiscellaneousInfoController
    extends $AsyncNotifier<MiscellaneousInfo> {
  late final _$args = ref.$arg as (String, String);
  String get familyId => _$args.$1;
  String get miscellaneousId => _$args.$2;

  FutureOr<MiscellaneousInfo> build(String familyId, String miscellaneousId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<MiscellaneousInfo>, MiscellaneousInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MiscellaneousInfo>, MiscellaneousInfo>,
              AsyncValue<MiscellaneousInfo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
