package org.parish360.core.configurations.service;

import org.parish360.core.configurations.dto.ResourceInfo;

import java.util.List;

public interface ResourceManager {
    ResourceInfo createResource(String parishId, ResourceInfo resourceInfo);

    ResourceInfo updateResource(String parishId, String resourceId, ResourceInfo resourceInfo);

    ResourceInfo getResource(String parishId, String resourceId);

    List<ResourceInfo> getListOfResource(String parishId);

    void deleteResource(String parishId, String resourceId);
}
