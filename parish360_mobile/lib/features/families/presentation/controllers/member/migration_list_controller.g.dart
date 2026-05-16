// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'migration_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MigrationListController)
final migrationListControllerProvider = MigrationListControllerFamily._();

final class MigrationListControllerProvider
    extends
        $AsyncNotifierProvider<MigrationListController, List<MigrationInfo>> {
  MigrationListControllerProvider._({
    required MigrationListControllerFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'migrationListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$migrationListControllerHash();

  @override
  String toString() {
    return r'migrationListControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  MigrationListController create() => MigrationListController();

  @override
  bool operator ==(Object other) {
    return other is MigrationListControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$migrationListControllerHash() =>
    r'a3354f1196f7abae1afcd5a34cfd8c485e5564a9';

final class MigrationListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          MigrationListController,
          AsyncValue<List<MigrationInfo>>,
          List<MigrationInfo>,
          FutureOr<List<MigrationInfo>>,
          (String, String)
        > {
  MigrationListControllerFamily._()
    : super(
        retry: null,
        name: r'migrationListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MigrationListControllerProvider call(String familyId, String memberId) =>
      MigrationListControllerProvider._(
        argument: (familyId, memberId),
        from: this,
      );

  @override
  String toString() => r'migrationListControllerProvider';
}

abstract class _$MigrationListController
    extends $AsyncNotifier<List<MigrationInfo>> {
  late final _$args = ref.$arg as (String, String);
  String get familyId => _$args.$1;
  String get memberId => _$args.$2;

  FutureOr<List<MigrationInfo>> build(String familyId, String memberId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<MigrationInfo>>, List<MigrationInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<MigrationInfo>>, List<MigrationInfo>>,
              AsyncValue<List<MigrationInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
