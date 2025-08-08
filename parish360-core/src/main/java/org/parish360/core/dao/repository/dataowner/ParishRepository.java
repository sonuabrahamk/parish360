package org.parish360.core.dao.repository.dataowner;

import org.parish360.core.dao.entities.dataowner.Parish;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface ParishRepository extends JpaRepository<Parish, UUID> {
}
