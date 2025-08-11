package org.parish360.core.dao.repository.family;

import org.parish360.core.dao.entities.family.Family;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface FamilyInfoRepository extends JpaRepository<Family, UUID> {
}
