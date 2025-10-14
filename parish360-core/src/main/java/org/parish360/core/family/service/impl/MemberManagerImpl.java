package org.parish360.core.family.service.impl;

import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.entities.family.Family;
import org.parish360.core.dao.entities.family.Member;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.dao.repository.family.FamilyInfoRepository;
import org.parish360.core.dao.repository.family.MemberRepository;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.parish360.core.family.dto.MemberInfo;
import org.parish360.core.family.service.FamilyMapper;
import org.parish360.core.family.service.MemberManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MemberManagerImpl implements MemberManager {
    private final ParishRepository parishRepository;
    private final FamilyInfoRepository familyInfoRepository;
    private final MemberRepository memberRepository;
    private final FamilyMapper familyMapper;

    public MemberManagerImpl(FamilyInfoRepository familyInfoRepository, MemberRepository memberRepository, ParishRepository parishRepository, ParishRepository parishRepository1, FamilyMapper familyMapper) {
        this.familyInfoRepository = familyInfoRepository;
        this.memberRepository = memberRepository;
        this.parishRepository = parishRepository1;
        this.familyMapper = familyMapper;
    }

    @Override
    @Transactional
    public MemberInfo createMember(String parishId, String familyId, MemberInfo memberInfo) {
        // get family information
        Family family = familyInfoRepository.findByIdAndParishId(UUIDUtil.decode(familyId),
                        UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("family information not found"));

        // get parish information
        Parish parish = parishRepository
                .findById(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish information"));

        Member member = familyMapper.memberInfoToDao(memberInfo);

        // set family to member
        member.setFamily(family);
        // set parish to member
        member.setParish(parish);

        return familyMapper.daoToMemberInfo(memberRepository.save(member));
    }

    @Override
    @Transactional
    public MemberInfo updateMember(String familyId, String memberId, MemberInfo memberInfo) {
        // get current member information
        Member currentMember = memberRepository.findByIdAndFamilyId(
                        UUIDUtil.decode(memberId), UUIDUtil.decode(familyId))
                .orElseThrow(() -> new ResourceNotFoundException("member information not found"));

        Member updateMember = familyMapper.memberInfoToDao(memberInfo);

        // update fields to be saved to current Member
        familyMapper.mergeNotNullMemberFieldToTarget(updateMember, currentMember);

        return familyMapper.daoToMemberInfo(memberRepository.save(currentMember));
    }

    @Override
    @Transactional(readOnly = true)
    public MemberInfo getMember(String familyId, String memberId) {
        return familyMapper.daoToMemberInfo(
                memberRepository.findByIdAndFamilyId(
                                UUIDUtil.decode(memberId), UUIDUtil.decode(familyId))
                        .orElseThrow(() -> new ResourceNotFoundException("member information not found")));
    }

    @Override
    @Transactional(readOnly = true)
    public List<MemberInfo> getMemberList(String familyId) {
        List<Member> memberList = memberRepository.findByFamilyId(
                        UUIDUtil.decode(familyId))
                .orElseThrow(() -> new ResourceNotFoundException("member list not found"));

        return memberList.stream()
                .map(familyMapper::daoToMemberInfo)
                .toList();
    }

    @Override
    public List<MemberInfo> getAllMembers(String parishId) {
        List<Member> memberList = memberRepository.findByParishId(
                        UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("member list not found"));

        return memberList.stream()
                .map(familyMapper::daoToMemberInfo)
                .toList();
    }

    @Override
    public void deleteMember(String familyId, String memberId) {
        // find member to remove
        Member member = memberRepository.findByIdAndFamilyId(
                        UUIDUtil.decode(memberId), UUIDUtil.decode(familyId))
                .orElseThrow(() -> new ResourceNotFoundException("member not found"));

        memberRepository.delete(member);
    }
}
