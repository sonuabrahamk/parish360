package org.parish360.core.dao.repository.bookings;

import org.parish360.core.dao.entities.bookings.ServiceIntention;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ServiceIntentionRepository extends JpaRepository<ServiceIntention, UUID> {
    Optional<ServiceIntention> findByIdAndParishId(UUID id, UUID parishId);

    Optional<List<ServiceIntention>> findByParishId(UUID parishId);
}
