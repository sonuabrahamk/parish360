package org.parish360.core.family.service;

import org.parish360.core.family.dto.MemberInfo;

import java.util.List;

public interface MemberManager {
    MemberInfo createMember(String parishId, String familyId, MemberInfo memberInfo);

    MemberInfo updateMember(String familyId, String memberId, MemberInfo memberInfo);

    MemberInfo getMember(String familyId, String memberId);

    List<MemberInfo> getMemberList(String familyId);

    List<MemberInfo> getAllMembers(String parishId);

    void deleteMember(String familyId, String memberId);

}
