import 'package:parish360_mobile/features/families/data/providers/migration_providers.dart';
import 'package:parish360_mobile/features/families/domain/entities/migration_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'migration_info_controller.g.dart';

@riverpod
class MigrationInfoController extends _$MigrationInfoController {
  @override
  Future<MigrationInfo?> build(
    String familyId,
    String memberId,
    String migrationId,
  ) async {
    return ref
        .read(migrationRepositoryProvider)
        .getMigrationById(familyId, memberId, migrationId);
  }

  Future<MigrationInfo> createMigration(
    String familyId,
    String memberId,
    MigrationInfo migrationInfo,
  ) async {
    final newMigration = await ref
        .read(migrationRepositoryProvider)
        .createMigration(familyId, memberId, migrationInfo);
    if (!ref.mounted) {
      return newMigration;
    }
    state = AsyncValue.data(newMigration);
    return newMigration;
  }

  Future<MigrationInfo> updateMigration(
    String familyId,
    String memberId,
    String migrationId,
    MigrationInfo migrationInfo,
  ) async {
    final updatedMigration = await ref
        .read(migrationRepositoryProvider)
        .updateMigration(familyId, memberId, migrationId, migrationInfo);

    if (!ref.mounted) {
      return updatedMigration;
    }

    state = AsyncValue.data(updatedMigration);
    return updatedMigration;
  }

  Future<void> deleteMigration(
    String familyId,
    String memberId,
    String migrationId,
  ) async {
    await ref
        .read(migrationRepositoryProvider)
        .deleteMigration(familyId, memberId, migrationId);

    if (!ref.mounted) {
      return;
    }
    state = AsyncValue.error(
      'Migration deleted',
      StackTrace.current,
    ); // Clear the state after deletion
  }
}
