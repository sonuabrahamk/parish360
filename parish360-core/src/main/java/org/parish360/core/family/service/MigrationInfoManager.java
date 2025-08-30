package org.parish360.core.family.service;

import org.parish360.core.family.dto.MigrationInfo;

import java.util.List;

public interface MigrationInfoManager {
    MigrationInfo createMigrationInfo(String familyId, String memberId, MigrationInfo migrationInfo);

    MigrationInfo updateMigrationInfo(String memberId, String migrationId, MigrationInfo migrationInfo);

    MigrationInfo getMigrationInfo(String memberId, String migrationId);

    List<MigrationInfo> getMigrationInfoList(String memberId);

    void deleteMigrationInfo(String memberId, String migrationId);
}
