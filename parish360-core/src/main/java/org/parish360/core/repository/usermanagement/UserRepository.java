package org.parish360.core.repository.usermanagement;

import org.parish360.core.entity.usermanagement.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, String> {
    Optional<User> findByEmail(String email);
}
