package org.parish360.core.dataowner.controller;

import jakarta.validation.Valid;
import org.parish360.core.dataowner.dto.ParishInfo;
import org.parish360.core.dataowner.service.ParishManager;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/dataowner/diocese/{dioceseId}/forane/{foraneId}")
public class ParishHandler {
    private final ParishManager parishManager;

    public ParishHandler(ParishManager parishManager) {
        this.parishManager = parishManager;
    }

    @GetMapping("/parish")
    public ResponseEntity<List<ParishInfo>> getParishList(
            @PathVariable("dioceseId") String dioceseId,
            @PathVariable("foraneId") String foraneId) {
        return ResponseEntity.ok(parishManager.getParishList(dioceseId, foraneId));
    }

    @PostMapping("/parish")
    public ResponseEntity<ParishInfo> createParish(
            @PathVariable("dioceseId") String dioceseId,
            @PathVariable("foraneId") String foraneId,
            @Valid @RequestBody ParishInfo parishInfo) {
        return ResponseEntity.ok(parishManager.createParish(dioceseId, foraneId, parishInfo));
    }
}
