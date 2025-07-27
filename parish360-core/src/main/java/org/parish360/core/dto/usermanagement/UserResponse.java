package org.parish360.core.dto.usermanagement;

import lombok.Data;

import java.util.UUID;

@Data
public class UserResponse {
    private UUID id;
    private String firstName;
    private String lastName;
    private String email;
    private String contact;
    private String password;
    private String status;
}
