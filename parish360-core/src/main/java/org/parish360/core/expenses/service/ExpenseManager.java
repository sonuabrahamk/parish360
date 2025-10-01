package org.parish360.core.expenses.service;

import org.parish360.core.expenses.dto.ExpenseInfo;

import java.util.List;

public interface ExpenseManager {
    ExpenseInfo createExpense(String parishId, ExpenseInfo expenseInfo);

    ExpenseInfo updateExpense(String parishId, String expenseId, ExpenseInfo expenseInfo);

    ExpenseInfo getExpenseInfo(String parishId, String expenseId);

    List<ExpenseInfo> getListOfExpenses(String parishId);

    void deleteExpenseInfo(String parishId, String expenseId);
}
