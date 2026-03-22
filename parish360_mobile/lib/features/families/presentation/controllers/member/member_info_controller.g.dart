// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_info_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MemberInfoController)
final memberInfoControllerProvider = MemberInfoControllerFamily._();

final class MemberInfoControllerProvider
    extends $AsyncNotifierProvider<MemberInfoController, MemberInfo> {
  MemberInfoControllerProvider._({
    required MemberInfoControllerFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'memberInfoControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$memberInfoControllerHash();

  @override
  String toString() {
    return r'memberInfoControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  MemberInfoController create() => MemberInfoController();

  @override
  bool operator ==(Object other) {
    return other is MemberInfoControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$memberInfoControllerHash() =>
    r'27ab85033056ef55cf288cfdf45d882a66e20dd5';

final class MemberInfoControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          MemberInfoController,
          AsyncValue<MemberInfo>,
          MemberInfo,
          FutureOr<MemberInfo>,
          (String, String)
        > {
  MemberInfoControllerFamily._()
    : super(
        retry: null,
        name: r'memberInfoControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MemberInfoControllerProvider call(String familyId, String memberId) =>
      MemberInfoControllerProvider._(
        argument: (familyId, memberId),
        from: this,
      );

  @override
  String toString() => r'memberInfoControllerProvider';
}

abstract class _$MemberInfoController extends $AsyncNotifier<MemberInfo> {
  late final _$args = ref.$arg as (String, String);
  String get familyId => _$args.$1;
  String get memberId => _$args.$2;

  FutureOr<MemberInfo> build(String familyId, String memberId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<MemberInfo>, MemberInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MemberInfo>, MemberInfo>,
              AsyncValue<MemberInfo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
