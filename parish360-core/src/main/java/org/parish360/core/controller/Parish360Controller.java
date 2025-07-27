package org.parish360.core.controller;

import org.parish360.core.dto.usermanagement.AuthenticationRequest;
import org.parish360.core.dto.usermanagement.ErrorResponse;
import org.parish360.core.service.usermanagement.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Parish360Controller {

    @Autowired
    private UserService userService;

    @GetMapping("/health")
    public String heathCheck() {
        return "Parish 360 app is running!!";
    }

    @PostMapping("/authenticate")
    public ResponseEntity<?> authenticate(@RequestBody AuthenticationRequest authRequest) {
        if (authRequest.getUsername().isEmpty() || authRequest.getPassword().isEmpty()) {
            return ResponseEntity.badRequest().body(new ErrorResponse());
        }
        return ResponseEntity.ok(userService.authenticateUser(authRequest));
    }
}
