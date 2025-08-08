package org.parish360.core.usermanagement.controller;

import jakarta.validation.Valid;
import org.parish360.core.usermanagement.dto.PermissionInfo;
import org.parish360.core.usermanagement.dto.RoleInfo;
import org.parish360.core.usermanagement.service.RoleManager;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/dataowner/parish/{parishId}/roles")
public class RoleHandler {
    private final RoleManager roleManager;

    public RoleHandler(RoleManager roleManager) {
        this.roleManager = roleManager;
    }

    @GetMapping
    public ResponseEntity<List<RoleInfo>> getRoleList(@PathVariable("parishId") String parishId) {
        return ResponseEntity.ok(roleManager.getRoleList(parishId));
    }

    @GetMapping("/{roleId}")
    public ResponseEntity<RoleInfo> getRoleList(@PathVariable("parishId") String parishId,
                                                @PathVariable("roleId") String roleId) {
        return ResponseEntity.ok(roleManager.getRole(parishId, roleId));
    }

    @PostMapping
    public ResponseEntity<RoleInfo> createRole(@PathVariable("parishId") String parishId,
                                               @Valid @RequestBody RoleInfo roleInfo) {
        return ResponseEntity.ok(roleManager.createRole(parishId, roleInfo));
    }

    @PatchMapping("/{roleId}")
    public ResponseEntity<RoleInfo> updateRole(@PathVariable("parishId") String parishId,
                                               @PathVariable("roleId") String roleId,
                                               @Valid @RequestBody RoleInfo roleInfo) {
        return ResponseEntity.ok(roleManager.updateRole(parishId, roleId, roleInfo));
    }

    @PutMapping("/{roleId}/permissions")
    public ResponseEntity<RoleInfo> assignPermissionToRole(@PathVariable("parishId") String parishId,
                                                           @PathVariable("roleId") String roleId,
                                                           @Valid @RequestBody List<PermissionInfo> permissions) {
        return ResponseEntity.ok(roleManager.assignPermissions(parishId, roleId, permissions));
    }
}
