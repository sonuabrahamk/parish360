package org.parish360.core.auth.service.impl;

import org.parish360.core.auth.dto.AuthenticationRequest;
import org.parish360.core.auth.dto.AuthenticationResponse;
import org.parish360.core.auth.dto.Permissions;
import org.parish360.core.auth.service.AuthService;
import org.parish360.core.common.enums.PermissionType;
import org.parish360.core.common.util.JwtUtil;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.usermanagement.Permission;
import org.parish360.core.dao.entities.usermanagement.User;
import org.parish360.core.dao.repository.usermanagement.UserRepository;
import org.parish360.core.error.exception.AccessDeniedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Set;

@Service
public class AuthServiceImpl implements AuthService {

    private final UserRepository userRepository;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public AuthServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    private void applyPermission(Permissions permissions, Permission permission) {
        PermissionType permissionType = permission.getPermission();
        String module = permission.getModule();

        switch (permissionType) {
            case CREATE -> permissions.getModules().getCreate().add(module);
            case EDIT -> permissions.getModules().getEdit().add(module);
            case VIEW -> permissions.getModules().getView().add(module);
            case DELETE -> permissions.getModules().getDelete().add(module);
        }
    }

    @Override
    @Transactional(readOnly = true)
    public AuthenticationResponse authenticateUser(AuthenticationRequest authRequest) {
        // validate username
        User user = userRepository.findByIsActiveTrueAndUsernameOrEmail(authRequest.getUsername(),
                        authRequest.getUsername())
                .orElseThrow(() -> new UsernameNotFoundException("user not found"));

        // validate rawPassword 
        if (!passwordEncoder.matches(authRequest.getPassword(), user.getPassword())) {
            throw new AccessDeniedException("password is not matching");
        }

        // jwt token
        Permissions permissions = getPermissions(user);
        String jwt = jwtUtil.generateToken(user, permissions);
        return new AuthenticationResponse(jwt, permissions);
    }

    @Override
    public Permissions getPermissions(User user) {
        Permissions permissions = new Permissions();

        // add allowed module access to permissions
        user.getRoles().forEach(role -> role.getPermissions().forEach(
                permission -> applyPermission(permissions, permission)
        ));

        // add allowed data-owner access to permissions
        if (user.getDataowner() != null) {
            permissions.getDataOwner().setParish(Set.of(UUIDUtil.encode(user.getDataowner().getId())));
        }

        return permissions;
    }
}
