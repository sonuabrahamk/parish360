package org.parish360.core.dao.repository.bookings;

import org.parish360.core.dao.entities.bookings.Booking;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface BookingRepository extends JpaRepository<Booking, UUID> {
    Optional<Booking> findByIdAndParishId(UUID id, UUID parishId);

    @EntityGraph(attributePaths = {"resource", "service"})
    Optional<List<Booking>> findWithResourceAndServiceByBookingCodeAndParishId(String bookingCode, UUID parishId);

    Optional<List<Booking>> findByParishId(UUID parishId);

    @Query(value = """
            SELECT CASE
                WHEN EXISTS (
                    SELECT 1 FROM bookings
                    WHERE resource_id = :resourceId
                      AND booked_from <= :end
                      AND booked_to >= :start
                      AND status <> 'CANCELLED'
                ) THEN true
                ELSE false
            END AS result;
            """, nativeQuery = true)
    boolean existsByResourceAndTime(UUID resourceId, LocalDateTime start, LocalDateTime end);
}
