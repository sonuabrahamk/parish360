package org.parish360.core.family.controller;

import jakarta.validation.Valid;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.family.dto.MemberInfo;
import org.parish360.core.family.service.MemberManager;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/family-records/{familyId}/members")
public class MemberHandler {
    private final MemberManager memberManager;

    public MemberHandler(MemberManager memberManager) {
        this.memberManager = memberManager;
    }

    @PostMapping
    public ResponseEntity<MemberInfo> createMember(@PathVariable("parishId") String parishId,
                                                   @PathVariable("familyId") String familyId,
                                                   @Valid @RequestBody MemberInfo memberInfo) {
        // validate if familyId is matching in request body
        if (memberInfo.getFamilyId() != null && !memberInfo.getFamilyId().equals(familyId)) {
            throw new BadRequestException("family information not matching");
        }
        return ResponseEntity.ok(memberManager.createMember(parishId, familyId, memberInfo));
    }

    @PatchMapping("/{memberId}")
    public ResponseEntity<MemberInfo> updateMember(@PathVariable("familyId") String familyId,
                                                   @PathVariable("memberId") String memberId,
                                                   @Valid @RequestBody MemberInfo memberInfo) {
        //validate if familyId is matching
        if (memberInfo.getFamilyId() != null && !memberInfo.getFamilyId().equals(familyId)) {
            throw new BadRequestException("family information not matching");
        }

        //validate if member Id is matching
        if (memberInfo.getId() != null && !memberInfo.getId().equals(memberId)) {
            throw new BadRequestException("member information not matching");
        }

        return ResponseEntity.ok(memberManager.updateMember(familyId, memberId, memberInfo));
    }

    @GetMapping
    public ResponseEntity<List<MemberInfo>> getMemberList(@PathVariable("familyId") String familyId) {
        return ResponseEntity.ok(memberManager.getMemberList(familyId));
    }

    @GetMapping("/{memberId}")
    public ResponseEntity<MemberInfo> getMember(@PathVariable("familyId") String familyId,
                                                @PathVariable("memberId") String memberId) {
        return ResponseEntity.ok(memberManager.getMember(familyId, memberId));
    }

    @DeleteMapping("/{memberId}")
    public ResponseEntity<MemberInfo> deleteMember(@PathVariable("familyId") String familyId,
                                                   @PathVariable("memberId") String memberId) {
        memberManager.deleteMember(familyId, memberId);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
}
