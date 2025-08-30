package org.parish360.core.family.controller;

import jakarta.validation.Valid;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.family.dto.SacramentInfo;
import org.parish360.core.family.service.SacramentInfoManager;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/family-records/{familyId}/members/{memberId}/sacraments")
public class SacramentInfoHandler {
    private final SacramentInfoManager sacramentInfoManager;

    public SacramentInfoHandler(SacramentInfoManager sacramentInfoManager) {
        this.sacramentInfoManager = sacramentInfoManager;
    }

    @PostMapping
    ResponseEntity<SacramentInfo> createSacramentInfo(@PathVariable("familyId") String familyId,
                                                      @PathVariable("memberId") String memberId,
                                                      @Valid @RequestBody SacramentInfo sacramentInfo) {
        return ResponseEntity.ok(sacramentInfoManager.createSacramentInfo(familyId, memberId, sacramentInfo));
    }

    @PatchMapping("/{sacramentInfoId}")
    ResponseEntity<SacramentInfo> updateSacramentInfo(@PathVariable("memberId") String memberId,
                                                      @PathVariable("sacramentInfoId") String sacramentInfoId,
                                                      @Valid @RequestBody SacramentInfo sacramentInfo) {
        // validate if the sacrament records are matching
        if (sacramentInfo.getId() != null && !sacramentInfo.getId().equals(sacramentInfoId)) {
            throw new BadRequestException("sacrament reference is not matching");
        }

        return ResponseEntity.ok(sacramentInfoManager.updateSacramentInfo(memberId, sacramentInfoId, sacramentInfo));
    }

    @GetMapping
    ResponseEntity<List<SacramentInfo>> getSacramentInfoList(@PathVariable("memberId") String memberId) {
        return ResponseEntity.ok(sacramentInfoManager.getSacramentInfoList(memberId));
    }

    @GetMapping("/{sacramentInfoId}")
    ResponseEntity<SacramentInfo> getSacramentInfo(@PathVariable("memberId") String memberId,
                                                   @PathVariable("sacramentInfoId") String sacramentInfoId) {
        return ResponseEntity.ok(sacramentInfoManager.getSacramentInfo(memberId, sacramentInfoId));
    }

    @DeleteMapping("/{sacramentInfoId}")
    ResponseEntity<SacramentInfo> deleteSacramentInfo(@PathVariable("memberId") String memberId,
                                                      @PathVariable("sacramentInfoId") String sacramentInfoId) {
        sacramentInfoManager.deleteSacramentInfo(memberId, sacramentInfoId);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
}
