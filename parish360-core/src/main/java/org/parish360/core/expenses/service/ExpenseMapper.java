package org.parish360.core.expenses.service;

import org.mapstruct.*;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.Expense;
import org.parish360.core.expenses.dto.ExpenseInfo;

@Mapper(componentModel = "spring",
        uses = {UUIDUtil.class},
        nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface ExpenseMapper {
    // payments mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    @Mapping(source = "account.id", target = "accountId", qualifiedByName = "uuidToBase64")
    ExpenseInfo daoToExpenseInfo(Expense expense);

    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    Expense expenseInfoToDao(ExpenseInfo expenseInfo);

    void mergeNotNullExpense(Expense source, @MappingTarget Expense target);
}
