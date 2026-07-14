// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'committee_member_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CommitteeMemberListController)
final committeeMemberListControllerProvider =
    CommitteeMemberListControllerFamily._();

final class CommitteeMemberListControllerProvider
    extends
        $AsyncNotifierProvider<
          CommitteeMemberListController,
          List<CommitteeMemberInfo>
        > {
  CommitteeMemberListControllerProvider._({
    required CommitteeMemberListControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'committeeMemberListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$committeeMemberListControllerHash();

  @override
  String toString() {
    return r'committeeMemberListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CommitteeMemberListController create() => CommitteeMemberListController();

  @override
  bool operator ==(Object other) {
    return other is CommitteeMemberListControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$committeeMemberListControllerHash() =>
    r'637873fe34770f6e1e14c055732b92de4a29e9d0';

final class CommitteeMemberListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CommitteeMemberListController,
          AsyncValue<List<CommitteeMemberInfo>>,
          List<CommitteeMemberInfo>,
          FutureOr<List<CommitteeMemberInfo>>,
          String
        > {
  CommitteeMemberListControllerFamily._()
    : super(
        retry: null,
        name: r'committeeMemberListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CommitteeMemberListControllerProvider call(String pyAssociationId) =>
      CommitteeMemberListControllerProvider._(
        argument: pyAssociationId,
        from: this,
      );

  @override
  String toString() => r'committeeMemberListControllerProvider';
}

abstract class _$CommitteeMemberListController
    extends $AsyncNotifier<List<CommitteeMemberInfo>> {
  late final _$args = ref.$arg as String;
  String get pyAssociationId => _$args;

  FutureOr<List<CommitteeMemberInfo>> build(String pyAssociationId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<CommitteeMemberInfo>>,
              List<CommitteeMemberInfo>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<CommitteeMemberInfo>>,
                List<CommitteeMemberInfo>
              >,
              AsyncValue<List<CommitteeMemberInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(filteredCommitteeMembers)
final filteredCommitteeMembersProvider = FilteredCommitteeMembersFamily._();

final class FilteredCommitteeMembersProvider
    extends
        $FunctionalProvider<
          List<CommitteeMemberInfo>,
          List<CommitteeMemberInfo>,
          List<CommitteeMemberInfo>
        >
    with $Provider<List<CommitteeMemberInfo>> {
  FilteredCommitteeMembersProvider._({
    required FilteredCommitteeMembersFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'filteredCommitteeMembersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredCommitteeMembersHash();

  @override
  String toString() {
    return r'filteredCommitteeMembersProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<List<CommitteeMemberInfo>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<CommitteeMemberInfo> create(Ref ref) {
    final argument = this.argument as (String, String);
    return filteredCommitteeMembers(ref, argument.$1, argument.$2);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CommitteeMemberInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CommitteeMemberInfo>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredCommitteeMembersProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredCommitteeMembersHash() =>
    r'449f1278bef7a8c64463fb3712d85799c094f8e5';

final class FilteredCommitteeMembersFamily extends $Family
    with
        $FunctionalFamilyOverride<List<CommitteeMemberInfo>, (String, String)> {
  FilteredCommitteeMembersFamily._()
    : super(
        retry: null,
        name: r'filteredCommitteeMembersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredCommitteeMembersProvider call(
    String pyAssociationId,
    String filter,
  ) => FilteredCommitteeMembersProvider._(
    argument: (pyAssociationId, filter),
    from: this,
  );

  @override
  String toString() => r'filteredCommitteeMembersProvider';
}
