package org.parish360.core.dao.repository.associations;

import org.parish360.core.dao.entities.configurations.Association;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface AssociationRepository extends JpaRepository<Association, UUID> {
    Optional<Association> findByIdAndParishId(UUID id, UUID parishId);

    Optional<List<Association>> findByParishId(UUID parishId);
}
