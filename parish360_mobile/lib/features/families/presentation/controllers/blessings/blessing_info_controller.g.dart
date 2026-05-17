// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blessing_info_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BlessingInfoController)
final blessingInfoControllerProvider = BlessingInfoControllerFamily._();

final class BlessingInfoControllerProvider
    extends $AsyncNotifierProvider<BlessingInfoController, BlessingInfo> {
  BlessingInfoControllerProvider._({
    required BlessingInfoControllerFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'blessingInfoControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$blessingInfoControllerHash();

  @override
  String toString() {
    return r'blessingInfoControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  BlessingInfoController create() => BlessingInfoController();

  @override
  bool operator ==(Object other) {
    return other is BlessingInfoControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$blessingInfoControllerHash() =>
    r'7108b3163c51378e9e7e99f0691bd3ddec45f2a1';

final class BlessingInfoControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          BlessingInfoController,
          AsyncValue<BlessingInfo>,
          BlessingInfo,
          FutureOr<BlessingInfo>,
          (String, String)
        > {
  BlessingInfoControllerFamily._()
    : super(
        retry: null,
        name: r'blessingInfoControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BlessingInfoControllerProvider call(String familyId, String blessingId) =>
      BlessingInfoControllerProvider._(
        argument: (familyId, blessingId),
        from: this,
      );

  @override
  String toString() => r'blessingInfoControllerProvider';
}

abstract class _$BlessingInfoController extends $AsyncNotifier<BlessingInfo> {
  late final _$args = ref.$arg as (String, String);
  String get familyId => _$args.$1;
  String get blessingId => _$args.$2;

  FutureOr<BlessingInfo> build(String familyId, String blessingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BlessingInfo>, BlessingInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BlessingInfo>, BlessingInfo>,
              AsyncValue<BlessingInfo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
