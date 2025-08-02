package org.parish360.core.controller.parish.usermanagement;

import org.parish360.core.dto.usermanagement.UserResponse;
import org.parish360.core.service.usermanagement.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/parish/{parishId}/users")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping
    public ResponseEntity<?> createUser(@PathVariable("parishId") UUID parishId, @RequestBody UserResponse userRequest) {
        UserResponse user = userService.createUser(userRequest);
        return ResponseEntity.ok(user);
    }

    @GetMapping
    public ResponseEntity<?> getUsersList(@PathVariable("parishId") UUID parishId) {
        return ResponseEntity.ok(new UserResponse[]{});
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getUserByUsername(@PathVariable("id") UUID id) {
        return ResponseEntity.ok(userService.getUserWithRolesAndPermissions(id));
    }
}
