package org.parish360.core.associations.controller;

import jakarta.validation.Valid;
import org.parish360.core.associations.dto.AssociatesRequest;
import org.parish360.core.associations.dto.CommitteeMemberInfo;
import org.parish360.core.associations.service.PYAssociationsManager;
import org.parish360.core.error.exception.BadRequestException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/associations/{pyAssociationId}")
public class PYAssociationsHandler {
    private final PYAssociationsManager pyAssociationsManager;

    public PYAssociationsHandler(PYAssociationsManager pyAssociationsManager) {
        this.pyAssociationsManager = pyAssociationsManager;
    }

    @PostMapping("/committee")
    public ResponseEntity<CommitteeMemberInfo> addCommitteeMember(
            @PathVariable("pyAssociationId") String pyAssociationId,
            @Valid @RequestBody CommitteeMemberInfo committeeMemberInfo) {
        return ResponseEntity.ok(pyAssociationsManager.addCommitteeMember(pyAssociationId, committeeMemberInfo));
    }

    @PatchMapping("/committee/{committeeMemberId}")
    public ResponseEntity<CommitteeMemberInfo> updateCommitteeInfo(
            @PathVariable("pyAssociationId") String pyAssociationId,
            @PathVariable("committeeMemberId") String committeeMemberId,
            @Valid @RequestBody CommitteeMemberInfo committeeMemberInfo) {
        return ResponseEntity.ok(
                pyAssociationsManager.updateCommitteeMember(pyAssociationId, committeeMemberId, committeeMemberInfo));
    }

    @GetMapping("/committee")
    public ResponseEntity<List<CommitteeMemberInfo>> getListOfCommitteeMembers(
            @PathVariable("pyAssociationId") String pyAssociationId) {
        return ResponseEntity.ok(pyAssociationsManager.getListOfCommitteeMembers(pyAssociationId));
    }

    @GetMapping("/committee/{committeeMemberId}")
    public ResponseEntity<CommitteeMemberInfo> getCommitteeMemberInfo(
            @PathVariable("pyAssociationId") String pyAssociationId,
            @PathVariable("committeeMemberId") String committeeMemberId) {
        return ResponseEntity.ok(pyAssociationsManager.getCommitteeMember(pyAssociationId, committeeMemberId));
    }

    @DeleteMapping("/committee/{committeeMemberId}")
    public ResponseEntity<Object> deleteCommitteeMember(
            @PathVariable("pyAssociationId") String pyAssociationId,
            @PathVariable("committeeMemberId") String committeeMemberId) {
        pyAssociationsManager.deleteCommitteeMember(pyAssociationId, committeeMemberId);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @PostMapping("/associates")
    public ResponseEntity<Object> mapAssociates(
            @PathVariable("pyAssociationId") String pyAssociationId,
            @Valid @RequestBody AssociatesRequest associatesRequest) {
        // validate if at least one associate information is present to map
        if (associatesRequest.getAssociates().isEmpty()) {
            throw new BadRequestException("at least one associate has be added");
        }

        pyAssociationsManager.mapAssociates(pyAssociationId, associatesRequest);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @DeleteMapping("/associates")
    public ResponseEntity<Object> unMapAssociates(
            @PathVariable("pyAssociationId") String pyAssociationId,
            @Valid @RequestBody AssociatesRequest associatesRequest) {
        // validate if at least one associate information is present to um-map
        if (associatesRequest.getAssociates().isEmpty()) {
            throw new BadRequestException("at least one associate has be added");
        }

        pyAssociationsManager.unMapAssociates(pyAssociationId, associatesRequest);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @GetMapping("/associates")
    public ResponseEntity<Object> getAssociates(
            @PathVariable("pyAssociationId") String pyAssociationId) {
        return ResponseEntity.ok(pyAssociationsManager.getAssociatesList(pyAssociationId));
    }
}
