package org.parish360.core.usermanagement.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.Instant;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserInfo {
    private String id;
    private Instant createAt;
    private String createdBy;
    private Instant updatedAt;
    private String updatedBy;

    @NotNull(message = "first name not provided")
    private String firstName;

    @NotNull(message = "last name not provided")
    private String lastName;

    @NotBlank(message = "username cannot be null")
    private String username;

    @Email(message = "email is not valid")
    private String email;

    private String contact;
    private String password;

    @NotNull(message = "status not set")
    private Boolean isActive;
    
    private Instant lastLogin;
    private Boolean isTouAccepted;
    private Boolean isResetPassword;
    private String comment;
    private String entityName;
    private UUID entityId;
}
