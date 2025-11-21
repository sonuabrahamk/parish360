package org.parish360.core.dao.repository;

import org.parish360.core.dao.entities.Payment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface PaymentRepository extends JpaRepository<Payment, UUID> {
    Optional<Payment> findByIdAndParishId(UUID id, UUID parishId);

    Optional<List<Payment>> findByParishId(UUID parishId);

    Optional<List<Payment>> findByFamilyId(UUID familyId);

    Optional<List<Payment>> findByParishIdAndBookingCode(UUID parishId, String bookingCode);

    Optional<List<Payment>> findByParishIdAndCreatedAtBetween(UUID parishId, Instant startDate, Instant endDate);
}
