package org.parish360.core.usermanagement.service;

import org.parish360.core.usermanagement.dto.UserInfo;

import java.util.List;

public interface UserManager {

    List<UserInfo> getUsersList(String entityID);

    UserInfo getUser(String entityId, String userId);

    UserInfo createUser(String dataownerID, UserInfo userInfo);

    UserInfo updateUser(String dataownerID, String userId, UserInfo userInfo);
}
