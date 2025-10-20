package org.parish360.core.dao.repository.dataowner;

import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dashboard.dto.ParishReportInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;
import java.util.UUID;

public interface ParishRepository extends JpaRepository<Parish, UUID> {
    @Query(value = """
            SELECT
                COUNT(DISTINCT a.id) AS numberOfAssociations,
                COUNT(DISTINCT u.id) AS numberOfUnits,
                COUNT(DISTINCT f.id) AS numberOfFamilies,
                COUNT(DISTINCT m.id) AS numberOfMembers
            FROM parish p
                LEFT JOIN associations a
                    ON a.parish_id = p.id
                   AND (a."scope" <> 'UNIT' OR a."scope" IS NULL)
                LEFT JOIN associations u
                    ON u.parish_id = p.id
                   AND u."scope" = 'UNIT'
                LEFT JOIN families f
                    ON f.parish_id = p.id
                LEFT JOIN members m
                    ON m.family_id = f.id
            WHERE p.id = :id;
            """, nativeQuery = true)
    Optional<ParishReportInfo> findParishReport(UUID id);
}
