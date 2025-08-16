package org.parish360.core.family.service.impl;

import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.family.Blessing;
import org.parish360.core.dao.entities.family.Family;
import org.parish360.core.dao.repository.family.BlessingInfoRepository;
import org.parish360.core.dao.repository.family.FamilyInfoRepository;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.parish360.core.family.dto.BlessingInfo;
import org.parish360.core.family.service.BlessingManager;
import org.parish360.core.family.service.FamilyMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BlessingManagerImpl implements BlessingManager {
    private final FamilyMapper familyMapper;
    private final FamilyInfoRepository familyInfoRepository;
    private final BlessingInfoRepository blessingInfoRepository;

    public BlessingManagerImpl(FamilyMapper familyMapper, FamilyInfoRepository familyInfoRepository, BlessingInfoRepository blessingInfoRepository) {
        this.familyMapper = familyMapper;
        this.familyInfoRepository = familyInfoRepository;
        this.blessingInfoRepository = blessingInfoRepository;
    }

    @Override
    @Transactional
    public BlessingInfo createBlessingInfo(String parishId, String familyId, BlessingInfo blessingInfo) {
        // fetch family info
        Family family = familyInfoRepository.findByIdAndParishId(
                        UUIDUtil.decode(familyId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("family information not found"));

        Blessing blessing = familyMapper.blessingInfoToDao(blessingInfo);
        blessing.setFamily(family);

        return familyMapper.daoToBlessingInfo(blessingInfoRepository.save(blessing));
    }

    @Override
    @Transactional
    public BlessingInfo updateBlessingInfo(String familyId, String blessingId, BlessingInfo blessingInfo) {
        // fetch current blessing info
        Blessing currentBlessing = blessingInfoRepository.findByIdAndFamilyId(
                        UUIDUtil.decode(blessingId), UUIDUtil.decode(familyId))
                .orElseThrow(() -> new ResourceNotFoundException("blessing information not found"));

        Blessing updateBlessing = familyMapper.blessingInfoToDao(blessingInfo);
        familyMapper.mergeNotNullBlessingFieldToTarget(updateBlessing, currentBlessing);

        return familyMapper.daoToBlessingInfo(blessingInfoRepository.save(currentBlessing));
    }

    @Override
    @Transactional(readOnly = true)
    public BlessingInfo getBlessingInfo(String familyId, String blessingId) {
        return familyMapper.daoToBlessingInfo(
                blessingInfoRepository.findByIdAndFamilyId(
                                UUIDUtil.decode(blessingId), UUIDUtil.decode(familyId))
                        .orElseThrow(() -> new ResourceNotFoundException("blessing information not found")));
    }

    @Override
    @Transactional(readOnly = true)
    public List<BlessingInfo> getBlessingInfoList(String familyId) {
        List<Blessing> blessingList = blessingInfoRepository.findByFamilyId(
                        UUIDUtil.decode(familyId))
                .orElseThrow(() -> new ResourceNotFoundException("blessing list not found"));

        return blessingList.stream()
                .map(familyMapper::daoToBlessingInfo)
                .toList();
    }

    @Override
    @Transactional
    public void deleteBlessingInfo(String familyId, String blessingId) {
        // fetch blessing information to delete
        Blessing blessing = blessingInfoRepository.findByIdAndFamilyId(
                        UUIDUtil.decode(blessingId), UUIDUtil.decode(familyId))
                .orElseThrow(() -> new ResourceNotFoundException("blessing information not found"));
        blessingInfoRepository.delete(blessing);
    }
}
