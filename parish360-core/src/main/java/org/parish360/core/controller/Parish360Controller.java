package org.parish360.core.controller;

import jakarta.servlet.http.HttpServletResponse;
import org.parish360.core.dto.auth.AuthenticationRequest;
import org.parish360.core.dto.auth.AuthenticationResponse;
import org.parish360.core.dto.error.ErrorResponse;
import org.parish360.core.service.auth.AuthConstants;
import org.parish360.core.service.auth.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.time.Duration;

@RestController
public class Parish360Controller {

    @Autowired
    private AuthService authService;

    @GetMapping("/health")
    public String heathCheck() {
        return "Parish.yml 360 app is running!!";
    }

    @PostMapping("/authenticate")
    public ResponseEntity<?> authenticate(@RequestBody AuthenticationRequest authRequest, HttpServletResponse response) {
        // Validate authenticationRequest
        if (authRequest.getUsername().isEmpty() || authRequest.getPassword().isEmpty()) {
            return ResponseEntity.badRequest().body(new ErrorResponse());
        }

        // Authenticate user
        AuthenticationResponse authenticationResponse = authService.authenticateUser(authRequest);

        // Create a cookie when authenticated
        ResponseCookie cookie = ResponseCookie.from("auth-cookie", authenticationResponse.getAccessToken())
                .httpOnly(true)
                .secure(true)
                .path("/")
                .maxAge(Duration.ofMinutes(AuthConstants.COOKIE_EXPIRY_MINUTES))
                .sameSite("Strict")
                .build();

        // Add cookie to response header
        response.addHeader(HttpHeaders.SET_COOKIE, cookie.toString());

        return ResponseEntity.ok(authenticationResponse);
    }
}
