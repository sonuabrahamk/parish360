package org.parish360.core.usermanagement.service;

import org.parish360.core.usermanagement.dto.UserResponse;

import java.util.List;
import java.util.UUID;

public interface UserManager {

    List<UserResponse> getUsersList(String entityName, String entityID);

    UserResponse getUser(UUID userId);

    UserResponse createUser(String entityName, String entityID);
}
