package org.parish360.core.auth.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class AuthenticationRequest {
    @NotBlank(message = "username not provided")
    private String username;

    @NotBlank(message = "password not provided")
    private String password;
}
