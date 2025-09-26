package org.parish360.core.dao.repository.configurations;

import org.parish360.core.dao.entities.associations.ParishYearAssociation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ParishYearAssociationRepository extends JpaRepository<ParishYearAssociation, UUID> {
    boolean existsByParishYearIdAndAssociationId(UUID parishYearId, UUID associationId);

    Optional<List<ParishYearAssociation>> findByParishYearId(UUID parishYearId);

    void deleteByParishYearId(UUID parishYearId);
}
