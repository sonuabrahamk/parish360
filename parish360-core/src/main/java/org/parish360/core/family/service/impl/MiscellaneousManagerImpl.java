package org.parish360.core.family.service.impl;

import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.family.Family;
import org.parish360.core.dao.entities.family.Miscellaneous;
import org.parish360.core.dao.repository.family.FamilyInfoRepository;
import org.parish360.core.dao.repository.family.MiscellaneousRepository;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.parish360.core.family.dto.MiscellaneousInfo;
import org.parish360.core.family.service.FamilyMapper;
import org.parish360.core.family.service.MiscellaneousManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MiscellaneousManagerImpl implements MiscellaneousManager {
    private final FamilyMapper familyMapper;
    private final FamilyInfoRepository familyInfoRepository;
    private final MiscellaneousRepository miscellaneousRepository;

    public MiscellaneousManagerImpl(FamilyMapper familyMapper,
                                    FamilyInfoRepository familyInfoRepository,
                                    MiscellaneousRepository miscellaneousRepository) {
        this.familyMapper = familyMapper;
        this.familyInfoRepository = familyInfoRepository;
        this.miscellaneousRepository = miscellaneousRepository;
    }

    @Override
    @Transactional
    public MiscellaneousInfo createMiscellaneousInfo(String parishId,
                                                     String familId,
                                                     MiscellaneousInfo miscellaneousInfo) {
        // fetch family info
        Family family = familyInfoRepository.findByIdAndParishId(UUIDUtil.decode(familId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("family info not found"));

        Miscellaneous miscellaneous = familyMapper.miscellaneousInfoToDao(miscellaneousInfo);
        miscellaneous.setFamily(family);

        return familyMapper.daoToMiscellaneousInfo(miscellaneousRepository.save(miscellaneous));
    }

    @Override
    @Transactional
    public MiscellaneousInfo updateMiscellaneousInfo(String familyId,
                                                     String miscellaneousId,
                                                     MiscellaneousInfo miscellaneousInfo) {
        // fetch current miscellaneous record
        Miscellaneous currentMiscellaneous = miscellaneousRepository.findByIdAndFamilyId(
                        UUIDUtil.decode(miscellaneousId), UUIDUtil.decode(familyId))
                .orElseThrow(() -> new ResourceNotFoundException("miscellaneous info not found"));

        Miscellaneous updateMiscellaneous = familyMapper.miscellaneousInfoToDao(miscellaneousInfo);
        familyMapper.mergeNotNullMiscellaneousFieldToTarget(updateMiscellaneous, currentMiscellaneous);

        return familyMapper.daoToMiscellaneousInfo(miscellaneousRepository.save(currentMiscellaneous));
    }

    @Override
    @Transactional(readOnly = true)
    public MiscellaneousInfo getMiscellaneousInfo(String familyId, String miscellaneousId) {
        return familyMapper.daoToMiscellaneousInfo(
                miscellaneousRepository.findByIdAndFamilyId(
                                UUIDUtil.decode(miscellaneousId), UUIDUtil.decode(familyId))
                        .orElseThrow(() -> new ResourceNotFoundException("miscellaneous record not found")));
    }

    @Override
    @Transactional(readOnly = true)
    public List<MiscellaneousInfo> getMiscellaneousInfoList(String familyId) {
        // fetch list of miscellaneous records for the family
        List<Miscellaneous> miscellaneousList = miscellaneousRepository.findByFamilyId(UUIDUtil.decode(familyId))
                .orElseThrow(() -> new ResourceNotFoundException("no records for this family"));

        return miscellaneousList.stream()
                .map(familyMapper::daoToMiscellaneousInfo)
                .toList();
    }

    @Override
    @Transactional
    public void deleteMiscellaneousInfo(String familyId, String miscellaneousId) {
        // fetch record to be deleted
        Miscellaneous miscellaneous = miscellaneousRepository.findByIdAndFamilyId(
                        UUIDUtil.decode(miscellaneousId), UUIDUtil.decode(familyId))
                .orElseThrow(() -> new ResourceNotFoundException("miscellaneous record not found"));
        miscellaneousRepository.delete(miscellaneous);
    }
}
