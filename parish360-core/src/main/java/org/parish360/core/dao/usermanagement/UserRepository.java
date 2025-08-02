package org.parish360.core.dao.usermanagement;

import lombok.NonNull;
import org.parish360.core.dao.entity.usermanagement.User;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface UserRepository extends JpaRepository<User, UUID> {
    @EntityGraph(attributePaths = {"roles", "roles.permissions"})
    Optional<User> findByUsernameOrEmail(String username, String email);

    @EntityGraph(attributePaths = {"roles", "roles.permissions"})
    @NonNull
    Optional<User> findById(@NonNull UUID id);
}
