package org.parish360.core.usermanagement.service;

import org.parish360.core.usermanagement.dto.UserInfo;
import org.parish360.core.util.enums.EntityType;

import java.util.List;

public interface UserManager {

    List<UserInfo> getUsersList(String entityID);

    UserInfo getUser(String entityId, String userId);

    UserInfo createUser(EntityType entityName, String entityID, UserInfo userInfo);

    UserInfo updateUser(EntityType entityName, String entityID, String userId, UserInfo userInfo);
}
