package org.parish360.core.dataowner.controller;

import jakarta.validation.Valid;
import org.parish360.core.dataowner.dto.DioceseInfo;
import org.parish360.core.dataowner.service.DioceseManager;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/dataowner")
public class DioceseHandler {

    private final DioceseManager dioceseManager;

    public DioceseHandler(DioceseManager dioceseManager) {
        this.dioceseManager = dioceseManager;
    }

    @GetMapping("/diocese")
    public ResponseEntity<List<DioceseInfo>> getDioceseList() {
        return ResponseEntity.ok(dioceseManager.getDiocese());
    }

    @PostMapping("/diocese")
    public ResponseEntity<DioceseInfo> createDiocese(@Valid @RequestBody DioceseInfo dioceseInfo) {
        return ResponseEntity.ok(dioceseManager.createDiocese(dioceseInfo));
    }
}
