package org.parish360.core.usermanagement.service;

import org.parish360.core.usermanagement.dto.PermissionInfo;
import org.parish360.core.usermanagement.dto.RoleInfo;

import java.util.List;

public interface RoleManager {
    RoleInfo createRole(String dataownerId, RoleInfo roleInfo);

    RoleInfo updateRole(String dataownerId, String roleId, RoleInfo roleInfo);

    RoleInfo getRole(String dataownerId, String roleId);

    List<RoleInfo> getRoleList(String dataownerId);

    RoleInfo assignPermissions(String dataownerId, String roleId, List<PermissionInfo> permissions);
}
