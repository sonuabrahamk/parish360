package org.parish360.core.dao.repository.associations;

import org.parish360.core.dao.entities.associations.Associate;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface AssociateRepository extends JpaRepository<Associate, UUID> {
    Optional<List<Associate>> findAllByParishYearAssociation_IdAndAssociatesIn(UUID pyAssociationId, Iterable<UUID> associates);

    Optional<List<Associate>> findAllByParishYearAssociation_Id(UUID pyAssociationId);

    boolean existsByParishYearAssociation_IdAndAssociates(UUID pyAssociationId, UUID associateId);
}
