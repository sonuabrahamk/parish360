// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_info_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FamilyInfoController)
final familyInfoControllerProvider = FamilyInfoControllerFamily._();

final class FamilyInfoControllerProvider
    extends $AsyncNotifierProvider<FamilyInfoController, FamilyInfo> {
  FamilyInfoControllerProvider._({
    required FamilyInfoControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'familyInfoControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$familyInfoControllerHash();

  @override
  String toString() {
    return r'familyInfoControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FamilyInfoController create() => FamilyInfoController();

  @override
  bool operator ==(Object other) {
    return other is FamilyInfoControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$familyInfoControllerHash() =>
    r'58d1a941784b416f82d95f741a336290a02d107e';

final class FamilyInfoControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          FamilyInfoController,
          AsyncValue<FamilyInfo>,
          FamilyInfo,
          FutureOr<FamilyInfo>,
          String
        > {
  FamilyInfoControllerFamily._()
    : super(
        retry: null,
        name: r'familyInfoControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FamilyInfoControllerProvider call(String familyId) =>
      FamilyInfoControllerProvider._(argument: familyId, from: this);

  @override
  String toString() => r'familyInfoControllerProvider';
}

abstract class _$FamilyInfoController extends $AsyncNotifier<FamilyInfo> {
  late final _$args = ref.$arg as String;
  String get familyId => _$args;

  FutureOr<FamilyInfo> build(String familyId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<FamilyInfo>, FamilyInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FamilyInfo>, FamilyInfo>,
              AsyncValue<FamilyInfo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
