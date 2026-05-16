import 'package:parish360_mobile/features/families/data/datasources/migration_api.dart';
import 'package:parish360_mobile/features/families/domain/entities/migration_info.dart';
import 'package:parish360_mobile/features/families/domain/repositories/migration_repository.dart';

class MigrationRepositoryImpl implements MigrationRepository {
  MigrationApi api;

  MigrationRepositoryImpl(this.api);

  @override
  Future<MigrationInfo> createMigration(String familyId, String memberId, MigrationInfo migrationInfo) async {
    final dto = await api.createMigration(familyId, memberId, migrationInfo);
    return dto;
  }

  @override
  Future<void> deleteMigration(String familyId, String memberId, String migrationId) async {
    await api.deleteMigration(familyId, memberId, migrationId);
    return;
  }

  @override
  Future<MigrationInfo> getMigrationById(String familyId, String memberId, String migrationId) async {
    final dto = await api.getMigrationById(familyId, memberId, migrationId);
    return dto;
  }

  @override
  Future<List<MigrationInfo>> getMigrations(String familyId, String memberId) async {
    final dto = await api.getMigrations(familyId, memberId);
    return dto;
  }

  @override
  Future<MigrationInfo> updateMigration(String familyId, String memberId, String migrationId, MigrationInfo migrationInfo) async {
    final dto = await api.updateMigration(familyId, memberId, migrationId, migrationInfo);
    return dto;
  }
  
}