package org.parish360.core.usermanagement.service;

import org.mapstruct.*;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.usermanagement.Permission;
import org.parish360.core.dao.entities.usermanagement.Role;
import org.parish360.core.dao.entities.usermanagement.User;
import org.parish360.core.usermanagement.dto.PermissionInfo;
import org.parish360.core.usermanagement.dto.RoleInfo;
import org.parish360.core.usermanagement.dto.UserInfo;

@Mapper(componentModel = "spring",
        uses = {UUIDUtil.class},
        nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface UserManagementMapper {

    // User Mappers
    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    @Mapping(target = "password", ignore = true)
    UserInfo daoToUserInfo(User user);

    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    User userInfoToDao(UserInfo userInfo);

    void mergeUserNotNullFieldToTarget(User source, @MappingTarget User target);

    // Role Mappers
    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    RoleInfo daoToRoleInfo(Role role);

    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    Role roleInfoToDao(RoleInfo roleInfo);

    void mergeRoleNotNullFieldToTarget(Role source, @MappingTarget Role target);

    // Permissions Mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    PermissionInfo daoToPermissionInfo(Permission permission);

    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    Permission permissionInfoToDao(PermissionInfo permissionInfo);
}
