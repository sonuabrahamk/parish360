package org.parish360.core.dao.repository.associations;

import org.parish360.core.dao.entities.associations.CommitteeMember;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface CommitteeMemberRepository extends JpaRepository<CommitteeMember, UUID> {
    Optional<CommitteeMember> findByIdAndParishYearAssociation_Id(UUID id, UUID pyAssociationId);

    Optional<List<CommitteeMember>> findByParishYearAssociation_Id(UUID pyAssociationId);
}
