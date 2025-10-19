package org.parish360.core.dao.repository.family;

import org.parish360.core.dao.entities.family.Subscription;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface SubscriptionRepository extends JpaRepository<Subscription, UUID> {
    Optional<Subscription> findByIdAndFamilyId(UUID subscriptionId, UUID familyId);

    Optional<List<Subscription>> findByFamilyId(UUID familyId, Sort sort);

    @Query(value = """
            SELECT *
                FROM subscriptions
                 WHERE
                 (make_date(year, month, 1) BETWEEN :startDate AND :endDate);
            """, nativeQuery = true)
    Optional<List<Subscription>> findByFamilyIdAndStartDateAndEndDate(
            UUID familyId, LocalDate startDate, LocalDate endDate);
}
