package org.parish360.core.dashboard.service.impl;

import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.family.Member;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.dao.repository.family.MemberRepository;
import org.parish360.core.dashboard.dto.ParishReportInfo;
import org.parish360.core.dashboard.service.DashboardManager;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.parish360.core.family.dto.MemberInfo;
import org.parish360.core.family.service.FamilyMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DashboardManagerImpl implements DashboardManager {
    private final ParishRepository parishRepository;
    private final MemberRepository memberRepository;
    private final FamilyMapper familyMapper;

    public DashboardManagerImpl(ParishRepository parishRepository, MemberRepository memberRepository, FamilyMapper familyMapper) {
        this.parishRepository = parishRepository;
        this.memberRepository = memberRepository;
        this.familyMapper = familyMapper;
    }

    @Override
    @Transactional(readOnly = true)
    public ParishReportInfo getParishReport(String parishId) {
        return parishRepository
                .findParishReport(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish report"));
    }

    @Override
    @Transactional(readOnly = true)
    public List<MemberInfo> getAllMembers(String parishId) {
        List<Member> members = memberRepository
                .findByParishId(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find members"));
        return members.stream().map(familyMapper::daoToMemberInfo).toList();
    }
}
