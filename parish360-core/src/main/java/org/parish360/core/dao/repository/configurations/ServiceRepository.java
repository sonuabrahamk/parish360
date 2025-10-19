package org.parish360.core.dao.repository.configurations;

import org.parish360.core.dao.entities.configurations.Services;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ServiceRepository extends JpaRepository<Services, UUID> {
    Optional<Services> findByIdAndParishId(UUID id, UUID parishId);

    Optional<List<Services>> findByParishId(UUID parishId);

    Optional<List<Services>> findByParishIdAndDateBetween(UUID parishId, LocalDate startDate, LocalDate endDate);

    @Query(value = """
            SELECT
            	CASE
            		WHEN EXISTS (
            			SELECT 1 FROM services WHERE
            				resource_id = :resourceId
            				AND date = :date
            				AND start_time <= :endTime
            				AND end_time >= :startTime
            		) THEN TRUE
            		ELSE FALSE
            	END AS result
            """, nativeQuery = true)
    boolean existsByResourceAndDateAndTime(UUID resourceId, LocalDate date, LocalTime startTime, LocalTime endTime);
}
