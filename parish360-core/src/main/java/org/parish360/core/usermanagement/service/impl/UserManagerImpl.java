package org.parish360.core.usermanagement.service.impl;

import org.parish360.core.common.util.AuthUtil;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.dataowner.Dataowner;
import org.parish360.core.dao.entities.usermanagement.User;
import org.parish360.core.dao.repository.dataowner.DataownerRepository;
import org.parish360.core.dao.repository.usermanagement.UserRepository;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.parish360.core.usermanagement.dto.UserInfo;
import org.parish360.core.usermanagement.service.UserManagementMapper;
import org.parish360.core.usermanagement.service.UserManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
public class UserManagerImpl implements UserManager {

    private final DataownerRepository dataownerRepository;
    private final UserRepository userRepository;
    private final UserManagementMapper userManagementMapper;
    @Autowired
    private PasswordEncoder passwordEncoder;

    public UserManagerImpl(DataownerRepository dataownerRepository, UserRepository userRepository, UserManagementMapper userManagementMapper) {
        this.dataownerRepository = dataownerRepository;
        this.userRepository = userRepository;
        this.userManagementMapper = userManagementMapper;
    }

    @Override
    public List<UserInfo> getUsersList(String entityId) {
        UUID decodedEntityId = UUIDUtil.decode(entityId);
        List<User> userList = userRepository.findByDataownerId(decodedEntityId);
        List<UserInfo> userInfoList = new ArrayList<>();
        userList.forEach(user -> {
            userInfoList.add(userManagementMapper.daoToUserInfo(user));
        });
        return userInfoList;
    }

    @Override
    public UserInfo getUser(String entityId, String userId) {
        UUID decodedUserId = UUIDUtil.decode(userId);
        UUID decodedEntityId = UUIDUtil.decode(entityId);
        return userManagementMapper.daoToUserInfo(
                userRepository.findByIdAndDataownerId(decodedUserId, decodedEntityId)
                        .orElseThrow(() -> new RuntimeException("user not found")));
    }

    @Override
    public UserInfo createUser(String dataownerId, UserInfo userInfo) {

        Dataowner dataowner = dataownerRepository.findById(UUIDUtil.decode(dataownerId))
                .orElseThrow(() -> new BadRequestException("invalid dataowner"));

        // set default values and entity ID
        userInfo.setCreatedBy(AuthUtil.getCurrentUserId());
        userInfo.setCreatedAt(Instant.now());

        // password hashing for user creation
        if (userInfo.getPassword() == null) {
            throw new BadRequestException("password is required for user creation");
        }
        userInfo.setPassword(passwordEncoder.encode(userInfo.getPassword()));

        // save user records to repository
        User user = userManagementMapper.userInfoToDao(userInfo);
        user.setDataowner(dataowner);

        return userManagementMapper.daoToUserInfo(userRepository.save(user));
    }

    @Override
    @Transactional
    public UserInfo updateUser(String dataownerId, String userId, UserInfo userInfo) {

        // validate userInfo id with endpoint if present
        if (userInfo.getId() != null && !userInfo.getId().equals(userId)) {
            throw new BadRequestException("userId mismatch in payload and endpoint");
        }

        // copy id and entity fields to userInfo
        // create User DAO from userInfo
        userInfo.setId(userId);
        userInfo.setUpdatedAt(Instant.now());
        userInfo.setUpdatedBy(AuthUtil.getCurrentUserId());

        // hashing password if provided to update
        if (userInfo.getPassword() != null) {
            userInfo.setPassword(passwordEncoder.encode(userInfo.getPassword()));
        }

        // user DAO created from userInfo
        User updateUser = userManagementMapper.userInfoToDao(userInfo);

        // fetch current user details
        User currentUserToUpdate = userRepository.findByIdAndDataownerId(updateUser.getId(),
                        UUIDUtil.decode(dataownerId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find user to update"));

        // validate if immutable fields are updated
        if (isImmutableFieldModified(currentUserToUpdate, updateUser)) {
            throw new BadRequestException("immutable field values do not match");
        }

        // merge null values with current user values
        userManagementMapper.mergeUserNotNullFieldToTarget(updateUser, currentUserToUpdate);

        return userManagementMapper.daoToUserInfo(userRepository.save(currentUserToUpdate));
    }

    private boolean isImmutableFieldModified(User currentUser, User updateUser) {
        return !currentUser.getUsername().equals(updateUser.getUsername()) // validate username
                || !currentUser.getEmail().equals(updateUser.getEmail()); // validate email
    }
}
