package org.parish360.core.ceremonies.controller;

import jakarta.validation.Valid;
import org.parish360.core.ceremonies.dto.CeremonyInfo;
import org.parish360.core.ceremonies.service.CeremonyManager;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/ceremonies")
public class CeremonyHandler {
    private final CeremonyManager ceremonyManager;

    public CeremonyHandler(CeremonyManager ceremonyManager) {
        this.ceremonyManager = ceremonyManager;
    }

    @PostMapping
    ResponseEntity<CeremonyInfo> createCeremonyInfo(@PathVariable("parishId") String parishId,
                                                    @Valid @RequestBody CeremonyInfo ceremonyInfo) {
        return ResponseEntity.ok(ceremonyManager.createCeremonyInfo(parishId, ceremonyInfo));
    }

    @PatchMapping("/{ceremonyId}")
    ResponseEntity<CeremonyInfo> updateCeremonyInfo(@PathVariable("parishId") String parishId,
                                                    @PathVariable("ceremonyId") String ceremonyId,
                                                    @Valid @RequestBody CeremonyInfo ceremonyInfo) {
        return ResponseEntity.ok(ceremonyManager.updateCeremonyInfo(parishId, ceremonyId, ceremonyInfo));
    }

    @GetMapping
    ResponseEntity<List<CeremonyInfo>> getCeremonyList(@PathVariable("parishId") String parishId) {
        return ResponseEntity.ok(ceremonyManager.getListOfCeremonies(parishId));
    }

    @GetMapping("/{ceremonyId}")
    ResponseEntity<CeremonyInfo> getCeremonyInfo(@PathVariable("parishId") String parishId,
                                                 @PathVariable("ceremonyId") String ceremonyId) {
        return ResponseEntity.ok(ceremonyManager.getCeremonyInfo(parishId, ceremonyId));
    }

    @DeleteMapping("/{ceremonyId}")
    ResponseEntity<Object> deleteCeremonyInfo(@PathVariable("parishId") String parishId,
                                              @PathVariable("ceremonyId") String ceremonyId) {
        ceremonyManager.deleteCeremony(parishId, ceremonyId);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
}
