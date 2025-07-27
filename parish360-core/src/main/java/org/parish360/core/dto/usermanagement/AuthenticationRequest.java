package org.parish360.core.dto.usermanagement;

import lombok.Data;

@Data
public class AuthenticationRequest {
    private String username;
    private String password;
}
