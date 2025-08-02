package org.parish360.core.dto.usermanagement;

import lombok.*;
import org.parish360.core.entity.usermanagement.User;

import java.time.Instant;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserResponse {
    private UUID id;
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


    public static UserResponse setUserResponse(User user) {
        return UserResponse.builder()
                .id(user.getId())
                .createAt(user.getCreatedAt())
                .createdBy(user.getCreatedBy())
                .updatedAt(user.getUpdatedAt())
                .updatedBy(user.getUpdatedBy())
                .username(user.getUsername())
                .firstName(user.getFirstName())
                .lastName(user.getLastName())
                .email(user.getEmail())
                .password(user.getPassword())
                .contact(user.getContact())
                .isActive(user.getIsActive())
                .lastLogin(user.getLastLogin())
                .isTouAccepted(user.getIsTouAccepted())
                .isResetPassword(user.getIsResetPassword())
                .comment(user.getComment())
                .entityName(user.getEntityName())
                .entityId(user.getEntityId())
                .build();
    }
}
