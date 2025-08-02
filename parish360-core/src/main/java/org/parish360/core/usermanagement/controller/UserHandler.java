package org.parish360.core.usermanagement.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/parish/{parishId}/users")
public class UserHandler {

    @GetMapping
    public ResponseEntity<?> getUsersList(@PathVariable("parishId") String entityId) {
        return null;
    }

    @GetMapping("/{userId}")
    public ResponseEntity<?> getUser(@PathVariable("parishId") String entityId,
                                     @PathVariable("userId") String userId) {
        return null;
    }

    @PostMapping
    public ResponseEntity<?> createUser(@PathVariable("parishId") String entityId) {
        return null;
    }
}
