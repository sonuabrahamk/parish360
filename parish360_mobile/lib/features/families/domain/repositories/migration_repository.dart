import 'package:parish360_mobile/features/families/domain/entities/migration_info.dart';

abstract class MigrationRepository {
  Future<MigrationInfo> createMigration(String familyId, String memberId, MigrationInfo migrationInfo);
  Future<MigrationInfo> updateMigration(String familyId, String memberId, String migrationId, MigrationInfo migrationInfo);
  Future<void> deleteMigration(String familyId, String memberId, String migrationId);
  Future<List<MigrationInfo>> getMigrations(String familyId, String memberId);
  Future<MigrationInfo> getMigrationById(String familyId, String memberId, String migrationId);
}