package org.parish360.core.usermanagement.controller;

import org.parish360.core.usermanagement.dto.PermissionInfo;
import org.parish360.core.usermanagement.service.PermissionManager;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/dataowner/permissions")
public class PermissionHandler {
    private final PermissionManager permissionManager;

    public PermissionHandler(PermissionManager permissionManager) {
        this.permissionManager = permissionManager;
    }

    @GetMapping
    public ResponseEntity<List<PermissionInfo>> getPermissions() {
        return ResponseEntity.ok(permissionManager.getPermissions());
    }
}
