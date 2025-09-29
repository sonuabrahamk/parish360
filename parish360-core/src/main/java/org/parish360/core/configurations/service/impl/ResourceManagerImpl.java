package org.parish360.core.configurations.service.impl;

import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.configurations.dto.ResourceInfo;
import org.parish360.core.configurations.service.ConfigurationMapper;
import org.parish360.core.configurations.service.ResourceManager;
import org.parish360.core.dao.entities.configurations.Resource;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.repository.configurations.ResourceRepository;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ResourceManagerImpl implements ResourceManager {
    private final ConfigurationMapper configurationMapper;
    private final ParishRepository parishRepository;
    private final ResourceRepository resourceRepository;

    public ResourceManagerImpl(ConfigurationMapper configurationMapper, ParishRepository parishRepository, ResourceRepository resourceRepository) {
        this.configurationMapper = configurationMapper;
        this.parishRepository = parishRepository;
        this.resourceRepository = resourceRepository;
    }

    @Override
    @Transactional
    public ResourceInfo createResource(String parishId, ResourceInfo resourceInfo) {
        // fetch parish information
        Parish parish = parishRepository
                .findById(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish information"));

        Resource resource = configurationMapper.resourceInfoToDao(resourceInfo);
        resource.setParish(parish);

        return configurationMapper.daoToResourceInfo(resourceRepository.save(resource));
    }

    @Override
    @Transactional
    public ResourceInfo updateResource(String parishId, String resourceId, ResourceInfo resourceInfo) {
        // fetch Resource to be updated
        Resource currentResource = resourceRepository
                .findByIdAndParishId(UUIDUtil.decode(resourceId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find resource information"));

        Resource updateResource = configurationMapper.resourceInfoToDao(resourceInfo);

        configurationMapper.mergeNotNullResourceInfo(updateResource, currentResource);

        return configurationMapper.daoToResourceInfo(resourceRepository.save(currentResource));
    }

    @Override
    @Transactional(readOnly = true)
    public ResourceInfo getResource(String parishId, String resourceId) {
        return configurationMapper
                .daoToResourceInfo(resourceRepository
                        .findByIdAndParishId(UUIDUtil.decode(resourceId), UUIDUtil.decode(parishId))
                        .orElseThrow(() -> new ResourceNotFoundException("could not find resource information")));
    }

    @Override
    @Transactional(readOnly = true)
    public List<ResourceInfo> getListOfResource(String parishId) {
        List<Resource> resources = resourceRepository
                .findByParishId(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find resource information"));
        return resources.stream()
                .map(configurationMapper::daoToResourceInfo)
                .toList();
    }

    @Override
    @Transactional
    public void deleteResource(String parishId, String resourceId) {
        Resource resource = resourceRepository
                .findByIdAndParishId(UUIDUtil.decode(resourceId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find resource information"));
        resourceRepository.delete(resource);
    }
}
