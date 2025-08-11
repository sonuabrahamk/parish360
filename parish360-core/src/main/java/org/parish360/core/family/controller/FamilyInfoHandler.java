package org.parish360.core.family.controller;

import jakarta.validation.Valid;
import org.parish360.core.family.dto.FamilyInfo;
import org.parish360.core.family.service.FamilyInfoManager;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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
}
