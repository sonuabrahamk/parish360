package org.parish360.core.service.usermanagement;

import org.parish360.core.dto.usermanagement.UserResponse;
import org.parish360.core.entity.usermanagement.User;
import org.parish360.core.repository.usermanagement.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Transactional(readOnly = true)
    public UserResponse getUserWithRolesAndPermissions(UUID id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException(("User not found")));
        return UserResponse.setUserResponse(user);
    }
}
