package org.parish360.core.auth.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.parish360.core.usermanagement.dto.UserInfo;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class AuthenticationResponse {
    private String accessToken;
    private Permissions permissions;
    private UserInfo userInfo;
}
