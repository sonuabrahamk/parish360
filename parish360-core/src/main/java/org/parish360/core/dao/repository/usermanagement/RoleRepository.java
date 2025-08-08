package org.parish360.core.dao.repository.usermanagement;

import org.parish360.core.dao.entities.usermanagement.Role;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface RoleRepository extends JpaRepository<Role, UUID> {

    Optional<Role> findByIdAndDataownerId(UUID id, UUID dataownerId);

    List<Role> findAllByDataownerId(UUID dataownerId);
}
