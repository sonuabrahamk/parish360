package org.parish360.core.expenses.controller;

import jakarta.validation.Valid;
import org.parish360.core.expenses.dto.ExpenseInfo;
import org.parish360.core.expenses.service.ExpenseManager;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/expenses")
public class ExpenseHandler {
    private final ExpenseManager expenseManager;

    public ExpenseHandler(ExpenseManager expenseManager) {
        this.expenseManager = expenseManager;
    }

    @PostMapping
    public ResponseEntity<ExpenseInfo> createExpenseInfo(@PathVariable("parishId") String parishId,
                                                         @Valid @RequestBody ExpenseInfo expenseInfo) {
        return ResponseEntity.ok(expenseManager.createExpense(parishId, expenseInfo));
    }

    @PatchMapping("/{expenseId}")
    public ResponseEntity<ExpenseInfo> updateExpenseInfo(@PathVariable("parishId") String parishId,
                                                         @PathVariable("expenseId") String expenseId,
                                                         @Valid @RequestBody ExpenseInfo expenseInfo) {
        return ResponseEntity.ok(expenseManager.updateExpense(parishId, expenseId, expenseInfo));
    }

    @GetMapping("/{expenseId}")
    public ResponseEntity<ExpenseInfo> getExpenseInfo(@PathVariable("parishId") String parishId,
                                                      @PathVariable("expenseId") String expenseId) {
        return ResponseEntity.ok(expenseManager.getExpenseInfo(parishId, expenseId));
    }

    @GetMapping
    public ResponseEntity<List<ExpenseInfo>> getListOfExpenses(@PathVariable("parishId") String parishId) {
        return ResponseEntity.ok(expenseManager.getListOfExpenses(parishId));
    }

    @DeleteMapping("/{expenseId}")
    public ResponseEntity<ExpenseInfo> deleteExpenseInfo(@PathVariable("parishId") String parishId,
                                                         @PathVariable("expenseId") String expenseId) {
        expenseManager.deleteExpenseInfo(parishId, expenseId);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
}
