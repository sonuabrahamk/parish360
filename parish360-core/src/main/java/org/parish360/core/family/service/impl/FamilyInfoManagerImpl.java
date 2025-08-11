package org.parish360.core.family.service.impl;

import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.entities.family.Family;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.dao.repository.family.FamilyInfoRepository;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.parish360.core.family.dto.FamilyInfo;
import org.parish360.core.family.service.FamilyInfoManager;
import org.parish360.core.family.service.FamilyMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class FamilyInfoManagerImpl implements FamilyInfoManager {
    private final FamilyMapper familyMapper;
    private final FamilyInfoRepository familyInfoRepository;
    private final ParishRepository parishRepository;

    public FamilyInfoManagerImpl(FamilyMapper familyMapper, FamilyInfoRepository familyInfoRepository, ParishRepository parishRepository) {
        this.familyMapper = familyMapper;
        this.familyInfoRepository = familyInfoRepository;
        this.parishRepository = parishRepository;
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
    public FamilyInfo updateFamilyRecord(String parishId, String familyId, FamilyInfo familyInfo) {
        return null;
    }

    @Override
    public FamilyInfo getFamilyRecord(String parishId, String familyId) {
        return null;
    }

    @Override
    public List<FamilyInfo> getFamilyRecordsList(String parishId) {
        return List.of();
    }

    @Override
    public void removeFamilyRecord(String parishId, String familyId) {

    }
}
