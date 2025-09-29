package org.parish360.core.dao.repository.configurations;

import org.parish360.core.dao.entities.configurations.Resource;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ResourceRepository extends JpaRepository<Resource, UUID> {
    Optional<Resource> findByIdAndParishId(UUID id, UUID parishId);

    Optional<List<Resource>> findByParishId(UUID parishId);
}
