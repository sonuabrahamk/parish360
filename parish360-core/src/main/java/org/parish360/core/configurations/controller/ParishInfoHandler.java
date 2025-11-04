package org.parish360.core.configurations.controller;

import jakarta.validation.Valid;
import org.parish360.core.dataowner.dto.ParishInfo;
import org.parish360.core.dataowner.service.ParishManager;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/parish/{parishId}/configurations/parish")
public class ParishInfoHandler {
    private final ParishManager parishManager;

    public ParishInfoHandler(ParishManager parishManager) {
        this.parishManager = parishManager;
    }

    @GetMapping
    ResponseEntity<ParishInfo> getParishInfo(@PathVariable("parishId") String parishId) {
        return ResponseEntity.ok(parishManager.getParishInfo(parishId));
    }

    @PatchMapping
    ResponseEntity<ParishInfo> updateParishInfo(@PathVariable("parishId") String parishId,
                                                @Valid @RequestBody ParishInfo parishInfo) {
        return ResponseEntity.ok(parishManager.updateParishInfo(parishId, parishInfo));
    }
}
