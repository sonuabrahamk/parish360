// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MemberListController)
final memberListControllerProvider = MemberListControllerFamily._();

final class MemberListControllerProvider
    extends $AsyncNotifierProvider<MemberListController, List<MemberInfo>> {
  MemberListControllerProvider._({
    required MemberListControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'memberListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$memberListControllerHash();

  @override
  String toString() {
    return r'memberListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MemberListController create() => MemberListController();

  @override
  bool operator ==(Object other) {
    return other is MemberListControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$memberListControllerHash() =>
    r'c1c3a6d810fbbfa416e795b632c6adfb0fcc3e0c';

final class MemberListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          MemberListController,
          AsyncValue<List<MemberInfo>>,
          List<MemberInfo>,
          FutureOr<List<MemberInfo>>,
          String
        > {
  MemberListControllerFamily._()
    : super(
        retry: null,
        name: r'memberListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MemberListControllerProvider call(String familyId) =>
      MemberListControllerProvider._(argument: familyId, from: this);

  @override
  String toString() => r'memberListControllerProvider';
}

abstract class _$MemberListController extends $AsyncNotifier<List<MemberInfo>> {
  late final _$args = ref.$arg as String;
  String get familyId => _$args;

  FutureOr<List<MemberInfo>> build(String familyId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<MemberInfo>>, List<MemberInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<MemberInfo>>, List<MemberInfo>>,
              AsyncValue<List<MemberInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
