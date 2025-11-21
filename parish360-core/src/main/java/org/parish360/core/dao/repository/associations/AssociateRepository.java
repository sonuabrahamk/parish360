package org.parish360.core.dao.repository.associations;

import org.parish360.core.dao.entities.associations.Associate;
import org.parish360.core.dao.entities.configurations.Association;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface AssociateRepository extends JpaRepository<Associate, UUID> {
    Optional<List<Associate>> findAllByParishYearAssociation_IdAndAssociatesIn(UUID pyAssociationId, Iterable<UUID> associates);

    Optional<List<Associate>> findAllByParishYearAssociation_Id(UUID pyAssociationId);

    boolean existsByParishYearAssociation_IdAndAssociates(UUID pyAssociationId, UUID associateId);

    @Query(value = """
            SELECT a.*
              FROM associates assoc
              JOIN parish_year_associations pya
                  ON assoc.py_association_id = pya.id
              JOIN associations a
                  ON a.id = pya.association_id
              JOIN parish_year py
                  ON py.id = pya.parish_year_id
              WHERE assoc.associates = :familyId
                AND CURRENT_DATE BETWEEN py.start_date AND py.end_date;
            """, nativeQuery = true)
    Optional<Association> findAssociationByFamilyId(UUID familyId);
}
