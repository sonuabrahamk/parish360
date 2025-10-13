package org.parish360.core.configurations.service.impl;

import org.parish360.core.associations.service.AssociationMapper;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.configurations.dto.PYAssociationRequest;
import org.parish360.core.configurations.dto.PYAssociationResponse;
import org.parish360.core.configurations.dto.ParishYearInfo;
import org.parish360.core.configurations.service.ConfigurationMapper;
import org.parish360.core.configurations.service.ParishYearManager;
import org.parish360.core.dao.entities.associations.ParishYearAssociation;
import org.parish360.core.dao.entities.configurations.Association;
import org.parish360.core.dao.entities.configurations.ParishYear;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.repository.associations.AssociationRepository;
import org.parish360.core.dao.repository.configurations.ParishYearAssociationRepository;
import org.parish360.core.dao.repository.configurations.ParishYearRepository;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class ParishYearManagerImpl implements ParishYearManager {
    private final ConfigurationMapper configurationMapper;
    private final ParishYearRepository parishYearRepository;
    private final ParishRepository parishRepository;
    private final ParishYearAssociationRepository parishYearAssociationRepository;
    private final AssociationRepository associationRepository;

    public ParishYearManagerImpl(ConfigurationMapper configurationMapper, ParishYearRepository parishYearRepository, ParishRepository parishRepository, ParishYearAssociationRepository parishYearAssociationRepository, AssociationRepository associationRepository, AssociationMapper associationMapper) {
        this.configurationMapper = configurationMapper;
        this.parishYearRepository = parishYearRepository;
        this.parishRepository = parishRepository;
        this.parishYearAssociationRepository = parishYearAssociationRepository;
        this.associationRepository = associationRepository;
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

    @Override
    @Transactional
    public List<PYAssociationResponse> mapAssociations(String parishId, String parishYearId,
                                                       PYAssociationRequest pyAssociationRequest) {
        // check for valid parish year
        ParishYear parishYear = parishYearRepository
                .findByIdAndParishId(UUIDUtil.decode(parishYearId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("parish year information not found"));

        // Check if parish year is locked
        if (parishYear.isLocked()) {
            throw new BadRequestException("parish year is locked for any updates");
        }

        // check if associations list is empty
        if (pyAssociationRequest.getAssociations().isEmpty()) {
            throw new BadRequestException("association list to be mapped is empty");
        }

        // validate associations
        Set<UUID> associationUUIDs = pyAssociationRequest.getAssociations().stream()
                .map(UUIDUtil::decode)
                .collect(Collectors.toSet());
        List<Association> associations = associationRepository.findAllById(associationUUIDs);

        if (associations.size() != pyAssociationRequest.getAssociations().size()) {
            throw new BadRequestException("some of the association information mentioned are not valid");
        }

        // group all parishYear associations to be mapped (exclude already exiting mappings)
        List<ParishYearAssociation> newParishYearAssociations = associations.stream()
                .filter(association -> !parishYearAssociationRepository
                        .existsByParishYearIdAndAssociationId(parishYear.getId(), association.getId()))
                .map(association -> {
                    ParishYearAssociation pyAssociation = new ParishYearAssociation();
                    pyAssociation.setAssociation(association);
                    pyAssociation.setParishYear(parishYear);
                    return pyAssociation;
                })
                .toList();

        parishYearAssociationRepository.saveAll(newParishYearAssociations);

        List<ParishYearAssociation> pyAssociations = parishYearAssociationRepository
                .findByParishYearId(parishYear.getId())
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish year association information"));

        return pyAssociations.stream()
                .map(configurationMapper::daoToPYAssociationResponse)
                .toList();
    }

    @Override
    @Transactional
    public List<PYAssociationResponse> unMapAssociations(String parishId, String parishYearId,
                                                         PYAssociationRequest pyAssociationRequest) {
        // check for valid parish year
        ParishYear parishYear = parishYearRepository
                .findByIdAndParishId(UUIDUtil.decode(parishYearId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("parish year information not found"));

        // Check if parish year is locked
        if (parishYear.isLocked()) {
            throw new BadRequestException("parish year is locked for any updates");
        }

        // check if associations list is empty
        if (pyAssociationRequest.getAssociations().isEmpty()) {
            throw new BadRequestException("association list to be mapped is empty");
        }

        // validate associations
        Set<UUID> pyAssociationUUIDs = pyAssociationRequest.getAssociations().stream()
                .map(UUIDUtil::decode)
                .collect(Collectors.toSet());
        List<ParishYearAssociation> pyAssociations = parishYearAssociationRepository.findAllById(pyAssociationUUIDs);

        if (pyAssociations.size() != pyAssociationRequest.getAssociations().size()) {
            throw new BadRequestException("some of the associations information mentioned are not valid");
        }

        // delete association
        parishYearAssociationRepository.deleteAll(pyAssociations);

        // generate response
        pyAssociations = parishYearAssociationRepository
                .findByParishYearId(parishYear.getId())
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish year association information"));

        return pyAssociations.stream()
                .map(configurationMapper::daoToPYAssociationResponse)
                .toList();
    }

    @Override
    @Transactional(readOnly = true)
    public List<PYAssociationResponse> getPyAssociations(String parishYearId) {
        // generate response
        List<ParishYearAssociation> pyAssociations = parishYearAssociationRepository
                .findByParishYearId(UUIDUtil.decode(parishYearId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish year association information"));

        return pyAssociations.stream()
                .map(configurationMapper::daoToPYAssociationResponse)
                .toList();
    }

    @Override
    public PYAssociationResponse getPyAssociation(String pyAssociationId) {
        return configurationMapper
                .daoToPYAssociationResponse(parishYearAssociationRepository
                        .findById(UUIDUtil.decode(pyAssociationId))
                        .orElseThrow(() -> new
                                ResourceNotFoundException("could not find parish year association information")));
    }
}
