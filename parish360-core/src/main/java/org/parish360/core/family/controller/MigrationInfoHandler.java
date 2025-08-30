package org.parish360.core.family.controller;

import jakarta.validation.Valid;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.family.dto.MigrationInfo;
import org.parish360.core.family.service.MigrationInfoManager;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/family-records/{familyId}/members/{memberId}/migrations")
public class MigrationInfoHandler {
    private final MigrationInfoManager migrationInfoManager;

    public MigrationInfoHandler(MigrationInfoManager migrationInfoManager) {
        this.migrationInfoManager = migrationInfoManager;
    }

    @PostMapping
    ResponseEntity<MigrationInfo> createMigrationInfo(@PathVariable("familyId") String familyId,
                                                      @PathVariable("memberId") String memberId,
                                                      @Valid @RequestBody MigrationInfo migrationInfo) {
        return ResponseEntity.ok(
                migrationInfoManager.createMigrationInfo(familyId, memberId, migrationInfo));
    }

    @PatchMapping("/{migrationId}")
    ResponseEntity<MigrationInfo> updateMigrationInfo(@PathVariable("memberId") String memberId,
                                                      @PathVariable("migrationId") String migrationId,
                                                      @Valid @RequestBody MigrationInfo migrationInfo) {
        //validate migration record mismatch
        if (migrationInfo.getId() != null && !migrationInfo.getId().equals(migrationId)) {
            throw new BadRequestException("migration record id mismatch");
        }

        return ResponseEntity.ok(
                migrationInfoManager.updateMigrationInfo(memberId, migrationId, migrationInfo));
    }

    @GetMapping
    ResponseEntity<List<MigrationInfo>> getMigrationInfoList(@PathVariable("memberId") String memberId) {
        return ResponseEntity.ok(
                migrationInfoManager.getMigrationInfoList(memberId));
    }

    @GetMapping("/{migrationId}")
    ResponseEntity<MigrationInfo> getMigrationInfo(@PathVariable("memberId") String memberId,
                                                   @PathVariable("migrationId") String migrationId) {
        return ResponseEntity.ok(migrationInfoManager.getMigrationInfo(memberId, migrationId));
    }

    @DeleteMapping("/{migrationId}")
    ResponseEntity<MigrationInfo> deleteMigrationInfo(@PathVariable("memberId") String memberId,
                                                      @PathVariable("migrationId") String migrationId) {
        migrationInfoManager.deleteMigrationInfo(memberId, migrationId);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
}
