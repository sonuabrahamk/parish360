// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'committee_member_info_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CommitteeMemberInfoController)
final committeeMemberInfoControllerProvider =
    CommitteeMemberInfoControllerFamily._();

final class CommitteeMemberInfoControllerProvider
    extends
        $AsyncNotifierProvider<
          CommitteeMemberInfoController,
          CommitteeMemberInfo
        > {
  CommitteeMemberInfoControllerProvider._({
    required CommitteeMemberInfoControllerFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'committeeMemberInfoControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$committeeMemberInfoControllerHash();

  @override
  String toString() {
    return r'committeeMemberInfoControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  CommitteeMemberInfoController create() => CommitteeMemberInfoController();

  @override
  bool operator ==(Object other) {
    return other is CommitteeMemberInfoControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$committeeMemberInfoControllerHash() =>
    r'68ad3cf09aced49d70172ac97ba0d6c2548af51d';

final class CommitteeMemberInfoControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CommitteeMemberInfoController,
          AsyncValue<CommitteeMemberInfo>,
          CommitteeMemberInfo,
          FutureOr<CommitteeMemberInfo>,
          (String, String)
        > {
  CommitteeMemberInfoControllerFamily._()
    : super(
        retry: null,
        name: r'committeeMemberInfoControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CommitteeMemberInfoControllerProvider call(
    String pyAssociationId,
    String committeeMemberId,
  ) => CommitteeMemberInfoControllerProvider._(
    argument: (pyAssociationId, committeeMemberId),
    from: this,
  );

  @override
  String toString() => r'committeeMemberInfoControllerProvider';
}

abstract class _$CommitteeMemberInfoController
    extends $AsyncNotifier<CommitteeMemberInfo> {
  late final _$args = ref.$arg as (String, String);
  String get pyAssociationId => _$args.$1;
  String get committeeMemberId => _$args.$2;

  FutureOr<CommitteeMemberInfo> build(
    String pyAssociationId,
    String committeeMemberId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<CommitteeMemberInfo>, CommitteeMemberInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CommitteeMemberInfo>, CommitteeMemberInfo>,
              AsyncValue<CommitteeMemberInfo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
