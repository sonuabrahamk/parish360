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
import org.springframework.transaction.annotation.Transactional;

@Service
public class AuthService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JwtUtil jwtUtil;

    private Permissions setPermissions(User user) {
        Permissions permissions = new Permissions();

        // add allowed module access to permissions
        for (Role role : user.getRoles()) {
            for (Permission permission : role.getPermissions()) {
                switch (permission.getPermission().toUpperCase()) {
                    case "CREATE":
                        permissions.getModules().getCreate().add(permission.getModule());
                        break;
                    case "EDIT":
                        permissions.getModules().getEdit().add(permission.getModule());
                        break;
                    case "VIEW":
                        permissions.getModules().getView().add(permission.getModule());
                        break;
                    case "DELETE":
                        permissions.getModules().getDelete().add(permission.getModule());
                        break;
                }
            }
        }

        // add allowed data-owner access to permissions
        permissions.getDataOwner().setDiocese(user.getDioceseIds());
        permissions.getDataOwner().setForane(user.getForaneIds());
        permissions.getDataOwner().setParish(user.getParishIds());

        return permissions;
    }

    @Transactional(readOnly = true)
    public AuthenticationResponse authenticateUser(AuthenticationRequest authRequest) {
        User user = userRepository.findByUsernameOrEmail(authRequest.getUsername(),
                        authRequest.getUsername())
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));

        String jwt = jwtUtil.generateToken(user, setPermissions(user));
        return new AuthenticationResponse(jwt);
    }
}
