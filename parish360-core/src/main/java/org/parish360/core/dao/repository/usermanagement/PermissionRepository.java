package org.parish360.core.dao.repository.usermanagement;

import org.parish360.core.dao.entities.usermanagement.Permission;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface PermissionRepository extends JpaRepository<Permission, UUID> {
}
