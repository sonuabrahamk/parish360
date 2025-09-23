package org.parish360.core.configurations.controller;

import jakarta.validation.Valid;
import org.parish360.core.configurations.dto.ParishYearInfo;
import org.parish360.core.configurations.service.ParishYearManager;
import org.parish360.core.error.exception.BadRequestException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/configurations/parish-year")
public class ParishYearHandler {

    private final ParishYearManager parishYearManager;

    public ParishYearHandler(ParishYearManager parishYearManager) {
        this.parishYearManager = parishYearManager;
    }

    @PostMapping
    public ResponseEntity<ParishYearInfo> createParishYearInfo(@PathVariable("parishId") String parishId,
                                                               @Valid @RequestBody ParishYearInfo parishYearInfo) {
        // validate date range
        if (// parishYearInfo.getStartDate().isBefore(LocalDate.now()) ||  // UNCOMMENTING THIS RESTRICTS BACK DATED CREATION
                parishYearInfo.getStartDate().isAfter(parishYearInfo.getEndDate())) {
            throw new BadRequestException("invalid date range selected");
        }

        return ResponseEntity.ok(parishYearManager.createParishYearInfo(parishId, parishYearInfo));
    }

    @PatchMapping("/{parishYearId}")
    public ResponseEntity<ParishYearInfo> updateParishYearInfo(@PathVariable("parishId") String parishId,
                                                               @PathVariable("parishYearId") String parishYearId,
                                                               @Valid @RequestBody ParishYearInfo parishYearInfo) {
        // validate date range
        if (// parishYearInfo.getStartDate().isBefore(LocalDate.now()) || // UNCOMMENTING THIS RESTRICTS BACK DATED CREATION
                parishYearInfo.getStartDate().isAfter(parishYearInfo.getEndDate())) {
            throw new BadRequestException("invalid date range selected");
        }

        return ResponseEntity.ok(parishYearManager.updateParishYearInfo(parishId, parishYearId, parishYearInfo));
    }

    @GetMapping
    public ResponseEntity<List<ParishYearInfo>> getListOfParishYearInfo(@PathVariable("parishId") String parishId) {
        return ResponseEntity.ok(parishYearManager.getListOfParishYearInfo(parishId));
    }

    @GetMapping("/{parishYearId}")
    public ResponseEntity<ParishYearInfo> getParishYearInfo(@PathVariable("parishId") String parishId,
                                                            @PathVariable("parishYearId") String parishYearId) {
        return ResponseEntity.ok(parishYearManager.getParishYearInfo(parishId, parishYearId));
    }

}
