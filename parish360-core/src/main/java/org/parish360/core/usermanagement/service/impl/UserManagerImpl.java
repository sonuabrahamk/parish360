package org.parish360.core.usermanagement.service.impl;

import org.parish360.core.dao.entity.usermanagement.User;
import org.parish360.core.dao.usermanagement.UserRepository;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.parish360.core.usermanagement.dto.UserInfo;
import org.parish360.core.usermanagement.service.UserManager;
import org.parish360.core.usermanagement.service.UserMapper;
import org.parish360.core.util.AuthUtil;
import org.parish360.core.util.UUIDUtil;
import org.parish360.core.util.enums.EntityType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
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
    public UserInfo createUser(EntityType entityName, String entityId, UserInfo userInfo) {

        // set default values and entity ID
        userInfo.setCreatedBy(AuthUtil.getCurrentUserId());
        userInfo.setEntityName(entityName);
        userInfo.setEntityId(entityId);

        // save user records to repository
        User user = userMapper.userInfoToDao(userInfo);

        return userMapper.daoToUserInfo(userRepository.save(user));
    }

    @Override
    @Transactional
    public UserInfo updateUser(EntityType entityName, String entityId, String userId, UserInfo userInfo) {

        // validate userInfo id with endpoint if present
        if (userInfo.getId() != null && !userInfo.getId().equals(userId)) {
            throw new BadRequestException("userId mismatch in payload and endpoint");
        }

        // copy id and entity fields to userInfo
        // create User DAO from userInfo
        userInfo.setId(userId);
        userInfo.setEntityId(entityId);
        userInfo.setEntityName(entityName);
        userInfo.setUpdatedAt(Instant.now());
        userInfo.setUpdatedBy(AuthUtil.getCurrentUserId());
        User updateUser = userMapper.userInfoToDao(userInfo);

        // fetch current user details
        User currentUserToUpdate = userRepository.findByIdAndEntityId(updateUser.getId(), updateUser.getEntityId())
                .orElseThrow(() -> new ResourceNotFoundException("could not find user to update"));

        // validate if immutable fields are updated
        if (isImmutableFieldModified(currentUserToUpdate, updateUser)) {
            throw new BadRequestException("immutable field values do not match");
        }

        // merge null values with current user values
        userMapper.mergeUserIfTargetFieldIsNull(updateUser, currentUserToUpdate);

        return userMapper.daoToUserInfo(userRepository.save(currentUserToUpdate));
    }

    private boolean isImmutableFieldModified(User currentUser, User updateUser) {
        return !currentUser.getUsername().equals(updateUser.getUsername()) // validate username
                || !currentUser.getEmail().equals(updateUser.getEmail()) // validate email
                || !currentUser.getEntityId().equals(updateUser.getEntityId()) // validate entityId
                || !currentUser.getEntityName().equals(updateUser.getEntityName()); // validate entityName
    }
}
