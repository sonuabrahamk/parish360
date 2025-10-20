package org.parish360.core.dao.repository;

import org.parish360.core.dao.entities.ceremonies.Ceremony;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface CeremonyRepository extends JpaRepository<Ceremony, UUID> {
    Optional<Ceremony> findByIdAndParishId(UUID id, UUID parishId);

    Optional<List<Ceremony>> findByParishId(UUID parishId);
}
