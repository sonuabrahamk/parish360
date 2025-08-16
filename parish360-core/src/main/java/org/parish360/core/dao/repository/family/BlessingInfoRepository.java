package org.parish360.core.dao.repository.family;

import org.parish360.core.dao.entities.family.Blessing;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface BlessingInfoRepository extends JpaRepository<Blessing, UUID> {
    Optional<Blessing> findByIdAndFamilyId(UUID id, UUID familyId);

    Optional<List<Blessing>> findByFamilyId(UUID familyId);
}
