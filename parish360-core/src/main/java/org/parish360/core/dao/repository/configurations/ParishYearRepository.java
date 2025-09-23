package org.parish360.core.dao.repository.configurations;

import org.parish360.core.dao.entities.configurations.ParishYear;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

public interface ParishYearRepository extends JpaRepository<ParishYear, UUID> {
    Optional<ParishYear> findByIdAndParishId(UUID id, UUID parishId);

    Optional<List<ParishYear>> findByParishId(UUID parishId);

    @Query(value = """
            SELECT
                CASE WHEN EXISTS (SELECT 1 FROM parish_year WHERE name = :name AND parish_id = :parishId)
                    THEN true ELSE false END AS name_exists,
                CASE WHEN EXISTS (
                    SELECT 1 FROM parish_year WHERE
                        :startDate <= end_date AND :endDate >= start_date AND parish_id = :parishId
                ) THEN true ELSE false END AS date_overlap
            """, nativeQuery = true)
    Optional<Map<String, Object>> performCreateValidations(@Param("parishId") UUID parishId,
                                                           @Param("name") String name,
                                                           @Param("startDate") LocalDate startDate,
                                                           @Param("endDate") LocalDate endDate);

    @Query(value = """
            SELECT
                CASE WHEN EXISTS (SELECT 1 FROM parish_year WHERE name = :name AND
                        parish_id = :parishId AND AND id <> :id)
                    THEN true ELSE false END AS name_exists
                CASE WHEN EXISTS (
                    SELECT 1 FROM parish_year WHERE
                        :startDate <= end_date AND :endDate >= startDate AND parish_id = :parishId AND id <> :id
                ) THEN true ELSE false END AS date_overlap
            """, nativeQuery = true)
    Optional<Map<String, Object>> performUpdateValidations(@Param("parishId") UUID parishId,
                                                           @Param("id") UUID id,
                                                           @Param("name") String name,
                                                           @Param("startDate") LocalDate startDate,
                                                           @Param("endDate") LocalDate endDate);
}
