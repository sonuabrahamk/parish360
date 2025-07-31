package org.parish360.core.service.auth;

import org.parish360.core.dto.auth.AuthenticationRequest;
import org.parish360.core.dto.auth.AuthenticationResponse;
import org.parish360.core.dto.auth.Permissions;
import org.parish360.core.entity.usermanagement.Permission;
import org.parish360.core.entity.usermanagement.Role;
import org.parish360.core.entity.usermanagement.User;
import org.parish360.core.repository.usermanagement.UserRepository;
import org.parish360.core.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Set;

@Service
public class AuthService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JwtUtil jwtUtil;

    private Permissions setPermissions(Set<Role> roles) {
        Permissions permissions = new Permissions();
        for (Role role : roles) {
            for (Permission permission : role.getPermissions()) {
                switch (permission.getPermission().toUpperCase()) {
                    case "CREATE":
                        permissions.addCreate(permission.getModule());
                        break;
                    case "EDIT":
                        permissions.addEdit(permission.getModule());
                        break;
                    case "VIEW":
                        permissions.addView(permission.getModule());
                        break;
                    case "DELETE":
                        permissions.addDelete(permission.getModule());
                        break;
                }
            }
        }
        return permissions;
    }

    public AuthenticationResponse authenticateUser(AuthenticationRequest authRequest) {
        User user = userRepository.findByUsernameOrEmail(authRequest.getUsername(),
                        authRequest.getUsername())
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));

        String jwt = jwtUtil.generateToken(user, setPermissions(user.getRoles()));
        return new AuthenticationResponse(jwt);
    }
}
