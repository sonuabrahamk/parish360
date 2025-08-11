package org.parish360.core.family.controller;

import jakarta.validation.Valid;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.family.dto.FamilyInfo;
import org.parish360.core.family.service.FamilyInfoManager;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/family-records")
public class FamilyInfoHandler {
    private final FamilyInfoManager familyInfoManager;

    public FamilyInfoHandler(FamilyInfoManager familyInfoManager) {
        this.familyInfoManager = familyInfoManager;
    }

    @PostMapping
    public ResponseEntity<FamilyInfo> createFamilyInfo(@PathVariable("parishId") String parishId,
                                                       @Valid @RequestBody FamilyInfo familyInfo) {
        return ResponseEntity.ok(familyInfoManager.createFamilyRecord(parishId, familyInfo));
    }

    @PatchMapping("/{familyId}")
    public ResponseEntity<FamilyInfo> updateFamilyInfo(@PathVariable("parishId") String parishId,
                                                       @PathVariable("familyId") String familyId,
                                                       @Valid @RequestBody FamilyInfo familyInfo) {

        // validate parish
        if (familyInfo.getParishId() != null && !parishId.equals(familyInfo.getParishId())) {
            throw new BadRequestException("parish id for family record is not matching");
        }

        return ResponseEntity.ok(familyInfoManager.updateFamilyRecord(parishId, familyId, familyInfo));
    }

    @GetMapping
    public ResponseEntity<List<FamilyInfo>> getFamilyInfoList(@PathVariable("parishId") String parishId) {
        return ResponseEntity.ok(familyInfoManager.getFamilyRecordsList(parishId));
    }

    @GetMapping("/{familyId}")
    public ResponseEntity<FamilyInfo> getFamilyInfo(@PathVariable("parishId") String parishId,
                                                    @PathVariable("familyId") String familyId) {
        return ResponseEntity.ok(familyInfoManager.getFamilyRecord(parishId, familyId));
    }

    @DeleteMapping("/{familyId}")
    public ResponseEntity<?> deleteFamilyRecord(@PathVariable("parishId") String parishId,
                                                @PathVariable("familyId") String familyId) {

        //delete family record
        familyInfoManager.removeFamilyRecord(parishId, familyId);

        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
}
