package org.parish360.core.configurations.service.impl;

import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.configurations.dto.ParishYearInfo;
import org.parish360.core.configurations.service.ConfigurationMapper;
import org.parish360.core.configurations.service.ParishYearManager;
import org.parish360.core.dao.entities.configurations.ParishYear;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.repository.configurations.ParishYearRepository;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.Objects;

@Service
public class ParishYearManagerImpl implements ParishYearManager {
    private final ConfigurationMapper configurationMapper;
    private final ParishYearRepository parishYearRepository;
    private final ParishRepository parishRepository;

    public ParishYearManagerImpl(ConfigurationMapper configurationMapper, ParishYearRepository parishYearRepository, ParishRepository parishRepository) {
        this.configurationMapper = configurationMapper;
        this.parishYearRepository = parishYearRepository;
        this.parishRepository = parishRepository;
    }

    @Override
    @Transactional
    public ParishYearInfo createParishYearInfo(String parishId, ParishYearInfo parishYearInfo) {
        // perform db level validations for parish year entry
        Map<String, Object> validations = parishYearRepository.performCreateValidations(UUIDUtil.decode(parishId),
                        parishYearInfo.getName(), parishYearInfo.getStartDate(), parishYearInfo.getEndDate())
                .orElseThrow(() -> new BadRequestException("could not validate parish year request"));

        if ((boolean) validations.get("name_exists")) {
            throw new BadRequestException("parish year name already exists");
        }
        if ((boolean) validations.get("date_overlap")) {
            throw new BadRequestException("parish year period is overlapping with existing records");
        }

        Parish parish = parishRepository.findById(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish information"));

        ParishYear parishYear = configurationMapper.parishYearInfoToDao(parishYearInfo);
        parishYear.setParish(parish);

        return configurationMapper.daoToParishYearInfo(parishYearRepository.save(parishYear));
    }

    @Override
    @Transactional
    public ParishYearInfo updateParishYearInfo(String parishId, String parishYearId, ParishYearInfo parishYearInfo) {
        // fetch current parish year information
        ParishYear currentParishYear = parishYearRepository.findByIdAndParishId(
                        UUIDUtil.decode(parishYearId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish year information"));

        // check if db level validations are required
        if (!Objects.equals(currentParishYear.getName(), parishYearInfo.getName()) ||
                !Objects.equals(currentParishYear.getStartDate(), parishYearInfo.getStartDate()) ||
                !Objects.equals(currentParishYear.getEndDate(), parishYearInfo.getEndDate())) {
            Map<String, Object> validations = parishYearRepository.performUpdateValidations(
                            UUIDUtil.decode(parishId), UUIDUtil.decode(parishYearId),
                            parishYearInfo.getName(), parishYearInfo.getStartDate(), parishYearInfo.getEndDate())
                    .orElseThrow(() -> new BadRequestException("could not validate parish year request"));

            if ((boolean) validations.get("name_exists")) {
                throw new BadRequestException("parish year name already exists");
            }
            if ((boolean) validations.get("date_overlap")) {
                throw new BadRequestException("parish year period is overlapping with existing records");
            }
        }

        ParishYear updateParishYear = configurationMapper.parishYearInfoToDao(parishYearInfo);
        configurationMapper.mergeNotNullParishYearToTarget(updateParishYear, currentParishYear);

        return configurationMapper.daoToParishYearInfo(parishYearRepository.save(currentParishYear));
    }

    @Override
    @Transactional(readOnly = true)
    public ParishYearInfo getParishYearInfo(String parishId, String parishYearId) {
        return configurationMapper.daoToParishYearInfo(parishYearRepository.findByIdAndParishId(
                        UUIDUtil.decode(parishYearId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish year information")));
    }

    @Override
    @Transactional(readOnly = true)
    public List<ParishYearInfo> getListOfParishYearInfo(String parishId) {
        List<ParishYear> parishYearList = parishYearRepository.findByParishId(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish year records"));

        return parishYearList.stream()
                .map(configurationMapper::daoToParishYearInfo)
                .toList();
    }

    @Override
    public void deleteParishYearInfo(String parishId, String parishYearId) {

    }
}
