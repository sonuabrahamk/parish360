package org.parish360.core.dataowner.controller;

import jakarta.validation.Valid;
import org.parish360.core.dataowner.dto.ForaneInfo;
import org.parish360.core.dataowner.service.ForaneManager;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/dataowner/diocese/{dioceseId}")
public class ForaneHandler {

    private final ForaneManager foraneManager;

    public ForaneHandler(ForaneManager foraneManager) {
        this.foraneManager = foraneManager;
    }

    @GetMapping("/forane")
    public ResponseEntity<List<ForaneInfo>> getForaneList(@PathVariable("dioceseId") String dioceseId) {
        return ResponseEntity.ok(foraneManager.getForaneList(dioceseId));
    }

    @PostMapping("/forane")
    public ResponseEntity<ForaneInfo> createForane(@PathVariable("dioceseId") String dioceseId, @Valid @RequestBody ForaneInfo foraneInfo) {
        return ResponseEntity.ok(foraneManager.createForane(dioceseId, foraneInfo));
    }
}
