package org.parish360.core.dao.repository.family;

import org.parish360.core.dao.entities.family.Migration;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface MigrationRepository extends JpaRepository<Migration, UUID> {
    Optional<Migration> findByIdAndMemberId(UUID id, UUID memberId);

    Optional<List<Migration>> findByMemberId(UUID memberId);
}
