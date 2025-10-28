import { Observable } from 'rxjs';
import { EXPENSE_BY_ID, EXPENSES, EXTENSION } from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Expense } from '../interfaces/expenses.interface';

@Injectable({ providedIn: 'root' })
export class ExpenseService {
  constructor(private apiService: ApiService) {}

  getExpenses(): Observable<Expense[]> {
    return this.apiService.get<Expense[]>(EXPENSES);
  }

  getExpense(expenseId: string): Observable<Expense> {
    return this.apiService.get<Expense>(EXPENSE_BY_ID(expenseId));
  }

  createExpense(expenseData: Expense): Observable<Expense> {
    return this.apiService.post<Expense>(EXPENSES, expenseData);
  }

  updateExpense(expenseId: string, expenseData: Expense): Observable<Expense> {
    return this.apiService.patch<Expense>(
      EXPENSE_BY_ID(expenseId),
      expenseData
    );
  }

  deleteExpense(expenseId: string): Observable<void> {
    return this.apiService.delete<void>(EXPENSE_BY_ID(expenseId));
  }
}
