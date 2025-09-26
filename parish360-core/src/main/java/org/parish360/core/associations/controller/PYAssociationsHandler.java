package org.parish360.core.associations.controller;

import jakarta.validation.Valid;
import org.parish360.core.associations.dto.CommitteeMemberInfo;
import org.parish360.core.associations.service.PYAssociationsManager;
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
}
