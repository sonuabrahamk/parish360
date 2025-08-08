package org.parish360.core.usermanagement.service;

import org.parish360.core.usermanagement.dto.PermissionInfo;

import java.util.List;

public interface PermissionManager {
    List<PermissionInfo> getPermissions();
}
