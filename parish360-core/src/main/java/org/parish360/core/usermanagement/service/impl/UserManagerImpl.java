package org.parish360.core.usermanagement.service.impl;

import org.parish360.core.dao.entity.usermanagement.User;
import org.parish360.core.dao.usermanagement.UserRepository;
import org.parish360.core.usermanagement.dto.UserInfo;
import org.parish360.core.usermanagement.service.UserManager;
import org.parish360.core.usermanagement.service.UserMapper;
import org.parish360.core.util.AuthUtil;
import org.parish360.core.util.UUIDUtil;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
public class UserManagerImpl implements UserManager {

    private final UserRepository userRepository;

    private final UserMapper userMapper;

    public UserManagerImpl(UserRepository userRepository, UserMapper userMapper) {
        this.userRepository = userRepository;
        this.userMapper = userMapper;
    }

    @Override
    public List<UserInfo> getUsersList(String entityId) {
        UUID decodedEntityId = UUIDUtil.decode(entityId);
        List<User> userList = userRepository.findByEntityId(decodedEntityId);
        List<UserInfo> userInfoList = new ArrayList<>();
        userList.forEach(user -> {
            userInfoList.add(userMapper.daoToUserInfo(user));
        });
        return userInfoList;
    }

    @Override
    public UserInfo getUser(String entityId, String userId) {
        UUID decodedUserId = UUIDUtil.decode(userId);
        UUID decodedEntityId = UUIDUtil.decode(entityId);
        return userMapper.daoToUserInfo(
                userRepository.findByIdAndEntityId(decodedUserId, decodedEntityId)
                        .orElseThrow(() -> new RuntimeException("user not found")));
    }

    @Override
    public UserInfo createUser(String entityName, String entityId, UserInfo userInfo) {
        // decode UUID of entity ID
        UUID decodedEntityId = UUIDUtil.decode(entityId);

        // set default values and entity ID
        userInfo.setCreatedBy(AuthUtil.getCurrentUserId());
        userInfo.setEntityName(entityName);
        userInfo.setEntityId(decodedEntityId);

        // save user records to repository
        User user = userMapper.userInfoToDao(userInfo);

        return userMapper.daoToUserInfo(userRepository.save(user));
    }
}
