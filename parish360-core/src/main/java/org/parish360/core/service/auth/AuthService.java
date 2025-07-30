package org.parish360.core.service.auth;

import org.parish360.core.dto.auth.AuthenticationRequest;
import org.parish360.core.dto.auth.AuthenticationResponse;
import org.parish360.core.entity.usermanagement.Permission;
import org.parish360.core.entity.usermanagement.Role;
import org.parish360.core.entity.usermanagement.User;
import org.parish360.core.repository.usermanagement.UserRepository;
import org.parish360.core.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

@Service
public class AuthService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JwtUtil jwtUtil;

    public AuthenticationResponse authenticateUser(AuthenticationRequest authRequest) {
        User user = userRepository.findByUsernameOrEmail(authRequest.getUsername(),
                        authRequest.getUsername())
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));

        // find permissions for a user
        Map<String, Set<String>> permissions = new HashMap<>();
        Set<String> create = new HashSet<>();
        Set<String> edit = new HashSet<>();
        Set<String> view = new HashSet<>();
        Set<String> delete = new HashSet<>();
        for (Role role : user.getRoles()) {
            for (Permission permission : role.getPermissions()) {
                switch (permission.getPermission().toUpperCase()) {
                    case "CREATE":
                        create.add(permission.getModule());
                        break;
                    case "EDIT":
                        edit.add(permission.getModule());
                        break;
                    case "VIEW":
                        view.add(permission.getModule());
                        break;
                    case "DELETE":
                        delete.add(permission.getModule());
                        break;
                }
            }
        }

        if (!create.isEmpty()) {
            permissions.put("create", create);
        }
        if (!edit.isEmpty()) {
            permissions.put("edit", edit);
        }
        if (!view.isEmpty()) {
            permissions.put("view", view);
        }
        if (!delete.isEmpty()) {
            permissions.put("delete", delete);
        }

        String jwt = jwtUtil.generateToken(user, permissions);
        return new AuthenticationResponse(jwt);
    }
}
