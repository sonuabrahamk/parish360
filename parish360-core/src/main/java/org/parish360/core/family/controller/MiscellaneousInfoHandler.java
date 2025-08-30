package org.parish360.core.family.controller;

import jakarta.validation.Valid;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.family.dto.MiscellaneousInfo;
import org.parish360.core.family.service.MiscellaneousManager;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/family-records/{familyId}/miscellaneous")
public class MiscellaneousInfoHandler {
    private final MiscellaneousManager miscellaneousManager;

    public MiscellaneousInfoHandler(MiscellaneousManager miscellaneousManager) {
        this.miscellaneousManager = miscellaneousManager;
    }

    @PostMapping
    ResponseEntity<MiscellaneousInfo> createMiscellaneousInfo(@PathVariable("parishId") String parishId,
                                                              @PathVariable("familyId") String familyId,
                                                              @Valid @RequestBody MiscellaneousInfo miscellaneousInfo) {
        return ResponseEntity.ok(miscellaneousManager.createMiscellaneousInfo(parishId, familyId, miscellaneousInfo));
    }

    @PatchMapping("/{miscellaneousId}")
    ResponseEntity<MiscellaneousInfo> updateMiscellaneousInfo(@PathVariable("familyId") String familyId,
                                                              @PathVariable("miscellaneousId") String miscellaneousId,
                                                              @Valid @RequestBody MiscellaneousInfo miscellaneousInfo) {
        // validate if miscellaneous ID is matching
        if (miscellaneousInfo.getId() != null && !miscellaneousInfo.getId().equals(miscellaneousId)) {
            throw new BadRequestException("miscellaneous record id mismatch");
        }
        
        return ResponseEntity.ok(
                miscellaneousManager.updateMiscellaneousInfo(familyId, miscellaneousId, miscellaneousInfo));
    }

    @GetMapping
    ResponseEntity<List<MiscellaneousInfo>> getMiscellaneousInfoList(@PathVariable("familyId") String familyId) {
        return ResponseEntity.ok(miscellaneousManager.getMiscellaneousInfoList(familyId));
    }

    @GetMapping("/{miscellaneousId}")
    ResponseEntity<MiscellaneousInfo> getMiscellaneousInfo(@PathVariable("familyId") String familyId,
                                                           @PathVariable("miscellaneousId") String miscellaneousId) {
        return ResponseEntity.ok(miscellaneousManager.getMiscellaneousInfo(familyId, miscellaneousId));
    }

    @DeleteMapping("/{miscellaneousId}")
    ResponseEntity<MiscellaneousInfo> deleteMiscellaneousInfo(@PathVariable("familyId") String familyId,
                                                              @PathVariable("miscellaneousId") String miscellaneousId) {
        miscellaneousManager.deleteMiscellaneousInfo(familyId, miscellaneousId);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
}
