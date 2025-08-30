package org.parish360.core.dao.repository.family;

import org.parish360.core.dao.entities.family.Miscellaneous;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface MiscellaneousRepository extends JpaRepository<Miscellaneous, UUID> {
    Optional<Miscellaneous> findByIdAndFamilyId(UUID id, UUID familyId);

    Optional<List<Miscellaneous>> findByFamilyId(UUID familyId);
}
