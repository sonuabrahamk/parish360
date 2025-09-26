package org.parish360.core.configurations.controller;

import jakarta.validation.Valid;
import org.parish360.core.associations.service.AssociationMapper;
import org.parish360.core.configurations.dto.AssociationInfo;
import org.parish360.core.configurations.service.AssociationManager;
import org.parish360.core.dataowner.service.ParishManager;
import org.parish360.core.error.exception.BadRequestException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/configurations/association")
public class AssociationHandler {
    private final AssociationManager associationManager;

    public AssociationHandler(ParishManager parishManager, AssociationMapper associationMapper, AssociationManager associationManager) {
        this.associationManager = associationManager;
    }

    @PostMapping
    public ResponseEntity<AssociationInfo> createAssociationInfo(@PathVariable String parishId,
                                                                 @Valid @RequestBody AssociationInfo associationInfo) {
        // valid is type is specified
        if (associationInfo.getType() == null) {
            throw new BadRequestException("association type cannot be empty");
        }
        return ResponseEntity.ok(associationManager.createAssociation(parishId, associationInfo));
    }

    @PatchMapping("/{associationId}")
    public ResponseEntity<AssociationInfo> updateAssociationInfo(@PathVariable String parishId,
                                                                 @PathVariable String associationId,
                                                                 @Valid @RequestBody AssociationInfo associationInfo) {
        return ResponseEntity.ok(associationManager.updateAssociation(parishId, associationId, associationInfo));
    }

    @GetMapping
    public ResponseEntity<List<AssociationInfo>> getListOfAssociations(@PathVariable String parishId) {
        return ResponseEntity.ok(associationManager.getListOfAssociations(parishId));
    }

    @GetMapping("/{associationId}")
    public ResponseEntity<AssociationInfo> getAssociationInfo(@PathVariable String parishId,
                                                              @PathVariable String associationId) {
        return ResponseEntity.ok(associationManager.getAssociationInfo(parishId, associationId));
    }

    @DeleteMapping("/{associationId}")
    public ResponseEntity<Object> deleteAssociation(@PathVariable String parishId,
                                                    @PathVariable String associationId) {
        associationManager.deleteAssociation(parishId, associationId);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
}
