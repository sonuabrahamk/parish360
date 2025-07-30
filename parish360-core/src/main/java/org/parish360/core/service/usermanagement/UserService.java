package org.parish360.core.service.usermanagement;

import org.parish360.core.entity.usermanagement.User;
import org.parish360.core.repository.usermanagement.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public User getUserWithRolesAndPermissions(UUID id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException(("User not found")));
    }
}
