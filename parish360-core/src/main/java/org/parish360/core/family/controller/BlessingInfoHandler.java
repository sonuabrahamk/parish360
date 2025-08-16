package org.parish360.core.family.controller;

import jakarta.validation.Valid;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.family.dto.BlessingInfo;
import org.parish360.core.family.service.BlessingManager;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/family-records/{familyId}/blessings")
public class BlessingInfoHandler {
    private final BlessingManager blessingManager;

    public BlessingInfoHandler(BlessingManager blessingManager) {
        this.blessingManager = blessingManager;
    }

    @PostMapping
    public ResponseEntity<BlessingInfo> createBlessingInfo(@PathVariable("parishId") String parishId,
                                                           @PathVariable("familyId") String familyId,
                                                           @Valid @RequestBody BlessingInfo blessingInfo) {
        // validate familyId information

        return ResponseEntity.ok(blessingManager.createBlessingInfo(parishId, familyId, blessingInfo));
    }

    @PatchMapping("/{blessingId}")
    public ResponseEntity<BlessingInfo> updateBlessingInfo(@PathVariable("familyId") String familyId,
                                                           @PathVariable("blessingId") String blessingId,
                                                           @Valid @RequestBody BlessingInfo blessingInfo) {
        //validate blessing ID
        if (blessingInfo.getFamilyId() != null && !blessingInfo.getFamilyId().equals(blessingId)) {
            throw new BadRequestException("blessing information mismatch");
        }
        return ResponseEntity.ok(blessingManager.updateBlessingInfo(familyId, blessingId, blessingInfo));
    }

    @GetMapping
    public ResponseEntity<List<BlessingInfo>> getBlessingInfoList(@PathVariable("familyId") String familyId) {
        return ResponseEntity.ok(blessingManager.getBlessingInfoList(familyId));
    }

    @GetMapping("/{blessingId}")
    public ResponseEntity<BlessingInfo> getBlessingInfo(@PathVariable("familyId") String familyId,
                                                        @PathVariable("blessingId") String blessingId) {
        return ResponseEntity.ok(blessingManager.getBlessingInfo(familyId, blessingId));
    }

    @DeleteMapping("/{blessingId}")
    public ResponseEntity<BlessingInfo> deleteBlessingInfo(@PathVariable("familyId") String familyId,
                                                           @PathVariable("blessingId") String blessingId) {
        blessingManager.deleteBlessingInfo(familyId, blessingId);

        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

}
