package org.parish360.core.family.service.impl;

import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.configurations.Association;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.entities.family.Family;
import org.parish360.core.dao.entities.family.Member;
import org.parish360.core.dao.repository.associations.AssociateRepository;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.dao.repository.family.FamilyInfoRepository;
import org.parish360.core.dao.repository.family.MemberRepository;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.parish360.core.family.dto.FamilyInfo;
import org.parish360.core.family.service.FamilyInfoManager;
import org.parish360.core.family.service.FamilyMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;
import java.util.UUID;

@Service
public class FamilyInfoManagerImpl implements FamilyInfoManager {
    private final FamilyMapper familyMapper;
    private final FamilyInfoRepository familyInfoRepository;
    private final ParishRepository parishRepository;
    private final MemberRepository memberRepository;
    private final AssociateRepository associateRepository;

    public FamilyInfoManagerImpl(FamilyMapper familyMapper, FamilyInfoRepository familyInfoRepository, ParishRepository parishRepository, MemberRepository memberRepository, AssociateRepository associateRepository) {
        this.familyMapper = familyMapper;
        this.familyInfoRepository = familyInfoRepository;
        this.parishRepository = parishRepository;
        this.memberRepository = memberRepository;
        this.associateRepository = associateRepository;
    }

    @Override
    @Transactional
    public FamilyInfo createFamilyRecord(String parishId, FamilyInfo familyInfo) {
        // find parish information
        Parish parish = parishRepository.findById(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("parish not found"));

        // convert familyInfo DTO to dao
        Family family = familyMapper.familyInfoToDao(familyInfo);

        family.setParish(parish);

        return familyMapper.daoToFamilyInfo(familyInfoRepository.save(family));
    }

    @Override
    @Transactional
    public FamilyInfo updateFamilyRecord(String parishId, String familyId, FamilyInfo familyInfo) {
        // Fetch existing family record for update.
        Family currentFamily = familyInfoRepository.findByIdAndParishId(UUIDUtil.decode(familyId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("family record not found to update"));

        if (!currentFamily.getFamilyCode().equals(familyInfo.getFamilyCode())) {
            throw new BadRequestException("family code cannot be updated");
        }

        // prepare current family info record with updated values
        familyMapper.mergeNotNullFamilyFieldToTarget(familyMapper.familyInfoToDao(familyInfo), currentFamily);

        return familyMapper.daoToFamilyInfo(familyInfoRepository.save(currentFamily));
    }

    @Override
    @Transactional(readOnly = true)
    public FamilyInfo getFamilyRecord(String parishId, String familyId) {

        UUID parishUUID = UUIDUtil.decode(parishId);
        UUID familyUUID = UUIDUtil.decode(familyId);

        Family family = familyInfoRepository
                .findByIdAndParishId(familyUUID, parishUUID)
                .orElseThrow(() -> new ResourceNotFoundException("Family record not found"));

        // Get family members safely
        List<Member> members = memberRepository.findByFamilyId(family.getId())
                .orElse(Collections.emptyList());

        // Find head of family safely (by name, not by relationship string)
        String headOfFamily = members.stream()
                .filter(m -> "head-of-family".equalsIgnoreCase(
                        m.getRelationship() == null ? "" : m.getRelationship()))
                .map(Member::getFirstName)
                .findFirst()
                .orElse("");

        // Find unit association
        Association association = associateRepository.findAssociationByFamilyId(family.getId()).orElse(null);
        String unit = "";
        if (association != null) {
            unit = association.getName();
        }

        // Map family entity to DTO
        FamilyInfo familyInfo = familyMapper.daoToFamilyInfo(family);
        familyInfo.setHeadOfFamily(headOfFamily);
        familyInfo.setUnit(unit);

        return familyInfo;
    }

    @Override
    @Transactional(readOnly = true)
    public List<FamilyInfo> getFamilyRecordsList(String parishId) {
        List<Family> families = familyInfoRepository.findByParishId(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("family records not found"));
        return families.stream()
                .map(familyMapper::daoToFamilyInfo)
                .toList();
    }

    @Override
    @Transactional
    public void removeFamilyRecord(String parishId, String familyId) {
        // fetch family record to be deleted
        Family family = familyInfoRepository.findByIdAndParishId(UUIDUtil.decode(familyId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("family record not found to delete"));

        familyInfoRepository.delete(family);
    }
}
