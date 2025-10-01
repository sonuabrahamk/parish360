package org.parish360.core.dao.repository;

import org.parish360.core.dao.entities.Expense;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ExpenseRepository extends JpaRepository<Expense, UUID> {
    Optional<Expense> findByIdAndParishId(UUID id, UUID parishId);

    Optional<List<Expense>> findByParishId(UUID parishId);
}
