package org.parish360.core.expenses.service.impl;

import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.Expense;
import org.parish360.core.dao.entities.configurations.Account;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.repository.ExpenseRepository;
import org.parish360.core.dao.repository.configurations.AccountRepository;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.parish360.core.expenses.dto.ExpenseInfo;
import org.parish360.core.expenses.service.ExpenseManager;
import org.parish360.core.expenses.service.ExpenseMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ExpenseManagerImpl implements ExpenseManager {
    private final ExpenseMapper expenseMapper;
    private final ExpenseRepository expenseRepository;
    private final ParishRepository parishRepository;
    private final AccountRepository accountRepository;

    public ExpenseManagerImpl(ExpenseMapper expenseMapper, ExpenseRepository expenseRepository, ParishRepository parishRepository, AccountRepository accountRepository) {
        this.expenseMapper = expenseMapper;
        this.expenseRepository = expenseRepository;
        this.parishRepository = parishRepository;
        this.accountRepository = accountRepository;
    }

    @Override
    @Transactional
    public ExpenseInfo createExpense(String parishId, ExpenseInfo expenseInfo) {
        Expense expense = expenseMapper.expenseInfoToDao(expenseInfo);

        // fetch parish information
        Parish parish = parishRepository
                .findById(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish information"));
        expense.setParish(parish);

        // fetch account information
        Account account = accountRepository
                .findById(UUIDUtil.decode(expenseInfo.getAccountId()))
                .orElseThrow(() -> new ResourceNotFoundException("could not find account information"));
        expense.setAccount(account);

        return expenseMapper.daoToExpenseInfo(expenseRepository.save(expense));
    }

    @Override
    @Transactional
    public ExpenseInfo updateExpense(String parishId, String expenseId, ExpenseInfo expenseInfo) {
        // fetch current expense
        Expense currentExpense = expenseRepository
                .findByIdAndParishId(UUIDUtil.decode(expenseId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find expense information"));

        Expense updateExpense = expenseMapper.expenseInfoToDao(expenseInfo);
        expenseMapper.mergeNotNullExpense(updateExpense, currentExpense);

        return expenseMapper.daoToExpenseInfo(expenseRepository.save(currentExpense));
    }

    @Override
    @Transactional(readOnly = true)
    public ExpenseInfo getExpenseInfo(String parishId, String expenseId) {
        return expenseMapper.daoToExpenseInfo(expenseRepository
                .findByIdAndParishId(UUIDUtil.decode(expenseId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find expense information")));
    }

    @Override
    @Transactional(readOnly = true)
    public List<ExpenseInfo> getListOfExpenses(String parishId) {
        List<Expense> expenses = expenseRepository
                .findByParishId(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find expenses information"));
        return expenses.stream()
                .map(expenseMapper::daoToExpenseInfo)
                .toList();
    }

    @Override
    @Transactional
    public void deleteExpenseInfo(String parishId, String expenseId) {
        Expense expense = expenseRepository
                .findByIdAndParishId(UUIDUtil.decode(expenseId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find expense information"));
        expenseRepository.delete(expense);
    }
}
