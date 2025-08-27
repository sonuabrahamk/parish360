package org.parish360.core.dao.repository.family;

import org.parish360.core.dao.entities.family.Subscription;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface SubscriptionRepository extends JpaRepository<Subscription, UUID> {
    Optional<Subscription> findByIdAndFamilyId(UUID subscriptionId, UUID familyId);

    Optional<List<Subscription>> findByFamilyId(UUID familyId, Sort sort);
}
