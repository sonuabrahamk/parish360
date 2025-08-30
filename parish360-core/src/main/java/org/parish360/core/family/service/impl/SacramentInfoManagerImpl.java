package org.parish360.core.family.service.impl;

import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.family.Member;
import org.parish360.core.dao.entities.family.Sacrament;
import org.parish360.core.dao.repository.family.MemberRepository;
import org.parish360.core.dao.repository.family.SacramentRepository;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.parish360.core.family.dto.SacramentInfo;
import org.parish360.core.family.service.FamilyMapper;
import org.parish360.core.family.service.SacramentInfoManager;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SacramentInfoManagerImpl implements SacramentInfoManager {
    private final FamilyMapper familyMapper;
    private final MemberRepository memberRepository;
    private final SacramentRepository sacramentRepository;

    public SacramentInfoManagerImpl(FamilyMapper familyMapper,
                                    MemberRepository memberRepository,
                                    SacramentRepository sacramentRepository) {
        this.familyMapper = familyMapper;
        this.memberRepository = memberRepository;
        this.sacramentRepository = sacramentRepository;
    }

    @Override
    public SacramentInfo createSacramentInfo(String familyId, String memberId, SacramentInfo sacramentInfo) {
        // fetch member information
        Member member = memberRepository.findByIdAndFamilyId(
                        UUIDUtil.decode(memberId), UUIDUtil.decode(familyId))
                .orElseThrow(() -> new ResourceNotFoundException("member information not found"));

        Sacrament sacrament = familyMapper.sacramentInfoToDao(sacramentInfo);
        sacrament.setMember(member);

        return familyMapper.daoToSacramentInfo(
                sacramentRepository.save(sacrament));
    }

    @Override
    public SacramentInfo updateSacramentInfo(String memberId, String sacramentInfoId, SacramentInfo sacramentInfo) {
        // fetch sacrament information
        Sacrament currentSacrament = sacramentRepository.findByIdAndMemberId(
                        UUIDUtil.decode(sacramentInfoId), UUIDUtil.decode(memberId))
                .orElseThrow(() -> new ResourceNotFoundException("sacrament information not found"));

        Sacrament updateSacrament = familyMapper.sacramentInfoToDao(sacramentInfo);
        familyMapper.mergeNotNullSacramentFieldToTarget(updateSacrament, currentSacrament);

        return familyMapper.daoToSacramentInfo(
                sacramentRepository.save(currentSacrament));
    }

    @Override
    public SacramentInfo getSacramentInfo(String memberId, String sacramentInfoId) {
        return familyMapper.daoToSacramentInfo(
                sacramentRepository.findByIdAndMemberId(
                                UUIDUtil.decode(sacramentInfoId), UUIDUtil.decode(memberId))
                        .orElseThrow(() -> new ResourceNotFoundException("sacrament information not found")));
    }

    @Override
    public List<SacramentInfo> getSacramentInfoList(String memberId) {
        // fetch sacraments from repository
        List<Sacrament> sacraments = sacramentRepository.findByMemberId(
                        UUIDUtil.decode(memberId))
                .orElseThrow(() -> new ResourceNotFoundException("could not fetch sacraments list"));

        return sacraments.stream()
                .map(familyMapper::daoToSacramentInfo)
                .toList();
    }

    @Override
    public void deleteSacramentInfo(String memberId, String sacramentInfoId) {
        // fetch sacrament information
        Sacrament sacrament = sacramentRepository.findByIdAndMemberId(
                        UUIDUtil.decode(sacramentInfoId), UUIDUtil.decode(memberId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find sacrament information to delete"));

        sacramentRepository.delete(sacrament);
    }
}
