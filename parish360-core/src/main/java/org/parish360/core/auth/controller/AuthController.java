package org.parish360.core.auth.controller;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import org.parish360.core.auth.AuthConstants;
import org.parish360.core.auth.dto.AuthenticationRequest;
import org.parish360.core.auth.dto.AuthenticationResponse;
import org.parish360.core.auth.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Duration;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<AuthenticationResponse> authenticate(@Valid @RequestBody AuthenticationRequest authRequest,
                                                               HttpServletResponse response) {
        // Authenticate user
        AuthenticationResponse authenticationResponse = authService.authenticateUser(authRequest);

        // Create a cookie when authenticated
        ResponseCookie cookie = ResponseCookie.from(AuthConstants.AUTH_COOKIE_NAME,
                        authenticationResponse.getAccessToken())
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
