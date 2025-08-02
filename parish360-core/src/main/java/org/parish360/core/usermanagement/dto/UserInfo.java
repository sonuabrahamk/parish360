package org.parish360.core.usermanagement.dto;

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
    private String firstName;
    private String lastName;
    private String username;
    private String email;
    private String contact;
    private String password;
    private Boolean isActive;
    private Instant lastLogin;
    private Boolean isTouAccepted;
    private Boolean isResetPassword;
    private String comment;
    private String entityName;
    private UUID entityId;
}
