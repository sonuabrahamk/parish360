package org.parish360.core.auth.service;

import org.parish360.core.auth.dto.AuthenticationRequest;
import org.parish360.core.auth.dto.AuthenticationResponse;
import org.parish360.core.auth.dto.Permissions;
import org.parish360.core.dao.entity.usermanagement.User;

public interface AuthService {
    
    AuthenticationResponse authenticateUser(AuthenticationRequest authRequest);

    Permissions getPermissions(User user);
}
