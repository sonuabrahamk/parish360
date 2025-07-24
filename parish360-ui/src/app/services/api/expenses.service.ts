import { Observable } from 'rxjs';
import { EXPENSE_BY_ID, EXPENSES, EXTENSION } from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Expense } from '../interfaces/expenses.interface';

@Injectable({ providedIn: 'root' })
export class ExpenseService {
  constructor(private apiService: ApiService) {}

  getExpenses(): Observable<Expense[]> {
    return this.apiService.get<Expense[]>(EXPENSES + EXTENSION);
  }

  getExpense(expenseId: string): Observable<Expense> {
    return this.apiService.get<Expense>(EXPENSE_BY_ID(expenseId) + EXTENSION);
  }
}
