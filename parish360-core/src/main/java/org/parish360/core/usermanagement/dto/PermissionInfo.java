package org.parish360.core.usermanagement.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.common.enums.PermissionType;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PermissionInfo {
    private String id;
    private String name;
    private String description;
    private String module;
    private PermissionType permissionType;
}
