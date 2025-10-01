package org.parish360.core.dao.repository.configurations;

import org.parish360.core.dao.entities.configurations.Account;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface AccountRepository extends JpaRepository<Account, UUID> {
    Optional<Account> findByIdAndParishId(UUID id, UUID parishId);

    Optional<List<Account>> findByParishId(UUID parishId);
}
