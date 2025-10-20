package org.parish360.core.ceremonies.service.impl;

import org.parish360.core.ceremonies.dto.CeremonyInfo;
import org.parish360.core.ceremonies.service.CeremonyManager;
import org.parish360.core.ceremonies.service.CeremonyMapper;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.ceremonies.Ceremony;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.entities.family.Family;
import org.parish360.core.dao.repository.CeremonyRepository;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.dao.repository.family.FamilyInfoRepository;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CeremonyManagerImpl implements CeremonyManager {
    private final ParishRepository parishRepository;
    private final FamilyInfoRepository familyInfoRepository;
    private final CeremonyRepository ceremonyRepository;
    private final CeremonyMapper ceremonyMapper;

    public CeremonyManagerImpl(ParishRepository parishRepository, FamilyInfoRepository familyInfoRepository, CeremonyRepository ceremonyRepository, CeremonyMapper ceremonyMapper) {
        this.parishRepository = parishRepository;
        this.familyInfoRepository = familyInfoRepository;
        this.ceremonyRepository = ceremonyRepository;
        this.ceremonyMapper = ceremonyMapper;
    }

    @Override
    @Transactional
    public CeremonyInfo createCeremonyInfo(String parishId, CeremonyInfo ceremonyInfo) {
        // convert to ceremony DTO
        Ceremony ceremony = ceremonyMapper.ceremonyInfoToDao(ceremonyInfo);

        // fetch parish information
        Parish parish = parishRepository
                .findById(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish information"));
        ceremony.setParish(parish);

        // fetch family information if parishioner and has provided family code
        if (ceremonyInfo.getIsParishioner()
                && ceremonyInfo.getChurch().getFamilyCode() != null
                && !ceremonyInfo.getChurch().getFamilyCode().isEmpty()) {
            Family family = familyInfoRepository
                    .findByFamilyCodeAndParishId(ceremonyInfo.getChurch().getFamilyCode(), UUIDUtil.decode(parishId))
                    .orElseThrow(() -> new ResourceNotFoundException("could not family information"));
            ceremony.setFamily(family);
        }

        return ceremonyMapper.daoToCeremonyInfo(ceremonyRepository.save(ceremony));
    }

    @Override
    @Transactional
    public CeremonyInfo updateCeremonyInfo(String parishId, String ceremonyId, CeremonyInfo ceremonyInfo) {
        // fetch current ceremony information
        Ceremony currentCeremony = ceremonyRepository
                .findByIdAndParishId(UUIDUtil.decode(ceremonyId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find ceremony information"));

        // Convert provided ceremonyInfo to DTO
        Ceremony updateCeremony = ceremonyMapper.ceremonyInfoToDao(ceremonyInfo);

        ceremonyMapper.mergeNotNullCeremonyFields(updateCeremony, currentCeremony);

        return ceremonyMapper.daoToCeremonyInfo(ceremonyRepository.save(currentCeremony));
    }

    @Override
    @Transactional(readOnly = true)
    public CeremonyInfo getCeremonyInfo(String parishId, String ceremonyId) {
        return ceremonyMapper.daoToCeremonyInfo(ceremonyRepository
                .findByIdAndParishId(UUIDUtil.decode(ceremonyId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find ceremony information")));
    }

    @Override
    @Transactional(readOnly = true)
    public List<CeremonyInfo> getListOfCeremonies(String parishId) {
        List<Ceremony> ceremonies = ceremonyRepository
                .findByParishId(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not resource information"));

        return ceremonies.stream()
                .map(ceremonyMapper::daoToCeremonyInfo)
                .toList();
    }

    @Override
    @Transactional
    public void deleteCeremony(String parishId, String ceremonyId) {
        Ceremony ceremony = ceremonyRepository
                .findByIdAndParishId(UUIDUtil.decode(ceremonyId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find ceremony information"));
        ceremonyRepository.delete(ceremony);
    }
}
