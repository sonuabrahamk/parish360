package org.parish360.core.configurations.service.impl;

import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.configurations.dto.AssociationInfo;
import org.parish360.core.configurations.service.AssociationManager;
import org.parish360.core.configurations.service.ConfigurationMapper;
import org.parish360.core.dao.entities.configurations.Association;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.repository.associations.AssociationRepository;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AssociationManagerImpl implements AssociationManager {
    private final ParishRepository parishRepository;
    private final ConfigurationMapper configurationMapper;
    private final AssociationRepository associationRepository;

    public AssociationManagerImpl(ParishRepository parishRepository,
                                  ConfigurationMapper configurationMapper,
                                  AssociationRepository associationRepository) {
        this.parishRepository = parishRepository;
        this.configurationMapper = configurationMapper;
        this.associationRepository = associationRepository;
    }

    @Override
    @Transactional
    public AssociationInfo createAssociation(String parishId, AssociationInfo associationInfo) {
        // check if parishId is valid
        Parish parish = parishRepository.findById(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("parish information not found"));

        Association association = configurationMapper.associationInfoToDao(associationInfo);
        association.setParish(parish);

        return configurationMapper
                .daoToAssociationInfo(associationRepository
                        .save(association));
    }

    @Override
    @Transactional
    public AssociationInfo updateAssociation(String parishId, String associationId, AssociationInfo associationInfo) {
        // find current Association info
        Association currentAssociation = associationRepository.findByIdAndParishId(
                        UUIDUtil.decode(associationId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("association information not found"));

        //Check if type is modified
        if (associationInfo.getType() != null && associationInfo.getType() != currentAssociation.getType()) {
            throw new BadRequestException("association type cannot be modified");
        }

        Association updateAssociation = configurationMapper.associationInfoToDao(associationInfo);
        configurationMapper.mergeNotNullAssociationToTarget(updateAssociation, currentAssociation);

        return configurationMapper.daoToAssociationInfo(associationRepository.save(currentAssociation));
    }

    @Override
    @Transactional(readOnly = true)
    public AssociationInfo getAssociationInfo(String parishId, String associationId) {
        return configurationMapper
                .daoToAssociationInfo(associationRepository
                        .findByIdAndParishId(UUIDUtil.decode(associationId), UUIDUtil.decode(parishId))
                        .orElseThrow(() -> new ResourceNotFoundException("association information not found")));
    }

    @Override
    @Transactional(readOnly = true)
    public List<AssociationInfo> getListOfAssociations(String parishId) {
        List<Association> associations = associationRepository
                .findByParishId(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("associations not found for provided parish id"));
        return associations.stream()
                .map(configurationMapper::daoToAssociationInfo)
                .toList();
    }

    @Override
    @Transactional
    public void deleteAssociation(String parishId, String associationId) {
        Association association = associationRepository
                .findByIdAndParishId(UUIDUtil.decode(associationId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("association information not found"));
        associationRepository.delete(association);
    }
}
