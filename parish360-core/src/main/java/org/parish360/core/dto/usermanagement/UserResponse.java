package org.parish360.core.dto.usermanagement;

import lombok.Builder;
import lombok.Data;
import org.parish360.core.entity.usermanagement.User;

import java.util.UUID;

@Data
@Builder
public class UserResponse {
    private UUID id;
    private String firstName;
    private String lastName;
    private String email;
    private String contact;
    private String password;
    private Boolean status;

    public static UserResponse setUserResponse(User user) {
        return UserResponse.builder()
                .id(user.getId())
                .firstName(user.getFirstName())
                .lastName(user.getLastName())
                .email(user.getEmail())
                .contact(user.getContact())
                .status(user.getActive())
                .build();
    }
}
