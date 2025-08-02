package org.parish360.core.usermanagement.service.impl;

import org.parish360.core.usermanagement.dto.UserResponse;
import org.parish360.core.usermanagement.service.UserManager;

import java.util.List;
import java.util.UUID;

public class UserManagerImpl implements UserManager {
    @Override
    public List<UserResponse> getUsersList(String entityName, String entityID) {
        return List.of();
    }

    @Override
    public UserResponse getUser(UUID userId) {
        return null;
    }

    @Override
    public UserResponse createUser(String entityName, String entityID) {
        return null;
    }
}
