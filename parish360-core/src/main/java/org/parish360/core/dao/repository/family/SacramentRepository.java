package org.parish360.core.dao.repository.family;

import org.parish360.core.dao.entities.family.Sacrament;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface SacramentRepository extends JpaRepository<Sacrament, UUID> {
    Optional<Sacrament> findByIdAndMemberId(UUID id, UUID memberId);

    Optional<List<Sacrament>> findByMemberId(UUID memberId);
}
