package org.parish360.core.usermanagement.service.impl;

import org.parish360.core.dao.repository.usermanagement.PermissionRepository;
import org.parish360.core.usermanagement.dto.PermissionInfo;
import org.parish360.core.usermanagement.service.PermissionManager;
import org.parish360.core.usermanagement.service.UserManagementMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PermissionManagerImpl implements PermissionManager {
    private final PermissionRepository permissionRepository;
    private final UserManagementMapper userManagementMapper;

    public PermissionManagerImpl(PermissionRepository permissionRepository, UserManagementMapper userManagementMapper) {
        this.permissionRepository = permissionRepository;
        this.userManagementMapper = userManagementMapper;
    }

    @Override
    public List<PermissionInfo> getPermissions() {
        return permissionRepository.findAll()
                .stream()
                .map(userManagementMapper::daoToPermissionInfo)
                .toList();
    }
}
