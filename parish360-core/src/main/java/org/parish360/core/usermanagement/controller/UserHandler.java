package org.parish360.core.usermanagement.controller;

import jakarta.validation.Valid;
import org.parish360.core.usermanagement.dto.UserInfo;
import org.parish360.core.usermanagement.service.UserManager;
import org.parish360.core.util.enums.EntityType;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/parish/{parishId}/users")
public class UserHandler {

    private final UserManager userManager;

    public UserHandler(UserManager userManager) {
        this.userManager = userManager;
    }

    @GetMapping
    public ResponseEntity<?> getUsersList(@PathVariable("parishId") String entityId) {
        return ResponseEntity.ok(userManager.getUsersList(entityId));
    }

    @GetMapping("/{userId}")
    public ResponseEntity<?> getUser(@PathVariable("parishId") String entityId,
                                     @PathVariable("userId") String userId) {
        return ResponseEntity.ok(userManager.getUser(entityId, userId));
    }

    @PostMapping
    public ResponseEntity<?> createUser(@PathVariable("parishId") String entityId,
                                        @Valid @RequestBody UserInfo userInfo) {
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(userManager.createUser(EntityType.PARISH, entityId, userInfo));
    }

    @PatchMapping("/{userId}")
    public ResponseEntity<UserInfo> updateUser(@PathVariable("parishId") String entityId,
                                               @PathVariable("userId") String userId,
                                               @Valid @RequestBody UserInfo userInfo) {
        return ResponseEntity.ok(userManager.updateUser(EntityType.PARISH, entityId, userId, userInfo));
    }
}
