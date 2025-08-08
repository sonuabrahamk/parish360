package org.parish360.core.usermanagement.service.impl;

import org.parish360.core.common.util.AuthUtil;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.dataowner.Dataowner;
import org.parish360.core.dao.entities.usermanagement.Permission;
import org.parish360.core.dao.entities.usermanagement.Role;
import org.parish360.core.dao.repository.dataowner.DataownerRepository;
import org.parish360.core.dao.repository.usermanagement.RoleRepository;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.parish360.core.usermanagement.dto.PermissionInfo;
import org.parish360.core.usermanagement.dto.RoleInfo;
import org.parish360.core.usermanagement.service.RoleManager;
import org.parish360.core.usermanagement.service.UserManagementMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class RoleManagerImpl implements RoleManager {
    private final RoleRepository roleRepository;
    private final DataownerRepository dataownerRepository;
    private final UserManagementMapper userManagementMapper;

    public RoleManagerImpl(RoleRepository roleRepository, DataownerRepository dataownerRepository, UserManagementMapper userManagementMapper) {
        this.roleRepository = roleRepository;
        this.dataownerRepository = dataownerRepository;
        this.userManagementMapper = userManagementMapper;
    }

    @Override
    @Transactional
    public RoleInfo createRole(String dataownerId, RoleInfo roleInfo) {
        Dataowner dataowner = dataownerRepository.findById(UUIDUtil.decode(dataownerId))
                .orElseThrow(() -> new BadRequestException("dataowner not found"));

        // set default values for creation
        roleInfo.setCreatedAt(Instant.now());
        roleInfo.setCreatedBy(AuthUtil.getCurrentUserId());

        Role role = userManagementMapper.roleInfoToDao(roleInfo);
        role.setDataowner(dataowner);

        return userManagementMapper.daoToRoleInfo(roleRepository.save(role));
    }

    @Override
    @Transactional
    public RoleInfo updateRole(String dataownerId, String roleId, RoleInfo roleInfo) {
        //valid if payload roleId matching path role ID
        if (roleInfo.getId() != null && !roleInfo.getId().equals(roleId)) {
            throw new BadRequestException("there is a mismatch in roleId");
        }

        //set default update values
        roleInfo.setUpdatedAt(Instant.now());
        roleInfo.setUpdatedBy(AuthUtil.getCurrentUserId());

        Role updateRole = userManagementMapper.roleInfoToDao(roleInfo);

        Role currentRole = roleRepository.findById(UUIDUtil.decode(roleId))
                .orElseThrow(() -> new ResourceNotFoundException("role not found for update"));

        if (!currentRole.getDataowner().getId().equals(UUIDUtil.decode(dataownerId))) {
            throw new BadRequestException("dataowner mismatch, invalid role to update");
        }

        // update currentRole with values present in updateRole
        userManagementMapper.mergeRoleNotNullFieldToTarget(updateRole, currentRole);

        return userManagementMapper.daoToRoleInfo(roleRepository.save(currentRole));
    }

    @Override
    @Transactional(readOnly = true)
    public RoleInfo getRole(String dataownerId, String roleId) {
        return userManagementMapper
                .daoToRoleInfo(
                        roleRepository
                                .findByIdAndDataownerId(UUIDUtil.decode(roleId), UUIDUtil.decode(dataownerId))
                                .orElseThrow(() -> new ResourceNotFoundException("role not found")));
    }

    @Override
    @Transactional(readOnly = true)
    public List<RoleInfo> getRoleList(String dataownerId) {
        return roleRepository.findAllByDataownerId(UUIDUtil.decode(dataownerId))
                .stream()
                .map(userManagementMapper::daoToRoleInfo)
                .collect(Collectors.toList());
    }

    @Override
    public RoleInfo assignPermissions(String dataownerId, String roleId, List<PermissionInfo> permissions) {
        // fetch role
        Role role = roleRepository.findByIdAndDataownerId(UUIDUtil.decode(roleId), UUIDUtil.decode(dataownerId))
                .orElseThrow(() -> new ResourceNotFoundException("role not found"));

        // get permissions to assign
        Set<Permission> permissionToAssign = permissions.stream()
                .map(userManagementMapper::permissionInfoToDao)
                .collect(Collectors.toSet());

        role.setPermissions(permissionToAssign);

        return userManagementMapper.daoToRoleInfo(roleRepository.save(role));
    }
}
