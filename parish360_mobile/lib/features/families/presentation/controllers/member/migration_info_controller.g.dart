// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'migration_info_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MigrationInfoController)
final migrationInfoControllerProvider = MigrationInfoControllerFamily._();

final class MigrationInfoControllerProvider
    extends $AsyncNotifierProvider<MigrationInfoController, MigrationInfo?> {
  MigrationInfoControllerProvider._({
    required MigrationInfoControllerFamily super.from,
    required (String, String, String) super.argument,
  }) : super(
         retry: null,
         name: r'migrationInfoControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$migrationInfoControllerHash();

  @override
  String toString() {
    return r'migrationInfoControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  MigrationInfoController create() => MigrationInfoController();

  @override
  bool operator ==(Object other) {
    return other is MigrationInfoControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$migrationInfoControllerHash() =>
    r'd7d161a467dfed805474761aa79b32dff143311b';

final class MigrationInfoControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          MigrationInfoController,
          AsyncValue<MigrationInfo?>,
          MigrationInfo?,
          FutureOr<MigrationInfo?>,
          (String, String, String)
        > {
  MigrationInfoControllerFamily._()
    : super(
        retry: null,
        name: r'migrationInfoControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MigrationInfoControllerProvider call(
    String familyId,
    String memberId,
    String migrationId,
  ) => MigrationInfoControllerProvider._(
    argument: (familyId, memberId, migrationId),
    from: this,
  );

  @override
  String toString() => r'migrationInfoControllerProvider';
}

abstract class _$MigrationInfoController
    extends $AsyncNotifier<MigrationInfo?> {
  late final _$args = ref.$arg as (String, String, String);
  String get familyId => _$args.$1;
  String get memberId => _$args.$2;
  String get migrationId => _$args.$3;

  FutureOr<MigrationInfo?> build(
    String familyId,
    String memberId,
    String migrationId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<MigrationInfo?>, MigrationInfo?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MigrationInfo?>, MigrationInfo?>,
              AsyncValue<MigrationInfo?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2, _$args.$3));
  }
}
