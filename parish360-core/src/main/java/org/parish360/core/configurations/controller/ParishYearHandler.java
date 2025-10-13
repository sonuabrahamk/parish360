package org.parish360.core.configurations.controller;

import jakarta.validation.Valid;
import org.parish360.core.configurations.dto.PYAssociationRequest;
import org.parish360.core.configurations.dto.PYAssociationResponse;
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

    @PostMapping("/{parishYearId}/associations")
    public ResponseEntity<List<PYAssociationResponse>> mapAssociationsToParishYear(
            @PathVariable("parishId") String parishId,
            @PathVariable("parishYearId") String parishYearId,
            @Valid @RequestBody PYAssociationRequest pyAssociationRequest) {
        return ResponseEntity.ok(parishYearManager.mapAssociations(parishId, parishYearId, pyAssociationRequest));
    }

    @DeleteMapping("/{parishYearId}/associations")
    public ResponseEntity<List<PYAssociationResponse>> unMapAssociationsToParishYear(
            @PathVariable("parishId") String parishId,
            @PathVariable("parishYearId") String parishYearId,
            @Valid @RequestBody PYAssociationRequest pyAssociationRequest) {
        return ResponseEntity.ok(parishYearManager.unMapAssociations(parishId, parishYearId, pyAssociationRequest));
    }

    @GetMapping("/{parishYearId}/associations")
    public ResponseEntity<List<PYAssociationResponse>> getPyAssociations(
            @PathVariable("parishYearId") String parishYearId) {
        return ResponseEntity.ok(parishYearManager.getPyAssociations(parishYearId));
    }

    @GetMapping("/{parishYearId}/associations/{pyAssociationId}")
    public ResponseEntity<PYAssociationResponse> getPyAssociation(
            @PathVariable("parishYearId") String parishYearId,
            @PathVariable("pyAssociationId") String pyAssociationId) {
        return ResponseEntity.ok(parishYearManager.getPyAssociation(pyAssociationId));
    }

}
